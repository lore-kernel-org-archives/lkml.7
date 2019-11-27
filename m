Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61666C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373122178F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887543;
	bh=gla/T9epZxieOxWiss8ElTZqXZOTcBewGKHUizRHzyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JafHRyKD2LiVNxO26C8HFdLopMUqeV7iGdahuAt/btR+p9EJlAj32d9gw/2k9oNak
	 t2y7DJQ2GNrA/U0xKBfya4uSjmpeMZAFD+/9obL59kn0Ik0h7dvEvPUB42Y+jeweXb
	 zckAbmH2gtf9K91zdu88Z27RnyHPdJ6mTc/v7WGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfK0Upl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:45:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:56716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727835AbfK0Upj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:45:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D850B217AB;
        Wed, 27 Nov 2019 20:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887538;
        bh=gla/T9epZxieOxWiss8ElTZqXZOTcBewGKHUizRHzyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ALMAGc/sr+DR3AsdqUm+XB1PR5H27ErmnXQxcWmDajgDoAL+ANwzzc7A3jtF7hCyR
         5+7bGK2iiZefCl6YOyyqXeRZL+MZVPHcyT3eZVqE3IyxfdTrr4giOj/CsYrpZQzYGw
         RGzOqJPfdV2ymRYjtV4Dxkw1xiW2FqbcoE7P14fM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bernd Porr <mail@berndporr.me.uk>,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 4.9 148/151] staging: comedi: usbduxfast: usbduxfast_ai_cmdtest rounding error
Date:   Wed, 27 Nov 2019 21:32:11 +0100
Message-Id: <20191127203047.571694697@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bernd Porr <mail@berndporr.me.uk>

commit 5618332e5b955b4bff06d0b88146b971c8dd7b32 upstream.

The userspace comedilib function 'get_cmd_generic_timed' fills
the cmd structure with an informed guess and then calls the
function 'usbduxfast_ai_cmdtest' in this driver repeatedly while
'usbduxfast_ai_cmdtest' is modifying the cmd struct until it
no longer changes. However, because of rounding errors this never
converged because 'steps = (cmd->convert_arg * 30) / 1000' and then
back to 'cmd->convert_arg = (steps * 1000) / 30' won't be the same
because of rounding errors. 'Steps' should only be converted back to
the 'convert_arg' if 'steps' has actually been modified. In addition
the case of steps being 0 wasn't checked which is also now done.

Signed-off-by: Bernd Porr <mail@berndporr.me.uk>
Cc: <stable@vger.kernel.org> # 4.4+
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://lore.kernel.org/r/20191118230759.1727-1-mail@berndporr.me.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/comedi/drivers/usbduxfast.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

--- a/drivers/staging/comedi/drivers/usbduxfast.c
+++ b/drivers/staging/comedi/drivers/usbduxfast.c
@@ -1,5 +1,5 @@
 /*
- *  Copyright (C) 2004-2014 Bernd Porr, mail@berndporr.me.uk
+ *  Copyright (C) 2004-2019 Bernd Porr, mail@berndporr.me.uk
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -17,7 +17,7 @@
  * Description: University of Stirling USB DAQ & INCITE Technology Limited
  * Devices: [ITL] USB-DUX-FAST (usbduxfast)
  * Author: Bernd Porr <mail@berndporr.me.uk>
- * Updated: 10 Oct 2014
+ * Updated: 16 Nov 2019
  * Status: stable
  */
 
@@ -31,6 +31,7 @@
  *
  *
  * Revision history:
+ * 1.0: Fixed a rounding error in usbduxfast_ai_cmdtest
  * 0.9: Dropping the first data packet which seems to be from the last transfer.
  *      Buffer overflows in the FX2 are handed over to comedi.
  * 0.92: Dropping now 4 packets. The quad buffer has to be emptied.
@@ -359,6 +360,7 @@ static int usbduxfast_ai_cmdtest(struct
 				 struct comedi_cmd *cmd)
 {
 	int err = 0;
+	int err2 = 0;
 	unsigned int steps;
 	unsigned int arg;
 
@@ -408,11 +410,16 @@ static int usbduxfast_ai_cmdtest(struct
 	 */
 	steps = (cmd->convert_arg * 30) / 1000;
 	if (cmd->chanlist_len !=  1)
-		err |= comedi_check_trigger_arg_min(&steps,
-						    MIN_SAMPLING_PERIOD);
-	err |= comedi_check_trigger_arg_max(&steps, MAX_SAMPLING_PERIOD);
-	arg = (steps * 1000) / 30;
-	err |= comedi_check_trigger_arg_is(&cmd->convert_arg, arg);
+		err2 |= comedi_check_trigger_arg_min(&steps,
+						     MIN_SAMPLING_PERIOD);
+	else
+		err2 |= comedi_check_trigger_arg_min(&steps, 1);
+	err2 |= comedi_check_trigger_arg_max(&steps, MAX_SAMPLING_PERIOD);
+	if (err2) {
+		err |= err2;
+		arg = (steps * 1000) / 30;
+		err |= comedi_check_trigger_arg_is(&cmd->convert_arg, arg);
+	}
 
 	if (cmd->stop_src == TRIG_COUNT)
 		err |= comedi_check_trigger_arg_min(&cmd->stop_arg, 1);


