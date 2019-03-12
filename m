Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BA0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECBD2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LqyTcA5G";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ee1G/XRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfCLOHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:07:06 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:3532 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbfCLOHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1552399637; x=1583935637;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b58DFWAOLPpT0e5MgJ3PF3Dc++JzJCKfBHdLecNHaNY=;
  b=LqyTcA5GZO+WpMIuSnqWLF+x0b8+SeuqAGgOayNr265SvdnXfX53b8an
   sb/mSOhIOJfxy17SQuSztXInDXOQbtYCl3I7Q8jmmEttX9yYpAu3r1SE7
   MDIpkkAdGrJZj8J3L24TSDs4UseduQSvWtgPQj9agOzofPxOWLND5CRbI
   c73KQ+RxnDdqpQ9a/wSqz78YMK+aWI9DLiqAh9sthB32x2Hfn89VgoR5X
   koTWznqBANgi7Nb9nMRSRw8pJs1BowpNWvTHIbYA7VcBVjADEWuRbvQ0H
   bEPOfRVpCqgXJ31jZam+L9DzzS05ennazdKEzkFuTMLsxffKY0hkktEiS
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,471,1544457600"; 
   d="scan'208";a="201821970"
Received: from mail-bl2nam02lp2053.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.53])
  by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2019 22:07:06 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dFYOQ1+eGBvfPjxvLcIiy2dKBRUWPCImiXyWcsUdvc=;
 b=Ee1G/XRDhFTUsk4QhT0DvbBbZabsRmWYYzsOpxzlThcfRz62+I5x5Hg5lSA3Lh781Cs2wnAwXB50CttSyeQOKhWKuHLwAVC5AGDL1t2tuyp7ESsxljYPttZDaH2Z3lie+riCQfaFrJehmHYa0YlBuYib90xMM1Ls6Cj2zw3LvO8=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4048.namprd04.prod.outlook.com (52.135.82.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 12 Mar 2019 14:06:56 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::f4d4:a300:2010:195a]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::f4d4:a300:2010:195a%3]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 14:06:56 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Rajendra Nayak <rnayak@codeaurora.org>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "pedrom.Sousa@synopsys.com" <pedrom.Sousa@synopsys.com>
CC:     "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] scsi: ufs: Add error checks for pm_runtime_get_sync()
Thread-Topic: [PATCH 2/3] scsi: ufs: Add error checks for
 pm_runtime_get_sync()
Thread-Index: AQHU1YlcVXMbJLB9xUOqEjKn0KHaPKYIDUYA
Date:   Tue, 12 Mar 2019 14:06:56 +0000
Message-ID: <SN6PR04MB49256D55A9EFCE6F0579BC3BFC490@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <20190308083053.30631-1-rnayak@codeaurora.org>
 <20190308083053.30631-3-rnayak@codeaurora.org>
In-Reply-To: <20190308083053.30631-3-rnayak@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d48b66bc-c0e4-4e96-62d3-08d6a6f3fca4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4048;
x-ms-traffictypediagnostic: SN6PR04MB4048:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4048A5335DF49ECA2B6B3204FC490@SN6PR04MB4048.namprd04.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39860400002)(136003)(396003)(189003)(199004)(81156014)(7736002)(76176011)(8676002)(54906003)(81166006)(305945005)(102836004)(110136005)(229853002)(25786009)(6506007)(97736004)(316002)(68736007)(72206003)(4326008)(99286004)(14454004)(8936002)(6436002)(74316002)(66066001)(7696005)(14444005)(5660300002)(71200400001)(71190400001)(53936002)(33656002)(52536013)(105586002)(106356001)(2501003)(256004)(2906002)(446003)(486006)(6246003)(11346002)(476003)(86362001)(55016002)(478600001)(2201001)(3846002)(6116002)(26005)(186003)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4048;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KuN4E+8XluBUXyypysiZNBHg5LEPhW1+LmPVz7NKdhkc3+Iq49PGYVmTOwGZ73r6C8nuJNRr/p2aZbHpp0EB4NuvkYA44+Uyrt81UDQqD9BGZsuZhK4f2Hdn1AFqTvexIWdETIq0gGsPqKa2u0pOnGyElAo8C923E71dmSZ9EX9iKKVaZ7A69KPX8t8WG64jubL7SnwtsFLAxx0PJNnEmh4bb3v2vHVUnLH0H6pu4Av8JgSUXUfHyhnRdiQlxo2vtuLKdK5XLtdPbXb9eRk5UuxfmjsxM/y2A3u//r9aPuDlM1i1q6oYrmZec+dUANBnhuBI9pGwzN8O2h2uMEbeXBBTW64My8VpiegngKNnsmMrXunR/kRTIteyfUhrgvzpjq3RppCecHzf2fYT8gtIlagdxVQ3IlrjBGtet3FXudU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d48b66bc-c0e4-4e96-62d3-08d6a6f3fca4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 14:06:56.4368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
>=20
> Add an error check for pm_runtime_get_sync(), ignoring this can
> hide issues with the runtime pm handling in the driver.
Can you elaborate on those issues?
I guess you've encountered some during your bring-up.

>=20
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
>  drivers/scsi/ufs/ufshcd.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 2ddf24466a62..060dc38cc582 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -8357,7 +8357,10 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem
> *mmio_base, unsigned int irq)
>  	}
>=20
>  	/* Hold auto suspend until async scan completes */
> -	pm_runtime_get_sync(dev);
> +	err =3D pm_runtime_get_sync(dev);
> +	if (err < 0)
> +		goto out_remove_scsi_host;
> +
>  	atomic_set(&hba->scsi_block_reqs_cnt, 0);
>  	/*
>  	 * We are assuming that device wasn't put in sleep/power-down
On your first patch you are incrementing the device's usage counter,
To avoid any suspend during probe, but this comment above state
 some assumption of this very same issue.
Is it still valid?

Thanks,
Avri
