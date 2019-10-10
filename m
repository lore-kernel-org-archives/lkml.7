Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C624C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 22:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A3320B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 22:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IRsNEcWr";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="bySIxchT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfJJWpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 18:45:44 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27294 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726184AbfJJWpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 18:45:44 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AMhNEL004710;
        Thu, 10 Oct 2019 15:44:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=tacmddVBCqmn6XjYlckxpY0wHfyOCB4/1pEJDOmSb7Q=;
 b=IRsNEcWrT97KkZrVqzD+9QBeo3Mn3TNcm3BMlsLKznhEWDSJKqbtknl0tTIdQVKPb7zG
 C2ptZ/9nGVZw9JZ/LzbXms827mlasblLrcafe5rbcusP9AtNUsnMNkCL/WZaRA6UXKpD
 lFnZF4FWDkB18xPp5hZxkU4i2KorWwvayxw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vj7wya8rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Oct 2019 15:44:45 -0700
Received: from ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 10 Oct 2019 15:44:43 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 10 Oct 2019 15:44:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qp3btuj55Nh0tOACxDx5LWYv2Bgb5Vg+ljE+n7QxbcMO1BcWoF/PNHAN0sDr2edXwTOiVTOQCShEqcFAp+W3bedCFQ4z9uymgcgTUNfAO7HigCjLtAtH/6bxEwhjF9HF6rSNS4NV46RyqIxU0wG8y9LIh1+boX5n6nni9PjC0ZtDFlEQft2wri/sdrl1XYDPyckkBn2knkWy0qE5mwo7dxzhyp5y7F+v//C3VyA+9OoVi5CnVxzXnG4o6SIqOb6tmW9omcpt/FMfJTg74YtQ34A8g69bNJWZwRlIbimcb4QlPrj7yX6TxZUwIGMDCojcOIRJLYYf1EaNW7oUQpZgiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tacmddVBCqmn6XjYlckxpY0wHfyOCB4/1pEJDOmSb7Q=;
 b=bPR/OR2iYGvlh9N7ylgl3klwpE0LGKAbxhf7h2DTVrOf4Hj34RUZ8h/NBPOxg9jvz+yW29QNat9V16OI/PPCmNJPfEQX/TXixf3EYl4+1ejqzql9PX40dDZB3DqnHs9OcJmBLpmoAHWMqwaS+BIw0+I/KodhtPoqKt23jCw1Je3nkgx6f0832OGQyMS9EdCMnWg4NvfOTQyucpRAHZGLpfIfj8sIEQ9hmQDBwt1adBfU3Pxh7OgJxZZzyq+QQ1+kwhmu46/8ORfiBn+qCWjBGSbcKIJidkj1dUiBRatKADqtGg3xOM9BnC06z5Cdgzv7upwuIUUozJEsBbnmx95WKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tacmddVBCqmn6XjYlckxpY0wHfyOCB4/1pEJDOmSb7Q=;
 b=bySIxchT88sp39a4sAGdq7MRjHwL33sSNLUYrzMsuW73saEl6GCi9cYlqcIEaVl1YNbvO+dU6IbV/lHaXp+DAZEk5K5UCU2j3LRhL4d+XSWw5tVy/oc5zZF7IjVDnHttO6jQRnXlcI0PJztg1CEFs2RmbDUryvSwxk9dQIHtGgE=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1454.namprd15.prod.outlook.com (10.173.235.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 10 Oct 2019 22:44:42 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2347.016; Thu, 10 Oct 2019
 22:44:42 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     open list <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>, David Xu <dxu@fb.com>,
        Andrew Hall <hall@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] perf/kprobe: maxactive for fd-based kprobe (pmu
 perf_kprobe)
Thread-Topic: [PATCH] perf/kprobe: maxactive for fd-based kprobe (pmu
 perf_kprobe)
Thread-Index: AQHVfV79pbxZC0PPd0u0Pg6K2pv05adP1L4AgASpH4A=
Date:   Thu, 10 Oct 2019 22:44:42 +0000
Message-ID: <14283CB6-F665-47BA-9A77-54D2BBC85FD5@fb.com>
References: <20191007223111.1142454-1-songliubraving@fb.com>
 <20191008083420.cecebd6afdf5c34074565195@kernel.org>
In-Reply-To: <20191008083420.cecebd6afdf5c34074565195@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3594.4.19)
x-originating-ip: [2620:10d:c090:200::3:428c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccffcca2-5941-4e3a-2d33-08d74dd370d2
x-ms-traffictypediagnostic: MWHPR15MB1454:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB1454352FD15D67DEE98EA3E0B3940@MWHPR15MB1454.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 018632C080
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(366004)(39860400002)(346002)(189003)(199004)(66446008)(6486002)(102836004)(71190400001)(71200400001)(86362001)(6506007)(64756008)(66476007)(33656002)(66946007)(966005)(229853002)(53546011)(54906003)(5660300002)(305945005)(316002)(6246003)(66556008)(4744005)(4326008)(2906002)(7736002)(76176011)(99286004)(478600001)(25786009)(36756003)(6116002)(14454004)(6512007)(256004)(6306002)(476003)(446003)(76116006)(8936002)(6436002)(46003)(81156014)(186003)(81166006)(50226002)(486006)(6916009)(11346002)(8676002)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1454;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UsfxYewxRTLFQMwEMvFEmRy04thCVsIcH/elZoeeyUDhlDEJsZ0HuwPdCaLjxT6o6YQxfnzWMuBq/TBxENXXCoKY+SeIRyZoCHVkmEwXrcI4TT/Fm02gY1QpcPXiXEA2z2IlA6yDrXj7IPy0TGvl5+CJqSXwZh3T8LrdQIwS+gQieeNmPT8Azxd35Cx1CNYQiN0OVkqKw61bVl+pTBA6aptznwC4N3v4RgTi/jR2qOYQ9cOBeVY3k4i+h3WlezxHH0jQYXI/VcrYMy9v77iNER3vZUzzu/3LCo3SQFOqDe/2YuAohg4qN1/x3ckXspum7d2DuStPkdtHHhWvkFO8uEai98fV1rTewz3qVLtiKA22WWOOkxJNFzYCEA34+gJqB5DgSbh0nL+pkGi5PYfHeHF3aEgs1LgeAMEJE2iLfrRm2IegoVjJXM7nYPi/QStHFy5cG84xntGcKK24LvCN0A==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2DB2D03E642DBF449F8AAE42F5DC3E1C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ccffcca2-5941-4e3a-2d33-08d74dd370d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2019 22:44:42.0815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: whBvPKets7r8fjq7o3sYDn9RbKegi55ageRpthV6ZvUQlkZTEGYFxbS3XH7qOe9orwhp+2Wuw9O25rJuwG4EvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1454
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_08:2019-10-10,2019-10-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=731
 mlxscore=0 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910100197
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 7, 2019, at 4:34 PM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>=20
> Hi,
>=20
> On Mon, 7 Oct 2019 15:31:11 -0700
> Song Liu <songliubraving@fb.com> wrote:
>=20
>> Enable specifying maxactive for fd based kretprobe. This will be useful
>> for tracing tools like bcc and bpftrace. [1] discussed the need of this
>> in bpftrace. Use highest highest 12 bit (bit 52-63) to allow maximal
>> maxactive of 4095.
>>=20
>> [1] https://github.com/iovisor/bpftrace/issues/835
>=20
> From the view point of trace_kprobe, this looks good to me.
>=20
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks Masami!

Hi Peter and Steven,=20

Could you please share your comments on this?

Thanks,
Song
