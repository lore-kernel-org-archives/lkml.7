Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D005CC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A006D2072B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519747;
	bh=wvmeNpa027W1i5Q2eKJqK3An4IqirvgMkON7GabCJCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iTJCKvZsx72dtGRbVkzeR6lm+Lozkk8v1o9JhgHvq6CEMZ+TUPmmXkEAnLJVPGenO
	 b+WmowZvYjEPoLL7Mv7ecxWbn/UB/uo/CwVt3F+FSjAsdfDHuX+aDDWsh7xrVI2+XX
	 YOZ2duZYHr1pvWSN+yLUP1DW50GQOX7CBDXsatCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbfLPSJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:09:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:51056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729898AbfLPSJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:09:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C52E20700;
        Mon, 16 Dec 2019 18:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519742;
        bh=wvmeNpa027W1i5Q2eKJqK3An4IqirvgMkON7GabCJCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j4QneX6dvbg2ZAVEe3lCBInRn8g1CTQHX1vny6BlY/6kdBC9AqfkUYq9mURYKa5Pb
         Ft1+ShPnl1S+kDRLVQbcvboqD8chXm43Huq+bYSR+5ZK2MoUOfyGDHwbe0XE9GWFQi
         A2RcJZEH2Lh2FCF/eD8D2DtBrWPIr2dDRjae0+sI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thinh Nguyen <thinhn@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 5.3 050/180] usb: dwc3: gadget: Clear started flag for non-IOC
Date:   Mon, 16 Dec 2019 18:48:10 +0100
Message-Id: <20191216174822.817319138@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174806.018988360@linuxfoundation.org>
References: <20191216174806.018988360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

commit d3abda5a98a18e524e17fd4085c9f4bd53e9ef53 upstream.

Normally the END_TRANSFER command completion handler will clear the
DWC3_EP_TRANSFER_STARTED flag. However, if the command was sent without
interrupt on completion, then the flag will not be cleared. Make sure to
clear the flag in this case.

Cc: stable@vger.kernel.org
Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/gadget.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2699,6 +2699,9 @@ static void dwc3_stop_active_transfer(st
 	WARN_ON_ONCE(ret);
 	dep->resource_index = 0;
 
+	if (!interrupt)
+		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
+
 	if (dwc3_is_usb31(dwc) || dwc->revision < DWC3_REVISION_310A)
 		udelay(100);
 }


