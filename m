Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6BEC31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262EF2086A
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="fjqFKtOS";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="L/4AicPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407274AbfHIQup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:50:45 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5430 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726157AbfHIQup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:50:45 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x79GnrEe029773;
        Fri, 9 Aug 2019 09:50:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=eMQ16HGJ9hpN3Q1U8SopVeewX7T50QmuoR83d3J3v24=;
 b=fjqFKtOSj8wVZfcc//TfZ6vMR3X0AySMnbnJP8ua2GceP7xfLXuD0a+jHASDDnlbnBig
 3B9xmHpJmETHoZ/ytnTMRJtuUvsmY5PbWFNrMDY6zb/72JyL3jLIPJAn38Rbv8Xbd3ql
 eXZoM84yaAn3KN31F1xeS7PzF2/IOZNZodU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2u9930s1xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 09 Aug 2019 09:50:30 -0700
Received: from ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) by
 ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 9 Aug 2019 09:50:29 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 9 Aug 2019 09:50:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GE7aZTwG+01l6VJpZRfW8x76KcwHTuK7gzabiaTII+PuN/u4l5gSXo/cHXmtyo1FJTgdLIdoHdyvqeghC8c0Mtv8V+GtOJEuID6tNXTfqRArNO1wZW4WvdJG4TLVCdlECKxtlFgP+tcYZS9vKqCtfPFRZ454a12Osuf20/TQEk3ECb0OpyWH19YU2uBKmAnB5G3jPt08xWOpPTJ/i+Eb9N+KoJHrSi2VKtW5VOC1JE8eHrV7wwhedgaIWzS2p+4cmegWCSLYh+6ctAM091Qc/pUuG/bk2jsliaBFJQWukw8iBEed33sEUHcmy0q+YHAC+M+ICWu408/sCvB6R1J6sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMQ16HGJ9hpN3Q1U8SopVeewX7T50QmuoR83d3J3v24=;
 b=T4eUQJi+01y/IoCTz/MmLIQuemk0x+kVhuMe8WOCM8sSw1GZBZw+uA16BTLDoKFrmndH+TwOhiVE49OescPGpRZJeTJG4krP8r+F2cXJswGKvXm2qQ9jbHbXhXuSvYWoIfvLMylOqkAQ3zIOGQXE9IcrM7DrZDuSNGmhGRcqIkm7hUC1f+cWkrLiTASe8RKXp0mPFK3ZXhsi3tuPLb7FKrfEQn9pVcsc2J9Y2FZN3liXZFfUlfNMa3OUqF+FsqKseHisOAZR+K2PuwoGjDm7VU7uU98mtE5+BYZ0nO1PsXZIOdxTyuMRZoKl8OjaqesuHNV9lIYKHoDJEb6h09ucww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMQ16HGJ9hpN3Q1U8SopVeewX7T50QmuoR83d3J3v24=;
 b=L/4AicPFC38K6Tfcmhzewd7L397Mb/Z0GFWO0uTk3coOeMPdAHhXk/8w76RpYhA3gYtG+ZK5T9MK0qJ/8WZi2CXqmUiGvYZpjF2T2fsNmzyy1qMxMj+yVYD+VGL6RY+8QPeRrtrecTFaNUCns/AQ9T1WoCSFrbX7GFVrxN+cAko=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1278.namprd15.prod.outlook.com (10.175.3.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Fri, 9 Aug 2019 16:50:27 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::79c8:442d:b528:802d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::79c8:442d:b528:802d%9]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 16:50:27 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "srikar@linux.vnet.ibm.com" <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH v12 3/6] mm, thp: introduce FOLL_SPLIT_PMD
Thread-Topic: [PATCH v12 3/6] mm, thp: introduce FOLL_SPLIT_PMD
Thread-Index: AQHVTXk1mNBIE/jl/kWGntKwDXuhGKbxdEOAgAAKuICAAYcWAIAABBIA
Date:   Fri, 9 Aug 2019 16:50:27 +0000
Message-ID: <4193FF07-3191-45D1-9F3E-90F08945389F@fb.com>
References: <20190807233729.3899352-1-songliubraving@fb.com>
 <20190807233729.3899352-4-songliubraving@fb.com>
 <20190808163745.GC7934@redhat.com>
 <48316E06-10B2-439C-AD10-3EC8C86C259C@fb.com>
 <20190809163551.GB21489@redhat.com>
In-Reply-To: <20190809163551.GB21489@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::1:68ef]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58c7bd01-5570-4ad0-87a3-08d71ce9ae86
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1278;
x-ms-traffictypediagnostic: MWHPR15MB1278:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB1278B18CAD00B067F8DCA3D2B3D60@MWHPR15MB1278.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(39860400002)(376002)(396003)(366004)(189003)(199004)(66946007)(6116002)(2906002)(6246003)(99286004)(4326008)(81166006)(64756008)(6436002)(14454004)(229853002)(81156014)(6486002)(256004)(54906003)(76176011)(53936002)(46003)(33656002)(57306001)(71200400001)(102836004)(6512007)(71190400001)(36756003)(478600001)(5660300002)(76116006)(8676002)(66446008)(66556008)(8936002)(6916009)(66476007)(50226002)(305945005)(11346002)(2616005)(186003)(25786009)(446003)(316002)(486006)(6506007)(7736002)(53546011)(476003)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1278;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Oh6Ko+BliASGksdyzMnq4YiKojCPe5VDPU3Q4EmUmHPq0Lp09gHc81uQ4zdDhBsCxYn/lX35+i73h4M5DpWOccTUpHlXptUmT9UMGC2wZ2pmL6jjgnEQYo0Z9myNmUXTrEQ0KO1BSTtNVbJT74DpsgqkrC+RhETtVswH33k/BP3KfiBQV+VWdn0BsLoTRTNmuMNFVv+W4jK3CXct613xTzU8qAxm0DDGC1/PglkRLMcF+DryLZg7aLmecBVhzdMl0bdduJy0nHGtCgeN0mTMdKBxXlMbFvR9sWZUJbZIQfrquy4zgYgTKxzfzm5Ch+CEt/+LMy4017pbMqq4v653mx4k1djx1o+yrZGjgiIIdkitb0vb+kKKS9Q33QZyQdHrGYhTe/0e4w8cZQGaJAtzY/Qvfysx0T9EuMd2Mgc8Wfw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <70C0E4356A74DB439318F9359B85B812@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c7bd01-5570-4ad0-87a3-08d71ce9ae86
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 16:50:27.4655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DITPPfoeUMhhlfNkCjtfTziI3ptcuAFybei6FUxVh0D+v8dNzjbhyG5C7jmRm36WjCEx6fFNKVnt5pM85Z/vIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1278
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-09_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=886 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908090165
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 9, 2019, at 9:35 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>=20
> On 08/08, Song Liu wrote:
>>=20
>>> On Aug 8, 2019, at 9:37 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>>>=20
>>> On 08/07, Song Liu wrote:
>>>>=20
>>>> @@ -399,7 +399,7 @@ static struct page *follow_pmd_mask(struct vm_area=
_struct *vma,
>>>> 		spin_unlock(ptl);
>>>> 		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
>>>> 	}
>>>> -	if (flags & FOLL_SPLIT) {
>>>> +	if (flags & (FOLL_SPLIT | FOLL_SPLIT_PMD)) {
>>>> 		int ret;
>>>> 		page =3D pmd_page(*pmd);
>>>> 		if (is_huge_zero_page(page)) {
>>>> @@ -408,7 +408,7 @@ static struct page *follow_pmd_mask(struct vm_area=
_struct *vma,
>>>> 			split_huge_pmd(vma, pmd, address);
>>>> 			if (pmd_trans_unstable(pmd))
>>>> 				ret =3D -EBUSY;
>>>> -		} else {
>>>> +		} else if (flags & FOLL_SPLIT) {
>>>> 			if (unlikely(!try_get_page(page))) {
>>>> 				spin_unlock(ptl);
>>>> 				return ERR_PTR(-ENOMEM);
>>>> @@ -420,6 +420,10 @@ static struct page *follow_pmd_mask(struct vm_are=
a_struct *vma,
>>>> 			put_page(page);
>>>> 			if (pmd_none(*pmd))
>>>> 				return no_page_table(vma, flags);
>>>> +		} else {  /* flags & FOLL_SPLIT_PMD */
>>>> +			spin_unlock(ptl);
>>>> +			split_huge_pmd(vma, pmd, address);
>>>> +			ret =3D pte_alloc(mm, pmd) ? -ENOMEM : 0;
>>>> 		}
>>>=20
>>> Can't resist, let me repeat that I do not like this patch because imo
>>> it complicates this code for no reason.
>>=20
>> Personally, I don't think this is more complicated than your version.
>=20
> I do, but of course this is subjective.
>=20
>> Also, if some code calls follow_pmd_mask() with flags contains both
>> FOLL_SPLIT and FOLL_SPLIT_PMD, we should honor FOLL_SPLIT and split the
>> huge page.
>=20
> Heh. why not other way around?

Because FOLL_SPLIT splits both the page and the pmd. FOLL_SPLIT_PMD=20
only splits the pmd, so it is a subset of FOLL_SPLIT. When the user
sets both, we should split both the page and the pmd.=20

Thanks,
Song

