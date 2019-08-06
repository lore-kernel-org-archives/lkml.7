Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6221DC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211AC20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="GUNVhgu3";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="C+Y0gajO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfHFVEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:04:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34438 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726085AbfHFVEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:04:14 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x76L16pa020499;
        Tue, 6 Aug 2019 14:04:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ide1blu3YP8g/p2Zu+hdzW6AgELwjU9yZ4FPavPhCKc=;
 b=GUNVhgu3JfiOPb0HEOqSDGuzolJVpAxfTPqWPyCSyZOCYALEG5yoYMX9HrPCprzm/xMb
 MqS5SNLeU5qMXYMEg0wq2D/rIY2BdTtJjTFko8ELNxueRg2+2eqTL1zgz/Wy8VK6NsvS
 X/N7JrnROhvJJyE4pxR9WrAiTpMLqefrIYY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2u7am1ss3w-19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 06 Aug 2019 14:04:00 -0700
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 6 Aug 2019 14:03:59 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 6 Aug 2019 14:03:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkbUrpdmtZRwzZDiEistLWVFjp+6TCdw3s066vFclNvSjGD6chPcQMdKynLF9/N7Lvy0MBPX+nfT+ysb908tNALrly4/TvAqzG8HG7P27JinltrP1WHUDWCB4x2FvGUy1PjRtUrcuqnf3rB89w7b93OS8Jzhm2740wybbgpZgVRB0UDsMBepdZ4FK/paHvpB3srNEBXb+OPFXOG2rY+RcjcdZ5pTxCzssNrTzNsg5ysZwgyNrAAQ/l9o/7iKqTPVlbJU2Fa9AO73AoFdhySsEqUmQjmx7Yfrhr/80ZVyPKBhOQFMaDade9zk3XwWFebnv17Og8R6WNgYOP0PCirpYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ide1blu3YP8g/p2Zu+hdzW6AgELwjU9yZ4FPavPhCKc=;
 b=JmMqn3AtTcE5mn1sKz8Zq8IXcK+YCmgwONB75MS18VC+WyZm4yf9gxwWBs+XeJkXDlBnuYDGTy5KbKG7Bh2fY6jaZ8ZXhn+OFNZTJAi7ts0vOlfp08IQ74ATRSPpkR0g6Vqq/R9iGTtv3ibqlK8NEVgSuimJvvt4aSqzsT/uVfpeh07gTBlLd1O4nGqzaXQFVdBkBboeuVHY3H5HLp++gQQI6LmtEmxzl/xN3GTS6ZxZg4D9MKdafRoocvv6p7lN7hw6f3Z/Q7/M5Z8JQvmZTLw4ILzKq+4I+6bQgFE8cKW92TF29hlBKj67jyWXFIq0lmEz8+dV/cvEGJaSpJ4Ndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ide1blu3YP8g/p2Zu+hdzW6AgELwjU9yZ4FPavPhCKc=;
 b=C+Y0gajOlJasJ4EK0+MzKh+tyy7P4TEu+Hi7JRV9xEVFBJCUAb08aBWSEXO4UnY7Ta/8+s+nBx53KnmTX/tQEK4JmYCleJ3tcNzEojnbZ3m/wPCcIkQIP2XQbHlvl0tSKCyH/EDxnh4TLrH+vIlMtuLK/cpuH7BHv48Tg71a7ow=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1790.namprd15.prod.outlook.com (10.174.97.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.17; Tue, 6 Aug 2019 21:03:58 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::79c8:442d:b528:802d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::79c8:442d:b528:802d%9]) with mapi id 15.20.2136.018; Tue, 6 Aug 2019
 21:03:58 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     lkml <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "William Kucharski" <william.kucharski@oracle.com>,
        "srikar@linux.vnet.ibm.com" <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 1/2] khugepaged: enable collapse pmd for pte-mapped THP
Thread-Topic: [PATCH v4 1/2] khugepaged: enable collapse pmd for pte-mapped
 THP
Thread-Index: AQHVSYiXGgj4LZsXukKr/14r9rTZvabt6SyAgAC4r4A=
Date:   Tue, 6 Aug 2019 21:03:58 +0000
Message-ID: <38C0FD76-3CA5-4B86-AB31-FDDD72F6C557@fb.com>
References: <20190802231817.548920-1-songliubraving@fb.com>
 <20190802231817.548920-2-songliubraving@fb.com>
 <20190806100256.GA21454@redhat.com>
In-Reply-To: <20190806100256.GA21454@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::2:4454]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6931790b-a5e1-4944-e41a-08d71ab199a4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1790;
x-ms-traffictypediagnostic: MWHPR15MB1790:
x-microsoft-antispam-prvs: <MWHPR15MB1790B677F795958445B957FEB3D50@MWHPR15MB1790.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0121F24F22
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(346002)(39860400002)(376002)(366004)(199004)(189003)(66556008)(2616005)(476003)(50226002)(46003)(486006)(229853002)(446003)(6246003)(5660300002)(66446008)(6486002)(316002)(66946007)(11346002)(64756008)(66476007)(186003)(53936002)(305945005)(6436002)(6512007)(33656002)(25786009)(57306001)(7736002)(68736007)(8936002)(6506007)(102836004)(53546011)(478600001)(86362001)(76176011)(54906003)(4326008)(36756003)(6916009)(76116006)(8676002)(256004)(6116002)(14444005)(2906002)(99286004)(71200400001)(71190400001)(81166006)(14454004)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1790;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wDqnauJb9gKOixGqaxXXVDT4mber2l6Cef5EuDRbV3GPvSrPkTTqmmVvRSCu5aP0BdkUyyLWX41+1IWZz95gv5DAYv9/YIrhz1ztxPsw9tXUhReLNL0rcGhGQn+JSijRfKwwcsqk5Ne5OYO5NyIpkeeqt/XMDTz5oIftwBeb2OU09kEZGED7Vnu1aJMIXWYB6W+bMmGqCX8FVkh84iQiDgVFJnjlmrFHx+nIpDnVRzok2wixrQbpOTs4QvNeJHL1gEeWV92bahFZO8MS7plxE2UFez1kMFhUOidUnAOc98qNg4pZbluwSs5oc/G94vZX2YwTbzjbzmObbBS+Ln9kq+n46thFHQl0jY2wvghmMdBztIooBvZ9mDc2zvcJRX9ZratG/tDnWSXgrMdbQyLxcyMXm+ex4RhOzfZp6zel4y8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <92A3DAB23753FE40BB55EC4FF7568523@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6931790b-a5e1-4944-e41a-08d71ab199a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2019 21:03:58.3629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1790
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-06_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=879 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908060182
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 6, 2019, at 3:02 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>=20
> On 08/02, Song Liu wrote:
>>=20
>> +void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
>> +{
>> +	unsigned long haddr =3D addr & HPAGE_PMD_MASK;
>> +	struct vm_area_struct *vma =3D find_vma(mm, haddr);
>> +	pmd_t *pmd =3D mm_find_pmd(mm, haddr);
>> +	struct page *hpage =3D NULL;
>> +	spinlock_t *ptl;
>> +	int count =3D 0;
>> +	pmd_t _pmd;
>> +	int i;
>> +
>> +	if (!vma || !vma->vm_file || !pmd ||
>> +	    vma->vm_start > haddr || vma->vm_end < haddr + HPAGE_PMD_SIZE)
>> +		return;
>=20
> I still can't understand why is it safe to blindly use mm_find_pmd().
>=20
> Say, what pmd_offset(pud, address) will return to this function if
> pud_huge() =3D=3D T? IIUC, this is possible if is_file_hugepages(vm_file)=
.
> How the code below can use this result?

IIUC, the concern is matching files in hugetlbfs. Maybe we can exclude
that specifically?=20

>=20
> I think you need something like hugepage_vma_check() or even
> hugepage_vma_revalidate().

To use hugepage_vma_check(), we will need to set VM_HUGEPAGE for the=20
following case:

    mount shm with huge=3Dalways
    copy app to shm
    start app and enable uprobe
    disable uprobe

This vma will not have VM_HUGEPAGE, so it will fail hugepage_vma_check().

How about something like:

diff --git i/kernel/events/uprobes.c w/kernel/events/uprobes.c
index 94d38a39d72e..f0d3e367f907 100644
--- i/kernel/events/uprobes.c
+++ w/kernel/events/uprobes.c
@@ -532,8 +532,10 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, s=
truct mm_struct *mm,
                                put_page(new_page);
                                new_page =3D NULL;

-                               if (PageCompound(orig_page))
+                               if (PageCompound(orig_page)) {
                                        orig_page_huge =3D true;
+                                       vma->vm_flags |=3D VM_HUGEPAGE;
+                               }
                        }
                        put_page(orig_page);
                }

Thanks,
Song=
