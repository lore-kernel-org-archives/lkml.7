Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CB1C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9321A218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610787;
	bh=hxtOyQw9ug4h5ERpL9+6Fv4vW4LO6LA3g5iB2yHjfoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LBkOhnruaIgkQPXmSmPxuYkWvdqnkdqM5Cz1v1s9kMil2NiXOXbXGaOWAiQlrk7Z6
	 e94P/FQ852WxDO++IoYyyAEsY4oYbNNTXTlRJQbf004bPeMMqIxlqxuf7+PmVVIByD
	 9AhURAcDkKXSyBwa5D4Fg671PjhQ54EciatTdrbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391481AbfDRSG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390285AbfDRSGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:06:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFC61218CD;
        Thu, 18 Apr 2019 18:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610784;
        bh=hxtOyQw9ug4h5ERpL9+6Fv4vW4LO6LA3g5iB2yHjfoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HxpbksBdTq4QNqEKkCXBYeDvpebZGkJa11VZMFTjz/zh+50Gj5MI3h4ekHsolq3yH
         xPXK/yUCpunNrL8YH+Q1rMkbihH4eEAX75C8Sw5WlQZx9rFQM0LixCK/NIBxeVGiqR
         nFBxHRmcbBf2VPhUe3rBuza2sgTEariG6yMUv6MY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Balbir Singh <sblbir@amzn.com>
Subject: [PATCH 4.14 83/92] bpf: fix check_map_access smin_value test when pointer contains offset
Date:   Thu, 18 Apr 2019 19:57:41 +0200
Message-Id: <20190418160437.796780044@linuxfoundation.org>
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

commit b7137c4eab85c1cf3d46acdde90ce1163b28c873 upstream.

In check_map_access() we probe actual bounds through __check_map_access()
with offset of reg->smin_value + off for lower bound and offset of
reg->umax_value + off for the upper bound. However, even though the
reg->smin_value could have a negative value, the final result of the
sum with off could be positive when pointer arithmetic with known and
unknown scalars is combined. In this case we reject the program with
an error such as "R<x> min value is negative, either use unsigned index
or do a if (index >=0) check." even though the access itself would be
fine. Therefore extend the check to probe whether the actual resulting
reg->smin_value + off is less than zero.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
[backported to 4.14 sblbir]
Signed-off-by: Balbir Singh <sblbir@amzn.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -994,13 +994,17 @@ static int check_map_access(struct bpf_v
 	 */
 	if (log_level)
 		print_verifier_state(state);
+
 	/* The minimum value is only important with signed
 	 * comparisons where we can't assume the floor of a
 	 * value is 0.  If we are using signed variables for our
 	 * index'es we need to make sure that whatever we use
 	 * will have a set floor within our range.
 	 */
-	if (reg->smin_value < 0) {
+	if (reg->smin_value < 0 &&
+	    (reg->smin_value == S64_MIN ||
+	     (off + reg->smin_value != (s64)(s32)(off + reg->smin_value)) ||
+	      reg->smin_value + off < 0)) {
 		verbose("R%d min value is negative, either use unsigned index or do a if (index >=0) check.\n",
 			regno);
 		return -EACCES;


