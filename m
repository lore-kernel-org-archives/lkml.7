Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3924C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9617C2064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GGTZ9J6n";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jISiTHek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfCFLn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:43:28 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:62853 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbfCFLn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:43:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1551872608; x=1583408608;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GqFO2buDULIB14ykuC/cofV7rLLWdMCWq3FeCtzv3aQ=;
  b=GGTZ9J6nKlU6F3jUHO9cINZ7IixPKwLmqmWbmOkDUp7SSxS5/2BzpbjK
   C+fz+sRSgQ3Oj1XlrPQ7zCuIdqWso+xBEa1vGLqocyLCYVM/NS79ghlNK
   nemTmTMyVKGW+GLpq7r1aDLai0cz8FQU6PTt6+ecyV2SSO5E5Fb61W+qa
   nIgVqm3F9NzonPvj4ShYzpeTGfGwIQJeVY4A/mTlrHzbTSy1w812B8rmF
   p/G/WFGvFdvB/hfwd8afk3H7nxkBBr4Dg2ANhBXUEw+6fOzZdeAHrNagG
   sbmVXUU0yRyz9NmMxkR3KcCnKe2Feek+/lW+RdyYbCoBri8JQtB9OuHgW
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,447,1544457600"; 
   d="scan'208";a="107862558"
Received: from mail-by2nam01lp2054.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.54])
  by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2019 19:43:26 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqFO2buDULIB14ykuC/cofV7rLLWdMCWq3FeCtzv3aQ=;
 b=jISiTHek3p+vdSVOxop3VOBE5UhODmbRL0s8ra1zjn5XzZ7NmxI8xJjUh7++ZDibQ6XpVAMBddJmP0W5kHdm6GSkyMYEC11WYuCFYfo4TexCsXBRvm7nyUujcWd8cr8J2O+aawaNmyXlpELxPM/2UT2YzzTJsK+aT3b1mGVwZfw=
Received: from DM6PR04MB4923.namprd04.prod.outlook.com (20.176.109.84) by
 DM6PR04MB5370.namprd04.prod.outlook.com (20.178.26.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Wed, 6 Mar 2019 11:43:24 +0000
Received: from DM6PR04MB4923.namprd04.prod.outlook.com
 ([fe80::5136:dcf0:34ac:239e]) by DM6PR04MB4923.namprd04.prod.outlook.com
 ([fe80::5136:dcf0:34ac:239e%3]) with mapi id 15.20.1665.019; Wed, 6 Mar 2019
 11:43:24 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Alim Akhtar <alim.akhtar@samsung.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Wei Li <liwei213@huawei.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/4] scsi: ufs: hisi: fix ufs_hba_variant_ops passing
Thread-Topic: [PATCH 4/4] scsi: ufs: hisi: fix ufs_hba_variant_ops passing
Thread-Index: AQHU0sI7OhZ3PoLFUEy3aM48UV2gWaX+fYiA
Date:   Wed, 6 Mar 2019 11:43:24 +0000
Message-ID: <DM6PR04MB49231ACAA50E4D8FF5BCE469FC730@DM6PR04MB4923.namprd04.prod.outlook.com>
References: <20190304193917.702601-1-arnd@arndb.de>
 <20190304193917.702601-4-arnd@arndb.de>
In-Reply-To: <20190304193917.702601-4-arnd@arndb.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f132bff-a56c-4b63-498e-08d6a228f0ff
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM6PR04MB5370;
x-ms-traffictypediagnostic: DM6PR04MB5370:
wdcipoutbound: EOP-TRUE
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DM6PR04MB5370;23:uqenWGzy2et49AE9aHE5qC8kxc/zTaJ7jzxWGj00t?=
 =?us-ascii?Q?PWivGiWNf2oI2dXFW4vSdVh9u2OAU3BRxO8u9GJ6WZLAk2XtwCbM26fvrrIM?=
 =?us-ascii?Q?pAPWCeXgJZw/EJmSrThXSp1NYz0xAvUr5/b5V2L4wCwXkbN1ZolePgIrRuvT?=
 =?us-ascii?Q?39s05wDd+LljfzkHiDluGe5dSPy7Cu+Qgh+CQM8wdQ5ZXfdR8H/MMD4UiesT?=
 =?us-ascii?Q?06BHTjzjr9F12x+UscuJ1UNZjffLqR5nzE4s9IJrRMUqm2ZRbXxtdfNq17ca?=
 =?us-ascii?Q?nvtv5P+wqxjnf4QuWj8HJF16GebjQgWyH5T0NlURHlnTs5Y1Z4TLQP+It3/t?=
 =?us-ascii?Q?QOyJrOqAxeJUKup3JgDG2nDvlnUoi82hdk4Zj1J+ZfwgBaBB8V6v/LuBEFD1?=
 =?us-ascii?Q?BqEDffJwSmiLs2/G93z/1ilW7bObW8g+3/fUvWex0ICApDCaF1wpK/Ah06ut?=
 =?us-ascii?Q?bWab6GmnKoZdeTq+Uk6ZrRpjBH0OxKi28fNcAmRy5g07uOG38pcWlswdJboB?=
 =?us-ascii?Q?+0aU7Ztk45kcn1R1/C2gZx9mJi5fNnALISldTczmxycxpe10j8q79sy9N0Eb?=
 =?us-ascii?Q?BkdWDtxNYLTbO9lfeElFbdHSyMIs8v5kqLlY5OMmofDk6+kTtM9jznWzhQ8b?=
 =?us-ascii?Q?usp0iMA4QrpPSPYZNreaRdHSwX4QnwvJ/N63hDUq0hVWr0y8c3+3m8FJDvEe?=
 =?us-ascii?Q?zrunHcdz3TgKE+FrKODyh3Y7cRklIC0cD1rJzOO/PlDMce1sdPTCaHSQfzqz?=
 =?us-ascii?Q?6SH90XAfBfgxxDV5FoYOdRWJMI6OGJav3Ey8UM90w8G2cboa+PQWq4OI+nhR?=
 =?us-ascii?Q?/8uGozxoijPRQEV06lb8R+JBVKf+jqvPVdW2bDG/hDXGHZgGwOunW8OwZhRU?=
 =?us-ascii?Q?KhOooRst+a/7ELSLH7V4nUL1RAPxzwY2/VQRsCzR2hIrUEMBZVAAQyAPfe+z?=
 =?us-ascii?Q?MIrH9jZpZWTHbfBM4esBejrlLB7PooIQIOnxAJGf7OHpRq+IHrKpomClBH8n?=
 =?us-ascii?Q?VGRB4gAzS4fwGtBa0MEnFDIJF5Tlv0ghAl54xCyW7ybOjPpmYrlgbfxD6KYk?=
 =?us-ascii?Q?/Wb3BSZVc8JUHxenzEoQVlG9HJw2B+N0W9ZIb/JM5k1D8WlHuuZKitb9UHno?=
 =?us-ascii?Q?LhEBmvJ9pYHYYuk0Aw3kB79t2MBDSYloD/KOf1Tk4Ba7qAwiLqx/EV2YU8QU?=
 =?us-ascii?Q?wIVqEuC2mrjrEEolR7WLuDB/lnx5uqk4isnaEOlhNTHv6P1laPFEyuLzriop?=
 =?us-ascii?Q?WNFS9ApFscy+45dJPE=3D?=
x-microsoft-antispam-prvs: <DM6PR04MB53709725987B6E933B88C912FC730@DM6PR04MB5370.namprd04.prod.outlook.com>
x-forefront-prvs: 0968D37274
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(136003)(346002)(366004)(189003)(199004)(7736002)(186003)(26005)(55016002)(54906003)(110136005)(305945005)(66066001)(33656002)(6436002)(71190400001)(9686003)(2906002)(102836004)(74316002)(6246003)(478600001)(97736004)(52536013)(316002)(6506007)(71200400001)(14454004)(5660300002)(3846002)(229853002)(8676002)(256004)(68736007)(99286004)(446003)(8936002)(72206003)(76176011)(486006)(11346002)(6116002)(81166006)(81156014)(106356001)(53936002)(476003)(4744005)(86362001)(25786009)(4326008)(105586002)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR04MB5370;H:DM6PR04MB4923.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kW6QUDK1oTtWLrEoUZ0DTz6rpVzWfJpiERCJ5k+vFnrneZ6GQZ3PKC9fK0RT5l2sPaqo77cxcIeofYEiPOdPbI0H3faZysMbFiW0OQGbX6OaaZQQtl9VdvtKrXsPvOidnx2V26d7pG54IzA/Z0hRtUmm43jUVWJoKvvaMLCYcIXKgyJTxTgwa3LEP9RSKK7StCVMrSg64ruQJ543qNXqMU48CEvcaATj+HNLr8bnEeUMMrUatwLMjiUyR8djwSZZiry09ookVK39aM3Cda40xrN6la3gTrLB3Q/YgsjHNJbpDZr3oLCLDEYWu1vtypXsz00mU0Oc3Iw1tNsa9H2xDMJfbGtfkQVgHO63p13F68Wy58wtCDBECW5ian44mnFWwb2SPzJzWirz5R91r6VsM/RzVZ00VXgMqxL8bE/r9uU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f132bff-a56c-4b63-498e-08d6a228f0ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2019 11:43:24.3076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5370
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Without CONFIG_OF, the of_match_node() helper does not evaluate
> its argument, and the compiler warns about the unused variable:
>=20
> drivers/scsi/ufs/ufs-hisi.c: In function 'ufs_hisi_probe':
> drivers/scsi/ufs/ufs-hisi.c:673:17: error: unused variable 'dev' [-
> Werror=3Dunused-variable]
>=20
> Rework this code to pass the data directly, and while we're
> at it, correctly handle the const pointers.
>=20
> Fixes: 653fcb07d95e ("scsi: ufs: Add HI3670 SoC UFS driver support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

Arnd, Thank you for your comments.
Regards,
Avri
