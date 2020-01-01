Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EADC2D0C0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 03:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24798206CC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 03:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LmXAxBYH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pjaXuMY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgAAD1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 22:27:04 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:7204 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbgAAD1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 22:27:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1577849223; x=1609385223;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=4tWaDeVt2dAXOgoyHNpnVKd4oN8rpdLKPk9FLKqy3Fg=;
  b=LmXAxBYHacGvQYcQDzLcniVdq+NAkSvo5o9DHzlNTU536TEuIL+9IUr6
   YZG1SPpsFMjcjbgAlbGs53YV4H/TYVkVG4UwS8pssMgKbgJBo6ki9ER7I
   bwHtySv1ZUVJqz5f6dlPq/I1scLN+6NfDIuVx858ND/OIAN869FbUYmmx
   JJjje3qiyRHA4cvxKOBW9C/vDJqkKGFN3cVHTwUA1v0/2HHpbIP35pTkh
   frDEnOAYgdieo8xuEjJI6K9agt5fF6Tta16BE3whCgIQlCDXEe+8SqUPK
   xguLdNXQRD48bq7jZBQZUiCMlWUHk94QCYhNiQbcldX5druNYaXz7+ALY
   g==;
IronPort-SDR: yqtZfSbQGnWASr1pX8FScLgGaNr6cV1X5nJMNV7GVZ+sv6DmbIP1HWTMASJbw6VknsO9tBRXqj
 i2UlckgbVlpEtIMB2Vp7hJNlD2IGaJX9HxuOn4v4wcAjT7fW7F0mKPVLzagehcswhnRh3AxMCS
 U2sCOKHKajT22waifblj31sQveI89of8agchdjWYWzPOZQIdYE0d28mguBsTCaNRbBeDDJdf8Y
 Kh2nT0YMC8S0pwTMC+20lBhS1FTFXxYojpH2gO/zQdB2QOZjJ6An9UWz31CmKsQXnlpwjXCYjk
 Z0Q=
X-IronPort-AV: E=Sophos;i="5.69,381,1571673600"; 
   d="scan'208";a="234267960"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jan 2020 11:27:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dm6OYQ4JkWHJbJzh66wd13u5Ru7iNJxLbQS0vqSVy7SVdpEfOXq28SWtU1FxgB+84WG8Ox+VqKtVTDWTvKu/9EAvSVEZ7U+SQF83cvBnDV2sU27tQwDNcUIgHuwWnuUkTQdenJml765cG43YBDR2bNMw1Olc0fsij7LLeIED5atgmS6WKC0xbUTlJ/Z/Fe3ggUe84S54lKNqoQnjJLgVO0jbdB7uiCQtDR1Acjn8Yzprmg8rARWUqRlKcLVxgNI6yQULypgyfGqkmLs1BuegZVawo2RIgdzBZmN/lGW9gCQxYiSRk6PiRO58xJGvPafYQ3fyFr9GK/W3d9OTWt4c/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tWaDeVt2dAXOgoyHNpnVKd4oN8rpdLKPk9FLKqy3Fg=;
 b=auFlmZh1442jEA3+ZuclW8eBURzdCpg6EKAZA4nsxJrj3bO1ppQW0m+2vdyo5Qlut9v//Yg9SBUSwcq02VPmRuI5NCat4rtJAy5QCWkZp3J33xHkUOUDxTnEhO9UePX3YwBPdJNthBJatUSRoNc1lttgfuo9Sa4PdmyrT7f1ToJ1eDAOXNXUmxkbfxfOqxbMZOlvhMkKWxeWjB4fMPexgZiX/ZFc9r8tGUfoJsSWz9UiRPSVK+Zvp+5ZF4NXs5J9Zz9DOoEfNsGqCB8+lZORUoTxheUK31ONAY0CsGn1w272JEhtrWT81JgyiXItE6aEusgF2r6ZQ91Oc4GeG6S43A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4tWaDeVt2dAXOgoyHNpnVKd4oN8rpdLKPk9FLKqy3Fg=;
 b=pjaXuMY2MzSJhz1amQZMiU31XDBvCOv1bKxsbBwfYbNkmjbug36x/Z5DJeq6Scy1InkUTByJd/XhLkyECVWkWwXCfk4WtOAJEt2tpGNMampnZz4WRRyy6SMJKvoNEE7uhWcdcnIhApN4zQSYbXBiLDG61+ioIhA71v1hItsJunM=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5862.namprd04.prod.outlook.com (20.179.58.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Wed, 1 Jan 2020 03:27:00 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::a8ea:4ba9:cb57:e90f%5]) with mapi id 15.20.2602.010; Wed, 1 Jan 2020
 03:26:59 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "Singh, Balbir" <sblbir@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "=linux-block@vger.kernel.org" <=linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "Sangaraju, Someswarudu" <ssomesh@amazon.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "hch@lst.de" <hch@lst.de>, "mst@redhat.com" <mst@redhat.com>
Subject: Re: [RFC PATCH 1/5] block/genhd: Notify udev about capacity change
Thread-Topic: [RFC PATCH 1/5] block/genhd: Notify udev about capacity change
Thread-Index: AQHVuTJSbECLIM1il0K+YWQEXBwT7Q==
Date:   Wed, 1 Jan 2020 03:26:59 +0000
Message-ID: <BYAPR04MB5749C2F13BD6F6C15509FE8586210@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191223014056.17318-1-sblbir@amazon.com>
 <e452f6a638fe09f065b9e4cd1c25d5d3a2f29e5a.camel@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [2605:e000:3e45:f500:218d:d9ca:f71d:c5c4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 74ee8643-b92e-49e0-0ea5-08d78e6a765a
x-ms-traffictypediagnostic: BYAPR04MB5862:
x-microsoft-antispam-prvs: <BYAPR04MB586278B05ECA40AEA83B218C86210@BYAPR04MB5862.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 02698DF457
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(199004)(189003)(66476007)(66446008)(71200400001)(53546011)(4326008)(64756008)(66556008)(86362001)(558084003)(7696005)(186003)(6506007)(5660300002)(52536014)(478600001)(76116006)(66946007)(8676002)(55016002)(9686003)(316002)(8936002)(81156014)(33656002)(81166006)(54906003)(110136005)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5862;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qnJjab+Qphngc4S8HXAhI5hdipbD5IW5wupEfa8MRaC2XNZU9LAZqWIryRRbZOesvTrlmzyUREg1ImMx64HKbyotAug8dPFHOv1m3sl04E+RJRskKEusk7Y4DXZny5s/0+NvqmRa9nI0wm6o8rRULMdE04Ps4U3+KU60lethjSIgBKTiscEhCDAu8Ix4ddZSnDP+WIh91YCxNYIOUN23nQMF6BPD6NMSMM4ns7PXF16PTFrU3crgSe0JomFZR1heGyqneWN8SmPesMQW1v0cMzzDecLKv/tzYNCvjgWidlgl6wtqdfE5ir4vWh6ZKOGnB6TyNW9lZ77tuCjByB7FhZOmUXEhFsUDE3OF8w4ymv3vagsCuwQbVa0NQTtsCacusg6yrTVJ5d6inO5gNHgootdA6k5b+x6ZsZiEK3199E49kXjuCG5B3RKS94mcO5/P
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ee8643-b92e-49e0-0ea5-08d78e6a765a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jan 2020 03:26:59.7366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xUva14W6FG2AZmeMdBDDde7pROo/zpa9YnZ/0j/FP6rKZXqbOLtjFT/DTK0vUjxZJ1pSayxd8VMjeKjCKASTtEhZqLM0lVlWlEWtrIT1kpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5862
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/19 5:53 PM, Singh, Balbir wrote:=0A=
> I messed up with linux-block ML address, I can resend with the right addr=
ess=0A=
> if needed. My apologies=0A=
> =0A=
> Balbir Singh.=0A=
=0A=
=0A=
Unless you have sent it already and I totally missed it,=0A=
if you are planning to resend can you please also add a cover-letter ?=0A=
