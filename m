Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E18BFA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 15:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0943D20650
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 15:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="FDBPO8pS";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="JVnoykXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407885AbfJQPf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 11:35:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20562 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407797AbfJQPf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 11:35:59 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x9HFZdn5030122;
        Thu, 17 Oct 2019 08:35:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=vvjmI7rGgegub3ftClGQFVwDM6NwKD2frvX5lGUhugQ=;
 b=FDBPO8pS73GoD/BZwuUc0c/AsNZKo1cWU/Z0EgSHqdhI9+ljciR/LhfoqioHt4y+CFU+
 hMGu1lXGN2yKbAB7m0dEBGaXM/yupJjjhKQdZa+fde3dazjiWSP/Xoo2DcqmlSZP8rh1
 dmuJblktP7ctAuWSEh/PeqoZL9ckilrWiY0= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2vp3uk64ba-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 17 Oct 2019 08:34:27 -0700
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 17 Oct 2019 08:34:25 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 17 Oct 2019 08:34:24 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 17 Oct 2019 08:34:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gs03pRj9bVhEXWpP8MzRgbqATITiEtAmb/D9sKb0jmdtFkeHhwqzX3uot8ccE14FsXWLyP6pYP2q0svO2P/M2473Czn+SD4zXpEicXIjDx8Bes38tDS827FN6vV1UhZGTFgLnnTTOPRw7nbzkhj9ahxJuBa7iaobr7Qo9FbuHtZm7R1HDEGEwEHBrk4OlivO8t0UshnT5IasSOIgx2i5LF/osnFxFHtyBy5rFM+sxWH3BHUxKuRjm/MMsH7/rPAulNQH30paGDP30egFsXgq3EriLAorsL8TohMw7erfOvJkXRW+t8c1ddNJ9Y0YmXEYzysDZylT1yoFuCQ1CoJbvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvjmI7rGgegub3ftClGQFVwDM6NwKD2frvX5lGUhugQ=;
 b=MWPsnnGB/xGvt6tXdoas65o/Tz4XNcTui2JdioRLXJYxJ+puuB433uUMKFcF4WzIzdYFELORhOllAZIfJZrtlm8BLL61gBHn3V+ebyVDsz9CdbT/wQP6xcoKnHr5MqqOTTKqyfxjqcliHwBt5hx9fv842QADRUomdOixCA9BXn1DQ+oBhZEz9Kiw4ebogy293bfPk+jy5tczeUE00V73IEp23brvPu2rcGlsQ4XEUoNLFjmjhSvTxUY8GD3n5ctV+EGYg6m602U9TXU3B4BqdA2uamYGuWzp88uy5N4jJ9D3IaZZvuuAYW+Wy1m2ETU2Jn5AiCvhKh6TD9AJUMMNbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vvjmI7rGgegub3ftClGQFVwDM6NwKD2frvX5lGUhugQ=;
 b=JVnoykXBjCCJ1sdHCdEpD1uN8ElegLeuSjBTzwPteqjEyLXoLAC/eXezpOizDi1NI6B7k3i2WKtCnVa+kuY4Hs43qozpBtKjjYuIyWodNSqqYCi+X4JXX7rnxw79A6CgY0Vp/F5YHVYzspP9kR4aERkayATV6SZ0R9++6np+g7Y=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1151.namprd15.prod.outlook.com (10.175.2.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 17 Oct 2019 15:34:22 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 15:34:22 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     open list <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] uprobe: only do FOLL_SPLIT_PMD for uprobe register
Thread-Topic: [PATCH 4/4] uprobe: only do FOLL_SPLIT_PMD for uprobe register
Thread-Index: AQHVg/TTl1jUwKEEhEe4JMFjXQBksqddLX+AgABDI4CAARZmAIAAWN+AgAAGcwCAABJuAA==
Date:   Thu, 17 Oct 2019 15:34:22 +0000
Message-ID: <6A48134B-416B-4A1D-B337-1B638D084382@fb.com>
References: <20191016073731.4076725-1-songliubraving@fb.com>
 <20191016073731.4076725-5-songliubraving@fb.com>
 <20191016121031.GA31585@redhat.com>
 <CE3DD093-E5B4-4C98-A7B7-3B05D7732D3C@fb.com>
 <20191017084714.GB17513@redhat.com>
 <A1DBC6EA-CBAB-45FE-919D-6D77D29DDE1D@fb.com>
 <20191017142824.GA453@redhat.com>
In-Reply-To: <20191017142824.GA453@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3594.4.19)
x-originating-ip: [2620:10d:c090:200::1:4c3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b54ff04-0b7c-435b-0076-08d753177c23
x-ms-traffictypediagnostic: MWHPR15MB1151:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB1151B698B27A8C3C2C8BD78FB36D0@MWHPR15MB1151.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(136003)(376002)(366004)(189003)(199004)(36756003)(81156014)(8676002)(14454004)(64756008)(66556008)(6506007)(76176011)(186003)(53546011)(102836004)(66446008)(486006)(476003)(4326008)(7736002)(33656002)(5660300002)(66476007)(6116002)(76116006)(86362001)(6916009)(25786009)(478600001)(66946007)(305945005)(81166006)(71190400001)(71200400001)(256004)(316002)(50226002)(446003)(99286004)(54906003)(229853002)(6246003)(6486002)(46003)(2616005)(2906002)(11346002)(5024004)(6512007)(8936002)(6436002)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1151;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MVyuOE5DwtHtJzBi54E7xNqustp1fVfXauIToVbJfKaRZSbI5LS0eGzaia80Gs2tkgBIAF6Gy6GOFBI1bSl0FlZQHc1JAFezfUJbS3ocCAYA0wzmKJOHTKwI51U28pOg/6TzGxirWnCgREtSZp9IqY7DoRwL/7mR6dKqN1auXwEit46M9N0RpWUYP06wm+uKg0nlLYSSWb7N1QP11nLYcNxF0DM2MMhkyYWb9+Vdhhekh0rY6jwOTv2QaOdFIeHNEzRtUab88EyAO3oGhvNSnbhfByQyBH28jT4jkLtozC1zLVhgdnVZiox0zxwowq+W2UkXy6fUgdHU5DIVkNr2Sbq/AzeKPSVxHD/N1SaGbC4Cx9DEJmZGbgiLIB5XxRpKsiHbtycUvH0Tye2EudkKIpfD0lHvwX3zIsNkHTRbu+Y=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1C75F855DA0E614C88DD90E0E365BE21@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b54ff04-0b7c-435b-0076-08d753177c23
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 15:34:22.6926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /7nKB8EYes98+0nvSqn0hsCWJaCiTBlJ2Fu7OcxRQpCOTfVWS037o7MJ72QisRgRapvSx2vMyeZ+jH4B5333Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1151
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-17_05:2019-10-17,2019-10-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910170139
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 17, 2019, at 7:28 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>=20
> On 10/17, Song Liu wrote:
>>=20
>>=20
>>> On Oct 17, 2019, at 1:47 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>>>=20
>>> On 10/16, Song Liu wrote:
>>>>=20
>>>>> On Oct 16, 2019, at 5:10 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>>>>>=20
>>>>>> @@ -489,6 +492,9 @@ int uprobe_write_opcode(struct arch_uprobe *aupr=
obe, struct mm_struct *mm,
>>>>>> 	if (ret <=3D 0)
>>>>>> 		goto put_old;
>>>>>>=20
>>>>>> +	WARN(!is_register && PageCompound(old_page),
>>>>>> +	     "uprobe unregister should never work on compound page\n");
>>>>>=20
>>>>> But this can happen with the change above. You can't know if *vaddr w=
as
>>>>> previously changed by install_breakpoint() or not.
>>>>=20
>>>>> If not, verify_opcode() should likely save us, but we can't rely on i=
t.
>>>>> Say, someone can write "int3" into vm_file at uprobe->offset.
>>>>=20
>>>> I think this won't really happen. With is_register =3D=3D false, we al=
ready
>>>> know opcode is not "int3", so current call must be from set_orig_insn(=
).
>>>> Therefore, old_page must be installed by uprobe, and cannot be compoun=
d.
>>>>=20
>>>> The other way is not guaranteed. With is_register =3D=3D true, it is s=
till
>>>> possible current call is from set_orig_insn(). However, we do not rely
>>>> on this path.
>>>=20
>>> Quite contrary.
>>>=20
>>> When is_register =3D=3D true we know that a) the caller is install_brea=
kpoint()
>>> and b) the original insn is NOT int3 unless this page was alreadt COW'e=
d by
>>> userspace, say, by gdb.
>>>=20
>>> If is_register =3D=3D false we only know that the caller is remove_brea=
kpoint().
>>> We can't know if this page was COW'ed by uprobes or userspace, we can n=
ot
>>> know if the insn we are going to replace is int3 or not, thus we can no=
t
>>> assume that verify_opcode() will fail and save us.
>>=20
>> So the case we worry about is:
>> old_page is COW by user space,
>=20
> no, in this case the page shouldn't be huge,
>=20
>> target insn is int3, and it is a huge page;
>> then uprobe calls remove_breakpoint();
>=20
> Yes,
>=20
>> Yeah, I guess this could happen.
>=20
> Yes,
>=20
>> For the fix, I guess return -Esomething in such case should be sufficien=
t?
>=20
> this is what I tried to suggest from the very beginning.
>=20

Thanks Oleg!

Attached is v2 of 4/4.=20

Song


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

From 0ab451f31b8fa6315d9de86eebe5d6c44dabac7e Mon Sep 17 00:00:00 2001
From: Song Liu <songliubraving@fb.com>
Date: Tue, 15 Oct 2019 22:38:55 -0700
Subject: [PATCH v2 4/4] uprobe: only do FOLL_SPLIT_PMD for uprobe register

Attaching uprobe to text section in THP splits the PMD mapped page table
into PTE mapped entries. On uprobe detach, we would like to regroup PMD
mapped page table entry to regain performance benefit of THP.

However, the regroup is broken For perf_event based trace_uprobe. This is
because perf_event based trace_uprobe calls uprobe_unregister twice on
close: first in TRACE_REG_PERF_CLOSE, then in TRACE_REG_PERF_UNREGISTER.
The second call will split the PMD mapped page table entry, which is not
the desired behavior.

Fix this by only use FOLL_SPLIT_PMD for uprobe register case.

Add a WARN() to confirm uprobe unregister never work on huge pages, and
abort the operation when this WARN() triggers.

Fixes: 5a52c9df62b4 ("uprobe: use FOLL_SPLIT_PMD instead of FOLL_SPLIT")
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Song Liu <songliubraving@fb.com>

---
Changes v1 -> v2:
Return -EINVAL if the WARN() triggers. (Oleg Nesterov)
---
 kernel/events/uprobes.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 94d38a39d72e..c74761004ee5 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -474,14 +474,17 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, =
struct mm_struct *mm,
        struct vm_area_struct *vma;
        int ret, is_register, ref_ctr_updated =3D 0;
        bool orig_page_huge =3D false;
+       unsigned int gup_flags =3D FOLL_FORCE;

        is_register =3D is_swbp_insn(&opcode);
        uprobe =3D container_of(auprobe, struct uprobe, arch);

 retry:
+       if (is_register)
+               gup_flags |=3D FOLL_SPLIT_PMD;
        /* Read the page with vaddr into memory */
-       ret =3D get_user_pages_remote(NULL, mm, vaddr, 1,
-                       FOLL_FORCE | FOLL_SPLIT_PMD, &old_page, &vma, NULL)=
;
+       ret =3D get_user_pages_remote(NULL, mm, vaddr, 1, gup_flags,
+                                   &old_page, &vma, NULL);
        if (ret <=3D 0)
                return ret;

@@ -489,6 +492,12 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, s=
truct mm_struct *mm,
        if (ret <=3D 0)
                goto put_old;

+       if (WARN(!is_register && PageCompound(old_page),
+                "uprobe unregister should never work on compound page\n"))=
 {
+               ret =3D -EINVAL;
+               goto put_old;
+       }
+
        /* We are going to replace instruction, update ref_ctr. */
        if (!ref_ctr_updated && uprobe->ref_ctr_offset) {
                ret =3D update_ref_ctr(uprobe, mm, is_register ? 1 : -1);
--
2.17.1


