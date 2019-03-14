Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D4AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CA1217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eInfochipsIndia.onmicrosoft.com header.i=@eInfochipsIndia.onmicrosoft.com header.b="V+pZVZat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfCNIXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 04:23:16 -0400
Received: from mail-eopbgr1320044.outbound.protection.outlook.com ([40.107.132.44]:49760
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726629AbfCNIXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 04:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eInfochipsIndia.onmicrosoft.com; s=selector1-einfochips-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPCauGzqw1HxmFLieiUCXYM1iE41S9qc20sx99Pzf34=;
 b=V+pZVZat5SZC9etoU8xWj49Uk+pG9YeZrbVgCWMSSBpIo2wZhThMWM4mSTxxYpYWjJJbveQpGuC03hBXmXq5DBXwVo2c2dUp56NnEGoXVnWcdmitv5ir/RDL3efQpt3cdZW6zKtfAKS8MCMPHODpxQCUxZHgga61UtQIkJ49Dfs=
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com (20.177.88.78) by
 SG2PR02MB3084.apcprd02.prod.outlook.com (20.177.88.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Thu, 14 Mar 2019 08:23:10 +0000
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::3180:828f:84bc:ea3]) by SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::3180:828f:84bc:ea3%4]) with mapi id 15.20.1686.021; Thu, 14 Mar 2019
 08:23:10 +0000
From:   Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "minchan@kernel.org" <minchan@kernel.org>
Subject: Re: vmscan: Reclaim unevictable pages
Thread-Topic: vmscan: Reclaim unevictable pages
Thread-Index: AQHU2jnLyCfGly2dbEuVu40O8aA4saYKwYIOgAACnP0=
Date:   Thu, 14 Mar 2019 08:23:10 +0000
Message-ID: <SG2PR02MB3098B751EC6B8E32806A42FBE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
References: <SG2PR02MB3098A05E09B0D3F3CB1C3B9BE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>,<SG2PR02MB309806967AE91179CAFEC34BE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
In-Reply-To: <SG2PR02MB309806967AE91179CAFEC34BE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.suryawanshi@einfochips.com; 
x-originating-ip: [14.98.130.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7abd29c2-63ea-4346-c890-08d6a8564b4d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:SG2PR02MB3084;
x-ms-traffictypediagnostic: SG2PR02MB3084:|SG2PR02MB3084:
x-microsoft-antispam-prvs: <SG2PR02MB308433A48CE21B46374F28CFE84B0@SG2PR02MB3084.apcprd02.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(136003)(376002)(39850400004)(189003)(199004)(6436002)(68736007)(93156006)(71190400001)(53936002)(5660300002)(9686003)(71200400001)(66574012)(97736004)(5640700003)(476003)(446003)(44832011)(52536014)(229853002)(4326008)(78486014)(33656002)(486006)(5024004)(14444005)(256004)(6246003)(11346002)(2501003)(25786009)(6916009)(3846002)(6116002)(8676002)(53546011)(186003)(14454004)(7736002)(305945005)(8936002)(99286004)(26005)(66066001)(2906002)(76176011)(7696005)(316002)(55236004)(74316002)(55016002)(2351001)(102836004)(81156014)(86362001)(2940100002)(105586002)(478600001)(106356001)(81166006)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR02MB3084;H:SG2PR02MB3098.apcprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: einfochips.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sCmNUSq1HzIRpnkVkvorZpYT5YPRh3dLYnJkouX67iiG2POq1rQYYPKMM06utXanBqWrvV1fUmQbVq002LMfz0a96SygtqecOPoYcXYJBVBu+BgeOgrXRFQA7Sbxnq7auLYIU4aNhPbE9ELf0RF/QBN4R2sWfpeDj0Bx+WwcMbvxK2CL4h0JvY8JIZAoHau3Jhnxna+0gBPG/RHwKnFU+vs4/0DA1Er9gHlYIim1BBgg4Pky+zMbzxT1hQZs545ZFwoivYxGS9bqP2OvSHSnPXr9qCpZ7EpMe3FXKn3x7Wv6QFWsbbtmMpr+qfmg7Jxs1EqsopcfAchIxHy1+J/13a+8Siy58ke/IJfQq3GERBzRi24GV4GTd5pb83Emo0RM6QyiyjbIZVeny2CFNjvuv/z4y1Ar0cWi75cVQcAiZJE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: einfochips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7abd29c2-63ea-4346-c890-08d6a8564b4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 08:23:10.2075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0adb040b-ca22-4ca6-9447-ab7b049a22ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Below is the Error Msg :

[   24.718792] page dumped because: VM_BUG_ON_PAGE(PageLRU(page) || PageUne=
victable(page))
[   24.726949] page->mem_cgroup:bd008c00
[   24.730693] ------------[ cut here ]------------
[   24.735304] kernel BUG at mm/vmscan.c:1350!
[   24.739478] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM


Solved the issue by below patch.


diff --git a/mm/vmscan.c b/mm/vmscan.c
index be56e2e..2e51edc 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -990,15 +990,17 @@ static unsigned long shrink_page_list(struct list_hea=
d *page_list,
                page =3D lru_to_page(page_list);
                list_del(&page->lru);

               if (!trylock_page(page)) {
                        goto keep;
               }

                VM_BUG_ON_PAGE(PageActive(page), page);

                sc->nr_scanned++;

                if (unlikely(!page_evictable(page)))
-                       goto activate_locked;
+                      goto cull_mlocked;

                if (!sc->may_unmap && page_mapped(page))
                        goto keep_locked;
@@ -1331,6 +1333,12 @@ static unsigned long shrink_page_list(struct list_he=
ad *page_list,
                } else
                        list_add(&page->lru, &free_pages);
                continue;
+cull_mlocked:
+                if (PageSwapCache(page))
+                        try_to_free_swap(page);
+                unlock_page(page);
+                list_add(&page->lru, &ret_pages);
+                continue;

 activate_locked:
                /* Not a candidate for swapping, so reclaim swap space. */




From: Pankaj Suryawanshi
Sent: 14 March 2019 13:23:53
To: linux-kernel@vger.kernel.org
Cc: minchan@kernel.org
Subject: vmscan: Reclaim unevictable pages



Hello ,

shrink_page_list() returns , number of pages reclaimed, when pages is unevi=
ctable it returns VM_BUG_ON_PAGE(PageLRU(page) || PageUnevicatble(page),pag=
e);

We can add the unevictable pages in reclaim list in shrink_page_list(), ret=
urn total number of reclaim pages including unevictable pages, let the call=
er handle unevictable pages.

Regards,
Pankaj

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
