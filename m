Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EF2C606AF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40CEF20861
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 11:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbfGHLl6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 07:41:58 -0400
Received: from mail-oln040092071017.outbound.protection.outlook.com ([40.92.71.17]:18247
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727973AbfGHLl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 07:41:58 -0400
Received: from VE1EUR03FT057.eop-EUR03.prod.protection.outlook.com
 (10.152.18.51) by VE1EUR03HT191.eop-EUR03.prod.protection.outlook.com
 (10.152.19.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2052.18; Mon, 8 Jul
 2019 11:41:54 +0000
Received: from VI1PR0601MB2111.eurprd06.prod.outlook.com (10.152.18.57) by
 VE1EUR03FT057.mail.protection.outlook.com (10.152.19.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Mon, 8 Jul 2019 11:41:54 +0000
Received: from VI1PR0601MB2111.eurprd06.prod.outlook.com
 ([fe80::acdd:656f:33be:2163]) by VI1PR0601MB2111.eurprd06.prod.outlook.com
 ([fe80::acdd:656f:33be:2163%5]) with mapi id 15.20.2052.020; Mon, 8 Jul 2019
 11:41:54 +0000
From:   morten petersen <morten_bp@live.dk>
To:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     morten petersen <morten_bp@live.dk>
Subject: [PATCH] mailbox: handle failed named mailbox channel request
Thread-Topic: [PATCH] mailbox: handle failed named mailbox channel request
Thread-Index: AQHVNYIkY1kb4XuU6Ue+u5b+Elm7ww==
Date:   Mon, 8 Jul 2019 11:41:54 +0000
Message-ID: <VI1PR0601MB211187A233E3185D228F5BDC8FF60@VI1PR0601MB2111.eurprd06.prod.outlook.com>
Accept-Language: da-DK, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0017.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::27)
 To VI1PR0601MB2111.eurprd06.prod.outlook.com (2603:10a6:800:2d::26)
x-incomingtopheadermarker: OriginalChecksum:DCC705C3B25B64136DD5D7D8D60EFC9FF39F0D2DD636C05E48CD499EA0094527;UpperCasedChecksum:28E56C009B079D34ADA5F20B7FD13A59EB3F3EBF4EEF74E9A7B0743F4AB8C35C;SizeAsReceived:7424;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-tmn:  [s8F56BQcmBqrVsG2M1ZY4B9EnWSnXARv]
x-microsoft-original-message-id: <1562586063-30142-1-git-send-email-morten_bp@live.dk>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:VE1EUR03HT191;
x-ms-traffictypediagnostic: VE1EUR03HT191:
x-microsoft-antispam-message-info: vld7J3C1U+1UhiXxKAEAKXIS9Z9GJtMC1cnulmobh7k2643gog5kbjpBDmoP2zc+qlwDpH7bW/AXed94JKknLgiwAqKZe6I/dghq2pPy9fmh0xhdUY6nrViDKHf8kWJtD2Bmnj2US1Nrvk6nwRcyLi9bO0RUpzPVkxR0O5mqN0PSsZXcX7i4NsL2VvpC4L8l
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f3455b65-45ff-4b9c-c3e8-08d70399468e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2019 11:41:54.8328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR03HT191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, if mbox_request_channel_byname was used with a name
which did not exist in the "mbox-names" property of a mailbox
client, the mailbox corresponding to the last entry in the
"mbox-names" list would be incorrectly selected.
With this patch, -EINVAL is returned if the named mailbox is
not found.

Signed-off-by: Morten Borup Petersen <morten_bp@live.dk>
---
 drivers/mailbox/mailbox.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index f4b1950..c823fd6 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -418,11 +418,13 @@ struct mbox_chan *mbox_request_channel_byname(struct mbox_client *cl,
 
 	of_property_for_each_string(np, "mbox-names", prop, mbox_name) {
 		if (!strncmp(name, mbox_name, strlen(name)))
-			break;
+			return mbox_request_channel(cl, index);
 		index++;
 	}
 
-	return mbox_request_channel(cl, index);
+	dev_err(cl->dev, "%s() could not locate mailbox named \"%s\"\n",
+		__func__, name);
+	return ERR_PTR(-EINVAL);
 }
 EXPORT_SYMBOL_GPL(mbox_request_channel_byname);
 
-- 
2.7.4

