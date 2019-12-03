Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F406C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1607E206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 10:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="uMQrEsn9";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="uMQrEsn9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfLCKAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 05:00:19 -0500
Received: from mail-eopbgr130048.outbound.protection.outlook.com ([40.107.13.48]:30030
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbfLCKAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 05:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiJyt8aCKTgavRWBmGI3w6BncY4jl9hnIRr6WijT/Bo=;
 b=uMQrEsn9tlIUnBx2hpdUQem7nLe09M3A+HCqvrJPbkdcNJ2OE8ByN0nY0vn8rx7XG0sccDH8VvODbnLAFCQW1Tu3A4euP8yGf3+tNSmrhi2sxXKCPQTh4FK9DpYcBQGVnPPYCZxEJf1P1phFuqc0CBVoKFHBMGik0Gn1wg3sulk=
Received: from VE1PR08CA0013.eurprd08.prod.outlook.com (2603:10a6:803:104::26)
 by DB8PR08MB4042.eurprd08.prod.outlook.com (2603:10a6:10:a4::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.19; Tue, 3 Dec
 2019 10:00:07 +0000
Received: from VE1EUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::200) by VE1PR08CA0013.outlook.office365.com
 (2603:10a6:803:104::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.20 via Frontend
 Transport; Tue, 3 Dec 2019 10:00:07 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT004.mail.protection.outlook.com (10.152.18.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18 via Frontend Transport; Tue, 3 Dec 2019 10:00:06 +0000
Received: ("Tessian outbound d825562be5de:v37"); Tue, 03 Dec 2019 10:00:05 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1467981df7640ece
X-CR-MTA-TID: 64aa7808
Received: from 115c1872aa5b.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0817D7B9-7EC6-4019-81C1-2A8305A83F76.1;
        Tue, 03 Dec 2019 09:59:59 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 115c1872aa5b.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 03 Dec 2019 09:59:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFqGR6wMsEnI066xRdHWxSRFWyDUuYrri2fQUlEvycvV7908BY3L0yRtwQDHWiQZu/2rH/IGWCxDZMDGrl2ThYdFMNhEwD8eTiW9DuRkmuqZLJPAcwB3fuRggCKSjLf6AgHzUwnZFz3hgpVWyCNSPKejMFfKPSqoyWPCSX425fa0PijgflnlAYmlo9QA9UukpfYcLuUpUPtjjYY17YYMf08X6Hf8n6Kl8X7KJtjQ/DN18FhRWIAZzijC6MdrsGe7uqYiM9zK5QfbHdZMn22wsIUxeDNUrATD5IPiTFWaiJwbtBsXSJ4amMOJwnYew4tcGj5KwLWK+ORw0GS3W3hl7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiJyt8aCKTgavRWBmGI3w6BncY4jl9hnIRr6WijT/Bo=;
 b=WqSUE70vjC6CEymbLxMGVm2ERwUDvbWxFsOTND9e+KoDPn7DiIx/CDAjlmyANn060ixTzSkG/DPaViFJ2RM2L9x+iQj5eOfYxY1+Cx8fiar8XEbiwEHElrJUhAlg9FLvr6wNkY4Wa+1TOkv9ZrVs9inlRl9SPNEYZhXi6SopFLOV4AlLeSUXFWorYGcUfGjM0kaK1td6Oa13QPssXFbYqoS2+M9OKMhlKt5N3APgaUJCQVSnjgKLfehSaAa2Iu0dBcHxx1HhdwssSd2+bhP7b1A/DyZMCMtRBuljYZ0aKryXvvzvs8UBVfMwz6K0a8Kg/jVEtW0gx9LAvqWOQhggiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiJyt8aCKTgavRWBmGI3w6BncY4jl9hnIRr6WijT/Bo=;
 b=uMQrEsn9tlIUnBx2hpdUQem7nLe09M3A+HCqvrJPbkdcNJ2OE8ByN0nY0vn8rx7XG0sccDH8VvODbnLAFCQW1Tu3A4euP8yGf3+tNSmrhi2sxXKCPQTh4FK9DpYcBQGVnPPYCZxEJf1P1phFuqc0CBVoKFHBMGik0Gn1wg3sulk=
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com (20.178.127.92) by
 VI1PR08MB3455.eurprd08.prod.outlook.com (20.177.59.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Tue, 3 Dec 2019 09:59:58 +0000
Received: from VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d]) by VI1PR08MB4078.eurprd08.prod.outlook.com
 ([fe80::8191:f0ac:574a:d24d%3]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 09:59:58 +0000
From:   Mihail Atanassov <Mihail.Atanassov@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>
CC:     nd <nd@arm.com>, "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ben Davis <Ben.Davis@arm.com>,
        "Oscar Zhang (Arm Technology China)" <Oscar.Zhang@arm.com>,
        "Channing Chen (Arm Technology China)" <Channing.Chen@arm.com>
Subject: Re: [PATCH v2 2/2] drm/komeda: Enable new product D32 support
Thread-Topic: [PATCH v2 2/2] drm/komeda: Enable new product D32 support
Thread-Index: AQHVoEQsEzx6hPV6tkqMxpVwDMM7k6emwEqAgAFJ2gCAADItgA==
Date:   Tue, 3 Dec 2019 09:59:57 +0000
Message-ID: <2125422.nYgIr5rE5T@e123338-lin>
References: <20191121081717.29518-1-james.qian.wang@arm.com>
 <15788924.1fOzIsmBsr@e123338-lin> <20191203064559.GA17018@jamwan02-TSP300>
In-Reply-To: <20191203064559.GA17018@jamwan02-TSP300>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.55]
x-clientproxiedby: LO2P265CA0121.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::13) To VI1PR08MB4078.eurprd08.prod.outlook.com
 (2603:10a6:803:e5::28)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 69a9f48e-a1b5-4771-1921-08d777d79357
X-MS-TrafficTypeDiagnostic: VI1PR08MB3455:|VI1PR08MB3455:|DB8PR08MB4042:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB40421F6FE02ACE7917B9E7D68F420@DB8PR08MB4042.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 02408926C4
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(199004)(189003)(6116002)(6636002)(81156014)(25786009)(3846002)(8936002)(110136005)(8676002)(2906002)(446003)(11346002)(14444005)(4326008)(6246003)(6436002)(316002)(229853002)(54906003)(71200400001)(71190400001)(81166006)(66556008)(66946007)(64756008)(66446008)(33716001)(66476007)(6486002)(86362001)(6512007)(9686003)(305945005)(5660300002)(7736002)(26005)(186003)(99286004)(76176011)(386003)(14454004)(102836004)(6506007)(478600001)(256004)(52116002)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3455;H:VI1PR08MB4078.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: M6va7nlN1wFPRw3K6mX6Uggvses1d5db9WvIM9DCzAnwvuTyicPUxilolzfiWFD0QrK0Lg/hDNDD5l0nQCFqC+P1wXNeHgTSqg9RGcnduwP8FaFqEmTtweKmUWl63BYtGo954ecCYjvZDmVr6aCBqLRk7m6/4oksNorBnLzk8gghZzIN9UpPeaDZg1wz4TByojD9DbIY8AXg6TX4ZHbxIEPZiTrHXN70QPuQR2phDETMuSQa9VC9lmSlLKnNxblvIK29R8TOD3hoWc37r4i6pVdkVtjkioR66wqECouw+ll0VRZ1pQ0zQG9K8G4emdpjlpD5rqFM1baas4ocg6eoV95cKJaVvfA/Q/G4O/Fgi7ITWL+t/hyhvmm5SEyo/4aEdimOJ4esIIdiWyPq5iJrDpV5GrafphyKye+8e4n87k8A4qQiFp9McnSPmqP/+7+V
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5D96D1DCD5A1DA4DBBDFE33B928A5BE8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3455
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mihail.Atanassov@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(7916004)(4636009)(39860400002)(396003)(346002)(376002)(136003)(189003)(199004)(305945005)(446003)(6116002)(3846002)(86362001)(478600001)(6506007)(76176011)(386003)(26826003)(186003)(106002)(8746002)(8936002)(46406003)(8676002)(97756001)(81166006)(81156014)(6636002)(70586007)(70206006)(356004)(25786009)(14454004)(7736002)(336012)(14444005)(102836004)(26005)(23726003)(11346002)(36906005)(316002)(4326008)(229853002)(9686003)(6512007)(6246003)(5660300002)(76130400001)(110136005)(54906003)(50466002)(99286004)(33716001)(6486002)(2906002)(22756006)(39026012);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR08MB4042;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e7209ab1-14e9-4218-1fb5-08d777d78db6
NoDisclaimer: True
X-Forefront-PRVS: 02408926C4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QVpuLttMDJaEnCW/jaR7IQjYghgjMa1DQRHZBexJdOIVKb3H7vRwUKQQErXNZK18VqDVcdP6lL5xKcSl8CiHX5lIpgMMruLly1E7apXc/3UETpqNlACD++0kfZ8CaL1Tn3d3g7qjXHNSS261ZE7pHhrh2MC7CXWmTML4J1vayQCdl0cft8/2F83EXhXqxaCPaJIAMEIEZFwDaeuerBTrmq80lzl0s6TJn3nuX9vAgcbWk8zMtglep1hQarHFLSSswnkoBL7yywBmeKDa3vRStCswRWFjc+oXP6uqCPuuPDx2tWD1DSiNdiWBlz3eGozF01eWL2wKTqq/KRvzW215L6OmWKIbVWYYnpAOQRX8o/dcLhlyatgcTrpPGS+uCKxU0o1BNT+wcUWqMWakfmLdqCvDp4r68fMkxmSAhpxXk7FglHeqvBvHvM5wdHqEqJwQmMVmvp53iBdA0Nprp7FrGmBo8XHqfHJb7mU433GBvKU30RazsJZh1nDWURmMcBpi
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2019 10:00:06.8205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a9f48e-a1b5-4771-1921-08d777d79357
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 3 December 2019 06:46:06 GMT james qian wang (Arm Technology Ch=
ina) wrote:
> On Mon, Dec 02, 2019 at 11:07:52AM +0000, Mihail Atanassov wrote:
> > On Thursday, 21 November 2019 08:17:45 GMT james qian wang (Arm Technol=
ogy China) wrote:
> > > D32 is simple version of D71, the difference is:
> > > - Only has one pipeline
> > > - Drop the periph block and merge it to GCU
> > >=20
> > > v2: Rebase.
> > >=20
> > > Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wan=
g@arm.com>
> > > ---
> > >  .../drm/arm/display/include/malidp_product.h  |  3 +-
> > >  .../arm/display/komeda/d71/d71_component.c    |  2 +-
> > >  .../gpu/drm/arm/display/komeda/d71/d71_dev.c  | 43 ++++++++++++-----=
--
> > >  .../gpu/drm/arm/display/komeda/d71/d71_regs.h | 13 ++++++
> > >  .../gpu/drm/arm/display/komeda/komeda_drv.c   |  1 +
> > >  5 files changed, 44 insertions(+), 18 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/arm/display/include/malidp_product.h b/d=
rivers/gpu/drm/arm/display/include/malidp_product.h
> > > index 96e2e4016250..dbd3d4765065 100644
> > > --- a/drivers/gpu/drm/arm/display/include/malidp_product.h
> > > +++ b/drivers/gpu/drm/arm/display/include/malidp_product.h
> > > @@ -18,7 +18,8 @@
> > >  #define MALIDP_CORE_ID_STATUS(__core_id)     (((__u32)(__core_id)) &=
 0xFF)
> > > =20
> > >  /* Mali-display product IDs */
> > > -#define MALIDP_D71_PRODUCT_ID   0x0071
> > > +#define MALIDP_D71_PRODUCT_ID	0x0071
> > > +#define MALIDP_D32_PRODUCT_ID	0x0032
> > > =20
> > >  union komeda_config_id {
> > >  	struct {
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b=
/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > index 6dadf4413ef3..c7f7e9c545c7 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> > > @@ -1274,7 +1274,7 @@ static int d71_timing_ctrlr_init(struct d71_dev=
 *d71,
> > > =20
> > >  	ctrlr =3D to_ctrlr(c);
> > > =20
> > > -	ctrlr->supports_dual_link =3D true;
> > > +	ctrlr->supports_dual_link =3D d71->supports_dual_link;
> > > =20
> > >  	return 0;
> > >  }
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drive=
rs/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > > index 9b3bf353b6cc..2d429e310e5b 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> > > @@ -371,23 +371,33 @@ static int d71_enum_resources(struct komeda_dev=
 *mdev)
> > >  		goto err_cleanup;
> > >  	}
> > > =20
> > > -	/* probe PERIPH */
> > > +	/* Only the legacy HW has the periph block, the newer merges the pe=
riph
> > > +	 * into GCU
> > > +	 */
> > >  	value =3D malidp_read32(d71->periph_addr, BLK_BLOCK_INFO);
> > > -	if (BLOCK_INFO_BLK_TYPE(value) !=3D D71_BLK_TYPE_PERIPH) {
> > > -		DRM_ERROR("access blk periph but got blk: %d.\n",
> > > -			  BLOCK_INFO_BLK_TYPE(value));
> > > -		err =3D -EINVAL;
> > > -		goto err_cleanup;
> > > +	if (BLOCK_INFO_BLK_TYPE(value) !=3D D71_BLK_TYPE_PERIPH)
> > > +		d71->periph_addr =3D NULL;
> > > +
> > > +	if (d71->periph_addr) {
> > > +		/* probe PERIPHERAL in legacy HW */
> > > +		value =3D malidp_read32(d71->periph_addr, PERIPH_CONFIGURATION_ID)=
;
> > > +
> > > +		d71->max_line_size	=3D value & PERIPH_MAX_LINE_SIZE ? 4096 : 2048;
> > > +		d71->max_vsize		=3D 4096;
> > > +		d71->num_rich_layers	=3D value & PERIPH_NUM_RICH_LAYERS ? 2 : 1;
> > > +		d71->supports_dual_link	=3D !!(value & PERIPH_SPLIT_EN);
> > > +		d71->integrates_tbu	=3D !!(value & PERIPH_TBU_EN);
> > > +	} else {
> > > +		value =3D malidp_read32(d71->gcu_addr, GCU_CONFIGURATION_ID0);
> > > +		d71->max_line_size	=3D GCU_MAX_LINE_SIZE(value);
> > > +		d71->max_vsize		=3D GCU_MAX_NUM_LINES(value);
> > > +
> > > +		value =3D malidp_read32(d71->gcu_addr, GCU_CONFIGURATION_ID1);
> > > +		d71->num_rich_layers	=3D GCU_NUM_RICH_LAYERS(value);
> > > +		d71->supports_dual_link	=3D GCU_DISPLAY_SPLIT_EN(value);
> > > +		d71->integrates_tbu	=3D GCU_DISPLAY_TBU_EN(value);
> > >  	}
> > > =20
> > > -	value =3D malidp_read32(d71->periph_addr, PERIPH_CONFIGURATION_ID);
> > > -
> > > -	d71->max_line_size	=3D value & PERIPH_MAX_LINE_SIZE ? 4096 : 2048;
> > > -	d71->max_vsize		=3D 4096;
> > > -	d71->num_rich_layers	=3D value & PERIPH_NUM_RICH_LAYERS ? 2 : 1;
> > > -	d71->supports_dual_link	=3D value & PERIPH_SPLIT_EN ? true : false;
> > > -	d71->integrates_tbu	=3D value & PERIPH_TBU_EN ? true : false;
> > > -
> > >  	for (i =3D 0; i < d71->num_pipelines; i++) {
> > >  		pipe =3D komeda_pipeline_add(mdev, sizeof(struct d71_pipeline),
> > >  					   &d71_pipeline_funcs);
> > > @@ -415,7 +425,7 @@ static int d71_enum_resources(struct komeda_dev *=
mdev)
> > >  	}
> > > =20
> > >  	/* loop the register blks and probe */
> > > -	i =3D 2; /* exclude GCU and PERIPH */
> > > +	i =3D 1; /* exclude GCU */
> > >  	offset =3D D71_BLOCK_SIZE; /* skip GCU */
> > >  	while (i < d71->num_blocks) {
> > >  		blk_base =3D mdev->reg_base + (offset >> 2);
> > > @@ -425,9 +435,9 @@ static int d71_enum_resources(struct komeda_dev *=
mdev)
> > >  			err =3D d71_probe_block(d71, &blk, blk_base);
> > >  			if (err)
> > >  				goto err_cleanup;
> > > -			i++;
> > >  		}
> > > =20
> > > +		i++;
> >=20
> > This change doesn't make much sense if you want to count how many
> > blocks are available, since you're now counting the reserved ones, too.
>=20
> That's because for D32 num_blocks includes the reserved blocks.
>=20
> > On the counting note, the prior code rides on the assumption the periph
> > block is last in the map, and I don't see how you still handle not
> > counting it in the D71 case.
>=20
> Since D71 has one reserved block, and now we count reserved block.
>=20
> So now no matter D32 or D71:
>   num_blocks =3D n_valid_block + n_reserved_block + GCU.

So at least we need that comment dropped in with the code. Future HW
might break your assumption here once more and it will then be useful
to know why this works for both products.

I'd personally abstract that a bit behind a small helper func and
handle different products separately. It's a bit of duplication but
much easier to comprehend. Saved cycles reading code =3D=3D Good Thing(tm).

>=20
> Thanks
> James
> >=20
> > >  		offset +=3D D71_BLOCK_SIZE;
> > >  	}
> > > =20
> > > @@ -603,6 +613,7 @@ d71_identify(u32 __iomem *reg_base, struct komeda=
_chip_info *chip)
> > > =20
> > >  	switch (product_id) {
> > >  	case MALIDP_D71_PRODUCT_ID:
> > > +	case MALIDP_D32_PRODUCT_ID:
> > >  		funcs =3D &d71_chip_funcs;
> > >  		break;
> > >  	default:
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h b/driv=
ers/gpu/drm/arm/display/komeda/d71/d71_regs.h
> > > index 1727dc993909..81de6a23e7f3 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h
> > > +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_regs.h
> > > @@ -72,6 +72,19 @@
> > >  #define GCU_CONTROL_MODE(x)	((x) & 0x7)
> > >  #define GCU_CONTROL_SRST	BIT(16)
> > > =20
> > > +/* GCU_CONFIGURATION registers */
> > > +#define GCU_CONFIGURATION_ID0	0x100
> > > +#define GCU_CONFIGURATION_ID1	0x104
> > > +
> > > +/* GCU configuration */
> > > +#define GCU_MAX_LINE_SIZE(x)	((x) & 0xFFFF)
> > > +#define GCU_MAX_NUM_LINES(x)	((x) >> 16)
> > > +#define GCU_NUM_RICH_LAYERS(x)	((x) & 0x7)
> > > +#define GCU_NUM_PIPELINES(x)	(((x) >> 3) & 0x7)
> > > +#define GCU_NUM_SCALERS(x)	(((x) >> 6) & 0x7)
> > > +#define GCU_DISPLAY_SPLIT_EN(x)	(((x) >> 16) & 0x1)
> > > +#define GCU_DISPLAY_TBU_EN(x)	(((x) >> 17) & 0x1)
> > > +
> > >  /* GCU opmode */
> > >  #define INACTIVE_MODE		0
> > >  #define TBU_CONNECT_MODE	1
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/driver=
s/gpu/drm/arm/display/komeda/komeda_drv.c
> > > index b7a1097c45c4..ad38bbc7431e 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> > > @@ -125,6 +125,7 @@ static int komeda_platform_remove(struct platform=
_device *pdev)
> > > =20
> > >  static const struct of_device_id komeda_of_match[] =3D {
> > >  	{ .compatible =3D "arm,mali-d71", .data =3D d71_identify, },
> > > +	{ .compatible =3D "arm,mali-d32", .data =3D d71_identify, },
> > >  	{},
> > >  };
> > > =20
> > >=20
> >=20
> >=20
>=20


--=20
Mihail



