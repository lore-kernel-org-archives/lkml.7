Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4423CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03EA720693
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eInfochipsIndia.onmicrosoft.com header.i=@eInfochipsIndia.onmicrosoft.com header.b="RATCnDa3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfCNLJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:09:52 -0400
Received: from mail-eopbgr1300048.outbound.protection.outlook.com ([40.107.130.48]:44013
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726693AbfCNLJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eInfochipsIndia.onmicrosoft.com; s=selector1-einfochips-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndrvWRIuBQFKBCyvfUIfmqTlqOLzC0XXr4CVTcl13CI=;
 b=RATCnDa3u2YWHasyU9yfB2+EQtDdhsGpFiWLM5rsAlqpmqo+47Rc5fjlaBFGXSw5kcdaPlWken/tpPXXlps+pK327T9V098twxZ9xRleeAL96ILpofIKgwVxyjlaKursiucHUaodLfUz/e6zzb9Z2gKOpFZwDu/RCAKt1XkQ/ag=
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com (20.177.88.78) by
 SG2PR02MB4187.apcprd02.prod.outlook.com (20.178.159.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Thu, 14 Mar 2019 11:09:44 +0000
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::3180:828f:84bc:ea3]) by SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::3180:828f:84bc:ea3%4]) with mapi id 15.20.1686.021; Thu, 14 Mar 2019
 11:09:44 +0000
From:   Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "minchan@kernel.org" <minchan@kernel.org>
Subject: Re: Re: [External] Re: vmscan: Reclaim unevictable pages
Thread-Topic: Re: [External] Re: vmscan: Reclaim unevictable pages
Thread-Index: AQHU2jnLyCfGly2dbEuVu40O8aA4saYKwYIOgAACnP2AAArTAIAAAt0egAAJfgCAABwNcg==
Date:   Thu, 14 Mar 2019 11:09:44 +0000
Message-ID: <SG2PR02MB3098299456FB6AE2FD822C4CE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
References: <SG2PR02MB3098A05E09B0D3F3CB1C3B9BE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <SG2PR02MB309806967AE91179CAFEC34BE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <SG2PR02MB3098B751EC6B8E32806A42FBE84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <20190314084120.GF7473@dhcp22.suse.cz>
 <SG2PR02MB309894F6D7DF9148846088F3E84B0@SG2PR02MB3098.apcprd02.prod.outlook.com>,<226a92b9-94c5-b859-c54b-3aacad3089cc@virtuozzo.com>
In-Reply-To: <226a92b9-94c5-b859-c54b-3aacad3089cc@virtuozzo.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.suryawanshi@einfochips.com; 
x-originating-ip: [14.98.130.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13d2ccae-9650-4cbb-46f0-08d6a86d902a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:SG2PR02MB4187;
x-ms-traffictypediagnostic: SG2PR02MB4187:|SG2PR02MB4187:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SG2PR02MB41876806347DA5F62D867B97E84B0@SG2PR02MB4187.apcprd02.prod.outlook.com>
x-forefront-prvs: 09760A0505
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(346002)(396003)(376002)(366004)(136003)(189003)(199004)(97736004)(478600001)(316002)(966005)(93886005)(33656002)(186003)(7736002)(14454004)(26005)(305945005)(6436002)(66574012)(74316002)(7696005)(229853002)(11346002)(86362001)(6246003)(2906002)(8676002)(81156014)(6116002)(3846002)(78486014)(6506007)(53546011)(68736007)(102836004)(54906003)(110136005)(106356001)(55236004)(81166006)(8936002)(44832011)(71190400001)(53936002)(71200400001)(76176011)(99286004)(476003)(105586002)(25786009)(446003)(66066001)(486006)(256004)(9686003)(4326008)(6306002)(5024004)(14444005)(55016002)(5660300002)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR02MB4187;H:SG2PR02MB3098.apcprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: einfochips.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4uRLDWNNyLLlxW2ytgcW7kgUqRUYu4tj+7uNATlI+mHDejYgtFlPT0KSr2NnYeeLoptl6biYSeeDHQT6nLWrYq9yj2MWNfcyFGjKCaxUgOy90FEBrcKdSN2SwXwcYha1ehAWcnJvCFmuZ52lrZ52fqd3HRBYfRGM5keiyXOFSvnpfvD6z2FtJayfPmtwHCC4dKRt3ibFiw0tJRWHN0tbJy/AEs1xN+5bkMRJYGGmMNrmC/KiQa9uMcN1FsC+u5SqPft6yvqer69CE8rqyb2EJFzIruIlnmdfn8ghYNXPWv8ONa6KESbwX3oz9GZZZcbb5SbdBLuImS8V7oICkR9eHXUsW5rEb0ReQUmyOFvNCVk5IP5UPsrTQszXlgX3Fufchj+J8xbuD64AhUpMTPqtVR2CIUi7ooN0pfdJTbUhO/Q=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: einfochips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d2ccae-9650-4cbb-46f0-08d6a86d902a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2019 11:09:44.0653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0adb040b-ca22-4ca6-9447-ab7b049a22ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello ,

The curly braces are just for debugging purpose so please ignore it.

Below is the updated patch :


                if (!trylock_page(page))
                        goto keep;

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

See  https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/=
mm/vmscan.c?h=3Dv4.14.65

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
