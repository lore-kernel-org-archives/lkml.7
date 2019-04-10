Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639E6C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3148A2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="K6emvlF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbfDJMOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:14:19 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.131]:49309 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727497AbfDJMOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:14:18 -0400
Received: from [46.226.53.56] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-c.eu-west-1.aws.symcld.net id 08/99-32334-71EDDAC5; Wed, 10 Apr 2019 12:14:15 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSa0hTYRjHfXfO2U7h4jSTPQ2VOBaleaZbkQu
  6+CHCD9m9KEnsOE/bYs6xM3FdIKOgmGVRlihZJiGVbqUQ5aU0SU1NzKLyUoo6NC9hF1d9CG1n
  Z5V9+z3v///cXh4SU9RKVSTnsHM2C2umpfNxY6xEyyj7XQfiXk8Rutc116S6bvcTmc5z84VEN
  zw2gyXgiXcqKojE6h85ssRvVRHbsWTCZEnLdBwkjLnlI8haSjhK68fxHNSEO9F8EqfuYfAw77
  I/UFB5EnDWdSIxGEBwoeE74UTzSCmlgeuTU0jgRdROGKqdlQkmjKpF0NJ62m8KodKgcHYWF01
  66J7Ol4msBefYACYwTi2D0fp+icByKgXcLre/qII6BtXt1X6eR22CAdclfx1EhcP0yXJ/LkYp
  oddzw58LFAW36joxkUNhbHiGEP2pcKb+k0x8j4GOdx4kMg1l3UWEyOHw6kZu4D0JvA39hLAMU
  F0IRn69CTSIBudkpVRkFTzvagokm+HUwK9AgzD4+bVGKiZPEeB6ViYVt9HD5+KOgCkC7p4fxE
  XTSwzOljQH1omBktqv0osoqmjOdkVzJJFXQtnNCazI/2MLobXQg5cg/C6KT7OZDEZ7BmsyM5q
  4OEaj0TLaOC0Tv1bNHmX0ai6LyeZ4O6NRs9m8mj+SoTenqy2cvQr5Dind2rbtERp1GhrRYlJC
  h8ot710HFAvSMtOPGFnemGrLMnN8IwojSRrkywVtoY0zcI5DJrPvGv/IQAbTi+QrBFnOW9kM3
  mQQpTbEkA2lg8WYArdkWjiVUh72wWeiBJMxy/K3xJ+bfoXCVSFyFBQUpAi2crYMk/1/fRwpSU
  SHyGmhVbDJYv/badw3hMQ3RH5MuTCEnf0nqXLQ1qhV6zu8yXse5cV2PY6wsu2765y9X8y5+4b
  dPUsTY++/LK5KsNewjrfnFm9u6dm+9/yx231RE0rv2kp9mW5BVFLnDvez9nqvy0Y3ezs8a5ZM
  RBpCIn9emWnbQqxmLhiyn66L2VV8vKVxyYYU3dWhE/v7Nq5/UNA3ihVc+3i0JWHnYRrnjawmG
  rPx7G8flCBlzgMAAA==
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-11.tower-308.messagelabs.com!1554898454!5646387!1
X-Originating-IP: [104.47.2.50]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8806 invoked from network); 10 Apr 2019 12:14:15 -0000
Received: from mail-db5eur01lp2050.outbound.protection.outlook.com (HELO EUR01-DB5-obe.outbound.protection.outlook.com) (104.47.2.50)
  by server-11.tower-308.messagelabs.com with AES256-SHA256 encrypted SMTP; 10 Apr 2019 12:14:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pU3laJQOiaWCyTJlh1zFj1dNrEcdk2ltiFDYfIT0Ywk=;
 b=K6emvlF+DYxCr2qlG8MWQmlkGxWaTFzFhXNRB/L6gcCPfS3/f4B+nMwxYeW5AUTInJLGQsUw6nKPHg4PWmCkUQ5I4l0WqfwSq1EfdcHEwIJpl9qNWjjN7mbGYRoY844soW0rtcMNQt4cNcpnGmbG54LCAlMBLD59cP1nGNZDm1c=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB2096.EURPRD10.PROD.OUTLOOK.COM (52.134.29.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Wed, 10 Apr 2019 12:14:11 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acc9:6d8f:da36:9f25]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::acc9:6d8f:da36:9f25%2]) with mapi id 15.20.1792.009; Wed, 10 Apr 2019
 12:14:11 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
CC:     "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH 10/22] watchdog: da9055_wdt: Use 'dev' instead of
 dereferencing it repeatedly
Thread-Topic: [PATCH 10/22] watchdog: da9055_wdt: Use 'dev' instead of
 dereferencing it repeatedly
Thread-Index: AQHU7kLZoqzH654vPU6f8Zb29cdDeaY1UNcg
Date:   Wed, 10 Apr 2019 12:14:11 +0000
Message-ID: <VI1PR10MB2352D7B63B2EEB0F33E73DD1FE2E0@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <1554752326-13319-1-git-send-email-linux@roeck-us.net>
 <1554752326-13319-11-git-send-email-linux@roeck-us.net>
In-Reply-To: <1554752326-13319-11-git-send-email-linux@roeck-us.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af5d4546-c568-4486-75ab-08d6bdae0a62
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR10MB2096;
x-ms-traffictypediagnostic: VI1PR10MB2096:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR10MB209689AE06C31B7ACF4542CDF52E0@VI1PR10MB2096.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(39850400004)(396003)(346002)(199004)(189003)(478600001)(105586002)(8676002)(5660300002)(52536014)(106356001)(305945005)(54906003)(4744005)(7736002)(110136005)(74316002)(81156014)(966005)(316002)(256004)(14454004)(71190400001)(26005)(33656002)(3846002)(186003)(71200400001)(2906002)(6116002)(446003)(81166006)(76176011)(102836004)(11346002)(6506007)(86362001)(53546011)(476003)(486006)(229853002)(9686003)(6436002)(99286004)(53936002)(6246003)(68736007)(97736004)(55016002)(4326008)(66066001)(107886003)(6306002)(7696005)(25786009)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB2096;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N22eNoTCZyITaZn5NT2mDLUo3FQbRwXSkd25Ul0+ijhIvXinm0E2tltUUE8FRpQUhDDQHaTyIgT6aR76T+Bruq/hq4V02M63nx7q9LGjnPHg2yGZGopMGhj4LWTi1dtUAKJ1ixf18Uc0oX+6dmheQL+MIzZkX4r48NZU+8nAzm6TVoKfzQKH9Xz8SxJ5N905Te/rI14UadawogZ4OdMYJKZ/AmGfTTlzq2ZV/Aq38T/LNDHAFg0WtRoyI3UDLE34rlJ8iUzH/BCdqQUz9+iEBYdPycFBBKxJCjdAafCLuxjjz+228+tEUnoWiXexsvEpPTD+bXJBf0tSKsGqJ6WL9CeVXE9E00jkozC1w2cymtLqn+9RXs/oDqmcjjc8FEoteJQ3EwZiw8eQyXgzoIuB7/wvL4W+BYQ4Bcwwbx9TC9U=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af5d4546-c568-4486-75ab-08d6bdae0a62
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 12:14:11.4567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08 April 2019 20:39, Guenter Roeck wrote:

> Subject: [PATCH 10/22] watchdog: da9055_wdt: Use 'dev' instead of
> dereferencing it repeatedly
>=20
> Introduce local variable 'struct device *dev' and use it instead of
> dereferencing it repeatedly.
>=20
> The conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts
> used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
>=20
> Cc: Support Opensource <support.opensource@diasemi.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve

