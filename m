Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01C3C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 05:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B462168B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 05:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="cCp0tuuV";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="LXWHyGgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbfI3FeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 01:34:11 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34374 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725767AbfI3FeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 01:34:11 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8U5S0lZ022648;
        Sun, 29 Sep 2019 22:33:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=0EcwwqCu6sf4IIFK1CDPYftnCmEEyqiw9x//j3zNFpA=;
 b=cCp0tuuV/O0qd4Ti4NATwPvkJUknpk3lDrB/ydHVcMtxFHtqqE0hvb3ad2GWzErvVmx7
 yaFBFjw7TAsdcIqfHBptoAWCcJQq4D4Cyiag6T7k9KWOaFMgmduD7LsRpuqWhQ3tVXDo
 Qb/bGqeQPqQRoMkCup1zXFHKOI0aYxrmeBI= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vaqu63u6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 29 Sep 2019 22:33:57 -0700
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Sun, 29 Sep 2019 22:33:56 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Sun, 29 Sep 2019 22:33:56 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Sun, 29 Sep 2019 22:33:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0fWQT4tyI04SQr3yMGaps7C7CADywRax0RQ5jYVdS6nc6GKJb705MUQ40ejYwZ6rzmrnYhYYRwyvYpbW8BDZMfHv6a7P0//1E6KF1ZPBC2Vy/CxUMzQ4U0WkNyact8FKvVzcoINwystyOkxUDn2NThK5KFQXG53SPzON1W/AF9p9uX7MVll02hIWRWRpb2mu2ki2NlaKE/G+rD09qdVSu3mcjc754hW8H3VkPRLBz6h8s5mn4rZ0xEkJ1i+8gWlCplzJ1MsWy24WbWaNu9zXdtZ5bURBr48Y5GGUrbpXf9zICwkEqYViv8omLR912PZUK4aERcsUN6tfKYZL3e1nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EcwwqCu6sf4IIFK1CDPYftnCmEEyqiw9x//j3zNFpA=;
 b=oJYQtt6hHFwuePAd6UGdQ7qqmnRT77drFinrqrhRkkZT2ElqHviJlutJYTCp3EF2eW9VKkB5iZDpFh43CQhGMzZSUXVOjJbG3hvX07qnK2sIfmX5WarR/KzHkxRAXOsLt2WCkTIuJpntASreob7yanXzuvzGXAx09qKLdVZEiTSVNRoGTMXHFCJtqTE/dLmRKsVUmQv7EqowDnV23ZJHfyC3PnPq3pEE/ebO+B5lX57YpP5LTDUQMZ+bJEDqez5aKraeRmlR5nnZu7gcYNKRCCy/WdiqQ235+75v/4wiBnBmPCgxx9F+58fBAzHDEOlecozHogHmdOF8rpWyKFPrvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EcwwqCu6sf4IIFK1CDPYftnCmEEyqiw9x//j3zNFpA=;
 b=LXWHyGgE+5rYPcyuMVbA4iEzhx30ido1vUJYYmJrf/+pNOvzo092+7EE1wghrWiBGI2ZXxKVY8frFB4mQx9mJRT8aB65Nah/d+zywoSzJBjcWEQE2amc5KE6cWKa/mTt3r1ZjOdv4aSs9G9qdvW/R4cFpH3BZhDDwGpJInMlO68=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1325.namprd15.prod.outlook.com (10.175.5.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Mon, 30 Sep 2019 05:33:53 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1%8]) with mapi id 15.20.2305.017; Mon, 30 Sep 2019
 05:33:52 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Hechao Li <hechaol@fb.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel Team <Kernel-team@fb.com>, Jie Meng <jmeng@fb.com>
Subject: Re: [PATCH] perf: rework memory accounting in perf_mmap()
Thread-Topic: [PATCH] perf: rework memory accounting in perf_mmap()
Thread-Index: AQHVY2o7Cb55MgzW70CjSsVfOs8326cuxyMAgAAHkYCAFQvAAA==
Date:   Mon, 30 Sep 2019 05:33:52 +0000
Message-ID: <663F4E97-531B-4B5F-A562-E28D6D20BCD4@fb.com>
References: <20190904214618.3795672-1-songliubraving@fb.com>
 <D0AB9FA0-B99D-4BE4-82FF-E3098EFFB208@fb.com>
 <20190916201021.GA99598@hechaol-mbp.dhcp.thefacebook.com>
In-Reply-To: <20190916201021.GA99598@hechaol-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::387f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e96d46a-bf37-494e-e5b2-08d74567c7a6
x-ms-traffictypediagnostic: MWHPR15MB1325:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB132583A7544604125CC333A1B3820@MWHPR15MB1325.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 01762B0D64
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(39860400002)(366004)(346002)(396003)(189003)(199004)(186003)(6506007)(316002)(305945005)(66476007)(64756008)(53546011)(66556008)(2616005)(486006)(46003)(66446008)(25786009)(102836004)(66946007)(229853002)(6486002)(6436002)(76116006)(476003)(37006003)(14444005)(446003)(5660300002)(54906003)(256004)(6636002)(11346002)(71190400001)(71200400001)(7736002)(36756003)(6246003)(4326008)(86362001)(33656002)(6862004)(6512007)(50226002)(8936002)(14454004)(81166006)(81156014)(6116002)(8676002)(99286004)(478600001)(2906002)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1325;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C93By1dUlWrrkLH6OpzHbpM7OUURIJiw+NEXN11MyFieEOL5tpoYGluUNVEFteTngvD4YQL1R36s1wi/FwZiaeX7/P/OO9AlolYZ58/4r0oEGciZ7XpGqbeOmFrgZYRCa+3VSmYxrT1SEMm9rdl68Gl9xzT4IiVgSb00MFNhYv4vgHWKg29UPzCgM7R2PmDpSHMJtTTExnHxPHV8l3S/oeH8vY61yGr7gAXFWMKN0Ns7k/rDgXV9JxIJONnixGAV6YLkwtJBLiI+aC5JIPa+tNG7cr1x3xswyYSRxlj2ERKlBCMJTUEnw856ACJTKTCx4KA07d6xwKRSJR0tyBdeXDD0DheezsixNyAMN0GpfXOx3AvuzkP5THivCiBs3y+wABFCBqjnibLpK4iOXZ2ULc5cqPW2TCjxHR6hOALWqrc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <42141DEFED64AB4283EB6A4428343064@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e96d46a-bf37-494e-e5b2-08d74567c7a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2019 05:33:52.8366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1lN5zfN6r/QM5erNLUvzTDjonrl8mhMdS7e9pzoqBs/9NA+NrKrk2n74mvoKBYJIhVbhaXENjYR40sploDHYYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1325
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-30_02:2019-09-25,2019-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909300057
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 16, 2019, at 1:10 PM, Hechao Li <hechaol@fb.com> wrote:
>=20
> Song Liu <songliubraving@fb.com> wrote on Mon [2019-Sep-16 12:43:16 -0700=
]:
>> Hi Peter,
>>=20
>>> On Sep 4, 2019, at 2:46 PM, Song Liu <songliubraving@fb.com> wrote:
>>>=20
>>> perf_mmap() always increases user->locked_vm. As a result, "extra" coul=
d
>>> grow bigger than "user_extra", which doesn't make sense. Here is an
>>> example case:
>>>=20
>>> Note: Assume "user_lock_limit" is very small.
>>> | # of perf_mmap calls |vma->vm_mm->pinned_vm|user->locked_vm|
>>> | 0                    | 0                   | 0             |
>>> | 1                    | user_extra          | user_extra    |
>>> | 2                    | 3 * user_extra      | 2 * user_extra|
>>> | 3                    | 6 * user_extra      | 3 * user_extra|
>>> | 4                    | 10 * user_extra     | 4 * user_extra|
>>>=20
>>> Fix this by maintaining proper user_extra and extra.
>>>=20
>>> Reported-by: Hechao Li <hechaol@fb.com>
>>> Cc: Jie Meng <jmeng@fb.com>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Signed-off-by: Song Liu <songliubraving@fb.com>
>>=20
>> Could you please share your feedbacks/comments on this one?
>>=20
>> Thanks,
>> Song
>=20
> The change looks good to me. Thanks, Song.
>=20
> Reviewed-By: Hechao Li <hechaol@fb.com>

Thanks Hechao!

Hi Peter,=20

Does this fix look good to you?

Thanks,
Song

