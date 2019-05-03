Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE99C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1172075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="spbiCAnF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfECQtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 12:49:23 -0400
Received: from mail-eopbgr710057.outbound.protection.outlook.com ([40.107.71.57]:34919
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbfECQtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 12:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwWAfMhRk3TfVww9pLUC/U7seE6HUj8w8mFr2/Aswag=;
 b=spbiCAnFxTSnLoDSKGE5Kzt3QsSPSAJBcttuMl5V24rTs7/nZAQHnNjdLDLN4uGNSTn9qHzYklu6r3ivxioOSbXOkg0Fa1s2QWEIGTDYDlAERLB5kxMTjAAlv8JMgKYAKXUR63J+rJEObgtlg2iU1xQiTz8lqHHzbDwg8Clvm4g=
Received: from BL0PR02MB5681.namprd02.prod.outlook.com (20.177.241.92) by
 BL0PR02MB5412.namprd02.prod.outlook.com (20.177.240.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Fri, 3 May 2019 16:49:19 +0000
Received: from BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::6cde:f726:b36e:752d]) by BL0PR02MB5681.namprd02.prod.outlook.com
 ([fe80::6cde:f726:b36e:752d%5]) with mapi id 15.20.1856.012; Fri, 3 May 2019
 16:49:19 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>, Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <dkiernan@xilinx.com>
Subject: RE: [PATCH V3 07/12] misc: xilinx_sdfec: Add ability to configure
 LDPC
Thread-Topic: [PATCH V3 07/12] misc: xilinx_sdfec: Add ability to configure
 LDPC
Thread-Index: AQHU/UVPnT63WxPZjkKYaNOUADJ+zqZYHgSAgAGG/0A=
Date:   Fri, 3 May 2019 16:49:19 +0000
Message-ID: <BL0PR02MB5681D386363988CB2CA4D040CB350@BL0PR02MB5681.namprd02.prod.outlook.com>
References: <1556402706-176271-1-git-send-email-dragan.cvetic@xilinx.com>
 <1556402706-176271-8-git-send-email-dragan.cvetic@xilinx.com>
 <20190502172713.GD1874@kroah.com>
In-Reply-To: <20190502172713.GD1874@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d7b0bf3-1c86-4547-abc5-08d6cfe74937
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BL0PR02MB5412;
x-ms-traffictypediagnostic: BL0PR02MB5412:
x-microsoft-antispam-prvs: <BL0PR02MB5412C25FE7D1D400B65F825ACB350@BL0PR02MB5412.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0026334A56
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(136003)(366004)(13464003)(189003)(199004)(99286004)(76176011)(71190400001)(8936002)(66066001)(71200400001)(25786009)(3846002)(81156014)(81166006)(305945005)(6116002)(107886003)(53936002)(2906002)(316002)(4326008)(8676002)(6246003)(68736007)(102836004)(7736002)(11346002)(476003)(446003)(7696005)(9686003)(6506007)(55016002)(14454004)(86362001)(73956011)(66946007)(478600001)(26005)(76116006)(52536014)(53546011)(6436002)(64756008)(66446008)(66476007)(66556008)(54906003)(486006)(6916009)(33656002)(186003)(74316002)(5660300002)(229853002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB5412;H:BL0PR02MB5681.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qo+gsKJzxC6o7eckHF0QCjN0zBgZbwxLSyAQl8oIeRm8m8/RQYP1xRXRlJyJGpUOCA59WTc28BfkYD+5h/7rkZ4Fj1rtHtTzZS1vkPw+Uaz8AooFcGlEWyahI5akJMCToDV5q0Lgb24WizkTLINMwm196kJLIQ6dEZwX5no6OdkPVd+ZPEzJFi28XCy176y6l52j7lN8v9lkeFx23yYxD4C6DPpl1UETbYwNO7Fo77FY6Va92kBg0LeXLPjHjOCYzoGp4QmPKKqE7YzVRnIWCc6ucUjCKpO9rScoHsncpC+zEeAgQ+zR4B6cXgNqyDhNk2RBBTJtIQMpusybE4QtmlmcgYpWjW+joKb5nW+mdPJFWtxtlcw8B+ytBD7tO2ysO9w7cnhf1gAhE5HCCsh0cbnYMai78hMwhKmjUG73j0c=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7b0bf3-1c86-4547-abc5-08d6cfe74937
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2019 16:49:19.0395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5412
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please find inline comments below.

Regards
Dragan


> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Thursday 2 May 2019 18:27
> To: Dragan Cvetic <draganc@xilinx.com>
> Cc: arnd@arndb.de; Michal Simek <michals@xilinx.com>; linux-arm-kernel@li=
sts.infradead.org; robh+dt@kernel.org;
> mark.rutland@arm.com; devicetree@vger.kernel.org; linux-kernel@vger.kerne=
l.org; Derek Kiernan <dkiernan@xilinx.com>
> Subject: Re: [PATCH V3 07/12] misc: xilinx_sdfec: Add ability to configur=
e LDPC
>=20
> On Sat, Apr 27, 2019 at 11:05:01PM +0100, Dragan Cvetic wrote:
> > --- a/include/uapi/misc/xilinx_sdfec.h
> > +++ b/include/uapi/misc/xilinx_sdfec.h
>=20
> <snip>
>=20
> > +/**
> > + * xsdfec_calculate_shared_ldpc_table_entry_size - Calculates shared c=
ode
> > + * table sizes.
> > + * @ldpc: Pointer to the LPDC Code Parameters
> > + * @table_sizes: Pointer to structure containing the calculated table =
sizes
> > + *
> > + * Calculates the size of shared LDPC code tables used for a specified=
 LPDC code
> > + * parameters.
> > + */
> > +inline void
> > +xsdfec_calculate_shared_ldpc_table_entry_size(struct xsdfec_ldpc_param=
s *ldpc,
> > +	struct xsdfec_ldpc_param_table_sizes *table_sizes)
> > +{
> > +	/* Calculate the sc_size in 32 bit words */
> > +	table_sizes->sc_size =3D (ldpc->nlayers + 3) >> 2;
> > +	/* Calculate the la_size in 256 bit words */
> > +	table_sizes->la_size =3D ((ldpc->nlayers << 2) + 15) >> 4;
> > +	/* Calculate the qc_size in 256 bit words */
> > +	table_sizes->qc_size =3D ((ldpc->nqc << 2) + 15) >> 4;
> > +}
>=20
> Why do you have an inline function in a user api .h file?  That's really
> not a good idea.

This is just a Helper function for users aligning the calculations.
Please advise, is this acceptable?

>=20
> thanks,
>=20
> greg k-h
