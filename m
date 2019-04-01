Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A6FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46002133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139282;
	bh=JJEyhfgsZDb2T9ZOumSdkfShZ6hu6ZJhMRpGMDGl3FM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O6ERQKTV+UCiPzOV5BD2Kq8BqmOyOAQQaB803P+kBecD8TX5Z9lhSaExci+tryLnc
	 8oOPW/uC1rkPox5WjYLkSjuFq1zpi8caLa3Ku6AKj6xG0ui73atVOvPxfrS7tMKX4L
	 W747w188l5dpBeFWD+nWLZ3N9bmb+m1ghQLUz2vI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731599AbfDARVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:21:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731546AbfDARVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:21:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96AA120883;
        Mon,  1 Apr 2019 17:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139279;
        bh=JJEyhfgsZDb2T9ZOumSdkfShZ6hu6ZJhMRpGMDGl3FM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0PrdzLAe/byb69TGWRIBqkxXKI6uaEfTNm4yllnGFWnmKlEqo7ZWbggIx5tQ/vlbX
         NVITU73LYVKZgePNYyl7m70Tq+ARsxgZNkzVs+qJkeNUks0rIRrYKMI7RUypFydy+m
         oqRM4KsOIDIaG+PSwiyocNfEuHL1KiZYKo8RtTrg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Suchanek <msuchanek@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 029/107] powerpc/64s: Enhance the information in cpu_show_spectre_v1()
Date:   Mon,  1 Apr 2019 19:01:44 +0200
Message-Id: <20190401170048.401661802@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170045.246405031@linuxfoundation.org>
References: <20190401170045.246405031@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Suchanek <msuchanek@suse.de>

commit a377514519b9a20fa1ea9adddbb4129573129cef upstream.

We now have barrier_nospec as mitigation so print it in
cpu_show_spectre_v1() when enabled.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/security.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -120,6 +120,9 @@ ssize_t cpu_show_spectre_v1(struct devic
 	if (!security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR))
 		return sprintf(buf, "Not affected\n");
 
+	if (barrier_nospec_enabled)
+		return sprintf(buf, "Mitigation: __user pointer sanitization\n");
+
 	return sprintf(buf, "Vulnerable\n");
 }
 


