Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2981EC282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3D220881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558640132;
	bh=GqsLDKO2hxLnFO/SE3HhpEzRNoCZlRTxRd/5JxBCzTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NyLwE3z03MEiQ7St+Vs8sUvMOcvOzDUZi09Ydv8JsZpoTCgXqThUz43AW8aO4iBYy
	 C5lk+5MnbK1M+8i6IS/0CKdnqY/HDRszXAmWCkVYvZKf5Rnj6yI6wDTvTHaeBksdzC
	 l7McNH611rNW8LEXyTHpGotLRYa0S1FjidOkmASE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391404AbfEWT0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:26:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390754AbfEWT0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:26:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1B0820868;
        Thu, 23 May 2019 19:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639597;
        bh=GqsLDKO2hxLnFO/SE3HhpEzRNoCZlRTxRd/5JxBCzTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0GvdTThpxrtF1vZ6Y+bCyLoaCEOOg8Q+o2xyueu085Y7Hj6rwRFL+zNrI76YSB5qk
         xCB2yUq54SpWdSGQWELiJOsSNW2cVRXWAlKYiAXOjJXR/1ZtN5c01tegaUo8LKE0Sb
         EWwTLZ3Hkf4As3PCtKVUiayjrPymEHcb++yuOikU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 007/122] net: usb: qmi_wwan: add Telit 0x1260 and 0x1261 compositions
Date:   Thu, 23 May 2019 21:05:29 +0200
Message-Id: <20190523181706.017527166@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181705.091418060@linuxfoundation.org>
References: <20190523181705.091418060@linuxfoundation.org>
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
@@ -1250,6 +1250,8 @@ static const struct usb_device_id produc
 	{QMI_FIXED_INTF(0x1bc7, 0x1101, 3)},	/* Telit ME910 dual modem */
 	{QMI_FIXED_INTF(0x1bc7, 0x1200, 5)},	/* Telit LE920 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1201, 2)},	/* Telit LE920, LE920A4 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1260, 2)},	/* Telit LE910Cx */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1261, 2)},	/* Telit LE910Cx */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1900, 1)},	/* Telit LN940 series */
 	{QMI_FIXED_INTF(0x1c9e, 0x9801, 3)},	/* Telewell TW-3G HSPA+ */
 	{QMI_FIXED_INTF(0x1c9e, 0x9803, 4)},	/* Telewell TW-3G HSPA+ */


