Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AE2C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 23:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43392214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 23:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfDRXhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 19:37:08 -0400
Received: from www.osadl.org ([62.245.132.105]:52380 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbfDRXhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 19:37:07 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x3INaWCx006335;
        Fri, 19 Apr 2019 01:36:32 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Eric Anholt <eric@anholt.net>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dominic Braun <inf.braun@fau.de>,
        Tobias Buettner <tobias.buettner@fau.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Phil Elwell <phil@raspberrypi.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH V2] staging: vc04_services: handle kzalloc failure
Date:   Fri, 19 Apr 2019 01:31:08 +0200
Message-Id: <1555630268-17017-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kzalloc here was being used without checking the return - if the
kzalloc fails return VCHIQ_ERROR. The call-site of
vchiq_platform_init_state() vchiq_init_state() was not responding
to an allocation failure so checks for != VCHIQ_SUCCESS
and pass VCHIQ_ERROR up to vchiq_platform_init() which then
will fail with -EINVAL.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Reported-by: kbuild test robot <lkp@intel.com>
---

Problem located with experimental coccinelle script

V2: The != VCHIQ_SUCCES went unnoticed not clear how I did that as
    building drivers/staging/vc04_services/vchiq.o seemed to have succeeded
    anyway kbuild test found it. This is one of the disadvantages if one
    can not make path/file.o due to missing Makefiles and is required to
    build entire directories for compile-testing, I suspect that I did not
    clean the directory before compile-testing the patch.
    

Patch was compile-tested with: bcm2835_defconfig (implies BCM2835_VCHIQ=m)
(with sparse warning:
  CHECK   drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c:410:29: warning: incorrect type in argument 1 (different address spaces)
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c:410:29:    expected void const *x
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c:410:29:    got char [noderef] <asn:1> *buf
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c:416:63: warning: incorrect type in argument 1 (different address spaces)
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c:416:63:    expected void const *addr
drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c:416:63:    got char [noderef] <asn:1> *
  CC [M]  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.o
Q: should this buf have been remapped to user space e.g. remap_vmalloc_range ?

Patch is against 5.1-rc5 (localversion next is 20190417)

 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c | 3 +++
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c     | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index 31eb7d5..a9a2291 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -179,6 +179,9 @@ vchiq_platform_init_state(struct vchiq_state *state)
 	struct vchiq_2835_state *platform_state;
 
 	state->platform_state = kzalloc(sizeof(*platform_state), GFP_KERNEL);
+	if (!state->platform_state)
+		return VCHIQ_ERROR;
+
 	platform_state = (struct vchiq_2835_state *)state->platform_state;
 
 	platform_state->inited = 1;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 6057a90..92e6221 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -2209,6 +2209,8 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero)
 	local->debug[DEBUG_ENTRIES] = DEBUG_MAX;
 
 	status = vchiq_platform_init_state(state);
+	if (status != VCHIQ_SUCCESS)
+		return VCHIQ_ERROR;
 
 	/*
 		bring up slot handler thread
-- 
2.1.4

