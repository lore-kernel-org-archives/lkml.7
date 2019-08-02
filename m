Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CA0C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F7F206A2
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564739547;
	bh=JhVQ6HvL8lgdRKvB0Rs7J5y76zHkECUXeabJ9WDEpQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CBvesKqpwKqaYn6R2bS6ix9LEYiIq9a6OlfF60yLE+jQHmTv3XQzTeqOoJilA+Fee
	 wV8IsqFFuXa2jkIq2RRnOigfyuPDw0UVwABXuU7ucFCZSqiZO5z7bRLhsQjW/IPbPs
	 hm8Iw38br44jwoWEQQtHWMlPpct3MEvu7AjHrPrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390239AbfHBJw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:52:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405506AbfHBJwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:52:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD0C12087E;
        Fri,  2 Aug 2019 09:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564739541;
        bh=JhVQ6HvL8lgdRKvB0Rs7J5y76zHkECUXeabJ9WDEpQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PFOuOVmSIpw3lduU+UHIeiPzhqEjYPahsM1NWCGac6FtFa8ure+Z4Dba5872Oz9ch
         BPbrUunZbFEjo9IVRms0XRP7rBm5711M47MFMmZK0fiH2mF3WWMrTiCUD8sGJYv6Hn
         8cRev063lDGOoL8Nbp8BxY64kW/YSPJ0sAYNYbXc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.9 205/223] x86/speculation/mds: Apply more accurate check on hypervisor platform
Date:   Fri,  2 Aug 2019 11:37:10 +0200
Message-Id: <20190802092250.298635264@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092238.692035242@linuxfoundation.org>
References: <20190802092238.692035242@linuxfoundation.org>
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
@@ -1205,7 +1205,7 @@ static ssize_t l1tf_show_state(char *buf
 static ssize_t mds_show_state(char *buf)
 {
 #ifdef CONFIG_HYPERVISOR_GUEST
-	if (x86_hyper) {
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
 		return sprintf(buf, "%s; SMT Host state unknown\n",
 			       mds_strings[mds_mitigation]);
 	}


