Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01EDC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C25420872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="I2wo4tHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbfDQMOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:14:17 -0400
Received: from mail-eopbgr70092.outbound.protection.outlook.com ([40.107.7.92]:10014
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726708AbfDQMOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jbLKGFq3bPYakonabdOf04bLP5RhwGJk/k9Sb72mNM=;
 b=I2wo4tHS1hQJb7cD6UXU94XRf9gGde/azrJ7lEmSxUwnMd4O5hKlHCM6tBLfJdjkruFQZ4jENo/ZAILEGxgeurmWvjSegLCQGT6Ll7mVE8uTTkSBl+qs4sNs1UKFzUfZL2fT3uDa6dhmrdjceDYifkXKbXtaKqwIVvpQI0BvG/o=
Received: from AM0PR07MB6019.eurprd07.prod.outlook.com (20.178.112.14) by
 AM0SPR01MB21.eurprd07.prod.outlook.com (52.134.87.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.9; Wed, 17 Apr 2019 12:14:14 +0000
Received: from AM0PR07MB6019.eurprd07.prod.outlook.com
 ([fe80::8538:2f6b:1fad:e3e7]) by AM0PR07MB6019.eurprd07.prod.outlook.com
 ([fe80::8538:2f6b:1fad:e3e7%2]) with mapi id 15.20.1813.009; Wed, 17 Apr 2019
 12:14:14 +0000
From:   "Koskinen, Aaro (Nokia - FI/Espoo)" <aaro.koskinen@nokia.com>
To:     Yue Haibing <yuehaibing@huawei.com>,
        "peppe.cavallaro@st.com" <peppe.cavallaro@st.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "joabreu@synopsys.com" <joabreu@synopsys.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH] net: stmmac: Use bfsize1 in ndesc_init_rx_desc
Thread-Topic: [PATCH] net: stmmac: Use bfsize1 in ndesc_init_rx_desc
Thread-Index: AQHU9MAG2Tyy46rygEK2TSRtfqvKI6ZAQa1g
Date:   Wed, 17 Apr 2019 12:14:14 +0000
Message-ID: <AM0PR07MB6019956E9F0C5829C1ACDC5EF4250@AM0PR07MB6019.eurprd07.prod.outlook.com>
References: <20190417014939.36656-1-yuehaibing@huawei.com>
In-Reply-To: <20190417014939.36656-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaro.koskinen@nokia.com; 
x-originating-ip: [131.228.2.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01fdd744-19ee-467a-e7a3-08d6c32e34d3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0SPR01MB21;
x-ms-traffictypediagnostic: AM0SPR01MB21:
x-microsoft-antispam-prvs: <AM0SPR01MB21D8F43B4BD6E6800A47A5F4250@AM0SPR01MB21.eurprd07.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(376002)(136003)(346002)(199004)(189003)(25786009)(66066001)(102836004)(316002)(5660300002)(54906003)(110136005)(26005)(4326008)(6436002)(4744005)(229853002)(6116002)(52536014)(76176011)(3846002)(186003)(6246003)(446003)(53936002)(11346002)(486006)(55016002)(9686003)(476003)(71190400001)(71200400001)(68736007)(74316002)(99286004)(86362001)(106356001)(7736002)(478600001)(7696005)(105586002)(14454004)(7416002)(305945005)(2501003)(256004)(2201001)(33656002)(81166006)(8676002)(81156014)(6506007)(14444005)(8936002)(97736004)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM0SPR01MB21;H:AM0PR07MB6019.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iRmqm3USVqtE4iVGOEhMzZdkOWf7IYctAWuq96Gxcg0+eLyEoeijWDt5ACg0j+WacJ4OX5WsRK8w8nih7FfEvEUx/WdaI8O6CNRrxsaYcBtFsOsTqeLMVYOHx+uWv1PeeVbRfy5m77jF3aQsxmYZkrVWDFr5Mdyjq9z0QvBFJz8+Gsn3sOFDHqMvhSZkNo1oSkdp2EsbfJZB5cWPXht+FPG67L6wILlxz8FbtdOBJZ8M9OOnFzIoALTnTS6EhORZyeQii0I50o8RofRK4ad3TS10PjdKtbwssXAkctkwZ1kmUVleN4XUIoZ3OJVAN/G4QCWNTTTtEyXASXFJr9GKErpA8dyBeGe+kPaLADRhEJljZ8BVCt6uzZrAkgP7wVP1/WiRA8zuB5XkEU8FJ4e3cYZbKwSAmu6wdpcWDFHZJKY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01fdd744-19ee-467a-e7a3-08d6c32e34d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 12:14:14.0299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0SPR01MB21
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

From: Yue Haibing [yuehaibing@huawei.com]
> gcc warn this:
>
> drivers/net/ethernet/stmicro/stmmac/norm_desc.c: In function ndesc_init_r=
x_desc:
> drivers/net/ethernet/stmicro/stmmac/norm_desc.c:138:6: warning: variable =
'bfsize1' set but not used [-Wunused-but-set-variable]
>
> Like enh_desc_init_rx_desc, we should use bfsize1
> in ndesc_init_rx_desc to calculate 'p->des1'
>
> Fixes: 583e63614149 ("net: stmmac: use correct DMA buffer size in the RX =
descriptor")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Aaro Koskinen <aaro.koskinen@nokia.com>

Thanks, looks like GCC 6.3.0 missed this.

A.
