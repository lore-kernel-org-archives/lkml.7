Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C23C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99A5218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610782;
	bh=Hh4Kyq670JqEVzeRQkf2+QuO3i/61SLB+rlCN2rodvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iNqPx3Kj3ZdA22gBVrLF1wsPM+UMnxMuhwgsFPs7tamtVFlVL5hyyzfS7RBBSGPTR
	 sdqDMj44OefvaOErZ9kbWoF9sERO4nNSq0lY/F7Zh7TrVJ5ZrBLmpxGTvMQNS2f93c
	 Zd2WHuMReVoSfuMPjAVLjg14XO1zU8ZeQzE2yJRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391468AbfDRSGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:06:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391458AbfDRSGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:06:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 298FB21871;
        Thu, 18 Apr 2019 18:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610776;
        bh=Hh4Kyq670JqEVzeRQkf2+QuO3i/61SLB+rlCN2rodvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qlAu/CrlzHiZGfAaG5W5VbthwXkrvKG2jXb07RLBckfF8WtPnqw7KNKmbDGSBhuYO
         oaAj8P8nKQ+5peyIneUS3k0whXin2eT0Kg2Pm212uLSSHDM1cMfrV1RMIxrbJDacUK
         4LQa4gJXl7tbgyyxclu5dGXSfVvy4JnbUY1autfU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 4.14 80/92] bpf: restrict map value pointer arithmetic for unprivileged
Date:   Thu, 18 Apr 2019 19:57:38 +0200
Message-Id: <20190418160437.471311269@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>

commit 0d6303db7970e6f56ae700fa07e11eb510cda125 upstream.

Restrict map value pointer arithmetic for unprivileged users in that
arithmetic itself must not go out of bounds as opposed to the actual
access later on. Therefore after each adjust_ptr_min_max_vals() with a
map value pointer as a destination it will simulate a check_map_access()
of 1 byte on the destination and once that fails the program is rejected
for unprivileged program loads. We use this later on for masking any
pointer arithmetic with the remainder of the map value space. The
likelihood of breaking any existing real-world unprivileged eBPF
program is very small for this corner case.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2191,6 +2191,17 @@ static int adjust_ptr_min_max_vals(struc
 	__update_reg_bounds(dst_reg);
 	__reg_deduce_bounds(dst_reg);
 	__reg_bound_offset(dst_reg);
+
+	/* For unprivileged we require that resulting offset must be in bounds
+	 * in order to be able to sanitize access later on.
+	 */
+	if (!env->allow_ptr_leaks && dst_reg->type == PTR_TO_MAP_VALUE &&
+	    check_map_access(env, dst, dst_reg->off, 1, false)) {
+		verbose(env, "R%d pointer arithmetic of map value goes out of range, prohibited for !root\n",
+			dst);
+		return -EACCES;
+	}
+
 	return 0;
 }
 


