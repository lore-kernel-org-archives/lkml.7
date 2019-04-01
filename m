Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A7DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3D720883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138996;
	bh=ggtC53fxRdcxyKXrrReDnGYCzRpV7Z8LyDt0a25gs1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yl1bUFKsMvcQYvb0vf4+NlZkDgzJoACvWEbGXKdxAnyB7OhpmNBNFLXYSaeoN7XjD
	 0Dr04VDFGgS+ZQMOExIFlCfREpBLYzG1fNBC2yrlJRutYvt/+Vdjdwm0uux9Xcp3nr
	 S+fzK6YBxM3F67lrqNLJhq5PgJcrVkBBpVlzlQNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfDARQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:16:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731020AbfDARQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:16:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35A6321473;
        Mon,  1 Apr 2019 17:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138989;
        bh=ggtC53fxRdcxyKXrrReDnGYCzRpV7Z8LyDt0a25gs1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JUI2/rVEfrFxncnt9yCfa6ePpySd6X6Exs7fDIKtJdDrZXEqkuizGPZkJQ0ESYhSy
         bHeElEfPWAOQwv4ALGbOeJ4lqTbmp2Pmn0zvtPitbEbdAID7CkbfnobkcaIVW7p2c+
         YNEk70HNdRK1lkjJYbwCHLT+IWK6FrM6MGCcYwzo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ivan Vasilyev <grabesstimme@gmail.com>,
        "Spencer E. Olson" <olsonse@umich.edu>,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 4.19 081/134] staging: comedi: ni_mio_common: Fix divide-by-zero for DIO cmdtest
Date:   Mon,  1 Apr 2019 19:01:57 +0200
Message-Id: <20190401170051.934736462@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Abbott <abbotti@mev.co.uk>

commit bafd9c64056cd034a1174dcadb65cd3b294ff8f6 upstream.

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

Reported-by: Ivan Vasilyev <grabesstimme@gmail.com>
Tested-by: Ivan Vasilyev <grabesstimme@gmail.com>
Fixes: f164cbf98fa8 ("staging: comedi: ni_mio_common: add finite regeneration to dio output")
Cc: <stable@vger.kernel.org> # 4.6+
Cc: Spencer E. Olson <olsonse@umich.edu>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/comedi/comedidev.h             |    2 +
 drivers/staging/comedi/drivers.c               |   33 +++++++++++++++++++++----
 drivers/staging/comedi/drivers/ni_mio_common.c |   10 +++++--
 3 files changed, 38 insertions(+), 7 deletions(-)

--- a/drivers/staging/comedi/comedidev.h
+++ b/drivers/staging/comedi/comedidev.h
@@ -987,6 +987,8 @@ int comedi_dio_insn_config(struct comedi
 			   unsigned int mask);
 unsigned int comedi_dio_update_state(struct comedi_subdevice *s,
 				     unsigned int *data);
+unsigned int comedi_bytes_per_scan_cmd(struct comedi_subdevice *s,
+				       struct comedi_cmd *cmd);
 unsigned int comedi_bytes_per_scan(struct comedi_subdevice *s);
 unsigned int comedi_nscans_left(struct comedi_subdevice *s,
 				unsigned int nscans);
--- a/drivers/staging/comedi/drivers.c
+++ b/drivers/staging/comedi/drivers.c
@@ -381,11 +381,13 @@ unsigned int comedi_dio_update_state(str
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
@@ -395,9 +397,9 @@ EXPORT_SYMBOL_GPL(comedi_dio_update_stat
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
 
@@ -414,6 +416,29 @@ unsigned int comedi_bytes_per_scan(struc
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
--- a/drivers/staging/comedi/drivers/ni_mio_common.c
+++ b/drivers/staging/comedi/drivers/ni_mio_common.c
@@ -3516,6 +3516,7 @@ static int ni_cdio_check_chanlist(struct
 static int ni_cdio_cmdtest(struct comedi_device *dev,
 			   struct comedi_subdevice *s, struct comedi_cmd *cmd)
 {
+	unsigned int bytes_per_scan;
 	int err = 0;
 	int tmp;
 
@@ -3545,9 +3546,12 @@ static int ni_cdio_cmdtest(struct comedi
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


