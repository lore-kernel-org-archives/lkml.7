Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3F9C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0453F208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Ho9KDzVp";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="IG7a0XU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbfFXNye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:54:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45680 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726716AbfFXNye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:54:34 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x5ODmit0018485;
        Mon, 24 Jun 2019 06:53:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=t7qV2OGm0S3XSCrqDNJX/lyn1hSgceyLnzNY2vFjfJU=;
 b=Ho9KDzVpewuxMaeCVuFE5BkF8+Z0l4UZYRic+2+eRaM9jLnPmXA2Vs+c1KQ4P3azAuTc
 jg06iPwGlnmsSBO0wVAp2IKfMHVatwQh7lTBra5INpupejqz1v07D2aLBuFGfO9+6+Uq
 BcVEi8b+AtUmHT0/igE8ViXfCGefyJG+QXY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2tavm1rmqd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 24 Jun 2019 06:53:05 -0700
Received: from ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 24 Jun 2019 06:53:05 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exopmbx201.TheFacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 24 Jun 2019 06:53:04 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 24 Jun 2019 06:53:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7qV2OGm0S3XSCrqDNJX/lyn1hSgceyLnzNY2vFjfJU=;
 b=IG7a0XU+y63MaCSENF9jwD/YN1nEpr0aiof8RjwbK6Kp+afeJnH+Hpe1hOkzJ14qlSMgY1XPaGLwQmh/NrFJl+2vIXl5Wk7ay/V2sICcQX5OQyS4OH1wswhEiwNcTT9/+Qw+RE0YKIWlldaHFMW4gETQhcBRTpt6Y1R7NPrQQDQ=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1328.namprd15.prod.outlook.com (10.175.3.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 13:53:03 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 13:53:02 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Kernel Team" <Kernel-team@fb.com>
Subject: Re: [PATCH v4 5/5] uprobe: collapse THP pmd after removing all
 uprobes
Thread-Topic: [PATCH v4 5/5] uprobe: collapse THP pmd after removing all
 uprobes
Thread-Index: AQHVIhGkBNxZAI1nUkK1d2OfbYvmTqamGxWAgAAIBYCAAAVYgIAAAncAgAAuG4CAABpPgIAEWukAgAAV5oA=
Date:   Mon, 24 Jun 2019 13:53:02 +0000
Message-ID: <4AAAAA33-9DA1-4301-8A98-4D230BC49408@fb.com>
References: <20190613175747.1964753-1-songliubraving@fb.com>
 <20190613175747.1964753-6-songliubraving@fb.com>
 <20190621124823.ziyyx3aagnkobs2n@box>
 <B72B62C9-78EE-4440-86CA-590D3977BDB1@fb.com>
 <20190621133613.xnzpdlicqvjklrze@box>
 <4B58B3B3-10CB-4593-8BEC-1CEF41F856A1@fb.com>
 <707D52CA-E782-4C9A-AC66-75938C8E3358@fb.com>
 <DB6689FE-8528-4883-8CD9-CFE5F3BEC321@fb.com>
 <20190624123438.dubsp52tauwkr342@box>
In-Reply-To: <20190624123438.dubsp52tauwkr342@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::1:d642]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bef99adc-ecb2-4b30-4253-08d6f8ab46bd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1328;
x-ms-traffictypediagnostic: MWHPR15MB1328:
x-microsoft-antispam-prvs: <MWHPR15MB1328084C144D0712BB1DB48CB3E00@MWHPR15MB1328.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(136003)(396003)(366004)(199004)(189003)(6246003)(8936002)(478600001)(76176011)(50226002)(6486002)(53546011)(102836004)(68736007)(6512007)(6436002)(6116002)(46003)(5660300002)(476003)(33656002)(54906003)(446003)(2616005)(486006)(316002)(71190400001)(256004)(71200400001)(11346002)(81166006)(81156014)(36756003)(305945005)(2906002)(7736002)(229853002)(86362001)(99286004)(14454004)(8676002)(57306001)(6506007)(66946007)(73956011)(66556008)(66476007)(186003)(25786009)(53936002)(6916009)(64756008)(66446008)(4326008)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1328;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Jtcv2lKTVi7GCLtnB6QW5ZeWCAThVfvF8LALBfbddCN5QQF53NwDoHw3F7wOVnJ9Tk9CZu33u0CiY2r755SceWj9gnJbakft9V8bFl13P9Y1MO+hKhhOVuaKnxbJ+9yytkJJFpQOAZsDUADk0zzYNVShgwYOBOHrp20NfY6Il/NojOEwMwHP6wCt4xaKsX14NBjFnkDq+yj8CBPxqEDi2mV5E1ExFiYpYs4kSkxWFLsHYVGf5M5qCpL6dVNkWX7DUIRvpWpM9BQXHLFkRMKZKQCdPETfpWLI+6A0mM5wQ/WUX2KMNk1CxIieFWIP/LUNxxF08dQdRYApSeRdR9PXcHlWl8mZR0RPBCEDnPeU4tPTBYnH2Cf05bA1nDIyzw2qRRfU3jI7HV+qKuzUuXn7blN2+wKxA8vzq8BxkoDS9mU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A9015E19456B554FA676A5F36DB64F5A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bef99adc-ecb2-4b30-4253-08d6f8ab46bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 13:53:02.7797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1328
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=863 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240113
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 24, 2019, at 5:34 AM, Kirill A. Shutemov <kirill@shutemov.name> wr=
ote:
>=20
> On Fri, Jun 21, 2019 at 06:04:14PM +0000, Song Liu wrote:
>>=20
>>=20
>>> On Jun 21, 2019, at 9:30 AM, Song Liu <songliubraving@fb.com> wrote:
>>>=20
>>>=20
>>>=20
>>>> On Jun 21, 2019, at 6:45 AM, Song Liu <songliubraving@fb.com> wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On Jun 21, 2019, at 6:36 AM, Kirill A. Shutemov <kirill@shutemov.name=
> wrote:
>>>>>=20
>>>>> On Fri, Jun 21, 2019 at 01:17:05PM +0000, Song Liu wrote:
>>>>>>=20
>>>>>>=20
>>>>>>> On Jun 21, 2019, at 5:48 AM, Kirill A. Shutemov <kirill@shutemov.na=
me> wrote:
>>>>>>>=20
>>>>>>> On Thu, Jun 13, 2019 at 10:57:47AM -0700, Song Liu wrote:
>>>>>>>> After all uprobes are removed from the huge page (with PTE pgtable=
), it
>>>>>>>> is possible to collapse the pmd and benefit from THP again. This p=
atch
>>>>>>>> does the collapse.
>>>>>>>>=20
>>>>>>>> An issue on earlier version was discovered by kbuild test robot.
>>>>>>>>=20
>>>>>>>> Reported-by: kbuild test robot <lkp@intel.com>
>>>>>>>> Signed-off-by: Song Liu <songliubraving@fb.com>
>>>>>>>> ---
>>>>>>>> include/linux/huge_mm.h |  7 +++++
>>>>>>>> kernel/events/uprobes.c |  5 ++-
>>>>>>>> mm/huge_memory.c        | 69 +++++++++++++++++++++++++++++++++++++=
++++
>>>>>>>=20
>>>>>>> I still sync it's duplication of khugepaged functinallity. We need =
to fix
>>>>>>> khugepaged to handle SCAN_PAGE_COMPOUND and probably refactor the c=
ode to
>>>>>>> be able to call for collapse of particular range if we have all loc=
ks
>>>>>>> taken (as we do in uprobe case).
>>>>>>>=20
>>>>>>=20
>>>>>> I see the point now. I misunderstood it for a while.=20
>>>>>>=20
>>>>>> If we add this to khugepaged, it will have some conflicts with my ot=
her=20
>>>>>> patchset. How about we move the functionality to khugepaged after th=
ese
>>>>>> two sets get in?=20
>>>>>=20
>>>>> Is the last patch of the patchset essential? I think this part can be=
 done
>>>>> a bit later in a proper way, no?
>>>>=20
>>>> Technically, we need this patch to regroup pmd mapped page, and thus g=
et=20
>>>> the performance benefit after the uprobe is detached.=20
>>>>=20
>>>> On the other hand, if we get the first 4 patches of the this set and t=
he=20
>>>> other set in soonish. I will work on improving this patch right after =
that..
>>>=20
>>> Actually, it might be pretty easy. We can just call try_collapse_huge_p=
md()=20
>>> in khugepaged.c (in khugepaged_scan_shmem() or khugepaged_scan_file() a=
fter=20
>>> my other set).=20
>>>=20
>>> Let me fold that in and send v5.=20
>>=20
>> On a second thought, if we would have khugepaged to do collapse, we need=
 a
>> dedicated bit to tell khugepaged which pmd to collapse. Otherwise, it ma=
y=20
>> accidentally collapse pmd that are split by other split_huge_pmd.=20
>=20
> Why is it a problem? Do you know a situation where such collapse possible
> and will break split_huge_pmd() user's expectation. If there's such user
> it is broken: normal locking should prevent such situation.
>=20

You are right. I found the the same after a third thought. So I tried to=20
get that logic in v6.=20

Thanks,
Song

