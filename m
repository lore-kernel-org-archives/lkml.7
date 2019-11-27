Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3FEC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 11:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B562068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 11:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="j/bmWQqL";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="j/bmWQqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfK0LGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 06:06:10 -0500
Received: from mail-eopbgr20081.outbound.protection.outlook.com ([40.107.2.81]:41059
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726282AbfK0LGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 06:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PS1MOdiVDXdRepJDZ2iQiCzzxgQs8nV55gwxJvsQJKk=;
 b=j/bmWQqLSxvCHIUPSTHdT8BQnTTQUNkZ6wLYopUnXppkw6es6AtHcizwEtG8Ny7h6D+Q2IH3p1jpNC7GrJsW50XU++vEYMhNCh1WLXPhbcFrVAwOmhzqScdFGX6B8huKPznlaPk8lshSJj1M0atbD6tX4WRLg6tHS3yDyUhrE70=
Received: from VI1PR08CA0106.eurprd08.prod.outlook.com (2603:10a6:800:d3::32)
 by AM4PR0802MB2227.eurprd08.prod.outlook.com (2603:10a6:200:5e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.17; Wed, 27 Nov
 2019 11:06:05 +0000
Received: from AM5EUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::209) by VI1PR08CA0106.outlook.office365.com
 (2603:10a6:800:d3::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.18 via Frontend
 Transport; Wed, 27 Nov 2019 11:06:05 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT004.mail.protection.outlook.com (10.152.16.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Wed, 27 Nov 2019 11:06:05 +0000
Received: ("Tessian outbound d55de055a19b:v37"); Wed, 27 Nov 2019 11:06:03 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6f1067049a300a7d
X-CR-MTA-TID: 64aa7808
Received: from b96fe9d401f2.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D4CC2479-6B90-42E8-A367-00311F2A2D09.1;
        Wed, 27 Nov 2019 11:05:58 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b96fe9d401f2.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 27 Nov 2019 11:05:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izGsrJ1ZcejIYTdtjLEqxhu63BcFtQm2akycqig/hx7lBzUqZY8NFx7F0j2JqT7KGPSFlZTPNKQejI/vEbT+e6ApaVz2+grIicmKP71FK9pY6JFRbtTOH1AYKdMG9WyqQrYiPrzjiH32hT1O1raM1Z4AmyqOCrtPALET5LiMExbKJ2BeSGYPOzX0iGOeOpu/BYwGXGdeZ//r6jOlc1/3THipMdc9ushHPOAR+PNleqOP6+p9bgAiWrLr3nbhBrKKLSO/5Wmah/nDkLOEAkkg0xb1IIycqcoQ7HD+QYhVBtEjtHR3P7BgmwfAj79Uh7AgYU6oZ9jODmtO8FtNrIHAgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PS1MOdiVDXdRepJDZ2iQiCzzxgQs8nV55gwxJvsQJKk=;
 b=jiK11NtF+ujSptvPUGlzTDB0GaFK4b0/scIMHLLQ3HCxzJOHeoy/WXxIe5jdfbB7MpE7xR2pXIG57g59IbNCoRuSc3ZbTNAwULWfz6RzONkT5umLFJdTmQ50zagi1xkC0uzcc7jZ9Qv1+UsdVIohbAITUbtgiVqKlMAmAi3+DufybERGT+PAGzYKUWTEP7MK0SpvmFDDQHhVDI2axtemO7aRnM1dBJsz5v9TugLpe9leLyssTdZb8x6BDkaI8dlz8Un9jjSgmYUQN8tB/yTgg4PGBpCZSn0zI2iiukT+GQNB5r2oh0/jyVmhkoFUErtQFrbT6i3+dd7LE1DoKMf40Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PS1MOdiVDXdRepJDZ2iQiCzzxgQs8nV55gwxJvsQJKk=;
 b=j/bmWQqLSxvCHIUPSTHdT8BQnTTQUNkZ6wLYopUnXppkw6es6AtHcizwEtG8Ny7h6D+Q2IH3p1jpNC7GrJsW50XU++vEYMhNCh1WLXPhbcFrVAwOmhzqScdFGX6B8huKPznlaPk8lshSJj1M0atbD6tX4WRLg6tHS3yDyUhrE70=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB5373.eurprd08.prod.outlook.com (52.133.245.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.17; Wed, 27 Nov 2019 11:05:56 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Wed, 27 Nov 2019
 11:05:56 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     Sam Ravnborg <sam@ravnborg.org>
CC:     nd <nd@arm.com>, Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>, nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/30] drm: Introduce drm_bridge_init()
Thread-Topic: [PATCH 01/30] drm: Introduce drm_bridge_init()
Thread-Index: AQHVpFukMd5nbiwRlEK6zRU7NBRujaedgi4AgAADJICAAFBIgIABBvWA
Date:   Wed, 27 Nov 2019 11:05:56 +0000
Message-ID: <2196368.mua8KTRpvS@e123338-lin>
References: <20191126131541.47393-1-mihail.atanassov@arm.com>
 <11447519.fzG14qnjOE@e123338-lin> <20191126192445.GA2044@ravnborg.org>
In-Reply-To: <20191126192445.GA2044@ravnborg.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0264.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::36) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 94d37e42-28d7-43fd-214f-08d77329cc69
X-MS-TrafficTypeDiagnostic: VI1PR08MB5373:|AM4PR0802MB2227:
X-Microsoft-Antispam-PRVS: <AM4PR0802MB2227E8EEBDE8EF57C60AC4608F440@AM4PR0802MB2227.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:2887;OLM:2887;
x-forefront-prvs: 023495660C
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(346002)(376002)(366004)(39860400002)(396003)(199004)(189003)(6506007)(102836004)(446003)(11346002)(6916009)(3846002)(6486002)(5660300002)(8676002)(4744005)(66476007)(66556008)(64756008)(66446008)(66946007)(6246003)(66066001)(71190400001)(71200400001)(256004)(6436002)(25786009)(8936002)(33716001)(4326008)(229853002)(81156014)(54906003)(99286004)(316002)(81166006)(6512007)(478600001)(52116002)(6116002)(86362001)(305945005)(7736002)(14454004)(76176011)(186003)(26005)(386003)(9686003)(2906002)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB5373;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: bjkwXFmTbSM0+mBRS/WV5T5/02GsDK6WU//Yw/TYzuLiRlTlOL8zlauRoEBoaGgMaFka99EnY2k8eemOiNKR+dlDb3JY8HvTfQmXXjHUN4O7jaEIhLUqn7hriEtKLoET+59CSMeuC8eBjpvbWQXIsNKYNbPaCqjV5NcyGvzN5AodFFwPgcNbJUki6Fr6N1WgU3PNyab7AzufPh3Xv3Wo3JFbl9IQiWM/vCy3LmvfzHqlUIBfoFV0uu7l7ZjgwldRvt1cu+AsnD0skkmzERsHHLSQZCxn99W5Cbs/1DdD1GfDJR4/L/6l73vlSaAqim4sNV9wKdpPcEsYGMxvPJJkFRClV1+MoHD8Ame+4Dd6MIt3pqAhv3S9960V7F2+/veh/VO2XFK2F/0f2Q6IGj3SlasQDIm5bi0roVMqXzgqzKMqWp+fpkPOCn8rwT80sBu5
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F2C90664F8B5984B956E288C72397E0E@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5373
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(396003)(39860400002)(346002)(136003)(199004)(189003)(316002)(33716001)(8936002)(26826003)(478600001)(106002)(8676002)(8746002)(50466002)(11346002)(81156014)(446003)(54906003)(81166006)(76130400001)(97756001)(356004)(25786009)(36906005)(76176011)(2906002)(14454004)(99286004)(6116002)(46406003)(5660300002)(23726003)(336012)(386003)(6506007)(86362001)(102836004)(186003)(26005)(229853002)(70586007)(6862004)(70206006)(6246003)(22756006)(47776003)(305945005)(9686003)(66066001)(6486002)(6512007)(7736002)(4326008)(4744005)(3846002)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2227;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e2c63a60-2af2-4c6e-eea8-08d77329c6fa
NoDisclaimer: True
X-Forefront-PRVS: 023495660C
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EfQNbkpNoN9OTrnwG9mAUAx1pxSIyytEX+ikT8jQJwLgWlsnS+1jU+/TXXoif/NPlIMpykVMHx9ezMy4Oej069h3w2vKoAeRbGCKLKlJlpYJ927i7Wg25l4ytS/rXWmdrq4PABBSzgKeS3rWzyDua5cB9yfCFTMKmi8LIOEmpmTTh5oH2uZLA455MQad65Os/KD9w81fypn7LWoELp5KW7yQrtvQhuPbLUH0J6S0MWg/Oy2C28Y/aww9b5OPKBKnMipNgZXSpFFjXnWhdFp7r724pstJoHf0AWIxPnPrDDBb5WIXetE94QVLtaRIyiYOtXP+GhkPyCufEE3Qi9co3IKCFePxG/mV73ZlTmJuJ1UJ8yDxo5ViIBpLJhMlPg6gapcgQCu8ymsmhc/nNGIBQO8QXhLP6DGuAfLxUflA5Oi6R5aO181L3gcRTw0pD7mP
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2019 11:06:05.5889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d37e42-28d7-43fd-214f-08d77329cc69
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2227
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 26 November 2019 19:24:45 GMT Sam Ravnborg wrote:
> Hi Mihail.

Hi Sam,

>=20
> > Ack, but with one caveat: bridge->dev is the struct drm_device that is
> > the bridge client, we need to add a bridge->device (patch 29 in this
> > series) which is the struct device that will manage the bridge lifetime=
.
> Other places uses the variable name "drm" for a drm_device.
> This is less confusion than the "dev" name.
>=20
> It seems a recent trend to use the variable name "drm" so you can find a
> lot of places using "dev".
>=20
> bike-shedding - but also about readability.
>=20
> 	Sam
>=20

I'm okay with the idea, I can do a follow-up patch or series for the
rename; I expect it would be a bit hefty to do it prior to this.

@Daniel, thoughts on s/bridge.dev/bridge.drm/ and
s/bridge.device/bridge.dev/ after this series?

--=20
Mihail



