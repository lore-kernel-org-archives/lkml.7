Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D07FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11BA32067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="f/FhoMQM";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="H5VrYAlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405428AbfJPQLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 12:11:05 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52142 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405297AbfJPQLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:11:04 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9GG9DpB017694;
        Wed, 16 Oct 2019 09:10:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=GfoXv/Fqrk3PRrOlR1VGGxedXFlxXp5lwUxvKUBzTd0=;
 b=f/FhoMQMas9VfT21hDDC5oindrZWOB/z/4gLjBwZ583Qh/AmJreIdBJr/ckT9CA/XF07
 YV9az2kR89mcKf1EpP3+4ZMbrgYctxmCuYq0EXBKUnGP0uASC9604XFfrJq1rRIC+FTd
 oatDC3o2LplByf9lpneQ4p+T+xgSLYsH4vc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vmtajk77s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 16 Oct 2019 09:10:52 -0700
Received: from ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 16 Oct 2019 09:10:51 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 16 Oct 2019 09:10:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfLE0fn41+yTPiDi/hC18IO5rB4yuKvMPcrN4B+4C1K0vAinG3VbSDmwfoRQ5fU3XbKFelD7ATRe2WftkP/oeGTEE1qOBVPFD+7MbUCgGEhw7OBbxSLuQWA0UXDaZnuf+A4tbXrtFSLHZ2MXKe1S8kK1C+Am9qWazn+OAt20xQnB+9gMoU72P6WJHKUoxLIxDhKJQd0FuFDyU5rAEeNuhbGoT6NQuNLooPxKi4pD8uvI9y7h+AXimpqUXdKs31xfR0uaJcSWghCdcQDZkbQFBYF6Wc9A+UTLdj18tOjuEtY0MQQDrClDGHgYn5d+vQsRcC9jTZtOar8iUu1K3Jw+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfoXv/Fqrk3PRrOlR1VGGxedXFlxXp5lwUxvKUBzTd0=;
 b=ln4FznQYIlDzVGKe/nQ+sXfvL0zJZEekx9qJw4rn/pGa5eHjSr7uRfBc9v2EGZ+xICStfW69yY00px3xrEjPBjHqy5KRkBFpWNf3AVcAeTFSHbmicIBytqPCvypgvBcPmC7gvJK2x/BSb+kEytdFTEMjSUC4lOqeROb/T/kJt+WoikR/Yjt7Zrr+TWR6DiivH9ZjvcoIco8aG8h/YOxqhvsOHO/Jrm6Fm7I0Ln/GybLTFLK5vrTQf2ewQh1kyz6wdx1ARPP0tnPOl44WiCEVXIp82o/bl/OpmbJgWFQTycXmdaokJ8rPWIIN5NSfu+DxsmUOsFzIJJCWhF6yr6yi7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfoXv/Fqrk3PRrOlR1VGGxedXFlxXp5lwUxvKUBzTd0=;
 b=H5VrYAlkUO2VBUbmsLMebxxx9jOHT64a+oa0efAD2xP0cmDVATH8wq+yzSF3hA9eSh9E/5497tDTPBXsWemfkBpH0OEXWS1rygtcicBLRnG2bupqzSDmKyUilwx2VSI56RoKzVJDyEbiYjNCZk3nHR9S9pW4y5rTh0yutBMyZ80=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1360.namprd15.prod.outlook.com (10.173.228.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.18; Wed, 16 Oct 2019 16:10:49 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2347.023; Wed, 16 Oct 2019
 16:10:49 +0000
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
Thread-Index: AQHVg/TTl1jUwKEEhEe4JMFjXQBksqddLX+AgABDI4A=
Date:   Wed, 16 Oct 2019 16:10:49 +0000
Message-ID: <CE3DD093-E5B4-4C98-A7B7-3B05D7732D3C@fb.com>
References: <20191016073731.4076725-1-songliubraving@fb.com>
 <20191016073731.4076725-5-songliubraving@fb.com>
 <20191016121031.GA31585@redhat.com>
In-Reply-To: <20191016121031.GA31585@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3594.4.19)
x-originating-ip: [2620:10d:c090:200::1:35f7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f833eda3-5037-4061-1739-08d752536944
x-ms-traffictypediagnostic: MWHPR15MB1360:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB136008E9AF88264DB162F3E8B3920@MWHPR15MB1360.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0192E812EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(366004)(376002)(136003)(189003)(199004)(6116002)(64756008)(8676002)(6512007)(66556008)(6246003)(6506007)(54906003)(316002)(229853002)(478600001)(81156014)(86362001)(71200400001)(486006)(476003)(71190400001)(33656002)(50226002)(81166006)(6436002)(186003)(102836004)(46003)(66476007)(76116006)(66446008)(6916009)(446003)(305945005)(66946007)(53546011)(11346002)(2616005)(7736002)(76176011)(14444005)(2906002)(14454004)(256004)(99286004)(6486002)(25786009)(4326008)(36756003)(8936002)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1360;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gD7QeNp7jW9EDkRJgYqRFBP3Z2osBfBS4C+DiI5k2mQ3+1rGYlPIWPSrj2sUpLJjKtHjDstYIliFdYbN3DcFdD1gHjw5Vv2o5l05VtgeCNwdOhF7DIUKUfExfQlo1Hp1gI1c7b9iSmQ4phnjk69b3yrt8uz7ReTy8nnA55QVg6lk56CPtnCT1C7f78LF8OKcrPGYpS04SBIqaoTBv7RJ2jR0s9R2sNNxSm0yM/9GiVI/GMHmW/ezK2XraW4s8YHaJ/OGiH1DzzeFUQTSUXhn/pataKhs8PTOn2RqvgbVKGkoVw8GHLLn5Xu6rjEzKWez+lyUh3TUhv09vr7B9sJOxUZj8a8lepPI+wzXYwdyo2u014nZNHOTz+NEsljyFRlL+fididLNVRFmpBV9HB5435qlHQ4qvmrXMxkLwFDAjPo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E81786F0A079F04B926518CE3CA6CF2D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f833eda3-5037-4061-1739-08d752536944
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2019 16:10:49.5778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n60JP/0m0vc2RSQreU45iujkoUxM7EwykTgNYbS6RqMGzG6c9MLtUKOwp/ROEZrkGlYjAwRDatefkUNv+wIoDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1360
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_07:2019-10-16,2019-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910160135
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 16, 2019, at 5:10 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>=20
> On 10/16, Song Liu wrote:
>>=20
>> --- a/kernel/events/uprobes.c
>> +++ b/kernel/events/uprobes.c
>> @@ -474,14 +474,17 @@ int uprobe_write_opcode(struct arch_uprobe *auprob=
e, struct mm_struct *mm,
>> 	struct vm_area_struct *vma;
>> 	int ret, is_register, ref_ctr_updated =3D 0;
>> 	bool orig_page_huge =3D false;
>> +	unsigned int gup_flags =3D FOLL_FORCE;
>>=20
>> 	is_register =3D is_swbp_insn(&opcode);
>> 	uprobe =3D container_of(auprobe, struct uprobe, arch);
>>=20
>> retry:
>> +	if (is_register)
>> +		gup_flags |=3D FOLL_SPLIT_PMD;
>> 	/* Read the page with vaddr into memory */
>> -	ret =3D get_user_pages_remote(NULL, mm, vaddr, 1,
>> -			FOLL_FORCE | FOLL_SPLIT_PMD, &old_page, &vma, NULL);
>> +	ret =3D get_user_pages_remote(NULL, mm, vaddr, 1, gup_flags,
>> +				    &old_page, &vma, NULL);
>> 	if (ret <=3D 0)
>> 		return ret;
>>=20
>> @@ -489,6 +492,9 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe,=
 struct mm_struct *mm,
>> 	if (ret <=3D 0)
>> 		goto put_old;
>>=20
>> +	WARN(!is_register && PageCompound(old_page),
>> +	     "uprobe unregister should never work on compound page\n");
>=20
> But this can happen with the change above. You can't know if *vaddr was
> previously changed by install_breakpoint() or not.

> If not, verify_opcode() should likely save us, but we can't rely on it.
> Say, someone can write "int3" into vm_file at uprobe->offset.

I think this won't really happen. With is_register =3D=3D false, we already=
=20
know opcode is not "int3", so current call must be from set_orig_insn().=20
Therefore, old_page must be installed by uprobe, and cannot be compound.

The other way is not guaranteed. With is_register =3D=3D true, it is still
possible current call is from set_orig_insn(). However, we do not rely
on this path.=20

Does this make sense? Or did I miss anything?

>=20
> And I am not sure it is safe to continue in this case, I'd suggest to
> return -EWHATEVER to avoid the possible crash.

I think we can return -ESOMETHING here to be safe. However, if the=20
analysis above makes sense, it is not necessary.=20

Thanks,
Song


