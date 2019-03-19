Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1B4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC56F20857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="fBKBUJT5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfCSLHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 07:07:38 -0400
Received: from mail-eopbgr50091.outbound.protection.outlook.com ([40.107.5.91]:33967
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726573AbfCSLHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 07:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3TbVBk+cuXGdgKmiQEXm20S4bVFa+SjKNrRqCol13E=;
 b=fBKBUJT5nrt/bELPwfWPoovSkky1mAyvrG7yResYAEhbdRDM4hFvtRzJhQgWocyb4xSSj+XbWWJi1XKaJ7nUeSNlaXs6jQDAHmIWTdLrYrErGLTLpKUwWAxhp2LWPdBvyN5uhL8QU5vwMQnDA9qoVjzSXYCji7MhYy+CdsV0f9s=
Received: from DB6PR0701MB2487.eurprd07.prod.outlook.com (10.168.78.13) by
 DB6PR0701MB2872.eurprd07.prod.outlook.com (10.168.81.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.11; Tue, 19 Mar 2019 11:07:34 +0000
Received: from DB6PR0701MB2487.eurprd07.prod.outlook.com
 ([fe80::3102:a9c3:8cb7:a2c8]) by DB6PR0701MB2487.eurprd07.prod.outlook.com
 ([fe80::3102:a9c3:8cb7:a2c8%11]) with mapi id 15.20.1709.015; Tue, 19 Mar
 2019 11:07:33 +0000
From:   "Koskinen, Aaro (Nokia - FI/Espoo)" <aaro.koskinen@nokia.com>
To:     Jose Abreu <jose.abreu@synopsys.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: stmmac: fix memory corruption with large MTUs
Thread-Topic: [PATCH] net: stmmac: fix memory corruption with large MTUs
Thread-Index: AQHU3dLOd25OwllMM0aI7XUqGnqYlaYSw4eAgAAHX2M=
Date:   Tue, 19 Mar 2019 11:07:33 +0000
Message-ID: <DB6PR0701MB2487FF2B8D4C0219DD209952F4400@DB6PR0701MB2487.eurprd07.prod.outlook.com>
References: <20190318213608.612-1-aaro.koskinen@iki.fi>,<92e465e5-0c77-e22f-d7e1-4689f3d655e7@synopsys.com>
In-Reply-To: <92e465e5-0c77-e22f-d7e1-4689f3d655e7@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaro.koskinen@nokia.com; 
x-originating-ip: [131.228.2.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5099ea9f-7289-4a3c-49c0-08d6ac5b168f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB6PR0701MB2872;
x-ms-traffictypediagnostic: DB6PR0701MB2872:
x-microsoft-antispam-prvs: <DB6PR0701MB28723C568E0F678CE6B44003F4400@DB6PR0701MB2872.eurprd07.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(39860400002)(396003)(136003)(199004)(189003)(478600001)(2201001)(2906002)(8936002)(2501003)(4744005)(256004)(486006)(14454004)(26005)(186003)(446003)(86362001)(476003)(52536014)(11346002)(7696005)(6506007)(76176011)(3846002)(71190400001)(71200400001)(102836004)(53546011)(6116002)(99286004)(33656002)(55016002)(53936002)(74316002)(106356001)(6436002)(66066001)(7736002)(9686003)(6246003)(8676002)(105586002)(81156014)(81166006)(5660300002)(316002)(110136005)(229853002)(97736004)(25786009)(68736007)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0701MB2872;H:DB6PR0701MB2487.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YebuLLQSfRhnhFuRxTtInhjrhHnKig1yDNt3IymKl1ov5zBNo9D4g4Kq3P8aQ5J9th+tSroKb8htaL8BC2MooCywwNmTFzpeUDUzXn/1fcilSxp74fzGqjkG7WHS0DoYUL05aJswaVgp/mHayBgQhfpcE6w0C5oxXT9mcv4wIOCNc6C8hezoxFKN+pdJh5uIwurgMmarx+Ag3ABci+V1bl87ZA1IMokKUk3ufIDuvCFvv9iB2fjP2nkmNe2cCxh2l6OQx1aiVXGe3l/u8vM+CZSA1/gHTbWAG2/IlEBjDVWjBGRNEaiBbO4mSMAboHFggv0pMdXvrha0nFvuz+9BuR8RovQgIzl+mph5OInUakRLNyvh/sgVydH9kAX3LrbAqNCyFk5uHanSQYEG3/BxdO9lhjRWw4hxlFyJgRQ8PBU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5099ea9f-7289-4a3c-49c0-08d6ac5b168f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 11:07:33.9544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0701MB2872
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

From: Jose Abreu [jose.abreu@synopsys.com]:
> On 3/18/2019 9:36 PM, Aaro Koskinen wrote:
> >       /* Fill DES3 in case of RING mode */
> > -     if (priv->dma_buf_sz >=3D BUF_SIZE_8KiB)
> > +     if (priv->dma_buf_sz =3D=3D BUF_SIZE_16KiB)
>
> Shouldn't this be: "if (priv->dma_buf_sz > BUF_SIZE_8KiB)" ?

I think it should be the same as in stmmac_init_rx_buffers():

        if (priv->dma_buf_sz =3D=3D BUF_SIZE_16KiB)
                stmmac_init_desc3(priv, p);

A.
