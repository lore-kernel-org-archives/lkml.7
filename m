Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472F2C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 04:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186B2208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 04:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfD0Ec3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 00:32:29 -0400
Received: from www.osadl.org ([62.245.132.105]:38968 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbfD0Ec3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 00:32:29 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x3R4WJYI018783;
        Sat, 27 Apr 2019 06:32:19 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH RFC] staging: fieldbus: anybus-s: use proper type for wait_for_completion_timeout
Date:   Sat, 27 Apr 2019 06:26:48 +0200
Message-Id: <1556339208-7722-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wait_for_completion_timeout() returns unsigned long (0 on timeout or
remaining jiffies) not int. thus there is no negative case to check for 
here.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem located with experimental API conformance checking cocci script

Q: It is not really clear if the proposed fix is the right thing here or if
   this should not be using wait_for_completion_interruptible - which would
   return -ERESTARTSYS on interruption. Someone that knows the details of
   this driver would need to check what condition should initiate the
   goto err_reset; which was actually unreachable in the current code.

Patch was compile-tested with. x86_64_defconfig + FIELDBUS_DEV=m,
HMS_ANYBUSS_BUS=m
(some unrelated sparse warnings (cast to restricted __be16))

Patch is against 5.1-rc6 (localversion-next is next-20190426)

 drivers/staging/fieldbus/anybuss/host.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/fieldbus/anybuss/host.c b/drivers/staging/fieldbus/anybuss/host.c
index e34d424..c52d715 100644
--- a/drivers/staging/fieldbus/anybuss/host.c
+++ b/drivers/staging/fieldbus/anybuss/host.c
@@ -1263,6 +1263,7 @@ anybuss_host_common_probe(struct device *dev,
 			  const struct anybuss_ops *ops)
 {
 	int ret, i;
+	unsigned long time_left;
 	u8 val[4];
 	u16 fieldbus_type;
 	struct anybuss_host *cd;
@@ -1325,11 +1326,9 @@ anybuss_host_common_probe(struct device *dev,
 	 *   interrupt came in: ready to go !
 	 */
 	reset_deassert(cd);
-	ret = wait_for_completion_timeout(&cd->card_boot, TIMEOUT);
-	if (ret == 0)
+	time_left = wait_for_completion_timeout(&cd->card_boot, TIMEOUT);
+	if (time_left == 0)
 		ret = -ETIMEDOUT;
-	if (ret < 0)
-		goto err_reset;
 	/*
 	 * according to the anybus docs, we're allowed to read these
 	 * without handshaking / reserving the area
-- 
2.1.4

