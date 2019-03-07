Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295F2C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F186920835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfCGJdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:33:24 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:49179 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCGJdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:33:24 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MmD6U-1gbG5g3kzw-00iC7E; Thu, 07 Mar 2019 10:33:12 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Christian Benvenuti <benve@cisco.com>,
        Govindarajulu Varadarajan <_govind@gmx.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] enic: fix build warning without CONFIG_CPUMASK_OFFSTACK
Date:   Thu,  7 Mar 2019 10:33:02 +0100
Message-Id: <20190307093311.3406888-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ElMFlO3oxbtfllvKKFpnrClWzaq4TOMo9BSVLmhjv+IsBLzPz9z
 5nweVAfoNs6YB3x3S289Uo2rj79EP1Q/imX1jwfhn2UnEixPhjVQWDRW7yGlqan127esPmQ
 g/mkuDiWapjz54M9ZoWRCkR+Wh3PQoZ32wLW2zYpsj4vQ0Sx4DIq2aHk0D/CnN1yrmLVIWL
 2PGGB9eFHCS3v3gOzDg1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TqoGyw5RBgg=:7lgFSaI0OFLIKbwuzEB7K9
 /giQjRL89z6mcYkW9GEzsHeocr9+UB7LLCneXnjFuUfyIBem61W43xzMHAXdkx0Cbg0G1y8nm
 oRosXRmn17HEBDR2SEgwGaMpoX0rD88VoXdTakDqZ0bPrqvbwaBsabcdzoBLPiytSLHHRDkz2
 rGhuaMCLpuQ9xhSaL3TQAfqOpwK2VKkRf2bn6ijjnijMdR2Jy2GfsJQFS18Z9BGFCJUnRDZNp
 AlNN0wYbBgEpkZHbM911w0+ILvqm+C3hONQC2RuBVo4XjG+q7rlxFIIyqMZnEf6UF3nKefUgX
 Ri5JKTR7nAxRlsLVEdJGHTdqDsa7Gj4kSHON5n+pdheEGyvyd3QagdFBcBvZ3heYcXPsab9kt
 EQOm9Fwpizivg2UvVZIsh0MboIhxLF7FNbr7kJCg4bfbYWI2M/NTca6+QNE+AU7ponN4SC2qg
 EZfUg21JvhQzjmNWuJHzqqE8LE0WJWhn0/96LGz69yfC0TZN85pUm9BsFo+CNltIIjyuEYrzX
 S+D+OdAUTboRdZglgOBQnVGLvCYmJ1wW9Mkn+WEKB5WdsolMotqcWWG4b6BhyW/dCPVDUMZ4I
 hoxuQYk5Rfhfa3UGyJCkQJ6DQW/xSg84mMsePgkb0oahi+ZzY5Enl/IEoaOYxefdjfAmHWwDl
 5rd7j5FppGag9E5n5ARZRSUUNoxw76/t6ANcmJZS0rWgNLUHUG5RWA2W3RJRADrFbe/BpKXD2
 2d0Jj96paklykVrQjzPL2Txn7wFyMGrq3osWUA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enic driver relies on the CONFIG_CPUMASK_OFFSTACK feature to
dynamically allocate a struct member, but this is normally intended for
local variables.

Building with clang, I get a warning for a few locations that check the
address of the cpumask_var_t:

drivers/net/ethernet/cisco/enic/enic_main.c:122:22: error: address of array 'enic->msix[i].affinity_mask' will always evaluate to 'true' [-Werror,-Wpointer-bool-conversion]

As far as I can tell, the code is still correct, as the truth value of
the pointer is what we need in this configuration.  To get rid of the
warning, I split out the check into a separate function, and hide that
portion if CONFIG_CPUMASK_OFFSTACK is disabled.

Fixes: 322cf7e3a4e8 ("enic: assign affinity hint to interrupts")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 9a7f70db20c7..f652a8bd163e 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -112,6 +112,15 @@ static struct enic_intr_mod_range mod_range[ENIC_MAX_LINK_SPEEDS] = {
 	{3,  6}, /* 10 - 40 Gbps */
 };
 
+static inline int enic_affinity_mask_empty(struct enic *enic, int i)
+{
+#ifdef CONFIG_CPUMASK_OFFSTACK
+	if (!enic->msix[i].affinity_mask)
+		return 1;
+#endif
+	return cpumask_empty(enic->msix[i].affinity_mask);
+}
+
 static void enic_init_affinity_hint(struct enic *enic)
 {
 	int numa_node = dev_to_node(&enic->pdev->dev);
@@ -119,8 +128,7 @@ static void enic_init_affinity_hint(struct enic *enic)
 
 	for (i = 0; i < enic->intr_count; i++) {
 		if (enic_is_err_intr(enic, i) || enic_is_notify_intr(enic, i) ||
-		    (enic->msix[i].affinity_mask &&
-		     !cpumask_empty(enic->msix[i].affinity_mask)))
+		    !enic_affinity_mask_empty(enic, i))
 			continue;
 		if (zalloc_cpumask_var(&enic->msix[i].affinity_mask,
 				       GFP_KERNEL))
@@ -148,8 +156,7 @@ static void enic_set_affinity_hint(struct enic *enic)
 	for (i = 0; i < enic->intr_count; i++) {
 		if (enic_is_err_intr(enic, i)		||
 		    enic_is_notify_intr(enic, i)	||
-		    !enic->msix[i].affinity_mask	||
-		    cpumask_empty(enic->msix[i].affinity_mask))
+		    enic_affinity_mask_empty(enic, i))
 			continue;
 		err = irq_set_affinity_hint(enic->msix_entry[i].vector,
 					    enic->msix[i].affinity_mask);
@@ -161,8 +168,7 @@ static void enic_set_affinity_hint(struct enic *enic)
 	for (i = 0; i < enic->wq_count; i++) {
 		int wq_intr = enic_msix_wq_intr(enic, i);
 
-		if (enic->msix[wq_intr].affinity_mask &&
-		    !cpumask_empty(enic->msix[wq_intr].affinity_mask))
+		if (!enic_affinity_mask_empty(enic, wq_intr))
 			netif_set_xps_queue(enic->netdev,
 					    enic->msix[wq_intr].affinity_mask,
 					    i);
-- 
2.20.0

