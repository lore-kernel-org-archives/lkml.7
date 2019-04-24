Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C38C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D671A20835
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="f6pQzgrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbfDXVgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:36:16 -0400
Received: from mail-eopbgr810129.outbound.protection.outlook.com ([40.107.81.129]:64512
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730260AbfDXVgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRfh9iE8YWY++mEcbJtwePIH6foZ7X8y8Eh448UbgYY=;
 b=f6pQzgrCbbA9QwF3UzsFij4t0e5on20UXCplZUug+uPdX7ZCXx4pZtBRFT9zdZWXaQbGh5Hwwb/GU4qJ6qCYLu9X+Sh8xMFiKraHRn4mE0XGzUJLuBJDuIbaqx09d6J2+HpwGXn1gLRh22QQzR88Uj/kjbVkHYimcGapHtTaot0=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1039.namprd22.prod.outlook.com (10.174.167.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.18; Wed, 24 Apr 2019 21:36:12 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 21:36:12 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Resend] arch: mips: Fix initrd_start and initrd_end when read
 from DT
Thread-Topic: [Resend] arch: mips: Fix initrd_start and initrd_end when read
 from DT
Thread-Index: AQHU9D29gHbzBFCLD0GOCgvAiyCd3qZD+84AgAdJugCAAJ1vgA==
Date:   Wed, 24 Apr 2019 21:36:12 +0000
Message-ID: <20190424213607.d6tzpqkndkxzgwrm@pburton-laptop>
References: <1555409900-31278-1-git-send-email-horatiu.vultur@microchip.com>
 <20190419205456.uylahdin2jlkeyyy@pburton-laptop>
 <20190424121236.uadnsmgg3ctvljdo@soft-dev3.microsemi.net>
In-Reply-To: <20190424121236.uadnsmgg3ctvljdo@soft-dev3.microsemi.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::26) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b20a20d-9688-44db-e9a1-08d6c8fcdf55
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR2201MB1039;
x-ms-traffictypediagnostic: MWHPR2201MB1039:
x-microsoft-antispam-prvs: <MWHPR2201MB1039C88A2E97DDD19FC86ED1C13C0@MWHPR2201MB1039.namprd22.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(136003)(366004)(376002)(346002)(39850400004)(199004)(189003)(316002)(9686003)(14444005)(186003)(5660300002)(53936002)(68736007)(58126008)(6512007)(6246003)(26005)(386003)(6506007)(102836004)(256004)(99286004)(2906002)(71190400001)(71200400001)(14454004)(66556008)(33716001)(6486002)(81166006)(66946007)(8936002)(44832011)(478600001)(4326008)(81156014)(64756008)(73956011)(8676002)(6116002)(6436002)(66446008)(486006)(305945005)(7736002)(1076003)(97736004)(66066001)(11346002)(54906003)(25786009)(52116002)(446003)(76176011)(3846002)(229853002)(66476007)(6916009)(42882007)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1039;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Zw8ja9XU/Sf4JN57F2v22z2/IvewsGmLXjGqh1rOeWNTmqCUzTHdNueN0giiWu5dWgKoSNPWa6vP7NMx8SPPMSaFV5dbnr0Jcx+riAvD5wmTC77gD6Qm0UkW+fbCPEWj4iJFuqouVs+qJUfZUoToSreeXJfSVLtWzzqAR36YMU11kXGYPAImmxgHVAWBnDlEB0N/X8DPmiIluBAPo+qy5aDzTa17u6d5WdOjtyVAzB+o019FdonE5U1eJ/4kA6wzyu3n6fg3qyIEBxTSv/N6M48HHu1/OkzUR22ZWb33M836vFYImOwyGSGjQPlDAR5u7idJrk7yeXYsWPvLGTGWY+i3RrjHtZfL33Hck0eyDV2dxu8ThtN6SQnCVEQQMS+npzyW+dzHP3Uwfz4G1jsK55ShancUKeh3VE9w+zfzkUg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8BB58791AB4E0544952B460276C7BB12@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b20a20d-9688-44db-e9a1-08d6c8fcdf55
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 21:36:12.6009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1039
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Horatiu,

On Wed, Apr 24, 2019 at 02:12:38PM +0200, Horatiu Vultur wrote:
> The 04/19/2019 20:55, Paul Burton wrote:
> > On Tue, Apr 16, 2019 at 12:18:20PM +0200, Horatiu Vultur wrote:
> > > When the bootloader passes arguments to linux kernel through device t=
ree,
> > > it passes the address of initrd_start and initrd_stop, which are in k=
seg0.
> > > But when linux kernel reads these addresses from device tree, it conv=
erts
> > > them to virtual addresses inside the function
> > > __early_init_dt_declare_initrd.
> >=20
> > I'm not sure I follow - if the bootloader provides an address in kseg0
> > then it's already a virtual address.
>=20
> So I am just a novice in this, but in my case the bootloader(Uboot) passe=
s
> the address in kseg0(e.g 0x9f8a6000), but if I understand correctly
> this is just cached access to location 0x1f8a6000.

That's right.

In this case the virtual address is 0x9f8a6000, which is in kseg0. That
means the cache-coherency attribute (CCA) is taken from the cop0 config
register's K0 field & is typically some form of cached access.

The physical address is 0x1f8a6000.

> > It looks like __early_init_dt_declare_initrd expects the DT to provide
> > physical addresses, which fits in well with the fact that DTs generally
> > use physical addresses for everything else.
> >=20
> > __early_init_dt_declare_initrd calling __va on a virtual address will
> > give you something bogus, and it looks like you're just cancelling this
> > out below. In practice for a typical system where PAGE_OFFSET is the
> > start of kseg0 (0x80000000) the bogus address you get will happen to be
> > the same as the physical address, but that's not guaranteed.
> >=20
> > > At a later point then in the function init_initrd, it is checking for
> > > initrd_start to be lower than PAGE_OFFSET, which for a 32 CPU it is n=
ot,
> > > therefore it would disable the initrd by setting 0 to initrd_start an=
d
> > > initrd_stop.
> >=20
> > The check you mention here is to make sure initrd_start looks like a
> > virtual address - if it's lower than PAGE_OFFSET (typically 0x80000000)
> > then it looks bad & initrd is disabled. I think your comment is
> > backwards - what you have is a physical address, entirely by accident,
> > and you're converting it back to a virtual address again by accident
> > which keeps the check happy.
>=20
> I am a little bit confused here. so the initrd_start has to have a
> virtual address(in kseg0) inside the function init_initrd. Meaning that
> when the bootloader passes the arguments to linux through a command line,
> then initrd_start has to be already a virtual address? Because I
> couldn't see a place where it converts the initrd_start. But when the
> bootloader pass the arguments through DT it has to be physical address?

Hmm, that's a good point - it does look like we expect virtual addresses
when passed on the command line. That inconsistency with DT is
unfortunate, but I still think keeping the DT itself consistent &
keeping MIPS consistent with other architectures as far as DT goes makes
it worthwhile to use physical addresses in the DT.

> > > The fix consists of checking if linux kernel received a device tree a=
nd not
> > > having enable extended virtual address and in that case convert them =
back
> > > to physical addresses that point in kseg0 as expected.
> >=20
> > Can you instead just have your bootloader provide physical addresses in
> > the DT?
>=20
> Yes, I have done few tests and it seems to work fine, but I need to
> understand it better.

I hope the above helps makes sense of that. I think overall that using
the physical address of the initrd in the DT makes more sense than using
the virtual address. It is afterall what's specified in the DT binding
documentation too, see Documentation/devicetree/bindings/chosen.txt:

> linux,initrd-start and linux,initrd-end
> ---------------------------------------
>=20
> These properties hold the physical start and end address of an initrd
> that's loaded by the bootloader.
>%

Thanks,
    Paul
