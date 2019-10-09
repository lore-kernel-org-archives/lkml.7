Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9DDECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F8A20679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="mC/haqQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731586AbfJISwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 14:52:38 -0400
Received: from mail-eopbgr760089.outbound.protection.outlook.com ([40.107.76.89]:40965
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730490AbfJISwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 14:52:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLIRcobzuzacAPla8Igh1/9w06+D8AqXSS5NE9cz+gMA3aTxgRBGmXBRV0ZFLj/Nck/kG7PktTRPRlsuJi/rb+ibzmQw7ApFU4mV7dPgpO+dU3ACvf1/c75huY9XkbKioUGqJD9BkYlhE3jOgUMJ5645iH6dJTjM+m/NSn5LrcPoipOVG8hRB1CoE0e6Du6sYLqOCVwmCFz7F/t217aY3VboMpcAa6A7ZRugBE78lIBpTaKp4Kq/hBJk+PnB9Lfv2OYyUgGpb24VTBZTUmKSOduL3wJs9Ai/X5zsPg+C2ORxGExpO5XoClFKqWDmc771nDZ/5GlKH0X7LI+PoKRmJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Oo9oQ2z4m9IXiJgn9l+5PqAvg4SF69EJMhhx+kA2iI=;
 b=d+b5p6gh+u2JRZqpQtqX5o6nc0xdffQz6ak2EI++MO1HsYcBs/nMMV3IOFf1yWYaDQbQyVDKWDYQ1QHsINPiQKzVwD+wDUnrHUzglPbtpufoj6JNKkC0HlA+i7CCq9uyHAC3BaLcxresfMK4QgX+2/HAAEuGvDPHFhZY7aTAEpnl7BPJDA8lFSHfe9UuSZd5TXmCwHZz8nBRBjy/68OVIgLZkSPs6vAeOFEO4qAvDbxxaEXUj1haBfSJxAidfk+oeyXUoJ3OQE/PdkjtGgtTd55k17xwt68sjmwUqXB7SW4Coiu7irgHhYStnEDbIkKivFkaniN4HF6LJwwMwj9vxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Oo9oQ2z4m9IXiJgn9l+5PqAvg4SF69EJMhhx+kA2iI=;
 b=mC/haqQJUHULlREqjiydtFi6zpxd1yCzzrhQtjPWBJvu0XZo+cUvNngpO5h9E+WrXYNcxJg7etn67YAeXCHL4GONuSruQNXloz0E8B88ppsBlvO/EsFPvkhvqDrJKNmJIDsqhTM4AqTCuCtfbsHaNdSd4ZpYKUkmg9ZXhOuF5tM=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB6192.namprd05.prod.outlook.com (20.178.244.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.14; Wed, 9 Oct 2019 18:52:34 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::286f:c413:5df1:4eb9]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::286f:c413:5df1:4eb9%4]) with mapi id 15.20.2347.014; Wed, 9 Oct 2019
 18:52:34 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?iso-8859-1?Q?Thomas_Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
CC:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>
Subject: Re: [PATCH v4 3/9] mm: pagewalk: Don't split transhuge pmds when a
 pmd_entry is present
Thread-Topic: [PATCH v4 3/9] mm: pagewalk: Don't split transhuge pmds when a
 pmd_entry is present
Thread-Index: AQHVfbjttG4Vh+cm+UmzThOYz5Zjow==
Date:   Wed, 9 Oct 2019 18:52:34 +0000
Message-ID: <MN2PR05MB6141B981C2CAB4955D59747EA1950@MN2PR05MB6141.namprd05.prod.outlook.com>
References: <20191008091508.2682-1-thomas_os@shipmail.org>
 <20191008091508.2682-4-thomas_os@shipmail.org>
 <20191009152737.p42w7w456zklxz72@box>
 <CAHk-=wh4waroKr-Xtcv+5pTxBcHxGEj-g73eQvXVawML_C0EXw@mail.gmail.com>
 <03d85a6a-e24a-82f4-93b8-86584b463471@shipmail.org>
 <CAHk-=whhdRSqjX5wy1LzFYnOG58UztpifkNvbxBcTVbT3Mzv4g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea50289d-6ab6-4c85-2ac9-08d74ce9d8ca
x-ms-traffictypediagnostic: MN2PR05MB6192:
x-microsoft-antispam-prvs: <MN2PR05MB6192A9627726E34D56025814A1950@MN2PR05MB6192.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(189003)(199004)(76176011)(8676002)(4326008)(7416002)(71190400001)(3846002)(2906002)(229853002)(7696005)(81156014)(81166006)(71200400001)(66556008)(99286004)(316002)(66946007)(52536014)(102836004)(6506007)(14454004)(66066001)(66446008)(64756008)(74316002)(53546011)(54906003)(55016002)(6436002)(66476007)(6116002)(91956017)(6246003)(9686003)(110136005)(76116006)(486006)(476003)(446003)(86362001)(33656002)(26005)(25786009)(8936002)(186003)(5660300002)(66574012)(305945005)(478600001)(14444005)(256004)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6192;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zP9TSjqv1/0zyNZB9VwcXYxKFcvCMpgYaYuFKGs2e7G4uKl3c2AvaJJLOcjB1ddmxgNb07tpSRfwMwKKJoYq3QVemiy3Og6C4WsWKHvo1sb8uhDMrORk+wwmw3hpfdiJZvKULAYGw9YfymImVESW/B2+GyBPYZ1Wmtz7NhtyweglBCtiXHx8/G0twC/NRS3wNjKc/o1zkfr9UEY9Rki/YFp2mZ0tzcCyzodTHesiq5xXbzxUP0p85e/UqXD/fhbBmH77OszjIFH93QU4RRNh2jV9RMMt18iVSXO0frpz/IPSeIQnbkkbmnrPtmnSTuzGItY8/Kue6+9guAtXh6oFTP02m16padmn7uEqcFYzn2FHHeTaCrN+uQQW6V/U0nv2U2933IXrGBGZFxtn5ge4llyOxSoIwkHI41WN3enXXtY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea50289d-6ab6-4c85-2ac9-08d74ce9d8ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 18:52:34.2494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KZW7/Ls3/MMTeBBBMtwlKRlY+7EgTZRhgmSmwWc+0iHgT3Z6qb4NzArk79ldLmHvCNYdpqcZf9AC+a+rhwhU4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=0A=
=0A=
On 10/9/19 7:17 PM, Linus Torvalds wrote:=0A=
> On Wed, Oct 9, 2019 at 10:03 AM Thomas Hellstr=F6m (VMware)=0A=
> <thomas_os@shipmail.org> wrote:=0A=
>> Nope, it handles the hugepages by ignoring them, since they should be=0A=
>> read-only, but if pmd_entry() was called with something else than a=0A=
>> hugepage, then it requests the fallback, but never a split.=0A=
> But  PAGE_WALK_FALLBACK _is_ a split.=0A=
>=0A=
> Oh, except you did this=0A=
>=0A=
> -               split_huge_pmd(walk->vma, pmd, addr);=0A=
> +               if (!ops->pmd_entry)=0A=
> +                       split_huge_pmd(walk->vma, pmd, addr);=0A=
>=0A=
>=0A=
> so it avoids the split.=0A=
>=0A=
> No, that's unacceptable. And makes no sense anyway. If it doesn't=0A=
> split the pmd, then it shouldn't walk the pte's - because they don't=0A=
> exist. And if it's not a hugepmd, then the split is a no-op, so the=0A=
> test makes no sense.=0A=
>=0A=
> I hadn't noticed that part of the patch. That simply can't be right. I=0A=
> don't think you've tested this, because you never actually have=0A=
> hugepages, do you?=0A=
>=0A=
> You didn't notice or realize that split_huge_pmd() just does that=0A=
>=0A=
>                 if (is_swap_pmd(*____pmd) || pmd_trans_huge(*____pmd)   \=
=0A=
>                                         || pmd_devmap(*____pmd))        \=
=0A=
>=0A=
> thing and doesn't do anythign at all if it's not huge.=0A=
>=0A=
> So no. That code makes no sense at all, and I didn't realize how=0A=
> senseless it was, becasue I stupidly missed that "make the split=0A=
> conditional" - which is insane and wrong - and I thought that you=0A=
> wanted PAGE_WALK_FALLBACK to split a pmd and fall back to per-pte=0A=
> entries, which is what the name implies.=0A=
>=0A=
> But that's not what you wanted at all.=0A=
>=0A=
> Just get rid of PAGE_WALK_FALLBACK entirely then, and make the rule be=0A=
> that a zero return value just means "split and do ptes". Which is what=0A=
> you want (see above why "split" simply is wrong, and isn't an issue=0A=
> for you anyway.=0A=
>=0A=
> That won't change any existing cases, since even if they do have a=0A=
> zero return value, they don't have a pte_entry() callback, so they=0A=
> won't do that "split and do ptes" anyway.=0A=
>=0A=
>              Linus=0A=
>=0A=
Hmm, so we have the following cases we need to handle when returning=0A=
from the pmd_entry() handler.=0A=
=0A=
1) Huge pmd was handled - Returns 0 and continues.=0A=
2) A pmd is otherwise unstable, typically someone just zapped a huge=0A=
pmd. Returns PAGE_WALK_FALLBACK, gets caught in the pmd_trans_unstable()=0A=
test and retries.=0A=
3) A pte directory - Returns PAGE_WALK_FALLBACK, falls through, avoids=0A=
the split and continues to the next level. Yeah that split avoidance=0A=
test is indeed made unnecessary by the preceding pmd_trans_unstable() test.=
=0A=
=0A=
-               split_huge_pmd(walk->vma, pmd, addr);=0A=
+               if (!ops->pmd_entry)=0A=
+                       split_huge_pmd(walk->vma, pmd, addr);=0A=
=0A=
But as the commit message says, PAGE_WALK_FALLBACK is necessary to have=0A=
a virtual address range being handled once and only once. Therefore we=0A=
must distinguish between 1) and 2) since 2) must be retried until it's=0A=
handled correctly.=0A=
=0A=
So we need the PAGE_WALK_FALLBACK. And if we instead were to combine 1)=0A=
and 3) in a single return value and use, for example PAGE_WALK_RETRY for=0A=
2)  the following could happen.=0A=
=0A=
a) we handle the huge pmd and return 0 from pte_entry().=0A=
b) another process splits it.=0A=
c) we fall through to the pte level and handle the same address range=0A=
again...=0A=
=0A=
So to summarize, yes the test in the code you cite is unnecessary. But=0A=
if we want to guarantee a virtual address range being handled once and=0A=
only once we need the PAGE_WALK_FALLBACK, (perhaps renamed). If not, we=0A=
can do without it similar to your original patch.=0A=
=0A=
Thanks,=0A=
=0A=
/Thomas=0A=
=0A=
=0A=
=0A=
