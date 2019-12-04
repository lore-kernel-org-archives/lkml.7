Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CB7C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5981F20674
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="rPpnFb1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfLDRvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:51:12 -0500
Received: from mail-eopbgr690054.outbound.protection.outlook.com ([40.107.69.54]:21204
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727852AbfLDRvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:51:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Moz9WYazWrVbRcRjn7BEIGoKcDvqIpS2Y9/9eT7Dvk/jGL8VsM3tkgLmXAdCjzfsRezIOPiDnK5XODOaTlzPoz+bVKtBBd6LFtxW6NeO8IVEPWasQbjBLUq+6fNq417pXq80tQnrEUtICjLrZPRmZr+Ufs9Z5TcHgAM+wjAExd8/NCRpPNiG0yTA4RIET3bOnpFToG5IgPfLwU386CXIDwoyNlBnbE9LVHxBeFqMVz7tWHiLm3L+W9az6jir8pKPgQZl4F9EAPVVXqXVmhHrNg2LVuRxeAIrTYLcUmziVTYYQSNz8bLanPNrT3kSqad5h8JkREiNkuv96AEueQJLrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=resmRhbbEdLQiaABkrvWa7UP0bKuajx8zrPkJ7jGyEY=;
 b=RLOIo2O9jCIv5K1mp2DNT1bavg2sTWDx8k/mlGGN5K7cNh24//mZIDXBza4aYQyjguHHw5RRYO6PBnZLUr+i/pVSaaOHVeIblvZFQdV2mMRZbPheEUniFvlRQSu4l5lFIvARQ+m6Di+JIYXUOs7rZGEj6ytABfDCzf+0I5GsvTTmAVt4ajUzrRaHba27xSqJF0ns3yUuOXj13n6cedEpWgTXW6BV07DpIMQPCvV+GwNdvyBtf8aeqdSdIovnZpbte1l1lDciFcjvEsmSd18MYHwJ8y4lL9aEysZzNFN/L8q3pe7JuG00AD2TqxJlsAgcmHtGx+Blf1JTGLYv2Yp/CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=resmRhbbEdLQiaABkrvWa7UP0bKuajx8zrPkJ7jGyEY=;
 b=rPpnFb1z0BrL2i/CtPpIowXppmzE+RFBwCy20iOA6KYgnUb6VY61TlHSn8ElnbiSP/VkG+yIpnO6+DdzvvMIYHikdYZnXz7FQdjMHQO93iw4EgPnZEvApsTOIZ+OFa2p1RTYJFArh4gYuALyT9tcwKOu9rFZBqwJtodLgqWed6k=
Received: from MN2PR05MB6141.namprd05.prod.outlook.com (20.178.241.217) by
 MN2PR05MB6111.namprd05.prod.outlook.com (20.178.240.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.5; Wed, 4 Dec 2019 17:51:06 +0000
Received: from MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::611e:6a6b:9109:5aa8]) by MN2PR05MB6141.namprd05.prod.outlook.com
 ([fe80::611e:6a6b:9109:5aa8%7]) with mapi id 15.20.2516.003; Wed, 4 Dec 2019
 17:51:06 +0000
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     Steven Price <steven.price@arm.com>,
        David Hildenbrand <david@redhat.com>
CC:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <James.Morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH v15 00/23] Generic page walk and ptdump
Thread-Topic: [PATCH v15 00/23] Generic page walk and ptdump
Thread-Index: AQHVqsB6USxvVndKC0O+X8JyjIw6Ng==
Date:   Wed, 4 Dec 2019 17:51:06 +0000
Message-ID: <MN2PR05MB61416E0CF8A99C91CD69FC43A15D0@MN2PR05MB6141.namprd05.prod.outlook.com>
References: <20191101140942.51554-1-steven.price@arm.com>
 <1572896147.5937.116.camel@lca.pw>
 <7B040741-EC8A-4CC0-964B-4046AE2E617A@lca.pw>
 <16da6118-ac4d-a165-6202-0731a776ac72@arm.com>
 <911fac4a-2204-f994-a101-16a60fba12e8@redhat.com>
 <0FA196FD-3FCD-431A-AA3E-21BF00EA07DC@lca.pw>
 <9d5f1689-db82-a6da-d51d-08070aa4bad5@redhat.com>
 <20191204163235.GA1597@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thellstrom@vmware.com; 
x-originating-ip: [155.4.205.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19d7ffd5-9909-4955-959f-08d778e289b5
x-ms-traffictypediagnostic: MN2PR05MB6111:
x-microsoft-antispam-prvs: <MN2PR05MB611135ED1D2BF841A8BBA04CA15D0@MN2PR05MB6111.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(55674003)(43544003)(189003)(199004)(76176011)(7696005)(45080400002)(229853002)(14454004)(6436002)(81166006)(81156014)(66476007)(66556008)(64756008)(66946007)(4326008)(86362001)(33656002)(8676002)(2906002)(76116006)(91956017)(55016002)(66446008)(966005)(6246003)(6306002)(14444005)(3846002)(71200400001)(102836004)(478600001)(6116002)(9686003)(71190400001)(8936002)(7416002)(316002)(52536014)(6506007)(53546011)(26005)(186003)(74316002)(5660300002)(99286004)(305945005)(7736002)(110136005)(25786009)(54906003)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR05MB6111;H:MN2PR05MB6141.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x2OLX0yjNFcT1EEx1vxWzhLV6rn+WQMnWMeFUDRfUFmrprXvctVTrM+BhE2JgyiF5jm3z2ebXQ0633TH+uiv/exSE2q7qjruCikK1YTzU8Yp07nwIu7UJBOOZBGjWQKDzoiv9aMZnMKu+8+r9GgY7Yk/mldpIu2oy4acLge/muez80rj6PNPpN0NXvup1TWG+jlwv5ZZ2HJcZBIik8HLqq5rmjSjzUe+lBL8C4qRwCwyLgNhFFjBie/svI+CvhfQBlTNy26LVcQHoUe7FIElOijQlquHNrepPpZg8NdUGsSO/Ofl4ihW5HttLhVaW3CYNIuDT6uInGD7H8wzVKk4xCQnimdyjdJ8L+FC7/G+H1n0fHqVKxhwMwRqzsdMSra//tG92L4A9jxhs764r6W0coz33xOsa1nVO1nzfL7Ksz8S/VW2CxNJRl4l3jsY93hvn75o+vMkO7nw88Ib6FtlhtmkoKgw0lLaL3manGu+vigH/YlIkfo7bTdluV04jJYExvzt/hlhBZWvnOo4QsephwVWD/oA4/YPh8UpKEEZBqoSrGLfxVAKng9bMF7bU4WuybOycYCiMe4k4PPg5UsTHw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d7ffd5-9909-4955-959f-08d778e289b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 17:51:06.2246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 777infu+mfbHdoYbtVmWIen0OrDr1SrCuKCYq9XkVJogJMTS+a3y30aoVSkccATQUyXI1p5ZxHTnUAAU+DPn/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/19 5:32 PM, Steven Price wrote:=0A=
> On Wed, Dec 04, 2019 at 02:56:58PM +0000, David Hildenbrand wrote:=0A=
>> On 04.12.19 15:54, Qian Cai wrote:=0A=
>>>=0A=
>>>> On Dec 3, 2019, at 6:02 AM, David Hildenbrand <david@redhat.com> wrote=
:=0A=
>>>>=0A=
>>>> On 06.11.19 16:05, Steven Price wrote:=0A=
>>>>> On 06/11/2019 13:31, Qian Cai wrote:=0A=
>>>>>>=0A=
>>>>>>> On Nov 4, 2019, at 2:35 PM, Qian Cai <cai@lca.pw> wrote:=0A=
>>>>>>>=0A=
>>>>>>> On Fri, 2019-11-01 at 14:09 +0000, Steven Price wrote:=0A=
>>>>> [...]=0A=
>>>>>>>> Changes since v14:=0A=
>>>>>>>> https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Flore.kernel.org%2Flkml%2F20191028135910.33253-1-steven.price%40arm.com%2F=
&amp;data=3D02%7C01%7Cthellstrom%40vmware.com%7C9f50ca595f81432eff5b08d778d=
7968a%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C1%7C637110739727088799&amp;s=
data=3DB3n6TFU7hluQyAXUOEaHBAGNC8mhscMfxSJi%2FrFr%2Flo%3D&amp;reserved=3D0=
=0A=
>>>>>>>> * Switch walk_page_range() into two functions, the existing=0A=
>>>>>>>>   walk_page_range() now still requires VMAs (and treats areas with=
out a=0A=
>>>>>>>>   VMA as a 'hole'). The new walk_page_range_novma() ignores VMAs a=
nd=0A=
>>>>>>>>   will report the actual page table layout. This fixes the previou=
s=0A=
>>>>>>>>   breakage of /proc/<pid>/pagemap=0A=
>>>>>>>> * New patch at the end of the series which reduces the 'level' num=
bers=0A=
>>>>>>>>   by 1 to simplify the code slightly=0A=
>>>>>>>> * Added tags=0A=
>>>>>>> Does this new version also take care of this boot crash seen with v=
14? Suppose=0A=
>>>>>>> it is now breaking CONFIG_EFI_PGT_DUMP=3Dy? The full config is,=0A=
>>>>>>>=0A=
>>>>>>> https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fraw.githubusercontent.com%2Fcailca%2Flinux-mm%2Fmaster%2Fx86.config&amp;da=
ta=3D02%7C01%7Cthellstrom%40vmware.com%7C9f50ca595f81432eff5b08d778d7968a%7=
Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C1%7C637110739727088799&amp;sdata=3D=
ymVh49kh7VL9yseRdkjSbTwRh%2B7yBXxhK7QMTUzwn4U%3D&amp;reserved=3D0=0A=
>>>>>>>=0A=
>>>>>> V15 is indeed DOA here.=0A=
>>>>> Thanks for finding this, it looks like EFI causes issues here. The be=
low fixes=0A=
>>>>> this for me (booting in QEMU).=0A=
>>>>>=0A=
>>>>> Andrew: do you want me to send out the entire series again for this f=
ix, or=0A=
>>>>> can you squash this into mm-pagewalk-allow-walking-without-vma.patch?=
=0A=
>>>>>=0A=
>>>>> Thanks,=0A=
>>>>>=0A=
>>>>> Steve=0A=
>>>>>=0A=
>>>>> ---8<---=0A=
>>>>> diff --git a/mm/pagewalk.c b/mm/pagewalk.c=0A=
>>>>> index c7529dc4f82b..70dcaa23598f 100644=0A=
>>>>> --- a/mm/pagewalk.c=0A=
>>>>> +++ b/mm/pagewalk.c=0A=
>>>>> @@ -90,7 +90,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long=
 addr, unsigned long end,=0A=
>>>>>  			split_huge_pmd(walk->vma, pmd, addr);=0A=
>>>>>  			if (pmd_trans_unstable(pmd))=0A=
>>>>>  				goto again;=0A=
>>>>> -		} else if (pmd_leaf(*pmd)) {=0A=
>>>>> +		} else if (pmd_leaf(*pmd) || !pmd_present(*pmd)) {=0A=
>>>>>  			continue;=0A=
>>>>>  		}=0A=
>>>>>=0A=
>>>>> @@ -141,7 +141,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned lo=
ng addr, unsigned long end,=0A=
>>>>>  			split_huge_pud(walk->vma, pud, addr);=0A=
>>>>>  			if (pud_none(*pud))=0A=
>>>>>  				goto again;=0A=
>>>>> -		} else if (pud_leaf(*pud)) {=0A=
>>>>> +		} else if (pud_leaf(*pud) || !pud_present(*pud)) {=0A=
>>>>>  			continue;=0A=
>>>>>  		}=0A=
>>>>>=0A=
>>>>>=0A=
>>>> Even with this fix, booting for me under QEMU fails. See=0A=
>>>>=0A=
>>>> https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flo=
re.kernel.org%2Flinux-mm%2Fb7ce62f2-9a48-6e48-6685-003431e521aa%40redhat.co=
m%2F&amp;data=3D02%7C01%7Cthellstrom%40vmware.com%7C9f50ca595f81432eff5b08d=
778d7968a%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C1%7C637110739727088799&a=
mp;sdata=3DfRuLrmrzNEkU2MFzSVdyVyXyRoyZ95yZOYuy7aMSi7A%3D&amp;reserved=3D0=
=0A=
>>>>=0A=
>>> Yes, for some reasons, this starts to crash on almost all arches here, =
so it might be worth=0A=
>>> for Andrew to revert those in the meantime while allowing Steven to rew=
ork.=0A=
>> I agree, this produces too much noise.=0A=
> I've bisected this problem and it's a merge conflict with:=0A=
>=0A=
> ace88f1018b8 ("mm: pagewalk: Take the pagetable lock in walk_pte_range()"=
)=0A=
>=0A=
> Reverting that commit "fixes" the problem. That commit adds a call to=0A=
> pte_offset_map_lock(), however that isn't necessarily safe when=0A=
> considering an "unusual" mapping in the kernel. Combined with my patch=0A=
> set this leads to the BUG when walking the kernel's page tables.=0A=
>=0A=
> At this stage I think it's best if Andrew drops my series and I'll try=0A=
> to rework it on top -rc1 fixing up this conflict and the other x86=0A=
> 32-bit issue that has cropped up.=0A=
=0A=
Hi,=0A=
=0A=
Unfortunately I wasn't aware of that conflict.=0A=
=0A=
Perhaps something similar to this=0A=
=0A=
https://elixir.bootlin.com/linux/v5.4/source/mm/memory.c#L2012=0A=
=0A=
would fix at least this particular issue?=0A=
=0A=
/Thomas=0A=
=0A=
=0A=
=0A=
=0A=
>=0A=
> Steve=0A=
>=0A=
=0A=
