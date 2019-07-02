Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1353C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0182184E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562054663;
	bh=JTbRhrbNlkJTnY/ifHd1A3etdWH9i2flTy5r5faXi1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TRcipBg7pBv++7ZMfaBBUtlWs6BA6ahg9ntaV9JjOdxdeTzsMzZwcpAvXxztK85AS
	 8ChF12gmlLCP+u0VzAvhZ4chLsx4HonQ5fGJIAs/gyvMLU96Noj2UeX3LXMIO7YhpS
	 fbl7E/N2bObuC+tqA1OUxrMBAp/wHRLKp/82Kk5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfGBIES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:04:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727584AbfGBIEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:04:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE64D21841;
        Tue,  2 Jul 2019 08:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562054652;
        bh=JTbRhrbNlkJTnY/ifHd1A3etdWH9i2flTy5r5faXi1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qNv+afYdilPNt8sERY6bk0zTDxRoe/6UvmI1YJhmHlzcWxRxOTBpH7ytVXVYLkOvX
         fHoZahpcPBPO1M9niNnfqglsNFJp9dMaDmAmcyxDmb5MOu9lqftPDODZiFaIlUxnW7
         3HSKpIecw7geTuzDaVv/e+MMAHYNBvyVSRHCWa1M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martynas Pumputis <m@lambda.lt>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 5.1 44/55] bpf: simplify definition of BPF_FIB_LOOKUP related flags
Date:   Tue,  2 Jul 2019 10:01:52 +0200
Message-Id: <20190702080126.383299550@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190702080124.103022729@linuxfoundation.org>
References: <20190702080124.103022729@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martynas Pumputis <m@lambda.lt>

commit b1d6c15b9d824a58c5415673f374fac19e8eccdf upstream.

Previously, the BPF_FIB_LOOKUP_{DIRECT,OUTPUT} flags in the BPF UAPI
were defined with the help of BIT macro. This had the following issues:

- In order to use any of the flags, a user was required to depend
  on <linux/bits.h>.
- No other flag in bpf.h uses the macro, so it seems that an unwritten
  convention is to use (1 << (nr)) to define BPF-related flags.

Fixes: 87f5fc7e48dd ("bpf: Provide helper to do forwarding lookups in kernel FIB table")
Signed-off-by: Martynas Pumputis <m@lambda.lt>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/uapi/linux/bpf.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3104,8 +3104,8 @@ struct bpf_raw_tracepoint_args {
 /* DIRECT:  Skip the FIB rules and go to FIB table associated with device
  * OUTPUT:  Do lookup from egress perspective; default is ingress
  */
-#define BPF_FIB_LOOKUP_DIRECT  BIT(0)
-#define BPF_FIB_LOOKUP_OUTPUT  BIT(1)
+#define BPF_FIB_LOOKUP_DIRECT  (1U << 0)
+#define BPF_FIB_LOOKUP_OUTPUT  (1U << 1)
 
 enum {
 	BPF_FIB_LKUP_RET_SUCCESS,      /* lookup successful */


