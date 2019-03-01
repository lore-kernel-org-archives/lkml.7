Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4936C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2ED2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 22:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="AlGGGmvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfCAWQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 17:16:23 -0500
Received: from mail-eopbgr680100.outbound.protection.outlook.com ([40.107.68.100]:25922
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726210AbfCAWQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 17:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feo2jrd/xvy1z3kGwS0LAAdwmjUPUqxgYYb4Pm7A2eE=;
 b=AlGGGmvDQHxh1+QgZMCdI6ra7FsyIdpANeNAOrr5Yp+KnDQsw6u8RElSdvibeNC5hXjTSiKPnPvf6GUv8YMC5PNCliUMRu4DNy1QnNV77WBceH72S1mgdjkKCnPALrQROXrStlSKUQJCik1bbV31+nwmk3Vv1LWAgCnUzkP+Gtw=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1566.namprd22.prod.outlook.com (10.172.63.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.15; Fri, 1 Mar 2019 22:16:18 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b8d4:8f0d:d6d1:4018%3]) with mapi id 15.20.1665.017; Fri, 1 Mar 2019
 22:16:18 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Will Deacon <will.deacon@arm.com>
CC:     "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 10/20] mips/mmiowb: Add unconditional mmiowb() to
 arch_spin_unlock()
Thread-Topic: [PATCH 10/20] mips/mmiowb: Add unconditional mmiowb() to
 arch_spin_unlock()
Thread-Index: AQHU0De1/M1S8jaEokePEKxrUNkxAKX3WFiA
Date:   Fri, 1 Mar 2019 22:16:18 +0000
Message-ID: <20190301221616.uhpjjepmxjmahkjt@pburton-laptop>
References: <20190301140348.25175-1-will.deacon@arm.com>
 <20190301140348.25175-11-will.deacon@arm.com>
In-Reply-To: <20190301140348.25175-11-will.deacon@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0021.prod.exchangelabs.com (2603:10b6:a02:80::34)
 To MWHPR2201MB1277.namprd22.prod.outlook.com (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ef99356-d908-4cd5-92a4-08d69e9386c5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1566;
x-ms-traffictypediagnostic: MWHPR2201MB1566:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;MWHPR2201MB1566;23:jgnNOyqZjPljRY45w2mKZlpmMDbtB22QFbaqe20?=
 =?us-ascii?Q?oWPoPIOwASNJuK5hLN6OGYpU5QW/XhX9eFP9UPMimGMVeyUE9NJfVBN4/daw?=
 =?us-ascii?Q?IQkeGrP4xHDlw5auN7sNWjqd7Zb2YOgneMdrt8E3JwJW21eGX5BlyoyHtI2w?=
 =?us-ascii?Q?F4GLwJgfvG2g8bzhQX/MgButboK2LMa7YIwo1TLA2dXsNNi1aAqKAraj0xc1?=
 =?us-ascii?Q?gwEF1vnNQurxhVUomPsuInDzXh3YALAUNCtNifFd52NyQjlXg2Z+HK5JKi+g?=
 =?us-ascii?Q?qFjkrtm1IAz7HS3MKYq4hoA34GwPVDSttmQAcv6fE0aClmD/ipIuJiiIV7xg?=
 =?us-ascii?Q?IoPzHnn5agdoih/D4tznRn0d+EYwYLWS40Q9bbMu7pp/dG0hT2OVM0f2h30n?=
 =?us-ascii?Q?zA02a37UgNc1CrpROR8Q1ob70NfaRW4CO5yaJDkvGy0Fmn80rYYbYcvnRwH9?=
 =?us-ascii?Q?peroQ7NSTPftrYgdXvhb54Y/wDp801Rp6YVLSgISoXYDDHiwJIsoCZOJPXWE?=
 =?us-ascii?Q?OKg1V12y61sDeFghzYV4Z/zwwj2KMoo+cAgs4UkURePKSgYaDoMBOKXsxo5h?=
 =?us-ascii?Q?ybzvdp/sdV8COvEtS9q0eTIENQhNWrM/HfceMsm6HB3rtr9QjtS7FR17g8xG?=
 =?us-ascii?Q?isCf8zjEsrxnCbNu6lzE6/ZJD4pXMWr0pJS9kgUXJ2euCR4I9SJaYbfLViWU?=
 =?us-ascii?Q?usmrr7O/T9iLq8Zvx3zgDlTS9bcZfCDhwE44DTizfMLd4gEnwu22A1fCTNwP?=
 =?us-ascii?Q?d4o7JMjMKN2NLWRoiRLUiJyK0HEjQrWiDUvl1iuNs7J4Zyvegt67JE/jdL/I?=
 =?us-ascii?Q?mOq9xr+PMkQLfV0WID/ftkPQyMnRku8ubiJQOxQCRgXC33emKDobkKTz5qVA?=
 =?us-ascii?Q?UZpNLEywE1ZQrhiMFvZP46RP0WZXouX4ONN2tSbkivoYknuTJ2yf9jHdYfG0?=
 =?us-ascii?Q?NlEHhC498Obv5zb/y5xPIgfuu0neijudNk1ZjL12Ru/OZKsWsTUPaKQATmW/?=
 =?us-ascii?Q?5c5LqhLCdk64ChtKcdT0g1WY5KUnesS4Gh5dCGhs2AJznBCkqMewHZDIqcaF?=
 =?us-ascii?Q?+1cV1BXGcv4wyThH49VG8rr9VpWGCAyDjk3n6jUbNDje/Fc0q6P38MSI2Aki?=
 =?us-ascii?Q?UWYQIsTrYD3h432aC5OPjiEmbHaVw5L3c7Lqs2bIMmk4N+jf1DO2qJTU3/yI?=
 =?us-ascii?Q?gTDqHjYUDKglR0StKal0pFNKejfMeElIByeUpHsCZ8IFJomehXciQdj1XMP4?=
 =?us-ascii?Q?n42IIoRDR+Is1CREC1T73y6tjbF4n+qLrHMBrV0CHUxOZZb3MjOfjAAfgvGF?=
 =?us-ascii?Q?N9kLp14Hnp4bHsgZ2hq8ybSzR+Bu9v+WXLoQL2moV2MC3KmNbAr9hca96zcp?=
 =?us-ascii?Q?+bbJHhQ=3D=3D?=
x-microsoft-antispam-prvs: <MWHPR2201MB156683D78C9115CFAE2C70E5C1760@MWHPR2201MB1566.namprd22.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39840400004)(366004)(136003)(376002)(396003)(346002)(199004)(189003)(54906003)(33716001)(6916009)(8936002)(14454004)(478600001)(68736007)(7736002)(8676002)(305945005)(81156014)(25786009)(2906002)(4326008)(66066001)(81166006)(6436002)(58126008)(6512007)(9686003)(6246003)(53936002)(6486002)(316002)(256004)(14444005)(4744005)(1076003)(386003)(99286004)(52116002)(102836004)(26005)(7416002)(486006)(6506007)(476003)(76176011)(44832011)(186003)(6116002)(3846002)(5660300002)(3716004)(11346002)(446003)(42882007)(97736004)(105586002)(229853002)(71190400001)(71200400001)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1566;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cTbKER40zO2jcwLoNOKUwzTnSG9FcZnjva03Z0uCht8VxYUf9LhiuZ6m9jXtYgmMwOfBgd3efbL1oTA0UlRlhOmt6wgpIN+rCj9ujmA4/90nzr/fnQP/HX1QdiZ7N0JUtuIkeTSUEgRbU2X2kD5PLChjcVi9LQdXpKTI/hptY/f+PAq4d6ZIk+9IIpqG3QKZZMHSUz0rRCDmPfAjYT0LH+HTomxL6ceeo6KAFLZn3K108IVJ8erlcpSxpNjjYeSi8sE71vvEVEoCEvPZDwyA38TxHZrr6Bvm5sjHH8OZW4PTncVqq+ok0CkoSZW9VXoyS6yrye9Sj72ClXqIVaFwHl/iFKQDVhFD2jUwuMBCsFcnva3gAgCFt3Wts4byuT3oyFqsEduiXMqxOk19+ZCeeaKeLu6jo0Sz8gfziY1n0xg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A3010C6AF45DBF439F24B8ACCA3A9798@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef99356-d908-4cd5-92a4-08d69e9386c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 22:16:18.1673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1566
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Fri, Mar 01, 2019 at 02:03:38PM +0000, Will Deacon wrote:
> The mmiowb() macro is horribly difficult to use and drivers will continue
> to work most of the time if they omit a call when it is required.
>=20
> Rather than rely on driver authors getting this right, push mmiowb() into
> arch_spin_unlock() for mips. If this is deemed to be a performance issue,
> a subsequent optimisation could make use of ARCH_HAS_MMIOWB to elide
> the barrier in cases where no I/O writes were performed inside the
> critical section.
>=20
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Cleaning up our I/O functions has been on my to-do list for a while, so
I'll aim to get to that soon & get the calls to mmiowb_set_pending() in
place as part of it so that we can look at that optimization & drop the
custom queued_spin_unlock().

Meanwhile this looks sane & I don't want to hold it up so:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul
