Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19549C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73AD206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 17:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="HWjSpBAg";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="cZ5Bfy2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfH1R7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 13:59:01 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35450 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726515AbfH1R7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 13:59:00 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7SHs9Wf032666;
        Wed, 28 Aug 2019 10:58:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Pgg5aM+1BhWFMi/zr0NtM/g3odDyiiDGyTgxtDeFDBk=;
 b=HWjSpBAgcWY/O65PenX7ZIwsUi5TMzaaoZXxE0HLwF4RdyeH52xnga+zZaly2yck4gDU
 Vxfo/sGyGhKr/siaFbbPvxyLAM+bHV8MZg3WKenchBPNUjkWcCPOA0PGUHlSOEa4Mmu8
 FjrArPyb7al+rrqFMgOVJPwh6bpL8kQEcgE= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2unka1u0vd-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 10:58:26 -0700
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 28 Aug 2019 10:58:22 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 28 Aug 2019 10:58:21 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 28 Aug 2019 10:58:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZou3hzRp+A4Kj7YSvqTVaEeMB8UTQ0FqwqhjS1ACqkpoOnd2i1tVy2Z7/jB3blAIV8OrUIyOHfDArPL1mkajbchuuja3hqL758sEm2Opf5rjjHcooDTjlACsTlFbhj3RTPl3yxt7RVNDsW10hRL81BCUga5F007GUW1hgCv/7Qonq4fK8ayQ5ToWCgue6jjTD0hbjp+LTJtiRWawAr9Bfiu3RCJS8tPXNYqtAGCAa+7UUmeXDn628+ptOACaMGxXq2BmH4XC2u0iX0dqID8PeWX4d0NvxRXciegrGkbRjC9qs2EbSZshejX9V6hMm28K/lXUUtoYvglKWZsKrwQag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pgg5aM+1BhWFMi/zr0NtM/g3odDyiiDGyTgxtDeFDBk=;
 b=RQCQ1CVABkXqvE8m1wArlv0z29vMMSisPRIYFJQlc5wDveh0gqfL5CTN9RoF8A+jKfzhPrGGmcystXKrQimkQNb6zhSD70HtJriVv9HCTeEUHymnmZT/vonyVFNVoBDidYYSFb4q3ODnNp/6sSLkwgMl2yZ24jYk4xQvjyUR8qekUJcJh/KVdtf4P+Q6e4SJlwOwE7AlDl31zlHkSc3TJcSuk7HuTauLTcnoh731ExDAOQUYu56q/iY/RtkIN84lmjBDP7Hver33cV6a99nmezPz9ztEAlRmGtwzxOlLFW5O/MdJ8hBl7XQRaHhZaQvHh6iIDljmgl4aAPrznVfHig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pgg5aM+1BhWFMi/zr0NtM/g3odDyiiDGyTgxtDeFDBk=;
 b=cZ5Bfy2ML35zPtzOAj4GjpOVa8vPOgH3R4f3+39XaDMgOlHIRwVmKcwOoCOcoJkUhKcKsBjm/ppTLfUG2WeV7wOjO0vo3SbCYNdQpIL2qyw+4u7CT3UC4ffU8Jg9Hlru+ETcZ31QcQfAUA9n6F6fHnbSklhsXb5Vp1/Wo33utDs=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1360.namprd15.prod.outlook.com (10.173.228.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.16; Wed, 28 Aug 2019 17:58:20 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5%3]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 17:58:20 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rik van Riel" <riel@surriel.com>
Subject: Re: [patch 1/2] x86/mm/pti: Handle unaligned address gracefully in
 pti_clone_pagetable()
Thread-Topic: [patch 1/2] x86/mm/pti: Handle unaligned address gracefully in
 pti_clone_pagetable()
Thread-Index: AQHVXa1SnM+Gh7oAvk+r6MnSURCjbqcQtC2AgAABSwCAACOGgA==
Date:   Wed, 28 Aug 2019 17:58:20 +0000
Message-ID: <309E5006-E869-4761-ADE2-ADB7A1A63FF1@fb.com>
References: <20190828142445.454151604@linutronix.de>
 <20190828143123.971884723@linutronix.de>
 <55bb026c-5d54-6ebf-608f-3f376fbec4e5@intel.com>
 <alpine.DEB.2.21.1908281750410.1938@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908281750410.1938@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::cae3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06acedb0-e5cd-4ce3-fe96-08d72be14fe7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1360;
x-ms-traffictypediagnostic: MWHPR15MB1360:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MWHPR15MB1360D7F70DDC42319ACFD13EB3A30@MWHPR15MB1360.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(136003)(346002)(39860400002)(199004)(189003)(6486002)(2906002)(36756003)(6916009)(478600001)(76176011)(6306002)(305945005)(99286004)(6436002)(966005)(186003)(102836004)(50226002)(316002)(4326008)(25786009)(8936002)(76116006)(6506007)(53546011)(54906003)(6116002)(71200400001)(71190400001)(229853002)(14454004)(46003)(53936002)(8676002)(86362001)(57306001)(81166006)(81156014)(5660300002)(256004)(6512007)(33656002)(14444005)(64756008)(66446008)(66556008)(11346002)(66476007)(66946007)(2616005)(476003)(6246003)(486006)(7736002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1360;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8LSRbN0hmjflKdzUYDbxZRUxVhGMaZiH4+NnI61srMXbegoxVc0/exvn5WVhDy79DYwED7+i39T6OWpIhckktRQ/vtkK5iD8t0XRc7tm0buvSEnNuk6QXKycV3zkvSw9OcNMuJnnwPVFgI0zB2QBlLYRTAZjCj4tIIvnb1DiWYbiMBGkuvxVpbgW+RyS032S4ie/A564etZ90e8jx4QF4rs7PczeDf7wPCYwAP07fE8ONkQegzt8r/e9V1ZZMCTo34fQJQf+JQsRswcnL1U5liWfIDGIHusuU8I4dVgYXHXG1ZHL5GY0gDpKn9RTDPuMaTHDNiw/Eeq9j6F3VRZF79XjI+SnGAe6HMddT5UCbH8wD3XZqTxYeEMa5BQEUoniKVG5ya4MUoyCvhDN1u5j+ExEvfxLf8bRok5ygBNeQaI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13EAA6F97D869B4D82650F2B36EB02E9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 06acedb0-e5cd-4ce3-fe96-08d72be14fe7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 17:58:20.3275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VSw1bVRWbB3zWZunmUEtGlvOFgToY9l7HA6daHucAJW4brXI01zAF18xUb23G82Fh24zGCEwOW/XXrFPm3UoGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1360
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-08-28_08:2019-08-28,2019-08-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 phishscore=0 impostorscore=0 mlxlogscore=965 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908280175
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 28, 2019, at 8:51 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> On Wed, 28 Aug 2019, Dave Hansen wrote:
>> On 8/28/19 7:24 AM, Thomas Gleixner wrote:
>>> From: Song Liu <songliubraving@fb.com>
>>>=20
>>> pti_clone_pmds() assumes that the supplied address is either:
>>>=20
>>> - properly PUD/PMD aligned
>>> or
>>> - the address is actually mapped which means that independent
>>>   of the mapping level (PUD/PMD/PTE) the next higher mapping
>>>   exist.
>>>=20
>>> If that's not the case the unaligned address can be incremented by PUD =
or
>>> PMD size wrongly. All callers supply mapped and/or aligned addresses, b=
ut
>>> for robustness sake, it's better to handle that case proper and to emit=
 a
>>> warning.
>>=20
>> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
>>=20
>> Song, did you ever root-cause the performance regression?  I thought
>> there were still some mysteries there.
>=20
> See Peter's series to rework the ftrace code patching ...

Thanks Thomas.=20

Yes, in summary, enabling ftrace or kprobe-on-ftrace causes the kernel
to split PMDs in kernel text mapping.=20

Related question: while Peter's patches fix it for 5.3 kernel, they don't=20
apply cleanly over 5.2 kernel (which we are using). So I wonder what is
the best solution for 5.2 kernel. May patch also fixes the issue:

https://lore.kernel.org/lkml/20190823052335.572133-1-songliubraving@fb.com/

How about we apply this patch to upstream 5.2 kernel?

Thanks,
Song
