Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41693CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 01:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03FA92190F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 01:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Df/W9Kxw";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YuD8HGp+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfJUBVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 21:21:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17758 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726610AbfJUBVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 21:21:17 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9L15YLV004097;
        Sun, 20 Oct 2019 18:21:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=wiDXFaqZEjBbfB/lOf2A3vaHJjBb+nBd43dbjcxcB4M=;
 b=Df/W9Kxw4Zp0oJqk26Nu6cWrQIvj/7HoODQifRavDq3HubI/YRxtnwi57kkEP+0dSjue
 GTareoP0HTTd6S2I2DM3/ZQbrdnXtEqC9x6OTPAAqPv5kFdnNnvvgKFPQnHFCTAtAYSE
 AJrZjIuzBhP2L0jaedqESyA+5XuDK9fqWwo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vrj5dt5r6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 20 Oct 2019 18:21:06 -0700
Received: from ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) by
 ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 20 Oct 2019 18:21:04 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 20 Oct 2019 18:21:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CR7Ew3+UV16bwCFrB/VAhBp7iT1Q7pxhtWCImwEKoEeVR6rH0t5IZVI1qJeNU20WRkKgqJfsITwFzfvEf4mpzwFK46JbzDTx8/k9ls4XLiVpcx7ttvHfUjSUu6ALQoEv5BOg11X/FbzIZeBVDQj0Qi29vAFCeu7LReEDgVo7JM1Cf+6x9fUSIvN/9MOUTyOjC/y79vVXHU2iC30FzHMepB/szRi9fmJiDk9t/S9+bP15i9rVwbCMg9QzKnPnUFyCS3zmcxXrJ2pJXJ6AJGWCknkVs28qMVKFhu5jRbrRBXwy302lnAEBwWwc2SnLeNr7e+HTsGZ/Fd/eV93tUixZcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiDXFaqZEjBbfB/lOf2A3vaHJjBb+nBd43dbjcxcB4M=;
 b=HlNUVn9DzwXRAiwdgmBzEH3Y4SIhw/CJ7ySTQXdGvU6LrdxkcOjyg/5/EfHuRpjTY12Op9dTbHxHfOH2Lsp9uJoF/ftvm+9aR1WpBBGYhCiLTJ3dSMM7Ke2mQtxXYmlYJ3NaoWbhzj3hUnvO2eEQPVXkpvg+sTCo2UgLiaVJr18sw4mKiQmSHKXb2EZNhAnjFS0aZBSXk/xI/sL+vcHZLaI3JnVv27CjZUq6qy766NVUp/WjP50KyBoxNTUFDb2Iyvnzmj+gi9owqVvGXuFGRxZtpCWwYJ9bxm/++L8CvbEDGw3orgUt7euZAgX9Vkdi0Md5zfkdA9fK3rRnzF9exw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiDXFaqZEjBbfB/lOf2A3vaHJjBb+nBd43dbjcxcB4M=;
 b=YuD8HGp+CdTEWg4NX3R0SsZWgjAlZc3SAk0gD1uWzJ5uB6BnS1jxu7c4C5b+dein+uGLXehC3cIHg2CNzpjCXKXz4eztpMbPLpsfdRskRhP3aB1n8xLCWdsXg3kkrXVawzz7LYN1CiXD1S4uqqrBUjZa/9SDAXe2W8fm6p6Gkus=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2577.namprd15.prod.outlook.com (20.179.138.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Mon, 21 Oct 2019 01:21:02 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::3056:945b:e60e:e2e0%6]) with mapi id 15.20.2347.028; Mon, 21 Oct 2019
 01:21:02 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Christopher Lameter <cl@linux.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 02/16] mm: vmstat: use s32 for vm_node_stat_diff in struct
 per_cpu_nodestat
Thread-Topic: [PATCH 02/16] mm: vmstat: use s32 for vm_node_stat_diff in
 struct per_cpu_nodestat
Thread-Index: AQHVhUsFBO4ANGUwi02i8A/g/NqcHqdkJyUAgAAp2AA=
Date:   Mon, 21 Oct 2019 01:21:02 +0000
Message-ID: <20191021012056.GB8869@castle>
References: <20191018002820.307763-1-guro@fb.com>
 <20191018002820.307763-3-guro@fb.com>
 <alpine.DEB.2.21.1910202250010.593@www.lameter.com>
In-Reply-To: <alpine.DEB.2.21.1910202250010.593@www.lameter.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO1PR15CA0061.namprd15.prod.outlook.com
 (2603:10b6:101:1f::29) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::37d5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfb5dd30-98b2-4431-7631-08d755c4f00b
x-ms-traffictypediagnostic: BN8PR15MB2577:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB25770465658C39DF4C622B54BE690@BN8PR15MB2577.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(396003)(39860400002)(136003)(376002)(366004)(199004)(189003)(6486002)(8676002)(4326008)(54906003)(229853002)(33656002)(99286004)(6512007)(9686003)(6436002)(66446008)(64756008)(66556008)(66476007)(66946007)(6246003)(102836004)(386003)(6506007)(14454004)(186003)(81156014)(81166006)(478600001)(8936002)(33716001)(1076003)(316002)(11346002)(446003)(2906002)(7736002)(46003)(71190400001)(71200400001)(256004)(6116002)(25786009)(486006)(14444005)(305945005)(76176011)(52116002)(5660300002)(476003)(6916009)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2577;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZnhD6JCqFZccI4X+2hKwJ/HSlYSDGSGmkJd649fKGMdTk4LNdlQ02bTw2ijbE4If5owDV7VsbQ58dL/i1WEhBatbJ0O6G9bjXj7xPILS/oP+2TlEy5ylcXYq6AFESTCv6W0NpA5zyZm75Mzr6uAZGJmLRt/+60qFRQVPGypsG5ypewIAJeBBiXGNYZeHCVCTweW9gPR/XngFe5+4a7qZBGQjvCH4aSaruYuL8hHDuhSg4Wihy9OtADX9M0OoJDRndw5J94P7sPEC9BeXkM2oW4ScZJSphHFzDNnIttXzzjGxE/fxu6GogCq8knA3Yx3QnOdkPqbXvOaK4HxWSgs5kGsmFxgFiDuKjxZgQvNAkdnbRrxRskasuyJFT6LSKHdtyciNUpteR3pMUQJDJrGiCE2OyXzL7CAkKajzwYsBd74=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <49F27AFB6826CB4B9F8061DC970E5C56@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb5dd30-98b2-4431-7631-08d755c4f00b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 01:21:02.6827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EQq9x6MHidoBSAbcUdA3XxqQbF7wgEE0A7d/cYkJWjSlVJk5sPInPzKhUFD9tFJH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2577
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-20_06:2019-10-18,2019-10-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=864 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910210008
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2019 at 10:51:10PM +0000, Christopher Lameter wrote:
> On Thu, 17 Oct 2019, Roman Gushchin wrote:
>=20
> > Currently s8 type is used for per-cpu caching of per-node statistics.
> > It works fine because the overfill threshold can't exceed 125.
> >
> > But if some counters are in bytes (and the next commit in the series
> > will convert slab counters to bytes), it's not gonna work:
> > value in bytes can easily exceed s8 without exceeding the threshold
> > converted to bytes. So to avoid overfilling per-cpu caches and breaking
> > vmstats correctness, let's use s32 instead.
>=20
> Actually this is inconsistenct since the other counters are all used to
> account for pages. Some of the functions in use for the page counters wil=
l
> no longer make sense. inc/dec_node_state() etc.

Actually I tried to implement what Johannes suggested earlier and convert
all counters to bytes, but it looked like it can lead to a significant
performance hit on 32bit platforms, as I'd need to replace all atomic_long_=
t
with atomic64_t. Also, to make the code look good, I'd need to convert
all counters to bytes (and atomic64_t): zone stats, vmevents, etc.
So I gave up relatively quickly.

Maybe it's a good long-term plan, but as now it doesn't really look
as an obviously good think to do.

I'm fully open to any suggestions here.
