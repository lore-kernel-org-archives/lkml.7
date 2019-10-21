Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0918ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44AE20679
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="vs05PJI9";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="vs05PJI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfJUPCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:02:19 -0400
Received: from mail-eopbgr50088.outbound.protection.outlook.com ([40.107.5.88]:43747
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726289AbfJUPCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYumAecp+Rc/UXQzDGtL4a2IhNxeYQpPPiaKw0q6ZbM=;
 b=vs05PJI9gL1jIUlC2tmA3gwWj+i4aNqVFA1cUdx2rthNEAdWkkho9t4YzAGQVfldDmAdtJX1/0UueKOFBr6dWgaqKE3BCw4SGe+WYlZiqw9lwNXP+cippZJ1HuLpGYd/ty0mNTnvtt7XK9EL+TPse19e78Rk0U6oCQM0rkcAq1o=
Received: from VI1PR08CA0154.eurprd08.prod.outlook.com (2603:10a6:800:d5::32)
 by AM0PR08MB3090.eurprd08.prod.outlook.com (2603:10a6:208:56::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16; Mon, 21 Oct
 2019 15:02:13 +0000
Received: from AM5EUR03FT041.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::208) by VI1PR08CA0154.outlook.office365.com
 (2603:10a6:800:d5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.21 via Frontend
 Transport; Mon, 21 Oct 2019 15:02:12 +0000
Authentication-Results: spf=temperror (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT041.mail.protection.outlook.com (10.152.17.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.23 via Frontend Transport; Mon, 21 Oct 2019 15:02:11 +0000
Received: ("Tessian outbound 927f2cdd66cc:v33"); Mon, 21 Oct 2019 15:02:03 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f603f75de94af4e4
X-CR-MTA-TID: 64aa7808
Received: from 3788f471119f.2 (ip-172-16-0-2.eu-west-1.compute.internal [104.47.8.51])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 94B43E00-7530-447C-9DC1-60C77ACB54AD.1;
        Mon, 21 Oct 2019 15:01:57 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-am5eur03lp2051.outbound.protection.outlook.com [104.47.8.51])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3788f471119f.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 21 Oct 2019 15:01:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMzbpEHw+av+EXWF8qQyjiodHa0HnXMX3vnppnJ/S8e99jHL28lUo3ZjJRzUucUSbmfETrpa8opU85sYHRrsM6khizd1Z4fR75rrHqwJM7yZV5f16oUK4Iuecxb4KRUYOwTBqfmZTbHAEPyyJELK+rCHdxyLhTarIiCsT/6llZNDDEYm8+U0+0ynOUvMWU8fA/E53WrrBKOpJ3Jx05rOzCR9S3LnJE9BoxNhU2pR1Av5MRRk5o+9DYOyCNkKbGtl20lkWohgivXpzHnQShmPp6e3djuZZeuQ6nuHuYMF7cXAToot7bxa982WRfnojyzbiTXCLf5xgr1tbB9JthpryQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYumAecp+Rc/UXQzDGtL4a2IhNxeYQpPPiaKw0q6ZbM=;
 b=Jf4NnPOFSCCRa1zcmc6bB3lL7wMVYgzH4a3trsXkf+Ash+1M9CW4BBAKDHC4egCLYCWYLgWbvuWLWNnrCGpTh3OugttyVViHDtHlDPNPOL2ZmXyhGcO3xWDvVq8LEotL8VV84t3AM339MK54pWDQtmdU25pMzGwmutLi2UcugQP10g0/D/XuhrupgRdafwKCQRs1WReD6h/IdrLd+EUkRm5A2YDDLkl/z2DwUOMHixrGZ2Txz3i95g5Is8AceeGK8u87HHpEXncM7hPhqQwXZ7K89pdnBfSKWK4LiexCBa6TlYej8W4ujxNHhIqyg8nZj6gQRj41WNhu9FWeIkWjiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYumAecp+Rc/UXQzDGtL4a2IhNxeYQpPPiaKw0q6ZbM=;
 b=vs05PJI9gL1jIUlC2tmA3gwWj+i4aNqVFA1cUdx2rthNEAdWkkho9t4YzAGQVfldDmAdtJX1/0UueKOFBr6dWgaqKE3BCw4SGe+WYlZiqw9lwNXP+cippZJ1HuLpGYd/ty0mNTnvtt7XK9EL+TPse19e78Rk0U6oCQM0rkcAq1o=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB4383.eurprd08.prod.outlook.com (20.179.28.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Mon, 21 Oct 2019 15:01:56 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::7d25:d1f2:e3eb:868b%6]) with mapi id 15.20.2367.022; Mon, 21 Oct 2019
 15:01:56 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     Mihail Atanassov <Mihail.Atanassov@arm.com>, nd <nd@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: Add Mihail to Komeda DRM driver
Thread-Topic: [PATCH] MAINTAINERS: Add Mihail to Komeda DRM driver
Thread-Index: AQHViCB7QBCpqKK/Z0mgls76GftRfw==
Date:   Mon, 21 Oct 2019 15:01:56 +0000
Message-ID: <20191021150123.19570-1-mihail.atanassov@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.51]
x-clientproxiedby: LO2P123CA0044.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::32)
 To VI1PR08MB4078.eurprd08.prod.outlook.com (2603:10a6:803:e5::28)
x-mailer: git-send-email 2.23.0
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 72fda1d3-2137-422c-eaec-08d75637a684
X-MS-Office365-Filtering-HT: Tenant
X-MS-TrafficTypeDiagnostic: VI1PR08MB4383:|VI1PR08MB4383:|AM0PR08MB3090:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB30907380308ABF78BCA4F5988F690@AM0PR08MB3090.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:873;OLM:873;
x-forefront-prvs: 0197AFBD92
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(189003)(199004)(5660300002)(50226002)(8676002)(6486002)(81156014)(1076003)(6512007)(256004)(81166006)(478600001)(4326008)(476003)(66066001)(71190400001)(5640700003)(4744005)(25786009)(8936002)(2616005)(36756003)(14454004)(71200400001)(6436002)(54906003)(66476007)(66446008)(64756008)(66556008)(3846002)(52116002)(186003)(386003)(6506007)(7736002)(66946007)(99286004)(44832011)(6116002)(305945005)(86362001)(6916009)(102836004)(486006)(26005)(7416002)(2906002)(316002)(2351001)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB4383;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 9sxBhaLoNaI027xoS+g1M19RiQYc6piQOcQocqKg6CQTnh0Murhs0fU9z4yqRv15g7M1LCp/IDIeUDVAogodxNOI2g5mA12amAEENXN67xTqD5WIN/0AeJgpQp09U17yRWSFfetTJwFWarCAxetkLVCsfQ4Yif+JX+WMJvcrnKnGTTaRau4rGOUi1oLpHhiAmCDgf41kaLl8/je6BhqvcMNKAgHkDEhUJqG1kVSGXa5LQTCJo8QV6+kp3J7R6wrYQXoz3fH7eFoDJMQRhkIz+pg2asqND/1SWpt2QlvWpouOsdUFS+ji8vhF5MM93qFbmpZFDDU0mirk6fZsMMlUbsdNVCe5Fahn64MKvN8+jAjqOf8NqwGH3brfiwGuqqW2G4P1vhgbQc2gD/PmKmmfNTE94SlaKbUGwaqNIC4qaN/nJFucZC+dyZ+xeYIEkP0F
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4383
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT041.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(346002)(376002)(189003)(199004)(54906003)(486006)(126002)(2906002)(6512007)(25786009)(36756003)(476003)(2616005)(50226002)(47776003)(316002)(36906005)(4744005)(2501003)(6486002)(6862004)(8936002)(478600001)(336012)(26826003)(81156014)(81166006)(8746002)(63350400001)(2351001)(6116002)(102836004)(22756006)(7736002)(1076003)(5660300002)(3846002)(186003)(50466002)(4326008)(6506007)(386003)(23756003)(26005)(356004)(76130400001)(8676002)(5640700003)(86362001)(66066001)(14454004)(70586007)(70206006)(99286004)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3090;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:TempError;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 25f36aad-e55d-4187-1bbe-08d756379d70
NoDisclaimer: True
X-Forefront-PRVS: 0197AFBD92
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CviGLXo9QPiV4zOMi1bROcRpAbBukxV7z1jGB82g9QCAACosHl5wc4uC3k2a1OAO7qRAllaSATLdO1KZr58USyqv2YXHCqiElOwRwetvFBzVB32NCOvzZWi/fLXjVarZt3o/vUGoV99+gFVxVzIRlrLO7WhygOM+8lVYyNUUESgHZh+KJ8ZiCfCOMryUUhImAnbyqHhR76nTwT2BOqn8IXFxFRhafdsFe39itWOdkNByWETdmSCUkip1SvGvHjoYq9Xl6x/l+1fqyiDstwNQC8k/iUanURfOYtOcAnYhhnMyYVpiMOBOtE6aKt3LniZR3O5azlngzItrAbSWCU3nrTucdxOJwvNwRWaNuG4hH1k0P2HMCN/sYoQ1QRWh6WTiEPrG4HkYX2qMX2Rv9zxvL8i6h2VGCqDNA1HHCgN6ssrNHnxvvx4GnYVdEvPJHKBj
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2019 15:02:11.2512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72fda1d3-2137-422c-eaec-08d75637a684
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'll be the main point of contact.

Cc: James Qian Wang (Arm Technology China) <james.qian.wang@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 94fb077c0817..d32f263f0022 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1251,6 +1251,7 @@ F:	Documentation/devicetree/bindings/display/arm,hdlc=
d.txt
 ARM KOMEDA DRM-KMS DRIVER
 M:	James (Qian) Wang <james.qian.wang@arm.com>
 M:	Liviu Dudau <liviu.dudau@arm.com>
+M:	Mihail Atanassov <mihail.atanassov@arm.com>
 L:	Mali DP Maintainers <malidp@foss.arm.com>
 S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
--=20
2.23.0

