Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URG_BIZ autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1203C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 18:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757AE21934
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 18:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="uAhk56qf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKRSG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 13:06:29 -0500
Received: from mga06.intel.com ([134.134.136.31]:52345 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbfKRSG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 13:06:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 10:06:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,321,1569308400"; 
   d="scan'208";a="407475149"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga006.fm.intel.com with ESMTP; 18 Nov 2019 10:06:27 -0800
Received: from FMSMSX109.amr.corp.intel.com (10.18.116.9) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 18 Nov 2019 10:06:27 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx109.amr.corp.intel.com (10.18.116.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 18 Nov 2019 10:06:26 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.55) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 18 Nov 2019 10:06:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpQYlghIhqSJ1n4Hcf5rZwYrUz38mqs33COu8Bo/0Dg7hBVjaCbN1jWwCRVbXxnr6yMIu/Z3RDk2Z+V03U7tSRNehxwu3VgsSwIgf0WGTcbQS8Yn5soNhYMtFfRGD9tLx+YlLB5zwV1XlmDNk3vPTLSSIZivB8GfwZo5d8I0lHc1chX0RuhWPOBYYB1p3h8gQc77Q8m/O8gsUVkoMYvKw9IwvyLoeJDdWWsKKSLSVkp1viOPoYFsEE7oxyxADNGsGhfx867fnT+eB4FLgzputQPityfrXurWdPNkuu3wHs3IYOAYAUwVKurT5vQZsDY95U82F1NsGGMasrbW3WGyyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwBdlNor/nPW2l/1Q/ce7wo0H83yO4qzz+F6N+jsUF8=;
 b=Vsk3z2l8jrmBn0BeHzQ0oqhlu/YZWRYbRdRyEU+FcLtbz8cB0mQgSUTWqxXAvXZFPdsm2RO/Dofab5oebV6RL72z6K0TOJINw7Wf15C70DasFPCT2rJJufPnMx31ViOfl8mBP1n/wg+LUDC0bTRFnTUUQWJKD+0OZQjWeJeBWqZ7OsfgnUKuxcQGoD89RoQjv1PNoEiD4gr8aoe7SpxMuhsM1VRHe0KBetR6acy0k7tOfU8W7H+alSefuJiLzMgMo74HrPQhncl0kVGQNX8DeJjq39Y/vc/l9eGyDszPAX/sYqITLSWRHTnb1w+Zpa88cVyKj36hjbmu4FKN05KKUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwBdlNor/nPW2l/1Q/ce7wo0H83yO4qzz+F6N+jsUF8=;
 b=uAhk56qfLjd/SAS1v+/+L9OPtCVcRXT0kotitD2WEblkx2qhHdq/D2IulCO9EyT0Q8fhli9KObg+qKmVY8npcIVKWZjY/6Mfoky5Iwiym/gpfDc/7/xqXLRzR76jmAiHr5swuprnn9+PBv4crmClkTFy27/y9mBbPiywxwfPNvQ=
Received: from MN2PR11MB3711.namprd11.prod.outlook.com (20.178.254.154) by
 MN2PR11MB4478.namprd11.prod.outlook.com (52.135.36.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Mon, 18 Nov 2019 18:06:24 +0000
Received: from MN2PR11MB3711.namprd11.prod.outlook.com
 ([fe80::e8c0:cc46:c44f:4718]) by MN2PR11MB3711.namprd11.prod.outlook.com
 ([fe80::e8c0:cc46:c44f:4718%7]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 18:06:24 +0000
From:   "Kammela, Gayatri" <gayatri.kammela@intel.com>
To:     "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
CC:     "Somayaji, Vishwanath" <vishwanath.somayaji@intel.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Prestopine, Charles D" <charles.d.prestopine@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Liang, Kan" <kan.liang@intel.com>,
        "Box, David E" <david.e.box@intel.com>,
        "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [PATCH v3 7/7] platform/x86: Add Comet Lake (CML) platform
 support to intel_pmc_core driver
Thread-Topic: [PATCH v3 7/7] platform/x86: Add Comet Lake (CML) platform
 support to intel_pmc_core driver
Thread-Index: AQHVmw1Kujxp330EEUmsFYkvvxYyW6eLAp8AgAY6fHA=
Date:   Mon, 18 Nov 2019 18:06:24 +0000
Message-ID: <MN2PR11MB37116883BFC29257FD6E9647F24D0@MN2PR11MB3711.namprd11.prod.outlook.com>
References: <cover.1573750525.git.gayatri.kammela@intel.com>
 <d43af9c7b3c536c489cdb925adb2204256099952.1573750525.git.gayatri.kammela@intel.com>
 <3acd91d2694c456da2af7256ed1dcf9c@AUSX13MPC105.AMER.DELL.COM>
In-Reply-To: <3acd91d2694c456da2af7256ed1dcf9c@AUSX13MPC105.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-11-14T18:50:18.5668120Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmU2M2M1MWUtZTI5ZC00N2YwLWE0MWQtNDkzYmI5YjJhODY4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZnZvdUVZb3d5TEV1bXFuaHh4cW5SVHlxSTBCZUVlTngwbmxnZUptZTNXNFBOdXlOVVhYUjJzTUNyS3dadFVJVSJ9
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
x-ctpclassification: CTP_NT
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gayatri.kammela@intel.com; 
x-originating-ip: [192.55.52.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a6cd924-2814-40af-a3c2-08d76c52066c
x-ms-traffictypediagnostic: MN2PR11MB4478:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB447892B21F107F4BB8C996E6F24D0@MN2PR11MB4478.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(376002)(39860400002)(396003)(199004)(189003)(102836004)(66066001)(5660300002)(76176011)(55016002)(9686003)(7696005)(256004)(76116006)(74316002)(229853002)(86362001)(3846002)(81166006)(8936002)(478600001)(14454004)(2906002)(6436002)(8676002)(6116002)(25786009)(81156014)(26005)(4326008)(52536014)(33656002)(11346002)(446003)(2501003)(305945005)(7736002)(6246003)(316002)(186003)(6506007)(54906003)(14444005)(66556008)(71200400001)(71190400001)(64756008)(66446008)(476003)(486006)(99286004)(66946007)(66476007)(110136005)(4744005);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR11MB4478;H:MN2PR11MB3711.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tixL7u4UjZgcszkN71zMzmkqdyB7L5m0Njv2bWpwzqMZQWLlPZAWImzo2/Onh7AlpuYZhpe5JeGraOolZ78vJpTb/aEkNrbO+SODkl03tepF3INNs5/kuFngJM4Rze5Z86eyfFf59KgTDOuj+lRMij5q8U2EzeeMziX+f7/r/puM+niRx4dC/jJLLp4HQflB6N1aGMcr9DbYRC0h5UlWLzDebtqWLRJf2gYm6JoecKTFzk34TKuNK3NApCsn6VU5TE/ayLnCsp8kqHZVUw6ycbZwUxaFuky5Ql8FSktv4w0DMeRNYl4Di3uPDmfPDdNE524hitT1atQqMiIoCnaghh+ecfbVqv9UYep1WCs2u1OTmrakyiStxF8zspCVKFnKIAfilEL9j/mAIoUyCgB4qT8o/6WMQw1Uu/KrbtyhWy96NrlTWZFHB1FZHlHvxrTj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6cd924-2814-40af-a3c2-08d76c52066c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 18:06:24.5696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QyRyjBP3kSH0oXdNMfLdpMpTF1LYXM5j0iqlFtODOWfrIW48KrRUdYKZxQbxQJXqwcoLDVCZ6fKOykhR424pVV5xrt15uKDwFGKuw+QONI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4478
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >  /* Cannon Lake: PGD PFET Enable Ack Status Register(s) bitmap */
> > static const struct pmc_bit_map cnp_pfear_map[] =3D {
> > +	/* Reserved for Cannon Lake but valid for Comet Lake */
> >  	{"PMC",                 BIT(0)},
> >  	{"OPI-DMI",             BIT(1)},
> >  	{"SPI/eSPI",            BIT(2)},
> > @@ -879,6 +880,8 @@ static const struct x86_cpu_id intel_pmc_core_ids[]
> =3D {
> >  	INTEL_CPU_FAM6(TIGERLAKE_L, tgl_reg_map),
> >  	INTEL_CPU_FAM6(TIGERLAKE, tgl_reg_map),
> >  	INTEL_CPU_FAM6(ATOM_TREMONT, tgl_reg_map),
> > +	INTEL_CPU_FAM6(COMETLAKE, cnp_reg_map),
> > +	INTEL_CPU_FAM6(COMETLAKE_L, cnp_reg_map),
> >  	{}
> >  };
> >
>=20
> Just a nit, that I'm not sure if there is a policy around.
> Shouldn't the order of these reflect the actual order they're available t=
o the
> marketplace?  So CML may want to come earlier in the patch series to refl=
ect
> that aspect.
 Hi Mario,  agreed! I will send this patch separately from the series as th=
is is an urgent request from Dell.
