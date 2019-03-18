Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381EBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B572083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 08:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eInfochipsIndia.onmicrosoft.com header.i=@eInfochipsIndia.onmicrosoft.com header.b="YMOAX+DK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfCRI4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 04:56:31 -0400
Received: from mail-eopbgr1300079.outbound.protection.outlook.com ([40.107.130.79]:61443
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726291AbfCRI4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 04:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eInfochipsIndia.onmicrosoft.com; s=selector1-einfochips-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuED9FEz9qLIbldpjz97LKTfT7m9qoG44WboQqMWJ64=;
 b=YMOAX+DK4f5xlHxC73foAK4R3RdvH1YgtBXe/qukP+09fVqHWcLjggelBKvi3jdLpB2+TqRaLTMxBqIV7dZWApEiwLTHbUbVyPZm4MB7BR65E26l9CJW6SNBlIQ5a0/ijzWbYdyEz8l4jtRcqEFmklSePEFNAPtfTpuhjPGLypQ=
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com (20.177.88.78) by
 SG2PR02MB4220.apcprd02.prod.outlook.com (20.178.158.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Mon, 18 Mar 2019 08:56:22 +0000
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::f432:20e4:2d22:e60b]) by SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::f432:20e4:2d22:e60b%4]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 08:56:22 +0000
From:   Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@kernel.org>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>
Subject: Re: vmscan: Reclaim unevictable pages
Thread-Topic: vmscan: Reclaim unevictable pages
Thread-Index: AQHU3Wh1dtxb99h/iUqWjmlP8cXYrA==
Date:   Mon, 18 Mar 2019 08:56:21 +0000
Message-ID: <SG2PR02MB3098EEB68EBFAA0BA1134DF3E8470@SG2PR02MB3098.apcprd02.prod.outlook.com>
References: <SG2PR02MB3098A05E09B0D3F3CB1C3B9BE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <SG2PR02MB309806967AE91179CAFEC34BE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <SG2PR02MB3098B751EC6B8E32806A42FBE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <20190314084120.GF7473@dhcp22.suse.cz>
 <SG2PR02MB309894F6D7DF9148846088F3E84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>,<226a92b9-94c5-b859-c54b-3aacad3089cc@virtuozzo.com>,<SG2PR02MB3098299456FB6AE2FD822C4CE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>,<SG2PR02MB30988333AD658F8124070ABEE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>,<SG2PR02MB3098AB587F4BFCD6B9D042FDE8440@SG2PR02MB3098.apcprd02.prod.outlook.com>,<SG2PR02MB3098E6F2C4BAEB56AE071EDCE8440@SG2PR02MB3098.apcprd02.prod.outlook.com>,<SG2PR02MB3098361719B67448CB6FF28CE8470@SG2PR02MB3098.apcprd02.prod.outlook.com>
In-Reply-To: <SG2PR02MB3098361719B67448CB6FF28CE8470@SG2PR02MB3098.apcprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.suryawanshi@einfochips.com; 
x-originating-ip: [14.98.130.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88452476-3878-4548-e4b6-08d6ab7f982b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:SG2PR02MB4220;
x-ms-traffictypediagnostic: SG2PR02MB4220:|SG2PR02MB4220:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SG2PR02MB4220E8CB9EC7A1BF07AAAEF9E8470@SG2PR02MB4220.apcprd02.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39840400004)(376002)(346002)(396003)(199004)(189003)(478600001)(446003)(78486014)(966005)(256004)(7736002)(8676002)(305945005)(74316002)(81156014)(5024004)(81166006)(106356001)(66574012)(55016002)(4326008)(11346002)(14444005)(14454004)(6436002)(25786009)(9686003)(97736004)(186003)(2501003)(6306002)(86362001)(93156006)(53936002)(5660300002)(26005)(6246003)(2940100002)(52536014)(102836004)(55236004)(33656002)(6506007)(229853002)(53546011)(71190400001)(71200400001)(476003)(2906002)(99286004)(8936002)(486006)(110136005)(76176011)(7696005)(66066001)(105586002)(93886005)(44832011)(3846002)(6116002)(68736007)(316002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR02MB4220;H:SG2PR02MB3098.apcprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: einfochips.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bTtbiYo0T4LQWg94SHQbzuzpk7jyCwrhe9bNB6qOcI0p+2Wo9jY5vBHSHhGxf+2P9gDJMZAz2M8q5Jc/GEkB997kgNQ09J993vrD31GVZQwnUVFzbYcGo4s3jgERHT5cYIfzqQRm58NyrdydvtzrH7UmBD4C5J7aak0jbuN66bATsXd2ddxzZdIxO39/j+RyL2UY0TYUY4xHsNy6VtYBOD+vm+bfaa77Mau+Sb35TisRuu9eQ45wa4Gh+iD2yNcLKmlXPzAAoStPqdZxRxI2LAADwxcY/3amkCjpUNdRJqnyl0aiIu+oQf9K5pa+9AwKR/Jgf4p+7TijmUl0jCkEAeoxWgXgiLO/JXtpHLKO1FZu7Ov9fjD7Pt9ld0n4vrtsyOxpapguGROEYw1sIqOTnyAdX70m20i9G0pS/2U8Guw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: einfochips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88452476-3878-4548-e4b6-08d6ab7f982b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 08:56:21.9692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0adb040b-ca22-4ca6-9447-ab7b049a22ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

shrink_page_list() returns , number of pages reclaimed, when pages is unevi=
ctable it returns VM_BUG_ON_PAGE(PageLRU(page) || PageUnevicatble(page),pag=
e);

We can add the unevictable pages in reclaim list in shrink_page_list(), ret=
urn total number of reclaim pages including unevictable pages, let the call=
er handle unevictable pages.

I think the problem is shrink_page_list is awkard. If page is unevictable i=
t goto activate_locked->keep_locked->keep lables, keep lable list_add the u=
nevictable pages and throw the VM_BUG instead of passing it to caller while=
 it relies on caller for non-reclaimed-non-unevictable page's putback.
I think we can make it consistent so that shrink_page_list could return non=
-reclaimed pages via page_list and caller can handle it. As an advance, it =
could try to migrate mlocked pages without retrial.


Below is the issue of CMA_ALLOC of large size buffer : (Kernel version - 4.=
14.65 (On Android pie [ARM])).

[   24.718792] page dumped because: VM_BUG_ON_PAGE(PageLRU(page) || PageUne=
victable(page))
[   24.726949] page->mem_cgroup:bd008c00
[   24.730693] ------------[ cut here ]------------
[   24.735304] kernel BUG at mm/vmscan.c:1350!
[   24.739478] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM


Below is the patch which solved this issue :

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




It fixes the below issue.

1. Large size buffer allocation using cma_alloc successful with unevictable=
 pages.

cma_alloc of current kernel will fail due to unevictable page

Please let me know if anything i am missing.

Regards,
Pankaj



From: Pankaj Suryawanshi
Sent: 18 March 2019 13:15:22
To: Kirill Tkhai; Michal Hocko; aneesh.kumar@linux.ibm.com
Cc: linux-kernel@vger.kernel.org; minchan@kernel.org; linux-mm@kvack.org; k=
handual@linux.vnet.ibm.com; vbabka@suse.cz
Subject: Re: Re: [External] Re: vmscan: Reclaim unevictable pages



It fixes the below issue.

1. Large size buffer allocation using cma_alloc successful with unevictable=
 pages.

cma_alloc of current kernel will fail due to unevictable pages.

Solved the below issue of cma_alloc

---------------------------------------------------------------------------=
--------------------------------------------------------------
 [   24.718792] page dumped because: VM_BUG_ON_PAGE(PageLRU(page) || PageUn=
evictable(page))
 [   24.726949] page->mem_cgroup:bd008c00
 [   24.730693] ------------[ cut here ]------------
 [   24.735304] kernel BUG at mm/vmscan.c:1350!
 [   24.739478] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
---------------------------------------------------------------------------=
--------------------------------------------------------------


From: Pankaj Suryawanshi
Sent: 15 March 2019 15:41:57
To: Kirill Tkhai; Michal Hocko; aneesh.kumar@linux.ibm.com
Cc: linux-kernel@vger.kernel.org; minchan@kernel.org; linux-mm@kvack.org; k=
handual@linux.vnet.ibm.com; hillf.zj@alibaba-inc.com; vbabka@suse.cz
Subject: Re: Re: [External] Re: vmscan: Reclaim unevictable pages



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

See       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/=
tree/mm/vmscan.c?h=3Dv4.14.65

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
