Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FF1C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5420B217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558638666;
	bh=cS6/SZU13+NzdnvfzNj+aR5lm0oXHestvc7owLc3QGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NkGVjF5Wcr0AHnL3iRnxn+R8UJl31IDnLVJQAWNlDCJiMwURz9cMPCH34d+cEs4un
	 P83hQx9EChfcHJZJIRrEgQKjgpciW6FCoYbhB93dkLXH7+1ynqmyAKyQhdfV7Sc8QL
	 5dT/enNJTNrINDyPnTpKV99vjiJggUkMqJfgQBqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388071AbfEWTLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:11:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388049AbfEWTLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:11:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7295B2133D;
        Thu, 23 May 2019 19:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558638661;
        bh=cS6/SZU13+NzdnvfzNj+aR5lm0oXHestvc7owLc3QGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dFJsoSV1eu1lUx5/eWNyniJr9bKmXJfjRSfl6K3Z2253lz0ypDFThR5bNY0C49Iiz
         FGRdn4ZADx8LYT2ui+NfVWRzLtRdaJ7GOFSn8AxjLTzM5xsPqWrIeirtHLnCljNQiq
         kHkvecLcm2Pp0AzaIB/BFGuqzCSkWCfnJPl53p4I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 04/77] net: usb: qmi_wwan: add Telit 0x1260 and 0x1261 compositions
Date:   Thu, 23 May 2019 21:05:22 +0200
Message-Id: <20190523181720.637874340@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181719.982121681@linuxfoundation.org>
References: <20190523181719.982121681@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniele Palmas <dnlplm@gmail.com>

[ Upstream commit b4e467c82f8c12af78b6f6fa5730cb7dea7af1b4 ]

Added support for Telit LE910Cx 0x1260 and 0x1261 compositions.

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
Acked-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/qmi_wwan.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1225,6 +1225,8 @@ static const struct usb_device_id produc
 	{QMI_FIXED_INTF(0x1bc7, 0x1101, 3)},	/* Telit ME910 dual modem */
 	{QMI_FIXED_INTF(0x1bc7, 0x1200, 5)},	/* Telit LE920 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1201, 2)},	/* Telit LE920, LE920A4 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1260, 2)},	/* Telit LE910Cx */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1261, 2)},	/* Telit LE910Cx */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1900, 1)},	/* Telit LN940 series */
 	{QMI_FIXED_INTF(0x1c9e, 0x9801, 3)},	/* Telewell TW-3G HSPA+ */
 	{QMI_FIXED_INTF(0x1c9e, 0x9803, 4)},	/* Telewell TW-3G HSPA+ */


