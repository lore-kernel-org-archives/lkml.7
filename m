Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAA7C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3318A2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="akEEORb+";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Hqf0Q03r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730608AbfEMQyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 12:54:45 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40090 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727774AbfEMQyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 12:54:45 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4DGoGPF025038;
        Mon, 13 May 2019 09:54:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Jz/Fc2aeRxv3NS5BTov4WT5FtMJAt0qvGdt17XBc/5Q=;
 b=akEEORb+pooMtRRcv5MVnPM6QxB0SvgAX47eaSAvjcw6DAtbj/ngpZmi/pj8TMT6YmPD
 e1Q/fYKJvV9tf0lzloJrMuRaiCwU00hT9kI1To4u1gBHa+y2mwUXYaQQqpBYiieylcok
 5MW+uH3P6FLlTeRImxzGdOhi/Txn366riTU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sf8h40wve-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 May 2019 09:54:42 -0700
Received: from ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 13 May 2019 09:54:35 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 13 May 2019 09:54:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jz/Fc2aeRxv3NS5BTov4WT5FtMJAt0qvGdt17XBc/5Q=;
 b=Hqf0Q03rm6QJGKo7VuyDICgTxmf8TSyDri49BfDwVFI31EMrji0Vk/nwyRwGaqkKIAa8F0fERfiNQ/Tm/SaV/XWsL01URrjf8BlRcqfAvUpEuYUv/3Byn/eJkeo9BIjfKKEgw0Al9UANd6WqGUl5cwfX+Naz2iQ8r1cgUPcBnr0=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2551.namprd15.prod.outlook.com (20.179.155.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Mon, 13 May 2019 16:54:33 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 16:54:33 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tj@kernel.org" <tj@kernel.org>, Kernel Team <Kernel-team@fb.com>
Subject: Re: [REGRESSION] ptrace broken from "cgroup: cgroup v2 freezer"
 (76f969e)
Thread-Topic: [REGRESSION] ptrace broken from "cgroup: cgroup v2 freezer"
 (76f969e)
Thread-Index: AQHVCSoMi3vTppklSEy7VGeoXNz2TaZo+TgAgABI+ACAAASKgA==
Date:   Mon, 13 May 2019 16:54:33 +0000
Message-ID: <20190513165426.GA10982@tower.DHCP.thefacebook.com>
References: <1557709124.798rxdb4l3.astroid@alex-desktop.none>
 <20190513121703.GA24724@redhat.com> <20190513163814.GA31756@redhat.com>
In-Reply-To: <20190513163814.GA31756@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0192.namprd04.prod.outlook.com
 (2603:10b6:104:5::22) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::b4b6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 741ed9b5-d487-45a1-3106-08d6d7c3ac75
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2551;
x-ms-traffictypediagnostic: BYAPR15MB2551:
x-microsoft-antispam-prvs: <BYAPR15MB25519FC6A41A19F1966227D8BE0F0@BYAPR15MB2551.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(366004)(136003)(396003)(189003)(199004)(53936002)(486006)(66556008)(66476007)(446003)(54906003)(11346002)(14454004)(46003)(66446008)(8676002)(33656002)(73956011)(476003)(66946007)(64756008)(86362001)(5660300002)(6512007)(9686003)(2906002)(1076003)(6436002)(229853002)(186003)(6916009)(71190400001)(102836004)(71200400001)(14444005)(256004)(8936002)(52116002)(81166006)(76176011)(6246003)(99286004)(316002)(478600001)(305945005)(25786009)(68736007)(4326008)(7736002)(386003)(6506007)(6486002)(6116002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2551;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: byhOFJ9NJNcB9VWb3sxDIaIKSAx0+aNHzBnoD+M9h3XewmKfCdwOEq4vzLbe/pLOTdwaXf1U86Ix23C3qryOMWkzU5+yaVKOlFG0gnd8bHt2GCMCcdWF+T+MUvvkgvTWFFyrbH6Ecez6LDywiF2qhA1767FUSLVihfxsV8FcYA88k1lHsJ8gIs+q+8QdqN3WvUAaxOYKn24CgIinjYM4MGoqyuLVHhItm3GInCymcXsYRad7SVBdUvd/6OdUAy2hppHuEJ1gKr8MiCK9WyZ52rzpaifp327DwijjrYeyYmLwOhtav8eqcFmhjhFOmQJ0d/0V6H44e4oWzGgdeBkdck5t/HPc3RU4uPj7a+dhdB15XmqXlUNV/7yQpPr1PPSZaO/ALI18OF6gFN2xOqle0XGGIbx7Vhlj+La0UDV9+J8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <25C31E7D308E4048959E70B81350211C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 741ed9b5-d487-45a1-3106-08d6d7c3ac75
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 16:54:33.4138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2551
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-13_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905130115
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 06:38:14PM +0200, Oleg Nesterov wrote:
> On 05/13, Oleg Nesterov wrote:
> >
> > Probably we add leave_frozen(true) after freezable_schedule() for now, =
then
> > think try to make something better...
>=20
> And again, this is what I thought ptrace_stop() does, somehow I didn't no=
tice
> that the last version doesn't have leave_frozen() in ptrace_stop().
>=20
> Perhaps we can do a bit better, change only tracehook_report_syscall_entr=
y() and
> PTRACE_EVENT_EXIT/SECCOMP paths to do leave_frozen() ?
>=20
> At first glance other callers look fine in that they can do nothing "inte=
resting"
> befor get_signal(), but we need to re-check...

Hi Oleg!

Thank you for looking into it!

I've just check the following patch (see below). It solves the regression
and overall seems correct. But I need some more time to check.

Thanks!

--

diff --git a/kernel/signal.c b/kernel/signal.c
index 8607b11ff936..088b377ad439 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2112,6 +2112,8 @@ static void ptrace_stop(int exit_code, int why, int c=
lear_code, kernel_siginfo_t
                preempt_enable_no_resched();
                cgroup_enter_frozen();
                freezable_schedule();
+               if (info)
+                       cgroup_leave_frozen(true);
        } else {
                /*
                 * By the time we got the lock, our tracer went away.
