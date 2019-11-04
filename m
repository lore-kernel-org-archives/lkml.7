Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F168CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A03B204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572906044;
	bh=1+u1DkWnQPvDJmZtTN8GhHQZL6ffowQ+Ec2hlERuOeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FBtkE0b5W2FStdUmUyLA5L5D1kqTaykSGRP9XBcA+H8EramrBleozzcLfsFMIbVaW
	 S3TCOPC6CyHakL41c701s7QqQhWAT5K3lmiKoJE2yfsTCFnbsDY375iDs8pdVxRfMv
	 EH2gtHPYdye0jEXWz4H54cK5MC/Nu6lI8iSqo3AA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbfKDV7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:59:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:56252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731012AbfKDV7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:59:07 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF2B5214E0;
        Mon,  4 Nov 2019 21:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904746;
        bh=1+u1DkWnQPvDJmZtTN8GhHQZL6ffowQ+Ec2hlERuOeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Npxs0+x8K0CdnJVgiM5+MBgRQUVdRxjboJ7dcSRwjB3Z+pRzP4hYbKPbP2Sb376Z3
         CVQ02Go3G98HqOA6W6j6+3mHumed7afF7Ivuvs/EKMRghqLwfbT7QUefcRYx/m/nto
         h4eBCXgwOskQWUIsV5jTU/BlXRx+nqSGa8ddQcqk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thinh Nguyen <thinhn@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 038/149] usb: dwc3: gadget: early giveback if End Transfer already completed
Date:   Mon,  4 Nov 2019 22:43:51 +0100
Message-Id: <20191104212138.439588864@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212126.090054740@linuxfoundation.org>
References: <20191104212126.090054740@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felipe Balbi <felipe.balbi@linux.intel.com>

[ Upstream commit 9f45581f5eec6786c6eded2b3c85345d82a910c9 ]

There is a rare race condition that may happen during a Disconnect
Interrupt if we have a started request that happens to be
dequeued *after* completion of End Transfer command. If that happens,
that request will be left waiting for completion of an End Transfer
command that will never happen.

If End Transfer command has already completed before, we are safe to
giveback the request straight away.

Tested-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index e7461c995116a..7b0957c530485 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1410,7 +1410,10 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 				goto out0;
 
 			dwc3_gadget_move_cancelled_request(req);
-			goto out0;
+			if (dep->flags & DWC3_EP_TRANSFER_STARTED)
+				goto out0;
+			else
+				goto out1;
 		}
 		dev_err(dwc->dev, "request %pK was not queued to %s\n",
 				request, ep->name);
@@ -1418,6 +1421,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 		goto out0;
 	}
 
+out1:
 	dwc3_gadget_giveback(dep, req, -ECONNRESET);
 
 out0:
-- 
2.20.1



