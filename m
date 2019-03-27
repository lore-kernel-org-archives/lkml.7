Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBAFC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F059F2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="MaWwIxl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732672AbfC0Jew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:34:52 -0400
Received: from mail-eopbgr1320115.outbound.protection.outlook.com ([40.107.132.115]:55216
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726237AbfC0Jev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4op3KVZdLLk9AwKtMpv6cduJsFzooG0mKxny8g9HR0=;
 b=MaWwIxl3yJtYDW//X6mvT+ex1kRVOd/ycPcCFZrz+GrJtR1lc7QHFKVw96TKcZey4TPpq6AreoWTWsf46rTYfZQqvTijs18MO0Ak4lk/9Al3ozTLRId1A48Z4U1LHul5GkDi+NMsJLD9I1wuLuIvH4xmV4SjrLmHwHq8bbaM3m8=
Received: from TY2PR01MB4812.jpnprd01.prod.outlook.com (20.179.170.147) by
 TY2PR01MB4939.jpnprd01.prod.outlook.com (20.179.171.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Wed, 27 Mar 2019 09:34:42 +0000
Received: from TY2PR01MB4812.jpnprd01.prod.outlook.com
 ([fe80::f423:2ed8:938:c28d]) by TY2PR01MB4812.jpnprd01.prod.outlook.com
 ([fe80::f423:2ed8:938:c28d%5]) with mapi id 15.20.1750.014; Wed, 27 Mar 2019
 09:34:42 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Nguyen An Hoan <na-hoan@jinso.co.jp>
CC:     "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        hideo inayoshi <h-inayoshi@jinso.co.jp>,
        "nv-dung@jinso.co.jp" <nv-dung@jinso.co.jp>,
        "cv-dong@jinso.co.jp" <cv-dong@jinso.co.jp>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>
Subject: RE: [RESEND PATCH] thermal: rcar_gen3_thermal: Fix init value of
 IRQCTL register
Thread-Topic: [RESEND PATCH] thermal: rcar_gen3_thermal: Fix init value of
 IRQCTL register
Thread-Index: AQHU5Hv5HUd3OK9MgUm+J5pX9J9CpKYfN2wA
Date:   Wed, 27 Mar 2019 09:34:42 +0000
Message-ID: <TY2PR01MB48128E8FFB7D26714A61BF62D8580@TY2PR01MB4812.jpnprd01.prod.outlook.com>
References: <1553677398-7896-1-git-send-email-na-hoan@jinso.co.jp>
In-Reply-To: <1553677398-7896-1-git-send-email-na-hoan@jinso.co.jp>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 608bede4-e4af-4820-071c-08d6b2977133
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TY2PR01MB4939;
x-ms-traffictypediagnostic: TY2PR01MB4939:
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-microsoft-antispam-prvs: <TY2PR01MB49399618034128FAA77F2665D8580@TY2PR01MB4939.jpnprd01.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(366004)(136003)(39860400002)(199004)(189003)(2906002)(478600001)(7416002)(5660300002)(86362001)(6116002)(3846002)(8676002)(6246003)(8936002)(74316002)(476003)(14454004)(54906003)(486006)(66066001)(9686003)(53936002)(11346002)(55016002)(446003)(81166006)(186003)(97736004)(26005)(6436002)(229853002)(52536014)(33656002)(316002)(81156014)(6506007)(68736007)(256004)(71190400001)(4326008)(76176011)(7736002)(305945005)(6916009)(102836004)(71200400001)(105586002)(106356001)(4744005)(25786009)(7696005)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR01MB4939;H:TY2PR01MB4812.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: phpjGw73tE9zknBWhDvkLKXRugcV3SilB5hLjvFIwfkJ0YF17QzfwaBNvl7hCQcFGEjThaB/vTYGWsx1c2JPlsuCnvMmuP6iXx1O0zuxAzxuBpwwFUymRHLGpOyT6J6e8vq0H7R1z8oSmb1jIwNU2bOxTSM75uw9DDiX6vc5cnwQncoWTmLhMEtCOuetPDpj9E+onhsrZe9LtJTn1a59yto1HbXNQc5ft2raxE/pr6+IC0CRk62agmXldWDoy+qpd4LYiCHBUTw4yCDpT/4441aMnGWu4xd7epFsLDFhpesYVcEJn/BNl7gXNuNgKLaio/BllJphQaQxguJpqXLUPCR8v9DQZnyoNFPz4P2F41RHTEjGmQ39wxEp5us6w5osm8dl8nfRf4iizMt/HiYN9ls05IF3eJVdMDUYDZEaSk0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 608bede4-e4af-4820-071c-08d6b2977133
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 09:34:42.6407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4939
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hoan-san,

> From: Nguyen An Hoan, Sent: Wednesday, March 27, 2019 6:03 PM
>=20
> Fix setting value for IRQCTL register. We are setting the last 6 bits
> of (IRQCTL) to be 1 (0x3f), this is only suitable for H3ES1.*, according
> to Hardware manual values 1 are "setting prohibited" for Gen3.
>=20
> Signed-off-by: Hoan Nguyen An <na-hoan@jinso.co.jp>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

