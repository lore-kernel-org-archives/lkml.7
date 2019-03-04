Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC351C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9977D2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688297;
	bh=nOHZIZxlFgkstYyXw3LWOWmyz97E/eqa8M6Fzue3v0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oSMROMYqq0hNJWi4hMGAM3txbypbOMOZCFmSwTPsGCRAOuH8JBJ2rGtQVDttFKmNa
	 g9RbssJw+hpmtgoh5BCZ7BTSTxwtsyrKClv+DSxdjoRgXDbyREg0crspDR4vkcY5Fg
	 UwZhA6m7uHCW0MXdgqrpwC4R7l+PG6mlEAdOruEE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfCDIbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:31:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:33618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbfCDIbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:31:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A415820836;
        Mon,  4 Mar 2019 08:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688292;
        bh=nOHZIZxlFgkstYyXw3LWOWmyz97E/eqa8M6Fzue3v0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mJFhHv5kYgL81/Bc1YD2FC+DNj9EoPdQhioTQWdzt5ZoeV2dFqqq2VjVB1h9xsAhs
         6NT+SlVfhCS79YzGumXqqrHuUMXfVLqAoDIWxbfxqqdFtsguGq4cxx2eB4dNOkCTvK
         SlWEw7t+mJon9mgHxtSFo/2jfavbefbR+AS8wCPo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH 4.19 77/78] MIPS: eBPF: Fix icache flush end address
Date:   Mon,  4 Mar 2019 09:23:00 +0100
Message-Id: <20190304081629.043690167@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@mips.com>

commit d1a2930d8a992fb6ac2529449f81a0056e1b98d1 upstream.

The MIPS eBPF JIT calls flush_icache_range() in order to ensure the
icache observes the code that we just wrote. Unfortunately it gets the
end address calculation wrong due to some bad pointer arithmetic.

The struct jit_ctx target field is of type pointer to u32, and as such
adding one to it will increment the address being pointed to by 4 bytes.
Therefore in order to find the address of the end of the code we simply
need to add the number of 4 byte instructions emitted, but we mistakenly
add the number of instructions multiplied by 4. This results in the call
to flush_icache_range() operating on a memory region 4x larger than
intended, which is always wasteful and can cause crashes if we overrun
into an unmapped page.

Fix this by correcting the pointer arithmetic to remove the bogus
multiplication, and use braces to remove the need for a set of brackets
whilst also making it obvious that the target field is a pointer.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: b6bd53f9c4e8 ("MIPS: Add missing file for eBPF JIT.")
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Cc: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: stable@vger.kernel.org # v4.13+
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/net/ebpf_jit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/net/ebpf_jit.c
+++ b/arch/mips/net/ebpf_jit.c
@@ -1818,7 +1818,7 @@ struct bpf_prog *bpf_int_jit_compile(str
 
 	/* Update the icache */
 	flush_icache_range((unsigned long)ctx.target,
-			   (unsigned long)(ctx.target + ctx.idx * sizeof(u32)));
+			   (unsigned long)&ctx.target[ctx.idx]);
 
 	if (bpf_jit_enable > 1)
 		/* Dump JIT code */


