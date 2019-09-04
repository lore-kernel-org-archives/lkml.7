Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B32C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A73582341E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Yvzr2jjH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FpqZhKTv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbfIDOMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 10:12:07 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:51025 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730512AbfIDOMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1567606326; x=1599142326;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Bw8ekpPmDqVi3QJtyu87RQ4jJQT6BFh2NoOQHO4+it8=;
  b=Yvzr2jjHk9ntGP1McxfrPD5jRRZvXtuzNY4T5DSx1F6hqpGkI/pmDOwu
   qmeI84J5/RgC7zGSlqA36bFN9QH9aQ17cAuTvBCTWOW431WzUABpWo8Pl
   mgV4JwIoGHNXocJzIAvVOc+AIDSSOhQBHavePblEroRDdoWaDx4FdNVwD
   CgM5mtWa4tf06ovjjM5IeVRIdnwqDVtU0GPU2DJJdJpff/k4cq2DQbVBe
   2lj5jITTPsr1Z2co7cpV05hrAjZwWxehCj4wWuWREU0K+fqmBQ6sw5gnU
   lu/0r8ILj03QqnYBc+wska2jJa/RZXs+oznbnYnHDz2lo8Ow4GveI1h6U
   g==;
IronPort-SDR: VddtBeQ9qCxoNCJSwWeihBoZL5CRVVkP/BtEPpRY5B1377ZmTfdZi2N0eN5nO3MLkSBMOx2J7M
 mzFdHqbPW7PjJLkj/jf2zFWefJeSggasj0ti+elphmB/yZTiueIiGS6bvnSpv8+zqXua/UNN1s
 7EpWrGDAEXJ4Jine1/i1c4FxeTB6UE90A2HQQKXIue8xA46pwKfB2uOyg6AoWaB/esB7yHuZRT
 EGHJhhqrJpFqM61mAbSOMGKgkp1ywaPUapSEdRAdDJfw50BUyU6Y/dmv4lJQb/FS0T6f3AIgeW
 uaQ=
X-IronPort-AV: E=Sophos;i="5.64,467,1559491200"; 
   d="scan'208";a="121974734"
Received: from mail-sn1nam01lp2053.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.53])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2019 22:12:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjl12I8Yi7jm0P8o5tP1nWAYHx8Qa+0tFF+kqVwPA69bgr0VgHV0sFTG/WzX0/p84jrIlNYsxatrAo2e6hU5QiZDlhW9dUTM5/tCDjnkHLauphsuFkkH9gXNITt7VbnOCveXM6NXbMY+cA+y2ffvL95xmnHxvDaC8++bPp5qISpN3luj7S5+IwCod6D4HCNIGXGerC253F5OscWixWpoZcucGIGBsGiqj/jKXOM6xUfFTRzqfZ/GB3s7qY9w3IhFERVqm+H9pI8p+8ky47xyKTPo8T7G6yXOw0pBqKfPLdjfXoTafajGE7G/KwPkGeYg5fgWn/ODemutUlQXv0h2hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51wCs06DUa2QcWW20+MVpvW8IwMh3ja27k1LgkdwRvU=;
 b=JOwDgzD8dN4AMS5GT1vaLKXZIw5q/sOfWRZGariVYhk2CTr8Cu+3Wljc1+cO/UFkvKnWzOQCrGl5pfId2LJDaSKhDWmHRsGdMM5hWMtne/NLZE7HNezKy8NFDqyBxsp0UYtQGzRoZvtEroUZHjVC2GgXWERtRXk7vkRxftvykIEwcdBScI84Nq2gsUCONOFuDpbph690bfN2Q4ArPGo8q3lqcJXjbzR15q2tecMNHvOWmYLLIYGQCvCNcXQYzXY/8ye7ancs/r+fvknoipYR8J1hTd3pSnr5tzaqwjIp55ygof98YT/ziJVOiI9mPDFsmsiZYiWTcjCNMTuWqtvbGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51wCs06DUa2QcWW20+MVpvW8IwMh3ja27k1LgkdwRvU=;
 b=FpqZhKTvXmqqc7HrKD1FIFFU3uCvXJEC94d009xHT2gblhq45hDdbSijIt0jPDcffY43Hsnd7Qjh9oIh9oSmTcpr8Tmns2e1ll0ROJy1z2RLaDW2lt5dtn7bEzuTty4RJyn8R8BJZTyPErkHDvVnvu0n3JuTiHx2uUpNvkuuY0I=
Received: from MN2PR04MB6991.namprd04.prod.outlook.com (10.186.144.209) by
 MN2PR04MB6416.namprd04.prod.outlook.com (52.132.170.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.13; Wed, 4 Sep 2019 14:11:58 +0000
Received: from MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::9c2b:ac1b:67b8:f371]) by MN2PR04MB6991.namprd04.prod.outlook.com
 ([fe80::9c2b:ac1b:67b8:f371%2]) with mapi id 15.20.2220.022; Wed, 4 Sep 2019
 14:11:58 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        YueHaibing <yuehaibing@huawei.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ming Lei <ming.lei@redhat.com>, Chris Boot <bootc@bootc.net>,
        Zachary Hays <zhays@lexmark.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "srv_heupstream@mediatek.com" <srv_heupstream@mediatek.com>
Subject: RE: [PATCH 2/2] mmc: block: add CMD13 polling for ioctl() cmd with
 R1B response
Thread-Topic: [PATCH 2/2] mmc: block: add CMD13 polling for ioctl() cmd with
 R1B response
Thread-Index: AQHVYvYWr7zFcN7xD0GIE0WcESsTdacbjhBA
Date:   Wed, 4 Sep 2019 14:11:58 +0000
Message-ID: <MN2PR04MB6991F51F6DDCA28FC23D02FEFCB80@MN2PR04MB6991.namprd04.prod.outlook.com>
References: <20190904075444.2163-1-chaotian.jing@mediatek.com>
 <20190904075444.2163-3-chaotian.jing@mediatek.com>
In-Reply-To: <20190904075444.2163-3-chaotian.jing@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08b6b784-e010-43c5-b0af-08d73141d984
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:MN2PR04MB6416;
x-ms-traffictypediagnostic: MN2PR04MB6416:
x-microsoft-antispam-prvs: <MN2PR04MB64164D8465E4397CA7ED9E57FCB80@MN2PR04MB6416.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(199004)(189003)(6246003)(54906003)(305945005)(110136005)(86362001)(2906002)(25786009)(66946007)(4744005)(14454004)(4326008)(76116006)(446003)(74316002)(5660300002)(33656002)(8936002)(6116002)(7416002)(7696005)(3846002)(476003)(11346002)(53936002)(71190400001)(71200400001)(256004)(478600001)(6506007)(81166006)(486006)(81156014)(316002)(52536014)(186003)(102836004)(9686003)(6436002)(55016002)(99286004)(8676002)(76176011)(7736002)(229853002)(66066001)(14444005)(64756008)(66556008)(66446008)(26005)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR04MB6416;H:MN2PR04MB6991.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dhXHev53uAbgm4xxIgZyc21nn67XzLaDY5BXfC/ejcG914J1EMY7RGtVlzirlZNgrLLBeba+VpBi1Q0o16+hIcBHoTyW5iiT3GtoXDK2vAlC31IjbLTgYI0qFK6sMnps/erOuVHapLJEJE0/ZIJDlE/h6paleukqfapdJ2Oh+pba1ePoHpFWEKfILT2egQPSlA5gZdmif8/C7iKGY7L4KxlBiePhhFJmSudl9+2btJHOvTzaSZ6y5Vwku5amupzdCAeHcuziA2Rx8QWD6awYaqNF4hOpGXxxsVib4VIVo9vnZvwJFA1NNm5Vo1cS2wSEO6BoS08Zv4TK1/0cwARzo4/7QStUTJFCl2Js55d09/rGY+8taoEsUPnZrBHHL9wgwIw8DUqp2qF3C4qnRt4MGhj755Uz2jAZWM6I0UUQmlk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b6b784-e010-43c5-b0af-08d73141d984
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 14:11:58.6880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wqdppwAIIBUz4R/8fpkC521g5A4InXclTlZObZ3KhPdsoqjP4JGtreDKPXr4Bu0VHzbrNcv4Oni1fj8N03JtaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6416
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct
> mmc_blk_data *md,
>                                struct mmc_blk_ioc_data *idata)
>  {
> @@ -623,6 +675,9 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> *card, struct mmc_blk_data *md,
>                                         __func__, status, err);
>         }
>=20
> +       if (!err && (cmd.flags & MMC_RSP_R1B))
> +               err =3D card_busy_detect(card, MMC_BLK_TIMEOUT_MS, NULL);
> +
>         return err;
>  }
You have both the R1B flag check, and status poll (for rpmb) few line above=
.
Maybe you could re-use it.
It will both simplify this patch, and save the tad optimization of your fir=
st patch.

Thanks,
Avri
