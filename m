Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DB3C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21342082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="Sc72f3cE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfC0O6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:58:01 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.129]:14233 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726469AbfC0O6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:58:00 -0400
Received: from [46.226.53.50] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-c.eu-west-1.aws.symcld.net id 5A/FB-01080-47F8B9C5; Wed, 27 Mar 2019 14:57:56 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSeUgUcRTH/e3Mzo7iyLhWPiWDloIwZ3O3qA2
  ii6K1i05BO2x0p92NvZhZc0siQ+jWrIhovCtENLOMwsoulbANyzRpkaQssbTLLlk6rJ0dK/vv
  M+/7+f1+7w2PxNR3iFiS87g53sHaNEQYbplG6Rn3kcKNiaV98YYTPb2EYejxfoWh41oRYbjc/
  15hyH+wZL7SeFXsVhnrqg4Qxr7yWtz4uW7CKjxVaXWkOz1blJb+Zh/masM9udXLc9AwdhCFkj
  hdi8GZwcyDKIxU0wUKyD//FskfzxA8avqokCyC1kHJ2w9I4jH0dDiXW6iSJIx+j2D4xFOlFET
  RC6DoYo5KlhZChy8Pl1kP7eLQyHOTobniOSExRW+CNn9HsK6mF0H78UvBs6H0Ymh4cCxYR3Qc
  fNlTHWSMjoau3tJgQ0DTcLbhISbzWOh/OayU/TTYd+udSq4nQOuTXiSzBip8olLmOGgvPRSok
  wFeAV+u6KRZgO5CcOHJtxE/Ht6V5BEy2+DX1+GRO8fDoL+BkA+0KKH77i+lPEAGDBa3jkgToC
  qvB5elNgxeVPxE8gQJUHb9EyHzVKgof4MVoCniqOHEUZo4ShODPywS7p3qxcsQXoVmpfNWs8V
  tZ602RpeYyOh0ekafOJ2ZqdeyO5kMLZfJZHGCm9Fp2SxBK+ywZ9hMWgfnrkOBdTK57s+tR68r
  zY0ohlRoxlIHJhduVEekO007LKxgSeMzbZzQiMaTpAaotfmBLJLnzJxnq9UW2Mk/MZDhmjHUQ
  immBBdrF6xmOfIihrx9uqcYU+MOp4OLjaayJYmWJEum4+8Vfza7HcXFRlEoJCREHe7ieLvV/X
  8+gKJJpImirNIt4VaH++9LA4EmFIEmBnYHm3Cz/6LYHKTZezPFn3/DmdviFdfVe1ZuYLceTsr
  2hZUfXmZKPVrThVW/aj7prUmafdtpzPIlEzHJfS1zCtd2X1gjNq7u9KZN3JU9VHNx85Fk3rRt
  HF9QlsI2bT80r9Lu3Umlx7RqKz/tn7T0Ocz4saKTj1yv8s/0GzqSzI+a6lMjXBHfP6ekanDBw
  uriMV5gfwO961201AMAAA==
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-4.tower-302.messagelabs.com!1553698675!4869248!1
X-Originating-IP: [104.47.13.50]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25360 invoked from network); 27 Mar 2019 14:57:56 -0000
Received: from mail-he1eur04lp2050.outbound.protection.outlook.com (HELO EUR04-HE1-obe.outbound.protection.outlook.com) (104.47.13.50)
  by server-4.tower-302.messagelabs.com with AES256-GCM-SHA384 encrypted SMTP; 27 Mar 2019 14:57:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EXAS5bcaeywyoUD9wYjVihmQpsvFa+g7AMa20ilPE0=;
 b=Sc72f3cEjzd2BklB5ajEJXRn4O7DfLwOskd7yIMyp6hL5mvC0ViOfXkHijARQzgXhVfsIgjm0ljw2I/rOkfQBLCfgvDk7NAw8ZWNIZ01H1TOpK1hgt8trXe3UxidYRI9iVtItNTYEn6zkLL78rP4A+lNwAeAduXeIKyzrb8sZMI=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB1549.EURPRD10.PROD.OUTLOOK.COM (10.165.191.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Wed, 27 Mar 2019 14:57:54 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7%4]) with mapi id 15.20.1730.019; Wed, 27 Mar 2019
 14:57:54 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: RE: [PATCH v2] regulator: da9063: convert header to SPDX
Thread-Topic: [PATCH v2] regulator: da9063: convert header to SPDX
Thread-Index: AQHU40n2wvtyH0sxREe+VqWNC8wWPKYfkmxQ
Date:   Wed, 27 Mar 2019 14:57:54 +0000
Message-ID: <VI1PR10MB235278B820E39A0473F4C562FE580@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190325203155.8885-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20190325203155.8885-1-wsa+renesas@sang-engineering.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 712f4f05-2704-4e31-9e2b-08d6b2c497be
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB1549;
x-ms-traffictypediagnostic: VI1PR10MB1549:
x-microsoft-antispam-prvs: <VI1PR10MB1549966CD5238A4C51B9494AF5580@VI1PR10MB1549.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(136003)(366004)(376002)(189003)(199004)(54906003)(53936002)(97736004)(66066001)(316002)(6116002)(71190400001)(305945005)(9686003)(6436002)(186003)(71200400001)(6246003)(55016002)(2906002)(7736002)(478600001)(25786009)(86362001)(3846002)(8676002)(8936002)(4744005)(68736007)(99286004)(4326008)(52536014)(33656002)(6506007)(53546011)(11346002)(81156014)(106356001)(102836004)(76176011)(256004)(229853002)(81166006)(486006)(5660300002)(26005)(446003)(14454004)(74316002)(105586002)(7696005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB1549;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CljAgPd0ffhblQ51EwO+JIVF4YbNMp7fFwDgYq7CKLKKc4ASCG/ImkOEoQo0wXmLONBHY62J7rDyCOYJ0gY589GkbSmH7psBvGWQHxk/1ukv5OcMPB9OLr06YARb3UBnrWHo1OPmTs8lu4W/y/SMBb/mPXxcRpEN9yvrzojLjU/q7ogsKlr0vbpJcmPK+9xrIhwUqnZfnEmZymK/h/OUyS5Yn+JXAaNuKBj/Rdj5gsMvvJ4aki6+4FOJOPWr8/QjwFkcGZhpcnbbJtzsBkwkLDTjLbkpC/6733JkswJXkRxzlvsfKPBWslInCthlPlaNhOIGLjKNNZ6z4e+DNb8p7GoDD0TMgzGot9X0VBapgQ/SNy4e4YWNCR+kcGIXKyJFAfrHlOocg8z/1sm1eKknqpy0n4RWAzz6IiG7wovM3pM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 712f4f05-2704-4e31-9e2b-08d6b2c497be
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 14:57:54.8109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1549
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 March 2019 20:32, Wolfram Sang wrote:
> Subject: [PATCH v2] regulator: da9063: convert header to SPDX
>=20
> Covnert the header of the source file to SPDX.

[...]

> diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9=
063-regulator.c
> +// SPDX-License-Identifier: GPL-2.0+
> +//
> +// Regulator driver for DA9063 PMIC series
> +//
> +// Copyright 2012 Dialog Semiconductors Ltd.
> +// Copyright 2013 Philipp Zabel, Pengutronix
> +//
> +// Author: Krystian Garbaciak <krystian.garbaciak@diasemi.com>

Thanks!
Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
