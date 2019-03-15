Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95FFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D953218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eInfochipsIndia.onmicrosoft.com header.i=@eInfochipsIndia.onmicrosoft.com header.b="fhCS1D4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfCOKMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:12:05 -0400
Received: from mail-eopbgr1320047.outbound.protection.outlook.com ([40.107.132.47]:41798
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727354AbfCOKME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 06:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eInfochipsIndia.onmicrosoft.com; s=selector1-einfochips-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7A+K015Dp1610DNrj3TSMyR/o0jnPrfbGAkdOndjZM=;
 b=fhCS1D4kaGh/st8JbjYWr35k6EgbXWnqtkToFN823LoEsjHK8p14s8VzDatC2jel+2WbL9wXmbpUss9oG76IaGG5QnA0Xuu5d1GG4f1kB6iG3Jr3WQw3XtfgN/ZY4+wkjZrQlRA8Sm2MD/Qp2lxWwRciawTXCf/4rgk88dnrgPo=
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com (20.177.88.78) by
 SG2PR02MB3257.apcprd02.prod.outlook.com (20.177.86.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Fri, 15 Mar 2019 10:11:57 +0000
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::3180:828f:84bc:ea3]) by SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::3180:828f:84bc:ea3%4]) with mapi id 15.20.1686.021; Fri, 15 Mar 2019
 10:11:57 +0000
From:   Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@kernel.org>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>,
        "hillf.zj@alibaba-inc.com" <hillf.zj@alibaba-inc.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>
Subject: Re: Re: [External] Re: vmscan: Reclaim unevictable pages
Thread-Topic: Re: [External] Re: vmscan: Reclaim unevictable pages
Thread-Index: AQHU2jnLyCfGly2dbEuVu40O8aA4saYKwYIOgAACnP2AAArTAIAAAt0egAAJfgCAABwNcoAAK5EogAESNQaAAERN0g==
Date:   Fri, 15 Mar 2019 10:11:57 +0000
Message-ID: <SG2PR02MB3098E6F2C4BAEB56AE071EDCE8440@SG2PR02MB3098.apcprd02.prod.outlook.com>
References: <SG2PR02MB3098A05E09B0D3F3CB1C3B9BE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <SG2PR02MB309806967AE91179CAFEC34BE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <SG2PR02MB3098B751EC6B8E32806A42FBE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <20190314084120.GF7473@dhcp22.suse.cz>
 <SG2PR02MB309894F6D7DF9148846088F3E84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>,<226a92b9-94c5-b859-c54b-3aacad3089cc@virtuozzo.com>,<SG2PR02MB3098299456FB6AE2FD822C4CE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>,<SG2PR02MB30988333AD658F8124070ABEE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>,<SG2PR02MB3098AB587F4BFCD6B9D042FDE8440@SG2PR02MB3098.apcprd02.prod.outlook.com>
In-Reply-To: <SG2PR02MB3098AB587F4BFCD6B9D042FDE8440@SG2PR02MB3098.apcprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.suryawanshi@einfochips.com; 
x-originating-ip: [14.98.130.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddb4fa11-3e0a-4afa-8577-08d6a92ea842
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SG2PR02MB3257;
x-ms-traffictypediagnostic: SG2PR02MB3257:|SG2PR02MB3257:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SG2PR02MB32570CC6359D508C637EF0B5E8440@SG2PR02MB3257.apcprd02.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39850400004)(366004)(396003)(376002)(199004)(189003)(6506007)(55236004)(55016002)(110136005)(6116002)(3846002)(478600001)(53546011)(74316002)(76176011)(9686003)(6306002)(26005)(53936002)(966005)(7696005)(105586002)(106356001)(102836004)(52536014)(4326008)(25786009)(66574012)(33656002)(81156014)(8676002)(81166006)(5660300002)(316002)(6246003)(305945005)(86362001)(93886005)(71200400001)(7736002)(229853002)(68736007)(476003)(99286004)(44832011)(11346002)(186003)(71190400001)(54906003)(97736004)(8936002)(93156006)(2906002)(14454004)(78486014)(256004)(14444005)(5024004)(486006)(2501003)(6436002)(446003)(66066001)(2940100002);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR02MB3257;H:SG2PR02MB3098.apcprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: einfochips.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 82zf/g4YP63bQJGCHWulCchJQEIHNvCAuCpVzSNGp0KnPhmdaZSZkKVvtxX+yw6xHqY1a6mFdjWH/mpR3sIDKN0wnFq4BOEpTXFGRjfQ9U3tIvg1XuUKHwg6z7G4DvmBFEYUq2wYnRLsIWFKvGO4za9nug95xCy9rHhF0BXw8SgJMRgpEQQ8N51XMs+3ybFGRYXvQ4Y0oqKqgt2MBbjY60s0UyHI2cMkUm7pj+a6h6yKigePA6hxhwTmRuiMD4s0Ctxv10S6OYtaQLwOsssA8DvlV00G7W2gCCCoWZ2fmGeznW+B1NKzTtLs5Y5ePCj6mI2NVoyofWlnL0WbKfGrWeUlb/bTqq/kQBAQndMDyM7QjeSly3rJ5gD+ffnMMepaXkGG3wRQkmi9Y2TjVYqNBZGrCqPFbES6k8sRtKPe3zA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: einfochips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb4fa11-3e0a-4afa-8577-08d6a92ea842
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 10:11:57.3403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0adb040b-ca22-4ca6-9447-ab7b049a22ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3257
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ cc Aneesh kumar, Anshuman, Hillf, Vlastimil]

From: Pankaj Suryawanshi
Sent: 15 March 2019 11:35:05
To: Kirill Tkhai; Michal Hocko
Cc: linux-kernel@vger.kernel.org; minchan@kernel.org; linux-mm@kvack.org
Subject: Re: Re: [External] Re: vmscan: Reclaim unevictable pages



[ cc linux-mm ]


From: Pankaj Suryawanshi
Sent: 14 March 2019 19:14:40
To: Kirill Tkhai; Michal Hocko
Cc: linux-kernel@vger.kernel.org; minchan@kernel.org
Subject: Re: Re: [External] Re: vmscan: Reclaim unevictable pages



Hello ,

Please ignore the curly braces, they are just for debugging.

Below is the updated patch.


diff --git a/mm/vmscan.c b/mm/vmscan.c
index be56e2e..12ac353 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -998,7 +998,7 @@ static unsigned long shrink_page_list(struct list_head =
*page_list,
                sc->nr_scanned++;

                if (unlikely(!page_evictable(page)))
-                       goto activate_locked;
+                      goto cull_mlocked;

                if (!sc->may_unmap && page_mapped(page))
                        goto keep_locked;
@@ -1331,7 +1331,12 @@ static unsigned long shrink_page_list(struct list_he=
ad *page_list,
                } else
                        list_add(&page->lru, &free_pages);
                continue;
-
+cull_mlocked:
+                if (PageSwapCache(page))
+                        try_to_free_swap(page);
+                unlock_page(page);
+                list_add(&page->lru, &ret_pages);
+                continue;
 activate_locked:
                /* Not a candidate for swapping, so reclaim swap space. */
                if (PageSwapCache(page) && (mem_cgroup_swap_full(page) ||



Regards,
Pankaj


From: Kirill Tkhai <ktkhai@virtuozzo.com>
Sent: 14 March 2019 14:55:34
To: Pankaj Suryawanshi; Michal Hocko
Cc: linux-kernel@vger.kernel.org; minchan@kernel.org
Subject: Re: Re: [External] Re: vmscan: Reclaim unevictable pages


On 14.03.2019 11:52, Pankaj Suryawanshi wrote:
>
> I am using kernel version 4.14.65 (on Android pie [ARM]).
>
> No additional patches applied on top of vanilla.(Core MM).
>
> If  I change in the vmscan.c as below patch, it will work.

Sorry, but 4.14.65 does not have braces around trylock_page(),
like in your patch below.

See     https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tr=
ee/mm/vmscan.c?h=3Dv4.14.65

[...]

>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index be56e2e..2e51edc 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -990,15 +990,17 @@ static unsigned long shrink_page_list(struct list_=
head *page_list,
>>                  page =3D lru_to_page(page_list);
>>                  list_del(&page->lru);
>>
>>                 if (!trylock_page(page)) {
>>                          goto keep;
>>                 }

***************************************************************************=
***************************************************************************=
******* eInfochips Business Disclaimer: This e-mail message and all attachm=
ents transmitted with it are intended solely for the use of the addressee a=
nd may contain legally privileged and confidential information. If the read=
er of this message is not the intended recipient, or an employee or agent r=
esponsible for delivering this message to the intended recipient, you are h=
ereby notified that any dissemination, distribution, copying, or other use =
of this message or its attachments is strictly prohibited. If you have rece=
ived this message in error, please notify the sender immediately by replyin=
g to this message and please delete it from your computer. Any views expres=
sed in this message are those of the individual sender unless otherwise sta=
ted. Company has taken enough precautions to prevent the spread of viruses.=
 However the company accepts no liability for any damage caused by any viru=
s transmitted by this email. **********************************************=
***************************************************************************=
************************************
