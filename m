Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56E6C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 19:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B186206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 19:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="oxZKISV4";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="f/uNDJRJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388371AbfIPToP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 15:44:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50158 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729144AbfIPToP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 15:44:15 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8GJhMiX032354;
        Mon, 16 Sep 2019 12:43:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=h2RKu/2FuEdq1QLqJ64FKX4QYysMxQzhTDvWdDOkDaA=;
 b=oxZKISV4n50v2CSPeBDerSXxypH0Yyv0hS5C9MSnqJWX1L9AA3ncS68lT6w2wpYyV6oq
 BEkotOUX+d0goFRDKDQrQM8yPiXTgIli2XxxvLfwEMFWFClQFuggtQWz+CvWnt0J+/ZW
 ZULIqngEe9KK2us30vtTc+bAQu76hGOPBkE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2v1fwsp79x-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 16 Sep 2019 12:43:27 -0700
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 16 Sep 2019 12:43:18 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 16 Sep 2019 12:43:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdTDR5Y0N26mp1RZjW3Xza4+EgT7g0PDEgoQm6Pc+LYL7bABQ27mO0O0ZNYGEezTXJh+/uR4A6Zw9AAX4U5wp1Mp4M0w94unQ9xRWoXgLFHoL806EJREl9j9ClIQY35c5xGZddn7F67Lrq/cC8kcpa4Ef6U7pBtejf+ESTGnV18Gjsf00vEHQs1x3nATTYIC/PF3n+D/pu5vUKCkb2Y5DsTAb3UT02jqfnLkX7KeNPjOD4a5u6AZI+HU1v8KpEZK0SLmXX+okvAfIOfCXMymzwV4xKzwTiLT5d1QEPvS6zbHT1jWcrdNY2R3Auks95oaui5IHk4jgTI1fM1mXxwrpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2RKu/2FuEdq1QLqJ64FKX4QYysMxQzhTDvWdDOkDaA=;
 b=CWHbsHviNv0xoxR98DM096a8iQFhh8nYuxLVbP3S/rKNTRVM7IjopWabo+WoXeLTqWT9qKNURwFOM+59QB9bVuRPxl+PA8PN3oDqGI4YDWnywEOnZlISSS5WNZSh8lmmbGh6oHOqd5PsR/u/bdPjBQJZ4o7MlsmMWB1f8R0ZH6DjTPb7gANXve1WTr97t2bU9xcr9LPByyzIb4VOvQv4ElmrZ6x1kC8b6OEV1Be8EAECvC1BkILTwiCha7DxKXyS0je14JTXb91KQM83NrLBSJO9WWhaXj7CVKF95kl7DMnMAhkPvfKSXH7elYy4fr4ubLOawEun1VG0TtVQzXcOnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2RKu/2FuEdq1QLqJ64FKX4QYysMxQzhTDvWdDOkDaA=;
 b=f/uNDJRJXWV2TagpTN7+lBBu7lwz1Qy0m+XjrdvsHxospbHKCXOag58w/1TMU0reIt5Px3AqADIMp2xgRqVTHWvZcasrfibKb8GLFXdQO1CKTo5TkFVNguM4iYUB7J7oo5KMZYxmqZmoNG70G++0fQ7ivkj8rX1qQCf8P0DDt6Q=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1421.namprd15.prod.outlook.com (10.173.235.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.24; Mon, 16 Sep 2019 19:43:17 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::a828:5750:379d:b9a1%8]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 19:43:17 +0000
From:   Song Liu <songliubraving@fb.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Kernel Team <Kernel-team@fb.com>, Jie Meng <jmeng@fb.com>,
        Hechao Li <hechaol@fb.com>
Subject: Re: [PATCH] perf: rework memory accounting in perf_mmap()
Thread-Topic: [PATCH] perf: rework memory accounting in perf_mmap()
Thread-Index: AQHVY2o7Cb55MgzW70CjSsVfOs8326cuxyMA
Date:   Mon, 16 Sep 2019 19:43:16 +0000
Message-ID: <D0AB9FA0-B99D-4BE4-82FF-E3098EFFB208@fb.com>
References: <20190904214618.3795672-1-songliubraving@fb.com>
In-Reply-To: <20190904214618.3795672-1-songliubraving@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::3:5e56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6eb719bc-5bf6-4a2e-4e94-08d73ade1ed0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR15MB1421;
x-ms-traffictypediagnostic: MWHPR15MB1421:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB1421C66B1B70DDF9A7E622B5B38C0@MWHPR15MB1421.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(39860400002)(136003)(346002)(199004)(189003)(25786009)(86362001)(99286004)(4744005)(6486002)(4326008)(7736002)(486006)(305945005)(71200400001)(66446008)(64756008)(66556008)(66476007)(316002)(8936002)(71190400001)(11346002)(33656002)(36756003)(6512007)(54906003)(110136005)(76116006)(66946007)(6436002)(46003)(50226002)(229853002)(53936002)(186003)(14454004)(478600001)(6116002)(476003)(2906002)(102836004)(2616005)(6506007)(53546011)(5660300002)(6246003)(76176011)(14444005)(81156014)(8676002)(81166006)(256004)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1421;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ir2CIPX0Xa9b+Mly7mnTgj/mL44BQNGHi4yGOjkID+axp9mptwpozvB5W6I0bWoaWFg2O70XP+KlryWL7L4ScBsyOEXaQt+jy6SGqoNk5JdEV0W7RGUImGN41U32+p+q41LtIjPub3n46Ldm+N7Ba9Lt5mfEJ/bgUdJgRXnyI9VLBDm13Z8KiTmGgXVXXTnA+Ecbi4X3qVQPJhioebX9cYRzebbqJk7+XbS+VE2/Xdjq6z2QhoYnmkT05m0YQwUZn8udw1MHxwBaA9PWsTeoA+ohiUrBCchHHwzeBCU7m4Xekj7LXbUYnq3AuKOFtUgvQvqu927M6j+KhEUvfaIrfYmB2q0WOhu06wwTrHGRd1E5TTzrp6zPo8EQ1fBYiIO1yA8qpjZl9JMswLvcsIua4dl2PaA6za7BXK9MzZAVp4c=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <326FA650D8EC2140B22A2E41FB505653@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb719bc-5bf6-4a2e-4e94-08d73ade1ed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 19:43:16.8534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XmzIUG+WN5sH6A1qyE6uZz5bQuwGZxdneRtxQl6gVppi4ghRDz+zLDxUMAgPi+fmFNDS/gKxvf7N7NIA2PKJ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1421
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-16_07:2019-09-11,2019-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909160192
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

> On Sep 4, 2019, at 2:46 PM, Song Liu <songliubraving@fb.com> wrote:
>=20
> perf_mmap() always increases user->locked_vm. As a result, "extra" could
> grow bigger than "user_extra", which doesn't make sense. Here is an
> example case:
>=20
> Note: Assume "user_lock_limit" is very small.
> | # of perf_mmap calls |vma->vm_mm->pinned_vm|user->locked_vm|
> | 0                    | 0                   | 0             |
> | 1                    | user_extra          | user_extra    |
> | 2                    | 3 * user_extra      | 2 * user_extra|
> | 3                    | 6 * user_extra      | 3 * user_extra|
> | 4                    | 10 * user_extra     | 4 * user_extra|
>=20
> Fix this by maintaining proper user_extra and extra.
>=20
> Reported-by: Hechao Li <hechaol@fb.com>
> Cc: Jie Meng <jmeng@fb.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Song Liu <songliubraving@fb.com>

Could you please share your feedbacks/comments on this one?

Thanks,
Song
