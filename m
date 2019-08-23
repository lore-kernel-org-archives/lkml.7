Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B662EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEA222CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="bilh2T+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390769AbfHWIX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:23:58 -0400
Received: from mail-eopbgr750073.outbound.protection.outlook.com ([40.107.75.73]:21828
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730759AbfHWIX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:23:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/h8n3LsLIXkvKYXgI3+GRbb4p5SlKZgaA6ArI12uYhVTI4RNsVNvaIiUD3kReVyXYs/XjNLtrjmmhrp7dS1aytDWe4ydT1unqlzotW/9rlMJjRfEFdAmj0bJiLXevwrqMxcV+nOHiN7MKD2htnhQB3f/UHQ7cu4hqYjjQBTQENqawGqpJg1pfkOdAbt0OCfXcoONVcidGu57KPajj/8v0resr2A1pITxs+IosO9UJB2Fr67XVs64xtDQ7LtlUoH80k6yRQ8RtfIFQTAbYgOTG0KxcBsur5lfMecrUN951x3RTykcztThAyenl8bedNaIVdgXNHDN7LnPbTFQruuKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iy5QS3g0RzZQTaIaRlnQxBdsVWHbTBKAt+bk9KCI/HY=;
 b=QHvzM/ZYdLsUwyGD8Lgs/qNIz6KmUjwGIJv2mFSU/aZvWaUCq4kt6XyJkLn2EnI4H7DztW/kEYKsOUgbRvgEVw6p6eTMa2PWBxVplXFx0MjjcfKFSdkbxIpnxURNJTw2drPo3VeawxPzj7bv8Nlw4UPTdP5WmfaDxFPsMYNV3X77YNn5cB4BLnmqUnEslmW5ustO0gr7RBzFFAY7Xrf8iBIexIwvtFELA+DUjZ1nXvbIRoaUC6AgSAg8YukPrz0rlVTklWoDpvvW/Kf2vKPVk17OUK794xalD1q9FKqUkRCuSxygcn+9vyBdIH3Zxt7EC3ZoI4uvZzjA0KTCDLua5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iy5QS3g0RzZQTaIaRlnQxBdsVWHbTBKAt+bk9KCI/HY=;
 b=bilh2T+peQDMFrlbQTv5Jv/drVQTTiDV5G8tOmVlrPNMwfKqGMMwrflLGQa+j10nXcjKJoKfBJWJhD6Mak/OSne6MsLvVBrT92gFkrhWJPXD2XJ6w0WYXVXDDYcH+dmfWBtNwSof65vpdJD+2BD9MQURBjST5adm+Wsh/4qmv3M=
Received: from CH2PR02MB6359.namprd02.prod.outlook.com (52.132.231.93) by
 CH2PR02MB6840.namprd02.prod.outlook.com (20.180.5.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 23 Aug 2019 08:23:55 +0000
Received: from CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::5c58:16c0:d226:4c96]) by CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::5c58:16c0:d226:4c96%2]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 08:23:54 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Derek Kiernan <dkiernan@xilinx.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH 3/4] misc: xilinx_sdfec: Prevent a divide by zero in
 xsdfec_reg0_write()
Thread-Topic: [PATCH 3/4] misc: xilinx_sdfec: Prevent a divide by zero in
 xsdfec_reg0_write()
Thread-Index: AQHVV+98zNjK4dF6zEutfzCzk1SLDacIZ9kA
Date:   Fri, 23 Aug 2019 08:23:54 +0000
Message-ID: <CH2PR02MB6359602748E6F8BB56E586B9CBA40@CH2PR02MB6359.namprd02.prod.outlook.com>
References: <20190821070606.GA26957@mwanda> <20190821070953.GC26957@mwanda>
In-Reply-To: <20190821070953.GC26957@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32f8f6db-ef76-4703-7b5a-08d727a33cd2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CH2PR02MB6840;
x-ms-traffictypediagnostic: CH2PR02MB6840:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR02MB68402EA5515C6F90CDA747CBCBA40@CH2PR02MB6840.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(366004)(396003)(136003)(199004)(13464003)(189003)(66476007)(66556008)(64756008)(66446008)(66946007)(76176011)(305945005)(66066001)(86362001)(52536014)(476003)(11346002)(7736002)(446003)(33656002)(3846002)(6116002)(6506007)(14444005)(14454004)(74316002)(7696005)(53546011)(256004)(316002)(2906002)(6436002)(5660300002)(6246003)(25786009)(71190400001)(99286004)(8676002)(110136005)(81156014)(81166006)(54906003)(71200400001)(9686003)(8936002)(76116006)(186003)(53936002)(102836004)(6636002)(478600001)(486006)(4326008)(229853002)(55016002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6840;H:CH2PR02MB6359.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oaDclW6SmLyqiAsVKLHN5vJbdtqcLM+1/OV2zl9/jDomZmvPIx/8bfl8D5s7rG553lgRGPi4pwfAB/1APdnnXQGH+Yle9Xd0QAUbP/tdbvM3izuHa+tHmlqLY7ARQKwQ2hsnqERcNk2V5SQ5/Wd8V/Gnqi50z45kFr+fQBqYKXGx98Kh7apqdsBUmRXKgAUmzY9a0muBjSxhqdwWo+xd8ViwdTSaF/Hjl02KrsyQ87g0W5P1KNlP8Qw6WUEa8e03YX0+C2Knw/id7SK1jY7H/rUe2CuLoZE6dPduOofob+siVTY+rd1218lmPyuMT3M4Vs/yxKrzyz1VTuFiULmgu+qPsf8rIWk3lWkoo8X7q5KkQf2+j5el3dqF+LGiNNDn96t2+JG8M1uCs2EkROfwTZKi0goyPQm2GdqG9LCSmMI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f8f6db-ef76-4703-7b5a-08d727a33cd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 08:23:54.8764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +PsNjo+rYeYQIMUs9dzPHkZXqZworoGpLoDay4le+SpNrjeZkc1gvHlSKITdVwVKbTHFivNx+rkU7eExTh+ilg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6840
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Wednesday 21 August 2019 08:10
> To: Derek Kiernan <dkiernan@xilinx.com>; Dragan Cvetic <draganc@xilinx.co=
m>
> Cc: Arnd Bergmann <arnd@arndb.de>; Greg Kroah-Hartman <gregkh@linuxfounda=
tion.org>; Michal Simek <michals@xilinx.com>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; kerne=
l-janitors@vger.kernel.org
> Subject: [PATCH 3/4] misc: xilinx_sdfec: Prevent a divide by zero in xsdf=
ec_reg0_write()
>=20
> The "psize" value comes from the user so we need to verify that it's
> non-zero before we check if "n % psize" or it will crash.
>=20
> Fixes: 20ec628e8007 ("misc: xilinx_sdfec: Add ability to configure LDPC")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> The parentheses in this condition are a no-op.  They're just confusing.
> Perhaps something else was intended?
>=20
>  drivers/misc/xilinx_sdfec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
> index 813b82c59360..3fc53d20abf3 100644
> --- a/drivers/misc/xilinx_sdfec.c
> +++ b/drivers/misc/xilinx_sdfec.c
> @@ -460,7 +460,7 @@ static int xsdfec_reg0_write(struct xsdfec_dev *xsdfe=
c, u32 n, u32 k, u32 psize,
>  {
>  	u32 wdata;
>=20
> -	if (n < XSDFEC_REG0_N_MIN || n > XSDFEC_REG0_N_MAX ||
> +	if (n < XSDFEC_REG0_N_MIN || n > XSDFEC_REG0_N_MAX || psize =3D=3D 0 ||
>  	    (n > XSDFEC_REG0_N_MUL_P * psize) || n <=3D k || ((n % psize) !=3D =
0)) {
>  		dev_dbg(xsdfec->dev, "N value is not in range");
>  		return -EINVAL;
> --
> 2.20.1

Reviewed-by: Dragan Cvetic <dragan.cvetic@xilinx.com>

Thanks,
Dragan
