Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2ECC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192A020857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eInfochipsIndia.onmicrosoft.com header.i=@eInfochipsIndia.onmicrosoft.com header.b="vtKla7/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbfCZJQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:16:16 -0400
Received: from mail-eopbgr1300057.outbound.protection.outlook.com ([40.107.130.57]:37952
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726258AbfCZJQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eInfochipsIndia.onmicrosoft.com; s=selector1-einfochips-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D88G+Vh5U3UtxzazzAqekvx4X29mAS8ojsGLDNKgfT8=;
 b=vtKla7/v3LR4Tgykdc1KFn6myJ2HwI2yMXTPeicaVrUICtB/RmvflByRxc7qZYVZhG2wMcX6Z2Ut4Nk8H0y/9VSrXVpzaBIMweFtfuAQYI0U5rVE/QULi4mL7yDw0pjF8HVB7yaKymmT9mISQRVtKz4yJeyoXKzegOLk+57On4Y=
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com (20.177.88.78) by
 SG2PR02MB4249.apcprd02.prod.outlook.com (20.179.102.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.17; Tue, 26 Mar 2019 09:16:12 +0000
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::f432:20e4:2d22:e60b]) by SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::f432:20e4:2d22:e60b%4]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 09:16:12 +0000
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
Thread-Index: AQHU3WaYCAMWaFadm0e/0+hd2XPYGaYRGYZ/gAAG5oCAAAD82oAAAx4AgAABDq2AAAzwgIAC47DNgAmAbsCAABOgAIAAA15X
Date:   Tue, 26 Mar 2019 09:16:11 +0000
Message-ID: <SG2PR02MB3098FAEA335228CFB56F1668E85F0@SG2PR02MB3098.apcprd02.prod.outlook.com>
References: <SG2PR02MB3098E6F2C4BAEB56AE071EDCE8440@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <0b86dbca-cbc9-3b43-e3b9-8876bcc24f22@suse.cz>
 <SG2PR02MB309841EA4764E675D4649139E8470@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <56862fc0-3e4b-8d1e-ae15-0df32bf5e4c0@virtuozzo.com>
 <SG2PR02MB3098EEAF291BFD72F4163936E8470@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <4c05dda3-9fdf-e357-75ed-6ee3f25c9e52@virtuozzo.com>
 <SG2PR02MB309869FC3A436C71B50FA57BE8470@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <09b6ee71-0007-7f1d-ac80-7e05421e4ec6@virtuozzo.com>
 <SG2PR02MB309864258DBE630AD3AD2E10E8410@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <SG2PR02MB309824F3FCD9B0D1DF689390E85F0@SG2PR02MB3098.apcprd02.prod.outlook.com>,<20190326090142.GH28406@dhcp22.suse.cz>
In-Reply-To: <20190326090142.GH28406@dhcp22.suse.cz>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.suryawanshi@einfochips.com; 
x-originating-ip: [14.98.130.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0efc8f5-9ce2-41a8-65b8-08d6b1cbb0b2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SG2PR02MB4249;
x-ms-traffictypediagnostic: SG2PR02MB4249:|SG2PR02MB4249:
x-microsoft-antispam-prvs: <SG2PR02MB4249BC2A7F5436F80FD23863E85F0@SG2PR02MB4249.apcprd02.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39850400004)(366004)(396003)(376002)(136003)(189003)(199004)(8936002)(52536014)(9686003)(476003)(74316002)(71200400001)(6116002)(105586002)(53936002)(54906003)(305945005)(6246003)(25786009)(55016002)(486006)(93886005)(316002)(33656002)(8676002)(5660300002)(11346002)(6506007)(7696005)(446003)(3846002)(6916009)(44832011)(68736007)(102836004)(53546011)(229853002)(55236004)(2906002)(14444005)(186003)(256004)(5024004)(106356001)(7736002)(76176011)(26005)(78486014)(81166006)(81156014)(14454004)(86362001)(6436002)(97736004)(66066001)(99286004)(66574012)(4326008)(478600001)(71190400001)(586874002);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR02MB4249;H:SG2PR02MB3098.apcprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: einfochips.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 14gN9kp6Yz+7tFHuZSR99p9ClLUkIKrz2aMS1hw63XQd/c45+hOK31pobFsGftdBQ3cVie0ENPVZsJfTk46LQAujdxDBq9muwPSrRfCq/xFD7kG3QXAkZRCh4rkJk67I3ekuEehJaOVbPknNcbY6da2Ak6Eq7zoatGuWG7Aieb143/zsa9W0LEhJuyZ+NqsdvV0sBE7XklAXr1R4RMX3MuRm4WUkuQr6PRCjmpmBNHc1vcMx3l9w5q0JZ9GXi0kFVX3KnYsQkp7+evJgJJbz8jlEr9rlbwGDhmaC5HJvPoJX3G3s1f+VyftA2SnXzul637IyulLFqAf6duNBtLf8AFvb2wINbG/zWnmaC682lstnZuYSZgUPTaVuk3Fa/m8BtkgaDfId48g3ce4dRj4nQz2IiTwZRBlZlxbjcwWx3Zw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: einfochips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0efc8f5-9ce2-41a8-65b8-08d6b1cbb0b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 09:16:11.8621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0adb040b-ca22-4ca6-9447-ab7b049a22ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4249
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


________________________________________
From: Michal Hocko <mhocko@kernel.org>
Sent: 26 March 2019 14:31
To: Pankaj Suryawanshi
Cc: Kirill Tkhai; Vlastimil Babka; aneesh.kumar@linux.ibm.com; linux-kernel=
@vger.kernel.org; minchan@kernel.org; linux-mm@kvack.org; khandual@linux.vn=
et.ibm.com
Subject: Re: [External] Re: vmscan: Reclaim unevictable pages

[You were asked to use a reasonable quoting several times. This is
really annoying because it turns the email thread into a complete mess]

[Already fix the email client, but dont know the reason for quoting Maybe a=
ccount issue.]

On Tue 26-03-19 07:53:14, Pankaj Suryawanshi wrote:
> Is there anyone who is familiar with this?  Please Comment.

Not really. You are observing an unexpected behavior of the page reclaim
which hasn't changed for quite some time. So I find more probable that
your non-vanilla kernel is doing something unexpected. It would help if
you could track down how does the unevictable page get down to the
reclaim path. I assume this is a CMA page or something like that but
those shouldn't get to the reclaim path AFIR.

As i said earlier, i am using vanilla kernel 4.14.65.
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
