Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC57ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869DC2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="gU2b6T9h";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="iOewOakb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389254AbfJQOFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:05:35 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:61396 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727447AbfJQOFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:05:34 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9HE58PW011490;
        Thu, 17 Oct 2019 07:05:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=YIdvY0DQwcSaESA1HkxfzVzNK2eSw4p1h1XN90pwJb0=;
 b=gU2b6T9hOgLz6sJeoLRA5KGBlrQPLuSVUDC9bEaAcexJTraOirVCs48Z4hCTN//Y7cE1
 xyD3+S3jqThEZI6Ptch5GB3sW/NQTWAONzjniQpIeT98WCIqjYQT4JkSzXU4pPBAWSt3
 nnz/x9vVxDteoQ1FqhSkoS+vg9h8CM9ylAU= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vp5k0db0e-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 17 Oct 2019 07:05:23 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 17 Oct 2019 07:05:21 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 17 Oct 2019 07:05:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgXCh/HZJYPSYaN0kEgrCFpu09RZ1w6YM1kqDAkJZOu1w8+he3avyvN9L3Rgs2pU4HvDE8tMSWn5FG/5sH4R4IZd/0QIlsagQWrxuwEEat5T8Vp5xQBJ5goPhfKBgCv2v9VuIfT8+QJ5n5stFuLWoawEM/SMYVKulFus2kNOLF/xivmQ0Y9eiRLouuHhN74EULvLMuDc0PmDtXavCg9s338R9yt8Eih+pJHV/2A2S6VxG03an1uVIlWfuDZHWMgGS0v2h7p2eySIkMt8FgNtUSURd5/KKJI+2YRkPjze4i4x2s/ruvXGFzFobZ2KETeVdSYcijKTCNDdLoK96MvLLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIdvY0DQwcSaESA1HkxfzVzNK2eSw4p1h1XN90pwJb0=;
 b=cWHKc/hH7eEeha+s78GKS2P9nR5zbjK2N8oECz+pv+J5NaXk2UxyDy2ev+7z3bL+Yy/BePFZ1bWBayfpswI+wwhgqmhi/jWb99/MN7TOQD4RMyWpq9xYGXfPOO/EK3diLApHMR8C/JiOTZrTW1aMCyH1upcwokEIioAuzDZdshxj9bcds72HSk44XaHvfBijvb48a5uHOzpQUxecc1r19UsWrPeN+Vij1D8NIPz1KJQj5D+jXKfmXjnZRMXFvTxj/05mzwiBIDpTq+E5M/Kmi2q5SzMCdqrSIWIPuqBfQSXAj1IDKC543sq2hhRoFzPD8X65O9Y4wMnYs4Uxk6JeDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIdvY0DQwcSaESA1HkxfzVzNK2eSw4p1h1XN90pwJb0=;
 b=iOewOakbkHTy4APfreAYq8T6odfuZA0Z7hgpa+mdGjSUzu8dVXRPjsCfd9drNBN0lSgyivMbQyS0LLKUEUSMsgeHa5ysj8Y3AUJ4yHVUCONabQaOgGsrf+3Qd3KUNEWbMKRz0fv9KBKcjOVY0CXTTyAFGM488RqrW50DSXIJE2A=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1519.namprd15.prod.outlook.com (10.173.234.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.19; Thu, 17 Oct 2019 14:05:20 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2347.023; Thu, 17 Oct 2019
 14:05:20 +0000
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
Thread-Index: AQHVg/TTl1jUwKEEhEe4JMFjXQBksqddLX+AgABDI4CAARZmAIAAWN+A
Date:   Thu, 17 Oct 2019 14:05:19 +0000
Message-ID: <A1DBC6EA-CBAB-45FE-919D-6D77D29DDE1D@fb.com>
References: <20191016073731.4076725-1-songliubraving@fb.com>
 <20191016073731.4076725-5-songliubraving@fb.com>
 <20191016121031.GA31585@redhat.com>
 <CE3DD093-E5B4-4C98-A7B7-3B05D7732D3C@fb.com>
 <20191017084714.GB17513@redhat.com>
In-Reply-To: <20191017084714.GB17513@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3594.4.19)
x-originating-ip: [2620:10d:c090:180::4a6a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97739617-04e5-4c0f-a847-08d7530b0b96
x-ms-traffictypediagnostic: MWHPR15MB1519:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB15190F34FDF6FE371DE849E2B36D0@MWHPR15MB1519.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(346002)(396003)(136003)(189003)(199004)(25786009)(71200400001)(53546011)(14444005)(478600001)(36756003)(76176011)(102836004)(186003)(86362001)(5660300002)(6512007)(6506007)(66476007)(76116006)(64756008)(66446008)(66556008)(4326008)(71190400001)(229853002)(66946007)(6116002)(6486002)(256004)(33656002)(14454004)(6246003)(2616005)(6916009)(50226002)(6436002)(99286004)(305945005)(7736002)(446003)(46003)(11346002)(54906003)(476003)(8936002)(486006)(81156014)(8676002)(81166006)(316002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1519;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O6Bi0CwMF3qHQBv3nJNgrqS0EJiyCCfTKwOejADN/h58Fj/l/TLHbo5+GoHk5P5XArtrC2J/lT5j9HThprUSEIFowxGwIuVDD+Da6c3X5lQA9ueXKrDSqyusoxcgFPYxb/BA1eX4GuK/U2637CrWaZg6yDEUcBQvcO0tvGYqZEBIHTFmqkBofyOZUogvOmPGpSdLvTya1pRdQ8UvDO3UEHM9XOgNBxvEsEVSB2ImMpu2bVib88yeCLojZQreAhfSIUlHaFEOAyj0v7ffGQ6Un+SBhdPP9K2KBiWIqznmBAp0saVOEzl+oYqxlJojRzOvoL8jujgIuM+uZjVCd9Jn9C14PZATe0kbs8mIMrpxIx1V3khenB/0jSV5mlROa3Khjsri7eaE14S07a0NMEGnKszfsPwAEf3uaFuXr71r4D8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C0DF626696652742BCE1A42DF55BCE9A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 97739617-04e5-4c0f-a847-08d7530b0b96
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 14:05:19.9063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uTQcD3pIVTqPCof4YEhD0gf2mT5SVW4Azvlq9BOlrDZyghhn44iRjnjLj7gkWio0LRUk0h9n9RD0xjlOA18XCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1519
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-17_05:2019-10-17,2019-10-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910170126
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 17, 2019, at 1:47 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>=20
> On 10/16, Song Liu wrote:
>>=20
>>> On Oct 16, 2019, at 5:10 AM, Oleg Nesterov <oleg@redhat.com> wrote:
>>>=20
>>>> @@ -489,6 +492,9 @@ int uprobe_write_opcode(struct arch_uprobe *auprob=
e, struct mm_struct *mm,
>>>> 	if (ret <=3D 0)
>>>> 		goto put_old;
>>>>=20
>>>> +	WARN(!is_register && PageCompound(old_page),
>>>> +	     "uprobe unregister should never work on compound page\n");
>>>=20
>>> But this can happen with the change above. You can't know if *vaddr was
>>> previously changed by install_breakpoint() or not.
>>=20
>>> If not, verify_opcode() should likely save us, but we can't rely on it.
>>> Say, someone can write "int3" into vm_file at uprobe->offset.
>>=20
>> I think this won't really happen. With is_register =3D=3D false, we alre=
ady
>> know opcode is not "int3", so current call must be from set_orig_insn().
>> Therefore, old_page must be installed by uprobe, and cannot be compound.
>>=20
>> The other way is not guaranteed. With is_register =3D=3D true, it is sti=
ll
>> possible current call is from set_orig_insn(). However, we do not rely
>> on this path.
>=20
> Quite contrary.
>=20
> When is_register =3D=3D true we know that a) the caller is install_breakp=
oint()
> and b) the original insn is NOT int3 unless this page was alreadt COW'ed =
by
> userspace, say, by gdb.
>=20
> If is_register =3D=3D false we only know that the caller is remove_breakp=
oint().
> We can't know if this page was COW'ed by uprobes or userspace, we can not
> know if the insn we are going to replace is int3 or not, thus we can not
> assume that verify_opcode() will fail and save us.

So the case we worry about is:=20
old_page is COW by user space, target insn is int3, and it is a huge page;=
=20
then uprobe calls remove_breakpoint();=20

Yeah, I guess this could happen.=20

For the fix, I guess return -Esomething in such case should be sufficient?

Thanks,
Song=20

