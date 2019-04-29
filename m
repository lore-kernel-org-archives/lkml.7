Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E66C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE6C206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfD2GLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 02:11:38 -0400
Received: from www.osadl.org ([62.245.132.105]:41116 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbfD2GLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 02:11:38 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x3T6BEmb005090;
        Mon, 29 Apr 2019 08:11:27 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH V3] staging: fieldbus: anybus-s: consolidate wait_for_completion_timeout return handling
Date:   Mon, 29 Apr 2019 08:05:40 +0200
Message-Id: <1556517940-13725-2-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1556517940-13725-1-git-send-email-hofrat@osadl.org>
References: <1556517940-13725-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wait_for_completion_timeout() returns unsigned long (0 on timeout or
remaining jiffies) not int - so this type error allows for a
theoretically int overflow - though not in this case where TIMEOUT is
only HZ*2). To fix this type inconsistency the completion is wrapped
into the if() rather than introducing an additional unsigned long
variable. 

Along with fixing this type inconsistency the fall-through if is
consolidated to a single if-block.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem located with experimental API conformance checking cocci script

V3: As requested by Sven Van Asbroeck <thesven73@gmail.com> cleanup
    the commit message to make it more clear what the impact of the
    proposed change is....lets see if this is any better.

V2: The original patch's logic was wrong as it was skipping the 
    fall-through if so using the fix proposed by Sven Van Asbroeck 
    <thesven73@gmail.com> - This solution also eliminates the need
    to introduce an additional variable - Thanks !

Patch was compile-tested with. x86_64_defconfig + OF=y, FIELDBUS_DEV=m,
HMS_ANYBUSS_BUS=m
(with an unrelated sparse warnings (cast to restricted __be16))

Patch is against 5.1-rc6 (localversion-next is next-20190426)

 drivers/staging/fieldbus/anybuss/host.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fieldbus/anybuss/host.c b/drivers/staging/fieldbus/anybuss/host.c
index e34d424..6227daf 100644
--- a/drivers/staging/fieldbus/anybuss/host.c
+++ b/drivers/staging/fieldbus/anybuss/host.c
@@ -1325,11 +1325,11 @@ anybuss_host_common_probe(struct device *dev,
 	 *   interrupt came in: ready to go !
 	 */
 	reset_deassert(cd);
-	ret = wait_for_completion_timeout(&cd->card_boot, TIMEOUT);
-	if (ret == 0)
+	if (!wait_for_completion_timeout(&cd->card_boot, TIMEOUT)) {
 		ret = -ETIMEDOUT;
-	if (ret < 0)
 		goto err_reset;
+	}
+
 	/*
 	 * according to the anybus docs, we're allowed to read these
 	 * without handshaking / reserving the area
-- 
2.1.4

