Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150D2C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0954206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732369AbfDQSop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:44:45 -0400
Received: from gateway23.websitewelcome.com ([192.185.47.80]:43058 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727340AbfDQSop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:44:45 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 160E9C385
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 13:44:44 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id GpY3hnElndnCeGpY4hZv3M; Wed, 17 Apr 2019 13:44:44 -0500
X-Authority-Reason: nr=8
Received: from [189.250.55.242] (port=57756 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hGpY3-002nJj-0y; Wed, 17 Apr 2019 13:44:43 -0500
Date:   Wed, 17 Apr 2019 13:44:40 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2] staging: greybus: power_supply: use struct_size() helper
Message-ID: <20190417184440.GA6025@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.55.242
X-Source-L: No
X-Exim-ID: 1hGpY3-002nJj-0y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.55.242]:57756
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes, in particular in the
context in which this code is being used.

So, replace code of the following form:

sizeof(*resp) + props_count * sizeof(struct gb_power_supply_props_desc)

with:

struct_size(resp, props, props_count)

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Rebase on top of 47830c1127ef ("staging: greybus: power_supply: fix prop-descriptor request size")

 drivers/staging/greybus/power_supply.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/power_supply.c b/drivers/staging/greybus/power_supply.c
index ae5c0285a942..34b40a409ea3 100644
--- a/drivers/staging/greybus/power_supply.c
+++ b/drivers/staging/greybus/power_supply.c
@@ -520,8 +520,8 @@ static int gb_power_supply_prop_descriptors_get(struct gb_power_supply *gbpsy)
 
 	op = gb_operation_create(connection,
 				 GB_POWER_SUPPLY_TYPE_GET_PROP_DESCRIPTORS,
-				 sizeof(*req), sizeof(*resp) + props_count *
-				 sizeof(struct gb_power_supply_props_desc),
+				 sizeof(*req),
+				 struct_size(resp, props, props_count),
 				 GFP_KERNEL);
 	if (!op)
 		return -ENOMEM;
-- 
2.21.0

