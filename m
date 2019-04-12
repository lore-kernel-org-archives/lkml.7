Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50395C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212032186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555033453;
	bh=b+3JRdiqd3xm94iRtsnB84wYg5vwpS62BhaMpIzJp+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cmH0Q0/IbKBEcRSS+IU99YTocnl4EplA/36bPzhCurfuGIgVOPzaHWb/Jzi+HZp5Q
	 BMoJT8NmjZjVg8X46bf1Vjc/UraW8RAu0mzFo8sxKn/rhI2VKFqGcZiVCSNP2jv4DN
	 3/eURlGVasi90/qrpORL/AyJXpTnJjWK3DSaY9EI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfDLBoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:44:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbfDLBoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:44:10 -0400
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [52.191.113.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F083D2184B;
        Fri, 12 Apr 2019 01:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555033449;
        bh=b+3JRdiqd3xm94iRtsnB84wYg5vwpS62BhaMpIzJp+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uyCakz6UAf5YhBO5j3uPZlvrzJK8/6bhvMuVZo5EWTD7ZEmeGQS9kdxkBfH6TEnd3
         b5LHogS4NNNFh42WlI9xhFH5Q9O6lo9d4WYeo58wwOvkK0uja9mfL7bN7wnz/sMg4R
         DDAYgZZwf4bI/+LXB8A9nNahIJLa5GG8vjufjD9U=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     josh@joshtriplett.org, keescook@chromium.org,
        Sinan Kaya <okaya@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND
        64-BIT))
Subject: [PATCH v4 2/5] powerpc: Replace CONFIG_DEBUG_KERNEL with CONFIG_DEBUG_MISC
Date:   Fri, 12 Apr 2019 01:43:52 +0000
Message-Id: <20190412014355.25307-3-okaya@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412014355.25307-1-okaya@kernel.org>
References: <20190412014355.25307-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_DEBUG_KERNEL should not impact code generation. Use the newly
defined CONFIG_DEBUG_MISC instead to keep the current code.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 arch/powerpc/kernel/sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index e8e93c2c7d03..7a1708875d27 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -610,7 +610,7 @@ SYSFS_PMCSETUP(pa6t_pmc2, SPRN_PA6T_PMC2);
 SYSFS_PMCSETUP(pa6t_pmc3, SPRN_PA6T_PMC3);
 SYSFS_PMCSETUP(pa6t_pmc4, SPRN_PA6T_PMC4);
 SYSFS_PMCSETUP(pa6t_pmc5, SPRN_PA6T_PMC5);
-#ifdef CONFIG_DEBUG_KERNEL
+#ifdef CONFIG_DEBUG_MISC
 SYSFS_SPRSETUP(hid0, SPRN_HID0);
 SYSFS_SPRSETUP(hid1, SPRN_HID1);
 SYSFS_SPRSETUP(hid4, SPRN_HID4);
@@ -639,7 +639,7 @@ SYSFS_SPRSETUP(tsr0, SPRN_PA6T_TSR0);
 SYSFS_SPRSETUP(tsr1, SPRN_PA6T_TSR1);
 SYSFS_SPRSETUP(tsr2, SPRN_PA6T_TSR2);
 SYSFS_SPRSETUP(tsr3, SPRN_PA6T_TSR3);
-#endif /* CONFIG_DEBUG_KERNEL */
+#endif /* CONFIG_DEBUG_MISC */
 #endif /* HAS_PPC_PMC_PA6T */
 
 #ifdef HAS_PPC_PMC_IBM
@@ -680,7 +680,7 @@ static struct device_attribute pa6t_attrs[] = {
 	__ATTR(pmc3, 0600, show_pa6t_pmc3, store_pa6t_pmc3),
 	__ATTR(pmc4, 0600, show_pa6t_pmc4, store_pa6t_pmc4),
 	__ATTR(pmc5, 0600, show_pa6t_pmc5, store_pa6t_pmc5),
-#ifdef CONFIG_DEBUG_KERNEL
+#ifdef CONFIG_DEBUG_MISC
 	__ATTR(hid0, 0600, show_hid0, store_hid0),
 	__ATTR(hid1, 0600, show_hid1, store_hid1),
 	__ATTR(hid4, 0600, show_hid4, store_hid4),
@@ -709,7 +709,7 @@ static struct device_attribute pa6t_attrs[] = {
 	__ATTR(tsr1, 0600, show_tsr1, store_tsr1),
 	__ATTR(tsr2, 0600, show_tsr2, store_tsr2),
 	__ATTR(tsr3, 0600, show_tsr3, store_tsr3),
-#endif /* CONFIG_DEBUG_KERNEL */
+#endif /* CONFIG_DEBUG_MISC */
 };
 #endif /* HAS_PPC_PMC_PA6T */
 #endif /* HAS_PPC_PMC_CLASSIC */
-- 
2.21.0

