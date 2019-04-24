Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9836EC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5662C21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="HS5skURq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDXWnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:43:55 -0400
Received: from mail-eopbgr780139.outbound.protection.outlook.com ([40.107.78.139]:52692
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726425AbfDXWnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kX3ChMlM5yboIQo3KtQkNAUMotgxjG6U43BH9cPshA4=;
 b=HS5skURqt8N2LQUTE7V3A+VglBM5tAmwrBqKWDTOaiZU78YEoBBi9M9FSTgm7ipRIYXo9pYT/uZ5ph6M67gPc0FPAZYOjrHaRW7uZDJiAx+3apMj5LAcMzzY+RJ2oeA93zWvngOr7rMg89jrxOxjjNJgDZVGPDccozpgJQdm1wI=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1438.namprd22.prod.outlook.com (10.174.169.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Wed, 24 Apr 2019 22:43:48 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 22:43:48 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Serge Semin <fancer.lancer@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Huacai Chen <chenhc@lemote.com>,
        Stefan Agner <stefan@agner.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Juergen Gross <jgross@suse.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/12] mips: Reserve memory for the kernel image resources
Thread-Topic: [PATCH 04/12] mips: Reserve memory for the kernel image
 resources
Thread-Index: AQHU+ibQQIEJaXUkgEWNBapHcAUrdaZL6giA
Date:   Wed, 24 Apr 2019 22:43:48 +0000
Message-ID: <20190424224343.4skr727fszycwksq@pburton-laptop>
References: <20190423224748.3765-1-fancer.lancer@gmail.com>
 <20190423224748.3765-5-fancer.lancer@gmail.com>
In-Reply-To: <20190423224748.3765-5-fancer.lancer@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::48) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea70e2ad-7267-448a-93d4-08d6c90650de
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR2201MB1438;
x-ms-traffictypediagnostic: MWHPR2201MB1438:
x-microsoft-antispam-prvs: <MWHPR2201MB1438217D7689E0DADE3905C0C13C0@MWHPR2201MB1438.namprd22.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(396003)(346002)(136003)(39850400004)(376002)(189003)(199004)(54906003)(1076003)(186003)(5660300002)(386003)(66476007)(478600001)(99286004)(102836004)(6916009)(66946007)(6506007)(66556008)(64756008)(66446008)(7416002)(26005)(8936002)(14454004)(66066001)(52116002)(81166006)(81156014)(25786009)(8676002)(73956011)(76176011)(71190400001)(58126008)(7736002)(6116002)(305945005)(4326008)(2906002)(3846002)(229853002)(6246003)(486006)(316002)(71200400001)(6486002)(97736004)(14444005)(11346002)(33716001)(68736007)(256004)(446003)(53936002)(44832011)(476003)(6512007)(9686003)(42882007)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1438;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Z+e5h7gjZSiXIEywpsHfuDVPj7/6k7V7ZtT1JaVSLgoSOYOhonLyLqcWDBTfpmcZ3oBF2wvJfnLz0d4Cgw6k71qcduHYFDNUo+bVfdTEnswGSzKfeGzMZuuchjVXAaNcWSIZvfsBZ2eiRFnzgovJiOWLn8XUuMcSAhg6CnRVOSS8pjdKomlCJwmhEgNIc0vi3U3Nfupj3LSA0cQCetQAt6cy548IpgcRpuWZxQfmKRvNZ4b6MLAyJAHIoeJHCrwTGPz26+T1Q+vHOGhChG5iQFKh9zvGRkERwWpjrxzyDpBTBdrNjQlq/4Aqy18RiBhr9i0aWrBQ0mJr9jD83gbHkVa6nJFpVL8xG44xEW1iJb93f1oxva2AaSS6Rj6S3ylx3E/+MCPQcFfG7X+A69sUJqXcokxaQqYcU9uFXEJNq1w=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <540AEEF9F0062F4A9ECB970A6E9C99EB@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea70e2ad-7267-448a-93d4-08d6c90650de
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 22:43:48.5966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1438
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

On Wed, Apr 24, 2019 at 01:47:40AM +0300, Serge Semin wrote:
> The reserved_end variable had been used by the bootmem_init() code
> to find a lowest limit of memory available for memmap blob. The original
> code just tried to find a free memory space higher than kernel was placed=
.
> This limitation seems justified for the memmap ragion search process, but
> I can't see any obvious reason to reserve the unused space below kernel
> seeing some platforms place it much higher than standard 1MB.

There are 2 reasons I'm aware of:

 1) Older systems generally had something like an ISA bus which used
    addresses below the kernel, and bootloaders like YAMON left behind
    functions that could be called right at the start of RAM. This sort
    of thing should be accounted for by /memreserve/ in DT or similar
    platform-specific reservations though rather than generically, and
    at least Malta & SEAD-3 DTs already have /memreserve/ entries for
    it. So this part I think is OK. Some other older platforms might
    need updating, but that's fine.

 2) trap_init() only allocates memory for the exception vector if using
    a vectored interrupt mode. In other cases it just uses CAC_BASE
    which currently gets reserved as part of this region between
    PHYS_OFFSET & _text.

    I think this behavior is bogus, and we should instead:

    - Allocate the exception vector memory using memblock_alloc() for
      CPUs implementing MIPSr2 or higher (ie. CPUs with a programmable
      EBase register). If we're not using vectored interrupts then
      allocating one page will do, and we already have the size
      calculation for if we are.

    - Otherwise use CAC_BASE but call memblock_reserve() on the first
      page.

    I think we should make that change before this one goes in. I can
    try to get to it tomorrow, but feel free to beat me to it.

Thanks,
    Paul
