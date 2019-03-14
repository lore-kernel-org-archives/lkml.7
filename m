Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180B0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDCF2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eInfochipsIndia.onmicrosoft.com header.i=@eInfochipsIndia.onmicrosoft.com header.b="lqyRx3hj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfCNNou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:44:50 -0400
Received: from mail-eopbgr1300050.outbound.protection.outlook.com ([40.107.130.50]:35920
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726957AbfCNNou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 09:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eInfochipsIndia.onmicrosoft.com; s=selector1-einfochips-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTs95jKqJTbGBOwBCX1Whgu4yenqTgtIIeyRLDWgwaU=;
 b=lqyRx3hjs7PkGR43vRSBX/d9mWad3d/4vFG+IXloV8qDfghWGUvpL5uQpGXWgJGCtQWdh5CUuEPrrIgpLCooG3N84WJaUGa4mDKn3z48rTy3Z7zvYo67+EIHe9s9ogVhV69zhe/SLOsXyjBYrW3Em9fu62e+1rQP6xzHoX564uc=
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com (20.177.88.78) by
 SG2PR02MB3575.apcprd02.prod.outlook.com (20.177.169.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Thu, 14 Mar 2019 13:44:40 +0000
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::3180:828f:84bc:ea3]) by SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::3180:828f:84bc:ea3%4]) with mapi id 15.20.1686.021; Thu, 14 Mar 2019
 13:44:40 +0000
From:   Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "minchan@kernel.org" <minchan@kernel.org>
Subject: Re: Re: [External] Re: vmscan: Reclaim unevictable pages
Thread-Topic: Re: [External] Re: vmscan: Reclaim unevictable pages
Thread-Index: AQHU2jnLyCfGly2dbEuVu40O8aA4saYKwYIOgAACnP2AAArTAIAAAt0egAAJfgCAABwNcoAAK5Eo
Date:   Thu, 14 Mar 2019 13:44:40 +0000
Message-ID: <SG2PR02MB30988333AD658F8124070ABEE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
References: <SG2PR02MB3098A05E09B0D3F3CB1C3B9BE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <SG2PR02MB309806967AE91179CAFEC34BE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <SG2PR02MB3098B751EC6B8E32806A42FBE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <20190314084120.GF7473@dhcp22.suse.cz>
 <SG2PR02MB309894F6D7DF9148846088F3E84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>,<226a92b9-94c5-b859-c54b-3aacad3089cc@virtuozzo.com>,<SG2PR02MB3098299456FB6AE2FD822C4CE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
In-Reply-To: <SG2PR02MB3098299456FB6AE2FD822C4CE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.suryawanshi@einfochips.com; 
x-originating-ip: [14.98.130.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d477eb82-a768-4666-17c9-08d6a883353d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:SG2PR02MB3575;
x-ms-traffictypediagnostic: SG2PR02MB3575:|SG2PR02MB3575:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SG2PR02MB357533DC84C9692097115570E84B0@SG2PR02MB3575.apcprd02.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39850400004)(396003)(346002)(136003)(376002)(199004)(189003)(5660300002)(33656002)(14454004)(68736007)(71190400001)(71200400001)(6436002)(78486014)(7696005)(52536014)(229853002)(4326008)(93156006)(53936002)(66066001)(9686003)(6306002)(55016002)(106356001)(97736004)(966005)(6246003)(105586002)(44832011)(8676002)(93886005)(256004)(446003)(478600001)(476003)(81156014)(110136005)(86362001)(81166006)(66574012)(2906002)(25786009)(14444005)(5024004)(11346002)(2940100002)(486006)(305945005)(55236004)(26005)(7736002)(316002)(6506007)(102836004)(53546011)(3846002)(6116002)(54906003)(8936002)(74316002)(99286004)(186003)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR02MB3575;H:SG2PR02MB3098.apcprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: einfochips.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BFZWATd8IhC8e7tRKi7ED7dP9ec0sDfPYSO782amEJceGOAaOekr3NOKyQPJ/YzZ653G1rw8qFWQA1QkAO3ol1YLNU6XeXErLQQY/Q96nLTWg7QqKnCOyr0RqEnGWg6yg+FJs8aeBk4756xmsEiDJd+myJTWJp1caaAsOcfeW8j5ix5SdkAHHtnV/hVHOZfQRrDv1RJVMf2VeM8CtkusQKuQqRXxSyZh4zotgrb00OTzhvYbJSeQ0rP7pyi3VbmvqbMUcR5/UvNAp0U9x1Li1N2sAoSdvtjIwncjgukalvUtzTs+SDPG/0IbCUluiYOE2TkGpSkFsdlueZNmeCQPF7HVtaZiwo/b2VWlRAXCCxQj9Xpqp9FZohGqkelpcubMwAStoVN3KuIAdgp5pms6QUSbqoSkGswvNVQB033J0IQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: einfochips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d477eb82-a768-4666-17c9-08d6a883353d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 13:44:40.4480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0adb040b-ca22-4ca6-9447-ab7b049a22ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3575
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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

See   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree=
/mm/vmscan.c?h=3Dv4.14.65

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
