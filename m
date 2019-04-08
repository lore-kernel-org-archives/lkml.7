Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55991C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22BE920883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sl8qLrBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfDHXhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 19:37:10 -0400
Received: from mail-eopbgr790070.outbound.protection.outlook.com ([40.107.79.70]:36864
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbfDHXhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 19:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHNeM3H21EYTzCRJDaon9G17+e1WQmqvuainH24EDkU=;
 b=sl8qLrBEC4C6Hj4tO1jo3Ic3twKm7vZ72vJ8vc1Y3C1bvonQ9CYqKLutrhtu6AqdOE++1MeoExW2WSVQ7jBe9VhkMmuFhYAbetOrpn6mbS64KYVCcWyUgSbiHd6jRASiX7WbT47aXeYxE23/5MKFPSDGBRYSMuE1CrX/8QC+hcA=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Mon, 8 Apr 2019 23:37:04 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::9c51:41bf:f88e:f3e8%2]) with mapi id 15.20.1771.016; Mon, 8 Apr 2019
 23:37:04 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     Borislav Petkov <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH RESEND 4/5] x86/MCE: Make number of MCA banks per_cpu
Thread-Topic: [PATCH RESEND 4/5] x86/MCE: Make number of MCA banks per_cpu
Thread-Index: AQHU7hUSYTqXxdHZ3kOiah7oXgcNraYytquAgAACGoCAAAJDAIAAAiCAgAAgghCAAApMgIAAAwKw
Date:   Mon, 8 Apr 2019 23:37:04 +0000
Message-ID: <SN6PR12MB2639D6D5DC408B3D70B8BCEAF82C0@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190408141205.12376-1-Yazen.Ghannam@amd.com>
 <20190408141205.12376-5-Yazen.Ghannam@amd.com>
 <20190408202659.GA5232@agluck-desk> <20190408203431.GM15689@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7E8F6A61@ORSMSX104.amr.corp.intel.com>
 <20190408205013.GN15689@zn.tnic>
 <SN6PR12MB2639F3E98157872E7C046705F82C0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190408232325.GA17000@agluck-desk>
In-Reply-To: <20190408232325.GA17000@agluck-desk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4c4d5e8-7179-4945-5a83-08d6bc7b1b25
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2639;
x-ms-traffictypediagnostic: SN6PR12MB2639:
x-microsoft-antispam-prvs: <SN6PR12MB26394423834CF247A6F8E687F82C0@SN6PR12MB2639.namprd12.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(136003)(39860400002)(51914003)(199004)(13464003)(189003)(486006)(53936002)(66066001)(6916009)(305945005)(3846002)(105586002)(6116002)(54906003)(106356001)(7736002)(8676002)(52536014)(11346002)(8936002)(476003)(5660300002)(81156014)(81166006)(186003)(93886005)(446003)(33656002)(97736004)(26005)(4326008)(316002)(25786009)(53546011)(478600001)(74316002)(6436002)(9686003)(55016002)(86362001)(4744005)(71200400001)(2906002)(99286004)(15650500001)(68736007)(72206003)(6246003)(71190400001)(76176011)(14454004)(102836004)(256004)(7696005)(229853002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2639;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xJ1kGe3u1qYVrxty0spO+/BzhrxW7eQ/g638H89oDz2mRLIQPAHduVsgELn1K9WvVDWeCWT9hrnF8I17Y1cR/4X+2edUD69Ma6v/kMb+9uuwccdoPR/BY+OFqm9QhiSOwEuS2Yy9mQCfH638YtvaJin6yPsKJ+4ykwH/Cajg5XdR6mFE+k9zHca9dH3NK0wyFCwB6O57sES1DY/jY2lnucHho1ALgWC0rCP+sBt6tE90S9vO6Ka1Twz99TL2u1+9T/vI/9XIwxlBsPxKPB2xMOT1q0aNj0qvEIiWYEsw6ZS0zdm/wWXqF3LhgjeHkXM2nzrhcjxUhORgoDoFkHG6V2MbLZb836Q5ia9/Ui9vYuZb/c/Opyf1MvpsObpuU/SS2KW2S7KFyRjcyuoKGV7ntsqZUunVpjhvsxtEHg8E62s=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c4d5e8-7179-4945-5a83-08d6bc7b1b25
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 23:37:04.0274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2639
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-edac-owner@vger.kernel.org <linux-edac-owner@vger.kernel.org>=
 On Behalf Of Luck, Tony
> Sent: Monday, April 8, 2019 6:23 PM
> To: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Cc: Borislav Petkov <bp@alien8.de>; linux-edac@vger.kernel.org; linux-ker=
nel@vger.kernel.org; x86@kernel.org
> Subject: Re: [PATCH RESEND 4/5] x86/MCE: Make number of MCA banks per_cpu
>=20
> On Mon, Apr 08, 2019 at 10:48:34PM +0000, Ghannam, Yazen wrote:
> > Okay, so drop the export and leave the injector code as-is (it's
> > already doing a rdmsrl_on_cpu()).
>=20
> It's still a globally visible symbol (shared by core.c and amd.c).
> So I think it needs a "mce_" prefix.
>=20
> While it doesn't collide now, there are a bunch of other
> subsystems that have "banks" and a variable to count them.
>=20
> Look at output from "git grep -w num_banks".
>=20

Okay, I'll add the prefix.

And thanks for the tip. I'll try to keep this in mind.

Thanks,
Yazen=20
