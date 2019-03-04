Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD09C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AED320830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="DK8DwhUs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfCDOeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:34:21 -0500
Received: from smtp65.iad3a.emailsrvr.com ([173.203.187.65]:46852 "EHLO
        smtp65.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726095AbfCDOeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:34:21 -0500
Received: from smtp1.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp1.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 47D115C8E;
        Mon,  4 Mar 2019 09:34:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1551710059;
        bh=qyjfk7ShMOHNghs1hLCxsg9fKVB4zw67M/LGPp9fxmk=;
        h=From:To:Subject:Date:From;
        b=DK8DwhUsOJPjm2bmWAxvagzSoXLOG/0Zo52UMZANWLSM2x2N734XxHJQ+wl25XKsk
         A0w9dchf3AAzY3cREwjIGTuuVayj7CVPo29dsVk3x60XAgsTHaf8BuOHL6g6ysB7Ya
         7mmz1EVAjKxpE60lPMdKV39+uINVO9EVDC/HTWb0=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp1.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 2FD345CEE;
        Mon,  4 Mar 2019 09:34:18 -0500 (EST)
X-Sender-Id: abbotti@mev.co.uk
Received: from ian-deb.inside.mev.co.uk (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256)
        by 0.0.0.0:465 (trex/5.7.12);
        Mon, 04 Mar 2019 09:34:19 -0500
From:   Ian Abbott <abbotti@mev.co.uk>
To:     devel@driverdev.osuosl.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Spencer E . Olson" <olsonse@umich.edu>
Subject: [PATCH] staging: comedi: ni_mio_common: Fix divide-by-zero for DIO cmdtest
Date:   Mon,  4 Mar 2019 14:33:54 +0000
Message-Id: <20190304143354.4964-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`ni_cdio_cmdtest()` validates Comedi asynchronous commands for the DIO
subdevice (subdevice 2) of supported National Instruments M-series
cards.  It is called when handling the `COMEDI_CMD` and `COMEDI_CMDTEST`
ioctls for this subdevice.  There are two causes for a possible
divide-by-zero error when validating that the `stop_arg` member of the
passed-in command is not too large.

The first cause for the divide-by-zero is that calls to
`comedi_bytes_per_scan()` are only valid once the command has been
copied to `s->async->cmd`, but that copy is only done for the
`COMEDI_CMD` ioctl.  For the `COMEDI_CMDTEST` ioctl, it will use
whatever was left there by the previous `COMEDI_CMD` ioctl, if any.
(This is very likely, as it is usual for the application to use
`COMEDI_CMDTEST` before `COMEDI_CMD`.) If there has been no previous,
valid `COMEDI_CMD` for this subdevice, then `comedi_bytes_per_scan()`
will return 0, so the subsequent division in `ni_cdio_cmdtest()` of
`s->async->prealloc_bufsz / comedi_bytes_per_scan(s)` will be a
divide-by-zero error.  To fix this error, call a new function
`comedi_bytes_per_scan_cmd(s, cmd)`, based on the existing
`comedi_bytes_per_scan(s)` but using a specified `struct comedi_cmd` for
its calculations.  (Also refactor `comedi_bytes_per_scan()` to call the
new function.)

Once the first cause for the divide-by-zero has been fixed, the second
cause is that `comedi_bytes_per_scan_cmd()` can legitimately return 0 if
the `scan_end_arg` member of the `struct comedi_cmd` being tested is 0.
Fix it by only performing the division (and validating that `stop_arg`
is no more than the maximum value) if `comedi_bytes_per_scan_cmd()`
returns a non-zero value.

The problem was reported on the COMEDI mailing list here:
https://groups.google.com/forum/#!topic/comedi_list/4t9WlHzMhKM

Fixes: f164cbf98fa8 ("staging: comedi: ni_mio_common: add finite regeneration to dio output")
Cc: <stable@vger.kernel.org> # 4.6+
Cc: Spencer E. Olson <olsonse@umich.edu>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/staging/comedi/comedidev.h            |  2 ++
 drivers/staging/comedi/drivers.c              | 33 ++++++++++++++++---
 .../staging/comedi/drivers/ni_mio_common.c    | 10 ++++--
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/comedi/comedidev.h b/drivers/staging/comedi/comedidev.h
index a7d569cfca5d..0dff1ac057cd 100644
--- a/drivers/staging/comedi/comedidev.h
+++ b/drivers/staging/comedi/comedidev.h
@@ -1001,6 +1001,8 @@ int comedi_dio_insn_config(struct comedi_device *dev,
 			   unsigned int mask);
 unsigned int comedi_dio_update_state(struct comedi_subdevice *s,
 				     unsigned int *data);
+unsigned int comedi_bytes_per_scan_cmd(struct comedi_subdevice *s,
+				       struct comedi_cmd *cmd);
 unsigned int comedi_bytes_per_scan(struct comedi_subdevice *s);
 unsigned int comedi_nscans_left(struct comedi_subdevice *s,
 				unsigned int nscans);
diff --git a/drivers/staging/comedi/drivers.c b/drivers/staging/comedi/drivers.c
index eefa62f42c0f..5a32b8fc000e 100644
--- a/drivers/staging/comedi/drivers.c
+++ b/drivers/staging/comedi/drivers.c
@@ -394,11 +394,13 @@ unsigned int comedi_dio_update_state(struct comedi_subdevice *s,
 EXPORT_SYMBOL_GPL(comedi_dio_update_state);
 
 /**
- * comedi_bytes_per_scan() - Get length of asynchronous command "scan" in bytes
+ * comedi_bytes_per_scan_cmd() - Get length of asynchronous command "scan" in
+ * bytes
  * @s: COMEDI subdevice.
+ * @cmd: COMEDI command.
  *
  * Determines the overall scan length according to the subdevice type and the
- * number of channels in the scan.
+ * number of channels in the scan for the specified command.
  *
  * For digital input, output or input/output subdevices, samples for
  * multiple channels are assumed to be packed into one or more unsigned
@@ -408,9 +410,9 @@ EXPORT_SYMBOL_GPL(comedi_dio_update_state);
  *
  * Returns the overall scan length in bytes.
  */
-unsigned int comedi_bytes_per_scan(struct comedi_subdevice *s)
+unsigned int comedi_bytes_per_scan_cmd(struct comedi_subdevice *s,
+				       struct comedi_cmd *cmd)
 {
-	struct comedi_cmd *cmd = &s->async->cmd;
 	unsigned int num_samples;
 	unsigned int bits_per_sample;
 
@@ -427,6 +429,29 @@ unsigned int comedi_bytes_per_scan(struct comedi_subdevice *s)
 	}
 	return comedi_samples_to_bytes(s, num_samples);
 }
+EXPORT_SYMBOL_GPL(comedi_bytes_per_scan_cmd);
+
+/**
+ * comedi_bytes_per_scan() - Get length of asynchronous command "scan" in bytes
+ * @s: COMEDI subdevice.
+ *
+ * Determines the overall scan length according to the subdevice type and the
+ * number of channels in the scan for the current command.
+ *
+ * For digital input, output or input/output subdevices, samples for
+ * multiple channels are assumed to be packed into one or more unsigned
+ * short or unsigned int values according to the subdevice's %SDF_LSAMPL
+ * flag.  For other types of subdevice, samples are assumed to occupy a
+ * whole unsigned short or unsigned int according to the %SDF_LSAMPL flag.
+ *
+ * Returns the overall scan length in bytes.
+ */
+unsigned int comedi_bytes_per_scan(struct comedi_subdevice *s)
+{
+	struct comedi_cmd *cmd = &s->async->cmd;
+
+	return comedi_bytes_per_scan_cmd(s, cmd);
+}
 EXPORT_SYMBOL_GPL(comedi_bytes_per_scan);
 
 static unsigned int __comedi_nscans_left(struct comedi_subdevice *s,
diff --git a/drivers/staging/comedi/drivers/ni_mio_common.c b/drivers/staging/comedi/drivers/ni_mio_common.c
index 5edf59ac6706..b04dad8c7092 100644
--- a/drivers/staging/comedi/drivers/ni_mio_common.c
+++ b/drivers/staging/comedi/drivers/ni_mio_common.c
@@ -3545,6 +3545,7 @@ static int ni_cdio_cmdtest(struct comedi_device *dev,
 			   struct comedi_subdevice *s, struct comedi_cmd *cmd)
 {
 	struct ni_private *devpriv = dev->private;
+	unsigned int bytes_per_scan;
 	int err = 0;
 
 	/* Step 1 : check if triggers are trivially valid */
@@ -3579,9 +3580,12 @@ static int ni_cdio_cmdtest(struct comedi_device *dev,
 	err |= comedi_check_trigger_arg_is(&cmd->convert_arg, 0);
 	err |= comedi_check_trigger_arg_is(&cmd->scan_end_arg,
 					   cmd->chanlist_len);
-	err |= comedi_check_trigger_arg_max(&cmd->stop_arg,
-					    s->async->prealloc_bufsz /
-					    comedi_bytes_per_scan(s));
+	bytes_per_scan = comedi_bytes_per_scan_cmd(s, cmd);
+	if (bytes_per_scan) {
+		err |= comedi_check_trigger_arg_max(&cmd->stop_arg,
+						    s->async->prealloc_bufsz /
+						    bytes_per_scan);
+	}
 
 	if (err)
 		return 3;
-- 
2.20.1

