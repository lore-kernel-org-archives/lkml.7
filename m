Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17784C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF28D206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 08:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="Bb9nFYOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfDOILZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 04:11:25 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.132]:61491 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725794AbfDOILY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 04:11:24 -0400
Received: from [46.226.53.50] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-c.eu-west-1.aws.symcld.net id C9/09-09106-9AC34BC5; Mon, 15 Apr 2019 08:11:21 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRWlGSWpSXmKPExsWSoc9morvCZku
  MwdzbhhaXd81hs9j68h2TRd85dwdmj2cL17N4fN4kF8AUxZqZl5RfkcCa0bZjNXPBFJaKX9/u
  szYwrmPuYuTkYBFYzyzxt9G8i5GLQ0ign0nizqy7LBDOfUaJGc39TCBVbAKGEvPevGcEsUUEj
  CXWNM9mByliFpjKKHHsylF2kISwgJ/E2ufHoIoCJHrv7wdawQFkG0mcXZ0EsU1V4vSrtWDlvA
  KxEhdutYJdISTgKrGlaytYnFPATeJP20mwOKOArMSXxtVgNrOAuMStJ/PB7pEQEJBYsuc8M4Q
  tKvHy8T9WiPp4ifb9b9kh4joSZ68/YYSwlSSW3ZjFCmHLSlya3w0V95VYO+8LVP1FRokrzXYQ
  tpbEvH+XoebnSBza3AFly0h0HPvLCPK7hMBlVomHjyezQTyQLPFh7lmoQXISq3ofskAUXWCW6
  Nm5kg3iAx2JBbs/QdnaEssWvmaewKgxC8lzs5CUzUJSNgscYIISJ2c+YVnAyLKK0SypKDM9oy
  Q3MTNH19DAQNfQ0EjXyMBQ11gvsUo3WS+1VLc8tbhE11AvsbxYr7gyNzknRS8vtWQTIzDlpBS
  cZN7B+GxF+iFGSQ4mJVFeb5YtMUJ8SfkplRmJxRnxRaU5qcWHGGU4OJQkeK9YAeUEi1LTUyvS
  MnOAyQ8mLcHBoyTCexQkzVtckJhbnJkOkTrFqMtxYNHDucxCLHn5ealS4rz81kBFAiBFGaV5c
  CNgifgSo6yUMC8jAwODEE9BalFuZgmq/CtGcQ5GJWFeLpApPJl5JXCbXgEdwQR0xBSd1SBHlC
  QipKQaGA/HtD6wvmaQ8E8qQkNT65bYwu6MEJ4uH7sdnK6zu448FrDfuOcj/9V5/9+wBa3+J/r
  S0EB169XulkUFTMkRCR0fX73dUfdUeobsKd67kyvybulIp3GwyXLumr+Eo0T5/qE/t0uydtYG
  NVQ+rPG8F+nIUy86wUxQ7XbbDMUrOqKWe6+9Wao4T4mlOCPRUIu5qDgRAJ1sjEC/AwAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-20.tower-302.messagelabs.com!1555315880!6339237!1
X-Originating-IP: [104.47.6.52]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 18570 invoked from network); 15 Apr 2019 08:11:20 -0000
Received: from mail-ve1eur02lp2052.outbound.protection.outlook.com (HELO EUR02-VE1-obe.outbound.protection.outlook.com) (104.47.6.52)
  by server-20.tower-302.messagelabs.com with AES256-SHA256 encrypted SMTP; 15 Apr 2019 08:11:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBj7kK95aM/L/kXsfWLuPJ6e/bw3kx7UJX6/yEjvXEM=;
 b=Bb9nFYOYWIPtcL5qbv4smVjBt1fxPJeVDOrXEPnZ7aWSfJ3RPjsBEnTD7Z7a648DSqpSLvomy5rCxOMjl2Xld8IqGjuV9zZ05bbTL9ehgvkWh6Mh0O7ZrEiILxmJ7FFO137ebm+erFd/Hi+fXTQhikVCaKRWmG+LGFa/yla4Ez0=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB2397.EURPRD10.PROD.OUTLOOK.COM (20.177.62.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Mon, 15 Apr 2019 08:11:17 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acc9:6d8f:da36:9f25]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acc9:6d8f:da36:9f25%2]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 08:11:17 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
CC:     LINUX RENESAS SOC <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH RFT] watchdog: da9063_wdt: parse DT for timeout value, too
Thread-Topic: [PATCH RFT] watchdog: da9063_wdt: parse DT for timeout value,
 too
Thread-Index: AQHU8rKQiJBjLGoJgEygrdEbYLd/faY82vLA
Date:   Mon, 15 Apr 2019 08:11:16 +0000
Message-ID: <VI1PR10MB23525523F623FFAC4126EBC9FE2B0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190414110933.30529-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190414110933.30529-1-wsa+renesas@sang-engineering.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3766fb73-80e0-4b35-cdcc-08d6c179ef6c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR10MB2397;
x-ms-traffictypediagnostic: VI1PR10MB2397:
x-microsoft-antispam-prvs: <VI1PR10MB2397D44EB96EDDEC05881148F52B0@VI1PR10MB2397.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39850400004)(366004)(346002)(189003)(199004)(305945005)(7736002)(74316002)(14454004)(68736007)(66066001)(256004)(8676002)(9686003)(3846002)(55016002)(2906002)(105586002)(106356001)(97736004)(6116002)(8936002)(81156014)(81166006)(478600001)(5660300002)(99286004)(486006)(476003)(71200400001)(52536014)(86362001)(53546011)(76176011)(102836004)(6246003)(7696005)(26005)(4326008)(4744005)(107886003)(6506007)(316002)(6436002)(54906003)(446003)(25786009)(11346002)(186003)(71190400001)(229853002)(33656002)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB2397;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S+KwyPoh4x742jHWLBJ7asxK5/q8y0C6KWoqODuqgBf6DsNie/FVyF6YOg3pTJx3bs5CJpMv0Lh0LNedB+6N4c0PHpkDA+sW+mlkqf5SAmjSlIK1MsDLSovC7WGo0f0kyC7hb3PnblSs9kiaxFUAMMav/6Sq+Ityse9int8ZLPA+azADYGbkEr1BKjrUsyqbwry6gZv+PPCZ2LRhkJfFr5u3QS49LWDz9+8sSx6BbsoQyeVXG4PPdgOpmsB9TuVYk3o1rDvgunReLbPxrhec6oObxH2hF1tFefnJTZVFTH4I1pCmOlZdKTo5DzkV8KsMQkcMiv4Q6OPWRKWguMVNhbk3GXg8QCtpcFprsx48WALqQ5u0FOZzlD9KxODc57nLlXok5BOr9SWaSJvtXX0QI1iWxBJE3eVf1B9a9+l0O08=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3766fb73-80e0-4b35-cdcc-08d6c179ef6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 08:11:17.0271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2397
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On 14 April 2019 12:10, Wolfram Sang wrote:

> Tested with a Renesas Lager board (R-Car H2, DA9063AD), checking the init=
ial
> timeout value via sysfs. I didn't test handover from bootloader because m=
y
> bootloader neither supports WDT or I2C out of the box.

Can I please check there is no mistake in your description. I have been rep=
eatedly
told by the hardware engineers here, (for the past 6 years) it is not possi=
ble.
But, you seem to have an R-Car H2 with the AD silicon version of DA9063?

Regards,
Steve
