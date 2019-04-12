Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59930C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3538920869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfDLBXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:23:01 -0400
Received: from mail-out-1.itc.rwth-aachen.de ([134.130.5.46]:35259 "EHLO
        mail-out-1.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726640AbfDLBXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:23:00 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BVBAAV5a9c/54agoZlHQEBBQEHBQGBZ?=
 =?us-ascii?q?YIRgh2EBK94DwEthECFdSM4EgEBAwEBCgEBAQECbSiFdA8BRjUCJgJfDoMnggk?=
 =?us-ascii?q?ErD+BL4kfgQ8JAYEBJYZyhFWCFoE4iDqCPYJXA4ppmzQHAoEsW5ILIItaiRSfa?=
 =?us-ascii?q?wICAgIJAhWBZiGBVnGDPJBNPoEuDCGOKAGBHwEB?=
X-IPAS-Result: =?us-ascii?q?A2BVBAAV5a9c/54agoZlHQEBBQEHBQGBZYIRgh2EBK94DwE?=
 =?us-ascii?q?thECFdSM4EgEBAwEBCgEBAQECbSiFdA8BRjUCJgJfDoMnggkErD+BL4kfgQ8JA?=
 =?us-ascii?q?YEBJYZyhFWCFoE4iDqCPYJXA4ppmzQHAoEsW5ILIItaiRSfawICAgIJAhWBZiG?=
 =?us-ascii?q?BVnGDPJBNPoEuDCGOKAGBHwEB?=
X-IronPort-AV: E=Sophos;i="5.60,339,1549926000"; 
   d="scan'208";a="75440744"
Received: from rwthex-w2-a.rwth-ad.de ([134.130.26.158])
  by mail-in-1.itc.rwth-aachen.de with ESMTP; 12 Apr 2019 03:13:24 +0200
Received: from pebbles.fritz.box (93.135.108.28) by rwthex-w2-a.rwth-ad.de
 (2a00:8a60:1:e500::26:158) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 12
 Apr 2019 03:13:19 +0200
From:   =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To:     <linux-media@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Antti Palosaari <crope@iki.fi>,
        =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
Subject: [PATCH 0/3] Cleanup error reporting
Date:   Fri, 12 Apr 2019 03:12:57 +0200
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [93.135.108.28]
X-ClientProxiedBy: rwthex-w1-a.rwth-ad.de (2a00:8a60:1:e500::26:156) To
 rwthex-w2-a.rwth-ad.de (2a00:8a60:1:e500::26:158)
Message-ID: <e8680c51-0bcd-4ef2-b117-cf122259062e@rwthex-w2-a.rwth-ad.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Almost all error path in dvb_usb_v2_generic_io report a specific
error using dev_err(), only the "writelen != actuallen" case
was omitted. Add an error message.

Remove any extra error reporting from the call sites which was
only required for this case. Only affected drivers are dvbsky
and af9035.

Stefan Brüns (3):
  media: dvb-usb-v2: Report error on all error paths
  media: dvbsky: Remove duplicate error reporting for
    dvbsky_usb_generic_rw
  media: af9035: Remove duplicate error reporting for
    dvbsky_usb_generic_rw

 drivers/media/usb/dvb-usb-v2/af9035.c      |  2 --
 drivers/media/usb/dvb-usb-v2/dvb_usb_urb.c | 15 ++++++++++-----
 drivers/media/usb/dvb-usb-v2/dvbsky.c      | 11 -----------
 3 files changed, 10 insertions(+), 18 deletions(-)

-- 
2.21.0

