Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FE0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 05:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E382173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 05:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eInfochipsIndia.onmicrosoft.com header.i=@eInfochipsIndia.onmicrosoft.com header.b="YOYni1GC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbfC2FaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 01:30:01 -0400
Received: from mail-eopbgr1320047.outbound.protection.outlook.com ([40.107.132.47]:25763
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726016AbfC2FaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 01:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eInfochipsIndia.onmicrosoft.com; s=selector1-einfochips-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKroL2t8ARaAYRXZJwslKbipjkHuCiMPAGKDhK2aYRI=;
 b=YOYni1GCwwLkjvuIXqSVj6GJMbh/y6EZctUB2YAu71UQ80ugqYegW7tM101tTTtEnTN0YDbjJKPfZ9C5p9WgPWYGA/wzdbyYS+6YwtjcvVWmTaJUVmiB+jLpRLHBaWabe+dHy+idOBge99DmXOP3BLmqYbAMgi6eGt2xBAhjp2o=
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com (20.177.88.78) by
 SG2PR02MB4042.apcprd02.prod.outlook.com (20.178.158.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Fri, 29 Mar 2019 05:29:56 +0000
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::f432:20e4:2d22:e60b]) by SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::f432:20e4:2d22:e60b%4]) with mapi id 15.20.1730.019; Fri, 29 Mar 2019
 05:29:55 +0000
From:   Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>
Subject: Re: [External] Re: vmscan: Reclaim unevictable pages
Thread-Topic: [External] Re: vmscan: Reclaim unevictable pages
Thread-Index: AQHU3WaYCAMWaFadm0e/0+hd2XPYGaYRGYZ/gAAG5oCAAAD82oAAAx4AgAABDq2AAAzwgIAC47DNgAmAbsCAABOgAIAAA15XgAAGdICABHGeeA==
Date:   Fri, 29 Mar 2019 05:29:55 +0000
Message-ID: <SG2PR02MB30981BA28AB1BE6A08B6AC5DE85A0@SG2PR02MB3098.apcprd02.prod.outlook.com>
References: <SG2PR02MB309841EA4764E675D4649139E8470@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <56862fc0-3e4b-8d1e-ae15-0df32bf5e4c0@virtuozzo.com>
 <SG2PR02MB3098EEAF291BFD72F4163936E8470@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <4c05dda3-9fdf-e357-75ed-6ee3f25c9e52@virtuozzo.com>
 <SG2PR02MB309869FC3A436C71B50FA57BE8470@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <09b6ee71-0007-7f1d-ac80-7e05421e4ec6@virtuozzo.com>
 <SG2PR02MB309864258DBE630AD3AD2E10E8410@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <SG2PR02MB309824F3FCD9B0D1DF689390E85F0@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <20190326090142.GH28406@dhcp22.suse.cz>
 <SG2PR02MB3098FAEA335228CFB56F1668E85F0@SG2PR02MB3098.apcprd02.prod.outlook.com>,<20190326093651.GM28406@dhcp22.suse.cz>
In-Reply-To: <20190326093651.GM28406@dhcp22.suse.cz>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.suryawanshi@einfochips.com; 
x-originating-ip: [14.98.130.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f627539-9c97-4b3c-dcdc-08d6b40793fa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:SG2PR02MB4042;
x-ms-traffictypediagnostic: SG2PR02MB4042:|SG2PR02MB4042:
x-microsoft-antispam-prvs: <SG2PR02MB4042E75C8336BB561B8C19CEE85A0@SG2PR02MB4042.apcprd02.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(396003)(39850400004)(376002)(199004)(189003)(86362001)(5660300002)(44832011)(186003)(14454004)(446003)(11346002)(6436002)(26005)(476003)(478600001)(486006)(78486014)(55236004)(53546011)(66574012)(76176011)(256004)(54906003)(4326008)(5024004)(81156014)(8676002)(6916009)(8936002)(25786009)(99286004)(14444005)(6506007)(229853002)(52536014)(81166006)(55016002)(316002)(305945005)(7696005)(105586002)(74316002)(7736002)(53936002)(66066001)(97736004)(3846002)(106356001)(6246003)(71190400001)(102836004)(9686003)(33656002)(71200400001)(68736007)(93886005)(2906002)(6116002)(586874002);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR02MB4042;H:SG2PR02MB3098.apcprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: einfochips.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: APpBgx8majN5EwOOc4u4FPVtZh+1MTutyWyAHcjJ/tsHNJ11ASABrGf2VMfh1ukKfXMff6e8or81fBm1HOgkd4rt/HusaTwMHPgaUwcRiI7Y81atrAAHvkVrAERr0VGEnGJI0ZPVyaKrh5GIl//YrRC4wc3Xtzxm/3naW6f5SvJ1HTs63Xo1+87qSAZOpSYkSprM/HCuUkg2D5uFaCcBpWigI346WmEpH17Av9cinc2QUHaB6B7H00D8htdvha+S0rLyPBPU/Unny+MzLoC5LYXjTuADNszwlGXLdn3OwG1GUYi80AhXFltRkCcjyClNpQR/7NJN/XO9knmHHSH9EpA4YygSXQDuuSbvOBGU5qFqmdbAayuSm9FCnSFMOTXMRgZ7V2qda+EtoDC3GAMjB0WybKL1YSdLTUJxQGI3Lw0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: einfochips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f627539-9c97-4b3c-dcdc-08d6b40793fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 05:29:55.8324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0adb040b-ca22-4ca6-9447-ab7b049a22ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


________________________________________
From: Michal Hocko <mhocko@kernel.org>
Sent: 26 March 2019 15:06
To: Pankaj Suryawanshi
Cc: Kirill Tkhai; Vlastimil Babka; aneesh.kumar@linux.ibm.com; linux-kernel=
@vger.kernel.org; minchan@kernel.org; linux-mm@kvack.org; khandual@linux.vn=
et.ibm.com
Subject: Re: [External] Re: vmscan: Reclaim unevictable pages

On Tue 26-03-19 09:16:11, Pankaj Suryawanshi wrote:
>
> ________________________________________
> From: Michal Hocko <mhocko@kernel.org>
> Sent: 26 March 2019 14:31
> To: Pankaj Suryawanshi
> Cc: Kirill Tkhai; Vlastimil Babka; aneesh.kumar@linux.ibm.com; linux-kern=
el@vger.kernel.org; minchan@kernel.org; linux-mm@kvack.org; khandual@linux.=
vnet.ibm.com
> Subject: Re: [External] Re: vmscan: Reclaim unevictable pages
>
> [You were asked to use a reasonable quoting several times. This is
> really annoying because it turns the email thread into a complete mess]
>
> [Already fix the email client, but dont know the reason for quoting Maybe=
 account issue.]

You clearly haven't

> As i said earlier, i am using vanilla kernel 4.14.65.

This got lost in the quoting mess. Can you reproduce with 5.0?
Actually i am using android pie-9.0, can i replace kernel 4.14.65 to 5.0 ?
--
Michal Hocko
SUSE Labs
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
