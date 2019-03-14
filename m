Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E048C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E175421019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eInfochipsIndia.onmicrosoft.com header.i=@eInfochipsIndia.onmicrosoft.com header.b="322VgYFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfCNIwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 04:52:43 -0400
Received: from mail-eopbgr1310058.outbound.protection.outlook.com ([40.107.131.58]:64320
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726539AbfCNIwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 04:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eInfochipsIndia.onmicrosoft.com; s=selector1-einfochips-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLCQ/IOMf9ZfRA0IZRLczf09lfv9ooqFAvvM6n1Blhk=;
 b=322VgYFHKRLElQ7p3RYX1Hu2jkpIHFo/U4TWynESqHP+icEvONcRyDfyFcy7+2nVDe1izymWGl0iD0S6DynXfWZLcSxTj/T9oEqCquQPe0OmzUMWyo+hD3ISN8Ph3X9RmMNW/VL8L1TeM3lI+miOrbNGPyb0rdlwEkL6fiFJ/vU=
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com (20.177.88.78) by
 SG2PR02MB4022.apcprd02.prod.outlook.com (20.178.152.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Thu, 14 Mar 2019 08:52:37 +0000
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::3180:828f:84bc:ea3]) by SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::3180:828f:84bc:ea3%4]) with mapi id 15.20.1686.021; Thu, 14 Mar 2019
 08:52:37 +0000
From:   Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "minchan@kernel.org" <minchan@kernel.org>
Subject: Re: [External] Re: vmscan: Reclaim unevictable pages
Thread-Topic: [External] Re: vmscan: Reclaim unevictable pages
Thread-Index: AQHU2jnLyCfGly2dbEuVu40O8aA4saYKwYIOgAACnP2AAArTAIAAAt0e
Date:   Thu, 14 Mar 2019 08:52:37 +0000
Message-ID: <SG2PR02MB309894F6D7DF9148846088F3E84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
References: <SG2PR02MB3098A05E09B0D3F3CB1C3B9BE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <SG2PR02MB309806967AE91179CAFEC34BE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <SG2PR02MB3098B751EC6B8E32806A42FBE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>,<20190314084120.GF7473@dhcp22.suse.cz>
In-Reply-To: <20190314084120.GF7473@dhcp22.suse.cz>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.suryawanshi@einfochips.com; 
x-originating-ip: [14.98.130.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c1b334d-b784-4409-7aa6-08d6a85a689a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:SG2PR02MB4022;
x-ms-traffictypediagnostic: SG2PR02MB4022:|SG2PR02MB4022:
x-microsoft-antispam-prvs: <SG2PR02MB40228F052365866522EC6734E84B0@SG2PR02MB4022.apcprd02.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(396003)(39840400004)(376002)(346002)(189003)(199004)(2906002)(478600001)(53936002)(102836004)(14454004)(33656002)(81166006)(8676002)(93886005)(5660300002)(81156014)(74316002)(6916009)(52536014)(8936002)(305945005)(316002)(54906003)(97736004)(229853002)(71190400001)(6436002)(3846002)(6116002)(66066001)(446003)(86362001)(7736002)(68736007)(26005)(486006)(44832011)(105586002)(11346002)(476003)(99286004)(256004)(5024004)(55236004)(66574012)(14444005)(55016002)(71200400001)(9686003)(76176011)(6506007)(7696005)(53546011)(6246003)(4326008)(186003)(78486014)(25786009)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR02MB4022;H:SG2PR02MB3098.apcprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: einfochips.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: c6ypzXME9XHt1MUdGrXuH7k0ajzcBc1EF5GJfvJDAVvuoPN+IMwaFPvE5fXfTHcK3W6O4iTl3R9oHx1i4SNdYpiJm3WZ+NGVt+kpMtFU8J1dGG4q2p7e5Ib7aibRx3xuWt4xhjc5pcqzenbTcR/RdFEUYouuU28HWyE79YQJOksmp+9Qhv4Jh1ClZi9j4HClUxQZrEr80yD/hi9G30SecP1EvynghFxLFdBd0CwAR7++BBqp5oTwwBGyR5lmhFu4BQ6DAOS092s+Su7aSoMPW/+3ip3G/RAkOw6syAgUW4lpVqhCT2WMe4mcpyXXnAVuT1yKLAl26mnxevrSl1w4Yo4TzRthmzHiJksN2OLFV1jzDvAmYePO+PAy/txFU9mGwC1WFDTqHglzHUbnlR7Gqcto1gqV61vHDOmS+kGrkB0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: einfochips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1b334d-b784-4409-7aa6-08d6a85a689a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 08:52:37.3730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0adb040b-ca22-4ca6-9447-ab7b049a22ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I am using kernel version 4.14.65 (on Android pie [ARM]).

No additional patches applied on top of vanilla.(Core MM).

If=A0 I change in the vmscan.c as below patch, it will work.=20

Regards,
Pankaj=20
=20

 =20
From: Michal Hocko <mhocko@kernel.org>
Sent: 14 March 2019 14:11:20
To: Pankaj Suryawanshi
Cc: linux-kernel@vger.kernel.org; minchan@kernel.org
Subject: [External] Re: vmscan: Reclaim unevictable pages
=A0=20

CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you recognize the sender and know the c=
ontent is safe.


On Thu 14-03-19 08:23:10, Pankaj Suryawanshi wrote:
>
> Below is the Error Msg :
>
> [=A0=A0 24.718792] page dumped because: VM_BUG_ON_PAGE(PageLRU(page) || P=
ageUnevictable(page))
> [=A0=A0 24.726949] page->mem_cgroup:bd008c00
> [=A0=A0 24.730693] ------------[ cut here ]------------
> [=A0=A0 24.735304] kernel BUG at mm/vmscan.c:1350!
> [=A0=A0 24.739478] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM

Just curious. Which kernel version is that? Are there any addional
patches applied on top of vanilla?

> Solved the issue by below patch.
>
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index be56e2e..2e51edc 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -990,15 +990,17 @@ static unsigned long shrink_page_list(struct list_h=
ead *page_list,
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 page =3D lru_to_page(page=
_list);
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 list_del(&page->lru);
>
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!trylock_page(page)) {
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 g=
oto keep;
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 VM_BUG_ON_PAGE(PageActive=
(page), page);
>
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sc->nr_scanned++;
>
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (unlikely(!page_evicta=
ble(page)))
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto =
activate_locked;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto cul=
l_mlocked;
>
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!sc->may_unmap && pag=
e_mapped(page))
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 g=
oto keep_locked;
> @@ -1331,6 +1333,12 @@ static unsigned long shrink_page_list(struct list_=
head *page_list,
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 l=
ist_add(&page->lru, &free_pages);
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
> +cull_mlocked:
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (PageSwapCache(page))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tr=
y_to_free_swap(page);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unlock_page(page);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 list_add(&page->lru, &ret_=
pages);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
>
>=A0 activate_locked:
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Not a candidate for sw=
apping, so reclaim swap space. */
>
>
>
>
> From: Pankaj Suryawanshi
> Sent: 14 March 2019 13:23:53
> To: linux-kernel@vger.kernel.org
> Cc: minchan@kernel.org
> Subject: vmscan: Reclaim unevictable pages
>
>
>
> Hello ,
>
> shrink_page_list() returns , number of pages reclaimed, when pages is une=
victable it returns VM_BUG_ON_PAGE(PageLRU(page) || PageUnevicatble(page),p=
age);
>
> We can add the unevictable pages in reclaim list in shrink_page_list(), r=
eturn total number of reclaim pages including unevictable pages, let the ca=
ller handle unevictable pages.
>
> Regards,
> Pankaj
>
> *************************************************************************=
***************************************************************************=
********* eInfochips Business Disclaimer: This e-mail message and all attac=
hments transmitted with it are intended  solely for the use of the addresse=
e and may contain legally privileged and confidential information. If the r=
eader of this message is not the intended recipient, or an employee or agen=
t responsible for delivering this message to the intended recipient, you  a=
re hereby notified that any dissemination, distribution, copying, or other =
use of this message or its attachments is strictly prohibited. If you have =
received this message in error, please notify the sender immediately by rep=
lying to this message and please  delete it from your computer. Any views e=
xpressed in this message are those of the individual sender unless otherwis=
e stated. Company has taken enough precautions to prevent the spread of vir=
uses. However the company accepts no liability for any damage caused  by an=
y virus transmitted by this email. ****************************************=
***************************************************************************=
******************************************

--
Michal Hocko
SUSE Labs
    =
