Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16664C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC292087C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 21:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="iXWffetj";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="KfXrmQai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732071AbfCZVKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 17:10:54 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:32770 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731589AbfCZVKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 17:10:54 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QL5cAk026570;
        Tue, 26 Mar 2019 14:09:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=Xex4KRI1i+eqWIXTpiQljB9qoQPTDumO8J1QB1vOJTQ=;
 b=iXWffetjIg8b6h6o5Dcq6c/C/shOOCE2iOA3pdrj57NUE8E0NM/GMs7/wpJhu8sSbxq7
 XJQosbrlrvY1p7ZE3jDocSenB+hN7Evm0zqDWCIvcapJbKc4dJjiH9K486awTp2U6RWu
 NSR9l1PpGbfeg5BBdIFXuGa/n9tU4nK9PeEngA6aAsnLcVWSX2PYjFeOlQGysEAKeS+B
 cEZbUTdX/K/uewImZPavqwkm77vgbjjgCPeop9h9PIv9t2zD0fR4L6qgCBEAQm+95HRB
 U749ABaFNfyGE+yzlWR3ROz/VcIVId98HO/tV9nAAHRqPGpdR4Ned8SxwEA186JSU6OT Dg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2rfjtbskhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 26 Mar 2019 14:09:26 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 26 Mar
 2019 14:09:24 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.58) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 26 Mar 2019 14:09:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xex4KRI1i+eqWIXTpiQljB9qoQPTDumO8J1QB1vOJTQ=;
 b=KfXrmQaiwjkKUIXEDRdbYYPwUjTVUE1zPrvqXR/rbZfSBc0TsdSMr8YYqXarmXnbMyKaU5Lzq/1DqfcaGZMKhXhs/RwK9NxX738pmvXyH5cvP/ImEg9dfwRsw9Ahfi4umL+QdN3WTYxeJ0SQXMGenlqghfscj9hyxJoQR3fMyzI=
Received: from MN2PR18MB3086.namprd18.prod.outlook.com (20.179.21.74) by
 MN2PR18MB2606.namprd18.prod.outlook.com (20.179.83.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Tue, 26 Mar 2019 21:09:19 +0000
Received: from MN2PR18MB3086.namprd18.prod.outlook.com
 ([fe80::ccaf:c004:6120:312e]) by MN2PR18MB3086.namprd18.prod.outlook.com
 ([fe80::ccaf:c004:6120:312e%5]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 21:09:19 +0000
From:   Yuri Norov <ynorov@marvell.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Travis <travis@sgi.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/6] bitmap_parselist: rework input string parser
Thread-Topic: [PATCH 3/6] bitmap_parselist: rework input string parser
Thread-Index: AQHU5BgtSKN9Jh48vk6eUkQSxrS94Q==
Date:   Tue, 26 Mar 2019 21:09:18 +0000
Message-ID: <MN2PR18MB30862D49744CFC6FEAD78177CB5F0@MN2PR18MB3086.namprd18.prod.outlook.com>
References: <20190325210748.6571-1-ynorov@marvell.com>
 <20190325210748.6571-4-ynorov@marvell.com>,<20190326101045.GT9224@smile.fi.intel.com>
In-Reply-To: <20190326101045.GT9224@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2601:648:8303:5c60:c057:734:2567:9ba6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79463fe6-9e3a-4e9d-60ab-08d6b22f4fc4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MN2PR18MB2606;
x-ms-traffictypediagnostic: MN2PR18MB2606:
x-microsoft-antispam-prvs: <MN2PR18MB2606C31A7A4FFD1092A572A1CB5F0@MN2PR18MB2606.namprd18.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(396003)(346002)(376002)(366004)(189003)(199004)(305945005)(316002)(74316002)(9686003)(97736004)(81166006)(7736002)(8936002)(53936002)(5660300002)(81156014)(446003)(256004)(8676002)(14444005)(105586002)(486006)(102836004)(7696005)(55016002)(106356001)(14454004)(46003)(11346002)(186003)(476003)(76176011)(7416002)(86362001)(6506007)(4326008)(33656002)(99286004)(6246003)(25786009)(229853002)(2906002)(71200400001)(54906003)(110136005)(68736007)(52536014)(6436002)(6116002)(478600001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2606;H:MN2PR18MB3086.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LSyDUDznO9y5ZmiQo+plVfSwyCtpDWPJOqd7d6Rvu5ZduHYJm7KWsK/6yNVQClp8D/24z6/nk+R6hSLRovZr0lszPQ+XhsY6KJnUFOtDtnklr8y8wI2X0IIz2mrCdSJGJHpOj4iXbXZkJOedtO1pOSyrXIPDv/FM8muG7HezhMB9jv5eAGcYIfUjDyiWENvwmxToVq02Vg2+pCXG/DLZTJhltvFIZYJGzKtntYjUKnrRJf4Jp08nPWs8uWMWVxPN0bIBCwn+8+kOJTxwhLbJXcodTW+49ugzQ5jCay2/3D94zcoRIyAmhVZRAvAlGXnb0U79lKMKerSZ0Ja6rOSJKaqCyTiqbBS1pjMsSFnv73Y77Spp+WrMrabNklYFxEx35W8IHSiBFYUryLmm4os6mfZLKT4Or9KNqyUidMppg+M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 79463fe6-9e3a-4e9d-60ab-08d6b22f4fc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 21:09:18.9829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2606
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_14:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Mike Travis <travis@sgi.com>=0A=
+ Thomas Gleixner <tglx@linutronix.de>=0A=
=0A=
----------------------------------------------------------------------=0A=
On Tue, Mar 26, 2019 at 12:07:45AM +0300, Yury Norov wrote:=0A=
>> The requirement for this rework is to keep the __bitmap_parselist()=0A=
>> copy-less and single-pass but make it more readable and maintainable by=
=0A=
>> splitting into logical parts and removing explicit nested cycles and=0A=
>> opaque local variables.=0A=
>>=0A=
>> __bitmap_parselist() can parse userspace inputs and therefore we cannot=
=0A=
>> use simple_strtoul() to parse numbers.=0A=
=0A=
> So, all above depends to what memory we access kernel / user space.=0A=
> Perhaps we can get copy of memory of a given size and then parse it in ke=
rnel space always?=0A=
=0A=
> --=0A=
> With Best Regards,=0A=
> Andy Shevchenko=0A=
=0A=
What I missed during rework is that we have only one caller of *parselist_u=
ser=A0 -=0A=
it's write_irq_affinity() introduced by Mike Travis in kernel/irq/proc.c. I=
t doesn't look=0A=
like a hot path as it's file operations handler. If no objections from Mike=
 or Thomas,=0A=
I think it would make sense to copy_from_user() the userspace data at the b=
eginning=0A=
in sake of simplicity of __bitmap_parselist(), as you suggested above.=0A=
=0A=
Yury=0A=
