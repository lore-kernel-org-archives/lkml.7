Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67781C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9B9217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564429463;
	bh=TFqTnxju/RcqurZHbARZd4YhaMMzHJ+XMmRzD+1Pn2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NMcuHul1Hjc59RB8jCQEnJff72NdNOPa3ofpoWiHogG1GFiwm0ZcU1JCBcj3wgrkJ
	 VokQECCHxuSmoND8d7dm5a+ZMA/2X6Uw+BdgYhVW8MtZtAbUqaFkXnaAIuQR9VLqWQ
	 08PtHBcUiYFd65Mz7iPQ7YIbWwys7CQM+7qDxzW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389785AbfG2ToV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:44:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:32804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389687AbfG2ToP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:44:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C8A5217D7;
        Mon, 29 Jul 2019 19:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429454;
        bh=TFqTnxju/RcqurZHbARZd4YhaMMzHJ+XMmRzD+1Pn2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uOikIoM5tlDe1fmOGUl8wTL5gFBeSVFxIu8nNxsTl1STYgn6sqWeaaKKQdtcKZt5+
         Fbz2CyhMU87iJXcMcw4NAlS+1wH3IcA7hnF596gmB71t8Jnou11defTXWHYsbvGzun
         YtdawqrH+/wrTMwwVieD/Zp6T9M+yU7AkeBWnk6E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.19 102/113] x86/speculation/mds: Apply more accurate check on hypervisor platform
Date:   Mon, 29 Jul 2019 21:23:09 +0200
Message-Id: <20190729190719.902947322@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190655.455345569@linuxfoundation.org>
References: <20190729190655.455345569@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenzhong Duan <zhenzhong.duan@oracle.com>

commit 517c3ba00916383af6411aec99442c307c23f684 upstream.

X86_HYPER_NATIVE isn't accurate for checking if running on native platform,
e.g. CONFIG_HYPERVISOR_GUEST isn't set or "nopv" is enabled.

Checking the CPU feature bit X86_FEATURE_HYPERVISOR to determine if it's
running on native platform is more accurate.

This still doesn't cover the platforms on which X86_FEATURE_HYPERVISOR is
unsupported, e.g. VMware, but there is nothing which can be done about this
scenario.

Fixes: 8a4b06d391b0 ("x86/speculation/mds: Add sysfs reporting for MDS")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1564022349-17338-1-git-send-email-zhenzhong.duan@oracle.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/bugs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1196,7 +1196,7 @@ static ssize_t l1tf_show_state(char *buf
 
 static ssize_t mds_show_state(char *buf)
 {
-	if (!hypervisor_is_type(X86_HYPER_NATIVE)) {
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
 		return sprintf(buf, "%s; SMT Host state unknown\n",
 			       mds_strings[mds_mitigation]);
 	}


