Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EDFC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 06:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F91C21873
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 06:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="YH2xPjhl";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="BxBw4+lO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbfGZGIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 02:08:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44920 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725842AbfGZGIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 02:08:12 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6Q63MIQ028149;
        Thu, 25 Jul 2019 23:07:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=o3t68lA290NjHS87SNe06fWTKA/sGe7mthr00H17FBg=;
 b=YH2xPjhlAZYRCKGXazyqDLoABYgB+5Pk0BqmbvXPVW4bBuyH1LW+LB87OeR5Uz1Wvcuv
 wr4UWpaknNw9bXVUsNINI42hdxa42A+MkQpo8MoHV0TRL+W7a4m5wDhIVl29yX5Jk7Hz
 KTmTI7WOHf6yer5nIznyIcPO06zH1ge+zp8= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2tyhfkt057-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 25 Jul 2019 23:07:24 -0700
Received: from prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 25 Jul 2019 23:07:22 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 25 Jul 2019 23:07:22 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 25 Jul 2019 23:07:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1nhypEynvHZEn83w9iEIqs80QytxBn8/sYNSV4bskOWcLidxCQVwGEthNN6yq0rbEhGb5kaemyhMw4YjUQ0b6rw7TtvslXhKtm5xKzk73z3p9TJryWCRvpDRXNUt4SVzfN90gW83dYl4/fUVgMn2pvU0FbzTaqynXK5Z1qcIfXTh8ZUEiY1Wf3FUskS/WjfLyIPcD5LOfyB7w1qQBi9k0LCXu+SxhGEJRWSvJ3bGwwAVAtcXqS/IJpOJ9eTf3z7YSOWsC9EcsVXPV213QjEg/dEHIjmbrg5HGhHzBHhhzDDFvDUFIiGD1Z6GxacROwdBYDZBRfbJTVNdZa6trHmwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3t68lA290NjHS87SNe06fWTKA/sGe7mthr00H17FBg=;
 b=T1WOVT5iRwEMpDu0d1dIVF6m2AQYhyV37KjeCSlzywh37F9S9ABi6ODAZWIXtC4WLJCE5DCRcYCbOhPCI2a4ttEutWXYkzuXlzJsgQmYv1orDvBQ2DD8LR482+Dhz4PBSm8i1BP8czSpHH4wZp6HBmYPmBdYjH4UE+tirWPVarALtrU00rmOMHCbnn3d+VyLdN/eKmR1Uf5WOt8pgsPuyzTZqUIOD4sFFvh6pWwqSjUo9zZ+lnkI3/bmgMSGuFq9ywDnOCYNperRijdC+31/MGGrf16otdAhfmKDG3OrAn0m65332fJQsLPVKPAEknqm0gLCueM91RFYxOOil3QsGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3t68lA290NjHS87SNe06fWTKA/sGe7mthr00H17FBg=;
 b=BxBw4+lO3fNqjWLmYX7Vow8FlNVVzcgzh7HzG7RiEPKaDhaVNYjCVVTcObClmmTehOzKknHrsBhNjU5YTqYL/gBX2TQWb2RbuSQjksm8oJwvKi899Ijq4kSyo5LTNP2wPBXsmcaGWa9nF/fZZNyr3fLpQ/yVFJjBp5tpDnNjPNI=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1278.namprd15.prod.outlook.com (10.175.3.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Fri, 26 Jul 2019 06:07:21 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4066:b41c:4397:27b7]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::4066:b41c:4397:27b7%7]) with mapi id 15.20.2094.013; Fri, 26 Jul 2019
 06:07:21 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     lkml <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Kernel Team" <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>
Subject: Re: [PATCH v8 2/4] uprobe: use original page when all uprobes are
 removed
Thread-Topic: [PATCH v8 2/4] uprobe: use original page when all uprobes are
 removed
Thread-Index: AQHVQfsnepoAlMhPK0qmuIU0gpphb6bZpE2AgAB5kgCAAOAOAIAAqHSAgADGbQA=
Date:   Fri, 26 Jul 2019 06:07:21 +0000
Message-ID: <A6BFA766-141D-445E-8F64-BE8E50C4AC0E@fb.com>
References: <20190724083600.832091-1-songliubraving@fb.com>
 <20190724083600.832091-3-songliubraving@fb.com>
 <20190724113711.GE21599@redhat.com>
 <BCE000B2-3F72-4148-A75C-738274917282@fb.com>
 <20190725081414.GB4707@redhat.com>
 <A0D24D6F-B649-4B4B-8C33-70B7DCB0D814@fb.com>
In-Reply-To: <A0D24D6F-B649-4B4B-8C33-70B7DCB0D814@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::1:be21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ee36e9d-b44e-4613-b0ec-08d7118f856e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1278;
x-ms-traffictypediagnostic: MWHPR15MB1278:
x-microsoft-antispam-prvs: <MWHPR15MB1278558065ACF9AD6718988DB3C00@MWHPR15MB1278.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01106E96F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(136003)(39860400002)(396003)(199004)(189003)(305945005)(6916009)(6436002)(33656002)(7736002)(14454004)(486006)(71200400001)(6116002)(4326008)(2906002)(2616005)(71190400001)(6512007)(6506007)(53936002)(46003)(25786009)(446003)(186003)(6246003)(256004)(14444005)(102836004)(478600001)(229853002)(54906003)(36756003)(11346002)(316002)(64756008)(86362001)(50226002)(68736007)(6486002)(91956017)(8936002)(4744005)(81156014)(81166006)(66476007)(66946007)(57306001)(76116006)(66556008)(8676002)(66446008)(5660300002)(76176011)(99286004)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1278;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XruTdm75ISvGDv5JUaGnwhTeH9Fg4zyRSiL+ZvUfN7feyu6AnBNCCDhvWu4IHKJvRUiTwCIOgKI9mY6lJfA0r/FZv760fhjSysL9kpoY3ygs3RV1kXgVkRKBmGGGpQpr1IOMSmDO+dCCd7XSRNPteVgbdZAIBdrYXQQpRsfZSX1BekcU+Fy/Y+A6Llls+5jaf4Sfmgog0brK8ZbD05q4V3hxIR18J/xoPk/KHHXbsTesrWbOKkDTn1P6CBjiGV3V6Mt4WqXPGu8sDB+WL/7vBs2LeINT/bOPirFtt3mMuNsr99y4bu22/6BFyNsEwc/+TtY3m0lRZOpFiN52Rq8sy1I9gsYVhE5kyfz3ap8KzpP5e5qrJz+MNiRjnqMfbT8ldKZyLQ/Prx06B3PiVCL500D6ijqil66Bxf8AcFu6NF0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4EAF74A21D565B4C8DA7E2CDC576E1D2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee36e9d-b44e-4613-b0ec-08d7118f856e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 06:07:21.1512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1278
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-26_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=830 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907260081
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Oleg,=20

>>=20
>> No. Yes, deny_write_access() protects mm->exe_file, but not the dynamic
>> libraries or other files which can be mmaped.
>=20
> I see. Let me see how we can cover this.=20
>=20
>>=20
>>>> and I am worried this code can try to lock the same page twice...
>>>> Say, the probed application does MADV_DONTNEED and then writes "int3"
>>>> into vma->vm_file at the same address to fool verify_opcode().
>>>>=20
>>>=20
>>> Do you mean the case where old_page =3D=3D new_page?
>>=20
>> Yes,
>>=20
>>> I think this won't
>>> happen, because in uprobe_write_opcode() we only do orig_page for
>>> !is_register case.
>>=20
>> See above.
>>=20
>> !is_register doesn't necessarily mean the original page was previously c=
ow'ed.
>> And even if it was cow'ed, MADV_DONTNEED can restore the original mappin=
g.
>=20
> I guess I know the case now. We can probably avoid this with an simp=10le=
=20
> check for old_page =3D=3D new_page?

I decided to follow your suggestion of "unmap old_page; fault in orig_page"=
.=20
Please see v9 of the set.=20

Thanks,
Song

