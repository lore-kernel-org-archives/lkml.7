Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9453FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 20:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5F120989
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 20:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.se header.i=@prevas.se header.b="Gwk1wJ0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfCXUjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 16:39:31 -0400
Received: from mail-eopbgr60109.outbound.protection.outlook.com ([40.107.6.109]:18208
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726317AbfCXUja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 16:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdjtsMeK8e37UxxfCQZSI/tmGjTzCaNEwgZ/w4K8v/0=;
 b=Gwk1wJ0X49C95Hy+AxCH8tOoR/eT9YD0Omgdq9DBykjR2srWssUpj9Bt+gQFx24YAQNxznitAWicOB43LiicGbKSwoV+XE3fDlA09SHFB4VfsE9Lk1aVG1Be45KoZy/EsjZehB51FbxGlzYqDPpgWz9qXhzRUHOt9CCoKMf9GkY=
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (20.178.126.212) by
 VI1PR10MB2784.EURPRD10.PROD.OUTLOOK.COM (20.178.204.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Sun, 24 Mar 2019 20:39:24 +0000
Received: from VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cd0:b7e8:6608:b826]) by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cd0:b7e8:6608:b826%5]) with mapi id 15.20.1730.019; Sun, 24 Mar 2019
 20:39:24 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Pavel Machek <pavel@ucw.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     =?Windows-1252?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 4/4] leds: netdev trigger: allow setting initial values in
 device tree
Thread-Topic: [PATCH 4/4] leds: netdev trigger: allow setting initial values
 in device tree
Thread-Index: AQHU2dsRX3iuRBdOzEGzzvsDZaUlTqYK7dCAgAAQDQCAAAmLgIAAFgwAgAUZYQCACxjGgA==
Date:   Sun, 24 Mar 2019 20:39:24 +0000
Message-ID: <9a01fe8a-c083-c552-faed-c0f2c6b1e818@prevas.dk>
References: <20190311144227.GA4404@amd>
 <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190313202615.22883-5-linux@rasmusvillemoes.dk>
 <20190314102911.GA15173@amd>
 <6fb71b90-1ae3-9d93-6e0c-c95e441ced7a@rasmusvillemoes.dk>
 <20190314120047.GA19072@amd>
 <2cd9c42c-1056-979f-568e-c7e387bf90c6@rasmusvillemoes.dk>
 <20190317191150.GA31285@amd>
In-Reply-To: <20190317191150.GA31285@amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0401CA0060.eurprd04.prod.outlook.com
 (2603:10a6:3:19::28) To VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e3::20)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [5.186.118.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83fecbbe-6a25-4f68-3c80-08d6b098cd2d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2784;
x-ms-traffictypediagnostic: VI1PR10MB2784:
x-microsoft-antispam-prvs: <VI1PR10MB2784AA7966A8398A4042EDCF8A5D0@VI1PR10MB2784.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 09860C2161
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(39840400004)(346002)(136003)(189003)(199004)(52314003)(3846002)(106356001)(6246003)(2906002)(6116002)(4326008)(6346003)(99286004)(53936002)(72206003)(305945005)(6486002)(8676002)(93886005)(229853002)(71190400001)(7736002)(76176011)(5660300002)(68736007)(74482002)(31686004)(6506007)(8976002)(54906003)(31696002)(256004)(81156014)(110136005)(66066001)(6436002)(8936002)(102836004)(26005)(81166006)(186003)(14454004)(386003)(478600001)(71200400001)(52116002)(2616005)(42882007)(71446004)(316002)(36756003)(97736004)(105586002)(446003)(11346002)(486006)(44832011)(25786009)(6512007)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR10MB2784;H:VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: prevas.se does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ppht1n4Xiva8dz9TQaMrQPc0O/ZTPXa/VNU1GXUcBWqJ2yD4ATbhTkIGenLaT+WcDHJFZ05rCJhgaf5SlWlRWEerZWePJh2Bjt1FHnDspkJp95httQZSOjDNmMl5PhRSvnccuHlbinEugxfuHUyFSVTUqP/NJMnF1zbYdhNk5EfKm2Y+3Ttj8CWsWz9OhkbhLp6DOLTw3uDawNcX/If40kw9vMZLxfCjfmT4geb9uHtninQbOvjNY1CImJwkD0oNyKchPNQMEr8Hw0p9AcblRUuYJeDKLtg+YtJq8nVPfKwLBtfYdW4Wb5nn8FnXY6jC0CsWd4inDZXeok9Na1J+UKiIrlC6lRDvG3BypBjBqm5v3U6E/ae6ItY40CvTYwb5cEgvLmzbwa/m4pyZzNKMtZzh/UNAEesOpyT5l8DDqxI=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <63A46BBF82393944951908A8175FD055@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 83fecbbe-6a25-4f68-3c80-08d6b098cd2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2019 20:39:24.7318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2784
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2019 20.11, Pavel Machek wrote:
> On Thu 2019-03-14 14:19:42, Rasmus Villemoes wrote:
>> On 14/03/2019 13.00, Pavel Machek wrote:
>> linux,default-trigger from
>>>
> Udev will not help with renaming -- it runs after kernel boot, while
> udev parsing is usually done before userland starts.

This is simply plain wrong. The netdev trigger explicitly tracks a
netdevice _by name_, and has netdev notifier in place to get notified
should a netdevice by that name ever appear.

> Plus, device tree should really describe hardware, and be usable with
> other operating systems. Of course, there are exceptions, but "can0"
> is unneccessarily linux-specific.

And "linux,netdev-trigger" is not linux-specific? And why are you so
hung up on the can example, it would work just as fine for usb0 or whatever=
.

Anyway, to whoever is responsible for merging this stuff, please at most
apply patch 1, factoring out the string-to-netdev handling doesn't make
much sense without the final configure-from-dt stuff.

Rasmus
