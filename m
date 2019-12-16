Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7374CC2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DF4207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520221;
	bh=NwxrMIBvLQ1k8xz/dopXirh2vs38YyqGeyRGmwIJV6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z4a2hiTAFFLDocDu8gnLbGuS+khxyIoA9yI68t7jMKChi41khbEwfJLJlSy9ZGR5V
	 4iThkrVfrWthnuDmLyyHi016aXF2SF59D8QoAvEv+hV6Q2RG532inNgoJdeTCjM6iE
	 8Y/4ALf7RWaXvcYtqD/oI8tLHQyt46W/kLxLo8+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731615AbfLPSQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:16:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:40054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731369AbfLPSQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:16:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9B0D206E0;
        Mon, 16 Dec 2019 18:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520213;
        bh=NwxrMIBvLQ1k8xz/dopXirh2vs38YyqGeyRGmwIJV6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GuZ94/AD4w4wsBvph9UYkUSX7DZ+6fbLp5Wp6Ns8ypDAZYsZAKrvhIJl1Lh5oa722
         /N7KuLdRScuIu99/gwkmrUkNtBePS79zFPdE8dfhD/HUZ/2IFN4AzXx2dooWGmO7NX
         T1jwGRKCCM7/Hxlshqpf42jvUOKCsWpv8PU4VGAg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thinh Nguyen <thinhn@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 5.4 062/177] usb: dwc3: ep0: Clear started flag on completion
Date:   Mon, 16 Dec 2019 18:48:38 +0100
Message-Id: <20191216174831.724164372@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

commit 2d7b78f59e020b07fc6338eefe286f54ee2d6773 upstream.

Clear ep0's DWC3_EP_TRANSFER_STARTED flag if the END_TRANSFER command is
completed. Otherwise, we can't start control transfer again after
END_TRANSFER.

Cc: stable@vger.kernel.org
Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/ep0.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -1117,6 +1117,9 @@ static void dwc3_ep0_xfernotready(struct
 void dwc3_ep0_interrupt(struct dwc3 *dwc,
 		const struct dwc3_event_depevt *event)
 {
+	struct dwc3_ep	*dep = dwc->eps[event->endpoint_number];
+	u8		cmd;
+
 	switch (event->endpoint_event) {
 	case DWC3_DEPEVT_XFERCOMPLETE:
 		dwc3_ep0_xfer_complete(dwc, event);
@@ -1129,7 +1132,12 @@ void dwc3_ep0_interrupt(struct dwc3 *dwc
 	case DWC3_DEPEVT_XFERINPROGRESS:
 	case DWC3_DEPEVT_RXTXFIFOEVT:
 	case DWC3_DEPEVT_STREAMEVT:
+		break;
 	case DWC3_DEPEVT_EPCMDCMPLT:
+		cmd = DEPEVT_PARAMETER_CMD(event->parameters);
+
+		if (cmd == DWC3_DEPCMD_ENDTRANSFER)
+			dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 		break;
 	}
 }


