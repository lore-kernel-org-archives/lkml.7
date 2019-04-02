Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980F0C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C142075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kIzqujUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbfDBQl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:41:28 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:16436 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbfDBQl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:41:28 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca390b30000>; Wed, 03 Apr 2019 00:41:24 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Tue, 02 Apr 2019 09:41:23 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Tue, 02 Apr 2019 09:41:23 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Apr
 2019 16:41:21 +0000
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.50) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 2 Apr 2019 16:41:21 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3317.namprd12.prod.outlook.com (20.178.55.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Tue, 2 Apr 2019 16:41:19 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::80de:b71d:ffd0:3d26]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::80de:b71d:ffd0:3d26%6]) with mapi id 15.20.1750.017; Tue, 2 Apr 2019
 16:41:18 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        Bitan Biswas <bbiswas@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH V1] mmc: tegra: add sdhci tegra suspend and resume
Thread-Topic: [PATCH V1] mmc: tegra: add sdhci tegra suspend and resume
Thread-Index: AQHU6RTP4jxGWf7A00qbVfjfNqhxuKYo9wyAgAAZuuA=
Date:   Tue, 2 Apr 2019 16:41:18 +0000
Message-ID: <BYAPR12MB3398861980C3F967CD209393C2560@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1554182853-31612-1-git-send-email-skomatineni@nvidia.com>
 <20190402145901.GF8017@ulmo>
In-Reply-To: <20190402145901.GF8017@ulmo>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af2a150e-a1c1-4731-da69-08d6b78a0828
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR12MB3317;
x-ms-traffictypediagnostic: BYAPR12MB3317:
x-microsoft-antispam-prvs: <BYAPR12MB3317CC5DEAB3FED54E396363C2560@BYAPR12MB3317.namprd12.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(366004)(396003)(346002)(199004)(189003)(99286004)(6916009)(256004)(8936002)(54906003)(53936002)(25786009)(33656002)(15650500001)(4326008)(478600001)(68736007)(14454004)(6436002)(11346002)(2906002)(229853002)(106356001)(7736002)(446003)(316002)(186003)(3846002)(6506007)(66066001)(105586002)(71190400001)(86362001)(81156014)(7696005)(8676002)(6246003)(76176011)(102836004)(14444005)(26005)(476003)(52536014)(81166006)(9686003)(97736004)(5660300002)(486006)(305945005)(55016002)(6116002)(71200400001)(74316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3317;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uJo2xa1QR4/Crbc423fs6GP9Bol0y+Gx5Quf9CngeY1T5s6mPK4+hPNIMQXFvLYowEpJGfBkgWwer9FwUFj+CIWr76DB24GBP1d+YAg+4Uayi/Sm2OQNW1B0pQhUVekLzFEsC+8frgfgsSneL2JNlJw6+R0AkrrOT4/p4g9teGnxA5HZerMOSSFlJ7J7LVtEFlpvfaVmxzEOrtuTbT67XD6NPK0MeEfirF0aCV2TP9IjlMmYzRZd811IHaUBYp+bGNNKti0zHmncSiAuMd9+DVkXkrA21cZIGbSrHX3EqYeDjqHNpqqQlUeAQwbmmdW+1TMumWDsUgpl1hrKGS/mVsBCeFYrgo55gkrVr5ZMpAQX7UDjZPqHxwaW4uLH+j5EjqNh63ssvYy8G1/JFE/gvNGAUEbNlb2CjBpEMc2bdm8=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: af2a150e-a1c1-4731-da69-08d6b78a0828
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 16:41:18.7777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3317
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554223284; bh=8snkT47SGM/u5bwy65Bb+jvmuH0syQjXnb7FZe35Lew=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-microsoft-antispam:x-ms-traffictypediagnostic:
         x-microsoft-antispam-prvs:x-forefront-prvs:
         x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=kIzqujUXjxxLTIu9ITkkGXbflvS+bvCnGB66i8xWIKY+hCIGPF5Obu6UIKdftOtne
         MRPDScALeH8KHhp1rai95ZwCkKaoF1wKK1QbZTFhQC4S/xrzodsRpPl4wCPkVig+bD
         UnvnDfYPT8bq2XcSiLZknAlWfESohvUaWRHChcGQwpfaRR5cyz7Zj2/l8REgLrMkJw
         vtprYthlCRcUvyJdeeTGyQJ6XaAes4SCwJb9IluOQwjsBrnvjZSN3vx6BcJdd86OnQ
         IKnDrOG/Qu87Wnco4DwB18m0Z5I0R0Fs52CNHlxw82tvT9sjDV6DK8m0Sq7LWFdMVT
         GqWp0zMpvKdXA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Apr 01, 2019 at 10:27:33PM -0700, Sowjanya Komatineni wrote:
> > This patch adds suspend and resume PM ops for tegra SDHCI.
> >=20
> > Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> > ---
> >  drivers/mmc/host/sdhci-tegra.c | 45=20
> > +++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 44 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/mmc/host/sdhci-tegra.c=20
> > b/drivers/mmc/host/sdhci-tegra.c index eafaaefab4a6..68263ea4a93e=20
> > 100644
> > --- a/drivers/mmc/host/sdhci-tegra.c
> > +++ b/drivers/mmc/host/sdhci-tegra.c
> > @@ -1611,11 +1611,54 @@ static int sdhci_tegra_remove(struct platform_d=
evice *pdev)
> >  	return 0;
> >  }
> > =20
> > +#ifdef CONFIG_PM_SLEEP
> > +static int sdhci_tegra_suspend(struct device *dev) {
> > +	struct sdhci_host *host =3D dev_get_drvdata(dev);
> > +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > +	int ret;
> > +
> > +	if (host->mmc->caps2 & MMC_CAP2_CQE) {
> > +		ret =3D cqhci_suspend(host->mmc);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	ret =3D sdhci_suspend_host(host);
> > +	if (ret)
> > +		return ret;
> > +
> > +	clk_disable_unprepare(pltfm_host->clk);
> > +	return 0;
> > +}
> > +
> > +static int sdhci_tegra_resume(struct device *dev) {
> > +	struct sdhci_host *host =3D dev_get_drvdata(dev);
> > +	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > +	int ret;
> > +
> > +	clk_prepare_enable(pltfm_host->clk);
>
> You need to check this for errors here.
>
> > +
> > +	ret =3D sdhci_resume_host(host);
> > +	if (ret)
> > +		return ret;
>
> And clk_disable_unprepare() in case of failure.
>
> > +
> > +	if (host->mmc->caps2 & MMC_CAP2_CQE)
> > +		return cqhci_resume(host->mmc);
>
> Same here. Also make sure to sdhci_suspend_host() if cqhci_resume() fails=
. It's probably best to have a standard error cleanup path for this.
>
> Thierry

Thanks Thierry. Will add error check and cleanup for clock and sdhci_resume=
_host.
Regarding, cqhci_resume always returns 0. Infact, it does nothing as resume=
 happens on first cqhci_request.
Since helper functions exists in cqhci driver, was using it for explicit re=
sume call.
