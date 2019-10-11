Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4A1C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB752214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R2BRbaEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbfJKOUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:20:48 -0400
Received: from mail-eopbgr40069.outbound.protection.outlook.com ([40.107.4.69]:15158
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728084AbfJKOUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:20:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zl9jj965900QDGJGQn3zJWG3EuCueQoXLm+j1W94rrF9Li9ztKKGWGCfaS3XfiIA5KtckKL2LG843D2HyKM1BkxNldAyX0Fcw9b/mgP0Wr475iTxeUBpivs/BxMlDYsuJYYHcEQbQy3UWSbgFy6fKwmcB1gvMNqxGqUI3XBGCZb0MzYZdyV8c7UCKn2wlRLWMEAaRpfj6vWgJtaqs5OUjwIAnzRAfNdqmLazbtSlPnAe+XDmrZyU+goC1l9jpwa9xF6jQnEUEZR4GxO0V9fktw9QvR40jV2h3/+7jQuYB+IVCXI2naWKK1np1KvBC8PG1LoC+lvlMabYyvMQNbuYJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUvTOWjB+Ajd/X2ab6qBYM/R/vLqxFicShpEaEdqWvQ=;
 b=bmbBdzcMm/KRABnv8Zx57S+Con0ZszdlpQCzuKsc/CfvTwGwpLOOcm0voGElTVC+iuz9+uW30owFzGaJs3Pw//w6mMiKSB59j2uedyLwHgh3Re0FrR5cyUtMR7v17pnKvP0tP6hjf6GAzONa5SeOgbqQPzkEcd7kNeczkkaw7n6WPmZWKf6ERgl3DP45+bbBZZcmxiCsd4xdZ1+0L3GXLn6SrBmlD1pVPLHrw4+n8wRbXoPZzVlyBV3EzIGEBtYXA5KbK+TAH0Mq8g5aK5CAnVRfKUJRGfff4pEcFBGucX8+InWBao/qJKAYCPXh4Hlq66baIiUo7BbCWPK2Y0TEXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUvTOWjB+Ajd/X2ab6qBYM/R/vLqxFicShpEaEdqWvQ=;
 b=R2BRbaEPhQKsr2URriHMNAN00pj1m+s2Tqja/9ImnYNXseWev5N7shFqeFz2H+x5jr+qtBOjeI/WdeIUQhnoTW7Op2PntUKIV6n2YH8cljR0HoT/knD7rh9GYnW6cnYUMFKS43TzeKsZAlx5yMIDtwWGzpvS8YY/38sjtcnJxVM=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB4495.eurprd04.prod.outlook.com (20.177.54.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 11 Oct 2019 14:20:44 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::8c20:60f:5a1c:42ef]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::8c20:60f:5a1c:42ef%3]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 14:20:44 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Joel Colledge <joel.colledge@linbit.com>
CC:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] scripts/gdb: fix lx-dmesg when CONFIG_PRINTK_CALLER is
 set
Thread-Topic: [PATCH v2] scripts/gdb: fix lx-dmesg when CONFIG_PRINTK_CALLER
 is set
Thread-Index: AQHVgC7oaoKGJTwDR023SeD0lnQ+JA==
Date:   Fri, 11 Oct 2019 14:20:44 +0000
Message-ID: <VI1PR04MB7023FB0139BDB810B1400F6EEE970@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <VI1PR04MB70236211F170522DD456553AEE940@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <20191011122409.23868-1-joel.colledge@linbit.com>
 <VI1PR04MB70239DA9EED5F689645071E9EE970@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAGNP_+Wkya-wn-ckAmCoC0Mda=3cBDi4vYeZj-9SWT0EF8ja4w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1c033b3-7e35-49e1-9994-08d74e563416
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR04MB4495:
x-microsoft-antispam-prvs: <VI1PR04MB4495033DC9B472B49D75B21CEE970@VI1PR04MB4495.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(189003)(199004)(51444003)(54094003)(3846002)(66066001)(6116002)(99286004)(6916009)(476003)(486006)(9686003)(86362001)(33656002)(2906002)(74316002)(7696005)(256004)(44832011)(446003)(7736002)(54906003)(305945005)(316002)(55016002)(71190400001)(76176011)(81166006)(71200400001)(102836004)(81156014)(91956017)(66556008)(14454004)(52536014)(5660300002)(66476007)(76116006)(66946007)(66446008)(64756008)(8936002)(478600001)(8676002)(4326008)(6436002)(6246003)(229853002)(186003)(25786009)(53546011)(6506007)(4744005)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4495;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oUZUhnodxwjxS9aAOstuDelZkP7Wj2xnb84bDrVGng8+twHz6ZuVJTeRo2D6HGsL2V0wI8gV5WIK71iBtIjsSaLZ/8WTr0swnvIousEOwiejpdeBApVonZAn688DNM1q/Qsv5ZZS4yXHdDqwEkdzON0JIUDbfvwFKkCkqFWQTR72Gf8/JPADU/q5d13U9J6E4nA72x/7P+MqGjZ1KDwI2dWxhQ89F4ha8REvvgWY1dWWBNEbNPD0G6H+yWcIxzFYdd9bLZuQKxrTUN0C6JoNOGj4bWotYyfL70Uvxl6ui88d29udn++09ql4pne6fDvk1frdyD9ZsfxflblhWZF/tPa1i3DC/t2LSSHf6njYnPgoMENzeCTK5J5OjrLh5nutSXYGJq/P3gQh23h9WUW1o1734RTGjL+PjxpIAFWR14c=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c033b3-7e35-49e1-9994-08d74e563416
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 14:20:44.3374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UQ7YAGw00uteWrnc4B+5ChU1JlRePriwZNgn5UxMknR+TvmWHo2B6GtY2HSuIpemtPdMhBDDPv8MBGnQSjXUBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4495
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.2019 16:02, Joel Colledge wrote:=0A=
> On Fri, Oct 11, 2019 at 2:47 PM Leonard Crestez <leonard.crestez@nxp.com>=
 wrote:=0A=
>> This struct printk_log is quite small, I wonder if it's possible to do a=
=0A=
>> single read for each log entry? This might make lx-dmesg faster because=
=0A=
>> of fewer roundtrips to gdbserver and jtag (or whatever backend you're=0A=
>> using).=0A=
> =0A=
> I think this is already covered. utils.read_memoryview uses=0A=
> inferior.read_memory and I think that reads the entire log buffer at=0A=
> once (at most 2 reads, one for each half).=0A=
=0A=
You're right, sorry=0A=
