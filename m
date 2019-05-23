Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF98CC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD8302184E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558639508;
	bh=mhpErQYsEnJx/fK3QnGd2h31dFlmGMTbeyJs3XNhU0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F8dxso17737iZlVrGyLAOh00Wc8RWy1W75iMzHDzbhR+kjaQwndVSik2Z29tfgLGc
	 OmaVJIb6kCvuV0up5V0+oG0tjmmHBnv0r16CUYmqoAxxOyd8m8cNvEsR1UX12mnG5q
	 aqrp3wXsTS0r0t0CLAcBJ04YCIvVJtdBlTcca3LM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390705AbfEWTZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:25:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391036AbfEWTZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:25:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 821352054F;
        Thu, 23 May 2019 19:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639503;
        bh=mhpErQYsEnJx/fK3QnGd2h31dFlmGMTbeyJs3XNhU0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wNscejp66WW2ikG2L9S6eki5MXigipajF7DOS6lgkR701PLLcFspLDBeI/VaDLPNC
         c8UQA2lLdZyC8RWc9NtS06KLsot4GyoqUT3AB9YcDVTAMsiblN0/YF2LQ3HsqKkWHf
         JK5mG2FqSxZDQm4QxHhSv2V4WbO9NwKP3w3UfS9Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 112/139] power: supply: cpcap-battery: Fix division by zero
Date:   Thu, 23 May 2019 21:06:40 +0200
Message-Id: <20190523181734.577188098@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181720.120897565@linuxfoundation.org>
References: <20190523181720.120897565@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit dbe7208c6c4aec083571f2ec742870a0d0edbea3 ]

If called fast enough so samples do not increment, we can get
division by zero in kernel:

__div0
cpcap_battery_cc_raw_div
cpcap_battery_get_property
power_supply_get_property.part.1
power_supply_get_property
power_supply_show_property
power_supply_uevent

Fixes: 874b2adbed12 ("power: supply: cpcap-battery: Add a battery driver")
Signed-off-by: Tony Lindgren <tony@atomide.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/cpcap-battery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 08d5037fd0521..6887870ba32c3 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -221,6 +221,9 @@ static int cpcap_battery_cc_raw_div(struct cpcap_battery_ddata *ddata,
 	int avg_current;
 	u32 cc_lsb;
 
+	if (!divider)
+		return 0;
+
 	sample &= 0xffffff;		/* 24-bits, unsigned */
 	offset &= 0x7ff;		/* 10-bits, signed */
 
-- 
2.20.1



