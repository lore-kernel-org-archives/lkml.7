Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4283EC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E26020B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IRzBIWil";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ItX8qr/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbfKTRSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:18:37 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10988 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730671AbfKTRSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:18:35 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAKGumVd014551;
        Wed, 20 Nov 2019 09:17:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=XnUgr6XC4IzD6AfeWGFe7tyFyTHx0g197GkvXNNlQAI=;
 b=IRzBIWilq+qzGIP+7uchjKdMlykE7ylA0v9ixqSYq143EAh3Ap49JrpTnYihzBOBjV58
 Pjj0RWi0uSAKn0aaA2U7eMBuaEEF65uTRlKI2XMs+WrHVF9bVJna8MT7ZwPces+ro07w
 mA0IE/2wsfJzD+WTZcIP1RD3OjrNx7IFgQY= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2wct98mfkk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Nov 2019 09:17:27 -0800
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 20 Nov 2019 09:17:25 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 20 Nov 2019 09:17:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R42b9aXEed+U/4Vn9GJvFVeOwiQs4MLVnHaLwjY6NV5pq6V0PW2F8M9XLUrqJ349qgv0d9lmcQaoAaGs3JF2wRBoyqtWkf+oD3QZTkEv9QQ45LZN/z/Spm7jI/j/cx1UUK/w9tf+UIKyOJCPPtoEF5FxBWzlsV8VP4PtYRY5xcsIc13SKbYkSwvoqV+pSg9vL0FZGTYjkh04hm4LzwRPN24ZLpuhqCe63FqhGB+IRsetDL/suCn/DECqZcymAL6G+gPRkyWOVcFIFKOljRypZhK92hOCBrBYBe2B+FTOWMCIUnSdY9iWDfHuEYRX17spuDNivexvo8IgGfzJjWYdvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnUgr6XC4IzD6AfeWGFe7tyFyTHx0g197GkvXNNlQAI=;
 b=OFabVy2S71wLSYBkaC4/gTMP/JhAl1W2b7fSMLb5yH2e/Z31UAW0SFfq+UNO03+hZtrd4uhnU0JHzZLMSFfJ+V9lI4uGh4lTAbYHshBjTZIv30o5+uHEIyyNWI9VwIeEso/HsCs0RfkDVDqtjlFkzD34dM7kfNgn0G9AlZloIENipU8uVPnYHmkm2FDsemIoqu53JVSJjTlanvMvXarlsDyQqthKCrLQa0Gxtixn99geCsz4hur3ZLKK95UFdpQAvLoC8lmwqRvDim8cDZw/smfqKKX5T5uhnOYslaSraaVnTxBubgoJyL9fWgmTJDzDQRpL/cf++XYdCWW+sY2OrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnUgr6XC4IzD6AfeWGFe7tyFyTHx0g197GkvXNNlQAI=;
 b=ItX8qr/HCGv4ejPO0Sp8zx1PGCrlz636S4o1kZYbtjWh3XD3LE/7NpA4uHTHcLAJNj4dcRzMTDJn5QhqJWEExGy6/iERovQP1nb8FXw4JVJ5ByzpzCSrdMkl3MqiUQmmUDBOs/oxSqHoI/0wcfBrgHcXGPGpCFCXOIefp3FjOy4=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1118.namprd15.prod.outlook.com (10.175.2.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.27; Wed, 20 Nov 2019 17:17:25 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::f831:d112:6187:90d9%4]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 17:17:25 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] perf: Make the mlock accounting simple again
Thread-Topic: [PATCH] perf: Make the mlock accounting simple again
Thread-Index: AQHVn8Vn0sTTCanwpkymLnNHz6eF3aeUTTUA
Date:   Wed, 20 Nov 2019 17:17:24 +0000
Message-ID: <C0F2E8FA-925C-4D71-9628-554270034422@fb.com>
References: <20191120170640.54123-1-alexander.shishkin@linux.intel.com>
In-Reply-To: <20191120170640.54123-1-alexander.shishkin@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3601.0.10)
x-originating-ip: [2620:10d:c090:180::5286]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd1e59df-6543-43f2-d6c6-08d76ddd831e
x-ms-traffictypediagnostic: MWHPR15MB1118:
x-microsoft-antispam-prvs: <MWHPR15MB1118D5A37EFCE5FA8957152CB34F0@MWHPR15MB1118.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(39860400002)(136003)(51914003)(199004)(189003)(478600001)(46003)(36756003)(54906003)(25786009)(256004)(81166006)(6506007)(81156014)(53546011)(76116006)(6116002)(33656002)(6246003)(99286004)(8676002)(8936002)(102836004)(4326008)(186003)(50226002)(4744005)(2906002)(5660300002)(71200400001)(71190400001)(6512007)(86362001)(76176011)(6486002)(2616005)(486006)(446003)(11346002)(476003)(14454004)(6916009)(66446008)(316002)(229853002)(7736002)(64756008)(66946007)(305945005)(15650500001)(66476007)(66556008)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1118;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v93edLv/i2F2XqLzRQxk55d8e++U9nfVUv/Ai0IZBUAhNGfjyFvRKWOi/JqvMuPn2FT/8xuK+5C8NSd1C0bb6aroyhMGsw3LgUmH/VNNhrm4zJ3ZJaXSuRIPqerZbxV+p/EARBEwObxBzmqFG6o42xr51uv/xWaSvNzLa/LIYhuxmdmL/4MLU7niZ4lP+P+QrPISKarRXkzc24olbsmpRMnF7ocj34dsJr0nEfZuGSU9ETHOIYTW3JNpMsOSC7X8PdBGIGa8NsYKrN3aOiFHRYaXT0SDbIf6Asf6uKnVElYNXeoVJjz9tyG4Hvt3Gv/Gpc18JVkWmF4Ht/IiM7tHvCVsbVMMIMdEU5XxGhNlKDZwkiW4v8cNVFT7u3lEfPgl1dyMQ+R6DnNXYE4RCGN9L0cvl3TaDjJ9ZvhqJh+8P/CX+PSi094JiFqEwnGXiFeP
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4557A4091DCD7740B8AC98C8B974F3F5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1e59df-6543-43f2-d6c6-08d76ddd831e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 17:17:24.8682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rwlVszclv6kEJOWb8MXAwmck2a2KUwwPpiYiEJcgA+UnmtgCznT6oSRRHFUCIHTlsrKM2Ifs68ciW4XzPgLzlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1118
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_05:2019-11-20,2019-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 mlxlogscore=890 impostorscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxscore=0 clxscore=1011
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911200145
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 20, 2019, at 9:06 AM, Alexander Shishkin <alexander.shishkin@linux=
.intel.com> wrote:
>=20
> Commit
>=20
>  d44248a41337 ("perf/core: Rework memory accounting in perf_mmap()")
>=20
> does a lot of things to the mlock accounting arithmetics, while the only
> thing that actually needed to happen is subtracting the part that is
> charged to the mm from the part that is charged to the user, so that the
> former isn't charged twice.
>=20
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: songliubraving@fb.com

Acked-by: Song Liu <songliubraving@fb.com>

Thanks for the fix!

