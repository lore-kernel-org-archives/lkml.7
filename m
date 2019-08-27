Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6075FC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241DD206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566893783;
	bh=ZU3M9rnuahrcRidXoudEmh8DLigZ1+VkOM2Way1zUBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EMjoxOO0azIPkUjv4yHeRHAs4Ct+xT6dDv00uG875tQtNd4DFa3lxhN2WSZ4jIRsZ
	 GSR2+E+q65hOJwTA0Apz3uSyvb0SnHjnCla/efnzztPgsotpkN+rwPqtQ6e74Mtyfq
	 MwE1LpR/atfJsUE7yAY4qkhKzQGaADCMDJK9pGXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbfH0HyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:54:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbfH0Hxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:53:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11AD0206BA;
        Tue, 27 Aug 2019 07:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892435;
        bh=ZU3M9rnuahrcRidXoudEmh8DLigZ1+VkOM2Way1zUBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nP46jL0nnQluSZBSGxlPCkeI8hUNNKIjeGILITYJgiMjBFqyBYOuIBT8muf+gvHHT
         hjZfLHaDdML73G2dWH2Jo5mvO10bQn+F0CYX5Y0NE4jILkLhJzcG0q7lHMy3dYFQJQ
         lQ1Xov0pPa3EBFz50HH+WX4lQjK+jvMV/1Z6M/EQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bob Ham <bob.ham@puri.sm>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 12/62] net: usb: qmi_wwan: Add the BroadMobi BM818 card
Date:   Tue, 27 Aug 2019 09:50:17 +0200
Message-Id: <20190827072701.061639225@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072659.803647352@linuxfoundation.org>
References: <20190827072659.803647352@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 9a07406b00cdc6ec689dc142540739575c717f3c ]

The BroadMobi BM818 M.2 card uses the QMI protocol

Signed-off-by: Bob Ham <bob.ham@puri.sm>
Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 4b0144b2a2523..e2050afaab7a8 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1220,6 +1220,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x2001, 0x7e35, 4)},	/* D-Link DWM-222 */
 	{QMI_FIXED_INTF(0x2020, 0x2031, 4)},	/* Olicard 600 */
 	{QMI_FIXED_INTF(0x2020, 0x2033, 4)},	/* BroadMobi BM806U */
+	{QMI_FIXED_INTF(0x2020, 0x2060, 4)},	/* BroadMobi BM818 */
 	{QMI_FIXED_INTF(0x0f3d, 0x68a2, 8)},    /* Sierra Wireless MC7700 */
 	{QMI_FIXED_INTF(0x114f, 0x68a2, 8)},    /* Sierra Wireless MC7750 */
 	{QMI_FIXED_INTF(0x1199, 0x68a2, 8)},	/* Sierra Wireless MC7710 in QMI mode */
-- 
2.20.1



