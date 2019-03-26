Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62138C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2629220856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lERrNkze";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FMmbQRbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731769AbfCZORi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:17:38 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:39863 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfCZORi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553609858; x=1585145858;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=llfqNFDm1Va/eMrrdInPoLOlP2jotK5w3uCRX/CpB5M=;
  b=lERrNkzeFUACP0Abtj6v/a96cwhaJMxY23zUdBXfIUiJIyCvhVLYB9BU
   Rd4qnj5xwOMOkD/9g7vm/vYgP9aroBZJArOj58cLTGUqT3zJH4z9dWTlq
   BQvV4JrK9kkVWzyVxP6ipZotOgV1DrQzSxuyVzmNczmq7Epvp2f6AyOEu
   d/6nzrC7rSIdO1eTAxSEp0KZOtZsxQ0+wsPh3M4S92jGtV8HETu6hvGaV
   HPG1daMvrnO7loG6W/kL6lSkbXvF0HArBDzcTegqxaGJMtzs93VIbDiZP
   UPToVcSN5kU0rvHEXXapWDbGDjytpwgOW60ayYnNTjmvAkYK7jfCzo49B
   g==;
X-IronPort-AV: E=Sophos;i="5.60,271,1549900800"; 
   d="scan'208";a="109313500"
Received: from mail-by2nam05lp2054.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.54])
  by ob1.hgst.iphmx.com with ESMTP; 26 Mar 2019 22:17:37 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDheJdAUNcU7ftoP3bZ+sWk//lNTucLZHnURtnNAe7I=;
 b=FMmbQRbA2ayPIIjgYsEwVXizAXv5/F7W2MC5+LW8ruzF5zBkJvvSmovDlKaXpwoL0oVsqC89WmNR/9MHgQX7+TFav8248vohSooy8QzERB6EtGJ5EwxEA4bPi3IO0qeMms5BN3zF5NkKobExEQbB+FBrGGKV5e0VJ1JwdCzOEQY=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB3965.namprd04.prod.outlook.com (52.135.82.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Tue, 26 Mar 2019 14:17:35 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::f4d4:a300:2010:195a]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::f4d4:a300:2010:195a%3]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 14:17:35 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Aditya Pakki <pakki001@umn.edu>
CC:     "kjlu@umn.edu" <kjlu@umn.edu>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Sharabi <ohad.sharabi@wdc.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: ufs: Fix to check the return value of
 alloc_ordered_workqueue
Thread-Topic: [PATCH] scsi: ufs: Fix to check the return value of
 alloc_ordered_workqueue
Thread-Index: AQHU3nzQ+UYIiJzbI06NKF8wn+NU06Yd/yLw
Date:   Tue, 26 Mar 2019 14:17:35 +0000
Message-ID: <SN6PR04MB49251FBA9EFB10A277FD8C5EFC5F0@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <20190319175423.13724-1-pakki001@umn.edu>
In-Reply-To: <20190319175423.13724-1-pakki001@umn.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ffd0c69c-2a3c-4c06-f635-08d6b1f5cb44
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB3965;
x-ms-traffictypediagnostic: SN6PR04MB3965:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB3965249CA12EE566EA0485C8FC5F0@SN6PR04MB3965.namprd04.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(366004)(376002)(396003)(189003)(199004)(305945005)(2906002)(105586002)(7696005)(76176011)(71190400001)(4744005)(97736004)(5660300002)(256004)(86362001)(14454004)(71200400001)(99286004)(52536014)(106356001)(102836004)(476003)(53936002)(6916009)(81156014)(6116002)(446003)(72206003)(2171002)(8676002)(478600001)(6506007)(11346002)(8936002)(6246003)(81166006)(316002)(6436002)(54906003)(74316002)(55016002)(9686003)(4326008)(66066001)(486006)(7736002)(3846002)(186003)(229853002)(68736007)(7416002)(25786009)(33656002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB3965;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A/KbcCWoiCeQkemn3+2oH+ClgZ5TOWneQXhHO4o1zK+Vx/J+AuwKhqqFGz+Swkk4I+cW3FnwHK8t33xHfA+RRlpcR8q3d50NukQmm+RG2Cp13cqzetZ4RzIXIpWkUYUxvknDIuYr+PUYyYnoSizIgndx8zForGDuNaz1rvhrBZs9EIqTDVA6IfWIuzJLiN11e9he/q2XKTD5WM6neUJlbOf6uo+vL21KESGMaHsk3PJGwE0JTEXx2ShAZ13pHXt5hKzCfOZ7PjuCBJlfYy/wRReyotfnwuQRYhq3uFWZ28xt+/MOUsohRcEheyTRCpRyJKpQYA/3j0tlymq5XhErUwODRQhLGKKBN3BFzTsOsCcnksvUQrIHneA8mvLtjUE+8GTwcsiJylEAt2WHxkIuOVzCRE/rY4sap6t01UmUUVI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd0c69c-2a3c-4c06-f635-08d6b1f5cb44
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 14:17:35.3481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3965
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
>=20
> In ufshcd_init_clk_gating, alloc_ordered_workqueue may fail and return
> NULL. The patch handles error consistent with other invocations in this
> module.
Not sure that's good enough, as later on we will try to queue work to that =
workqueue.

Thanks,
Avri


>=20
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/scsi/ufs/ufshcd.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index e040f9dd9ff3..701b2da25f09 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -1791,6 +1791,8 @@ static void ufshcd_init_clk_gating(struct ufs_hba
> *hba)
>  		 hba->host->host_no);
>  	hba->clk_gating.clk_gating_workq =3D
> alloc_ordered_workqueue(wq_name,
>=20
> WQ_MEM_RECLAIM);
> +	if (!hba->clk_gating.clk_gating_workq)
> +		dev_err(hba->dev, "Failed to allocate work queue\n");
>=20
>  	hba->clk_gating.is_enabled =3D true;
>=20
> --
> 2.17.1

