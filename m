Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2265C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2BC214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="03DSC6Hy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfCKWKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:10:33 -0400
Received: from mail-eopbgr820047.outbound.protection.outlook.com ([40.107.82.47]:25024
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727548AbfCKWKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 18:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAnNgiFaDw5m3upNh+8V1GqRxhwCoIjZ+6k4vbBNRAs=;
 b=03DSC6HyezPpMWbC1JI1NrQTZ8CFs3tVBa8n13cXKDqTnThRbJzD+b4oJB4hEs7A5Az6rNMqLp0qGO9eJMng0dHvv/Rk+Y7KKHWB11lOqvRPrg/K8Vr8jfQadU8M6a69rB2aW7FBRKs6fTUYQFyySZ6uI3BcYoAhR2VSHGpzOxg=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2814.namprd12.prod.outlook.com (52.135.107.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.20; Mon, 11 Mar 2019 22:10:30 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 22:10:29 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: RE: [PATCH] x86, mce: Fix machine_check_poll() tests for which errors
 to log
Thread-Topic: [PATCH] x86, mce: Fix machine_check_poll() tests for which
 errors to log
Thread-Index: AQHU2DtsQDXo+RWhv0y/sb6komHrxqYG4DzQgAAFIYCAABe+UA==
Date:   Mon, 11 Mar 2019 22:10:29 +0000
Message-ID: <SN6PR12MB2639C9CC6B5BA0A1F1FE771DF8480@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190311185118.32667-1-tony.luck@intel.com>
 <SN6PR12MB26399CBAEFB6C500D456255DF8480@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190311204217.GA1810@agluck-desk>
In-Reply-To: <20190311204217.GA1810@agluck-desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86ed4bca-a114-4951-9cdd-08d6a66e5f97
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2814;
x-ms-traffictypediagnostic: SN6PR12MB2814:
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2814;20:kYz6hOL/fYMb9M8vzBY6lGfXfYj8mx/H40jGO8k3QwASlP2HcUA9rmEgJ7TrXJoCy7l7kbmBwdX8YlBZ8uRPCZYm92k23XOkhi4NEo8mGVUms6MxbhWFM0MPcKblvwno99V4oHwxmBxmcNLhXebJU+ajHxQAkJb1m5t0v4TbaQgCbG+/sQegZLt5rnmClr79oGguKTYdfKwn+udasyFwYycuQOoe+xCw4f6aV9FgczqdZiJpAHHFEOQjvmyP/n74
x-microsoft-antispam-prvs: <SN6PR12MB28147C1873808BABC9FE3341F8480@SN6PR12MB2814.namprd12.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(366004)(396003)(189003)(199004)(13464003)(54906003)(6436002)(2906002)(106356001)(316002)(6246003)(7736002)(486006)(476003)(9686003)(305945005)(55016002)(4326008)(97736004)(53936002)(105586002)(86362001)(25786009)(6116002)(3846002)(229853002)(52536013)(66066001)(14454004)(478600001)(33656002)(71200400001)(71190400001)(72206003)(446003)(256004)(26005)(8676002)(81156014)(81166006)(74316002)(186003)(8936002)(6916009)(102836004)(68736007)(6506007)(53546011)(76176011)(7696005)(5660300002)(99286004)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2814;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zLh2MzKXicnh56gkiRb8xHq9aDnyUBj1drsE88qeXAQS06Cwu2vH4hLtAE1PK6kpeEAA7a0jm+nFqN75BTOnv4JNCvGKQDs5EB+OZRu/HmzyZ26A0PBadIrY0uyBePpDOhh8ia0EUNz2hQQWbbINp23wxJb4BeBcssnJT3Edbml0VfKuCdzJoTkueJH2vXisqLo1ROvhRqFhXQX1PYRm8DfYJKyUz7+ISTBwIa+VwdQjgv50Q79gJP/toGnm9nCIhco9ngyX+9jM0CVjxYfSuumRoauq7eawtGn5uIAIzs5rKoaeoFZEfynfLqM2dsam31N5GxnTDj6yqninBOgYSrTpjST4rmPe0afFd0q0asqRiboA0muFkNR4lqV4LK39jnM7UgLXeaDPsVwCzMJbqR1nLiWUkv6Y2Lb6fM/p9Sc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ed4bca-a114-4951-9cdd-08d6a66e5f97
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 22:10:29.8077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2814
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Luck, Tony <tony.luck@intel.com>
> Sent: Monday, March 11, 2019 3:42 PM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: Borislav Petkov <bp@alien8.de>; x86@kernel.org; linux-kernel@vger.ker=
nel.org; Ashok Raj <ashok.raj@intel.com>
> Subject: Re: [PATCH] x86, mce: Fix machine_check_poll() tests for which e=
rrors to log
>=20
> On Mon, Mar 11, 2019 at 08:25:53PM +0000, Ghannam, Yazen wrote:
> > > +		if (!(m.status & MCI_STATUS_PCC) && !(m.status & MCI_STATUS_S))
> > > +			goto log_it;
> > > +
> >
> > Can you please include a vendor check with this? MCi_STATUS[56] is
> > not defined the same way on AMD systems.
>=20
> Original code also looked at MCi_STATUS[56] without a vendor
> check:
>=20
> > > -               (m.status & (mca_cfg.ser ? MCI_STATUS_S : MCI_STATUS_=
UC)))
>=20
> Was this OK because you don't set mca_cfg.ser?
>=20
> If so, my new code will also skip out before getting to this test. But
> should probably have a better comment. Something like:
>=20
>=20
> 		/*
> 		 * Newer Intel systems that support software error
> 		 * recovery need to make some extra checks. Other
> 		 * CPUs should skip over uncorrected errors, but log
> 		 * everything else
> 		 */
> 		if (!mca_cfg.ser) {
> 			if (m.status & MCI_STATUS_UC)
> 				continue;
> 			goto log_it;
> 		}
>=20

Yes, you're right. Thanks for pointing that out.

-Yazen
