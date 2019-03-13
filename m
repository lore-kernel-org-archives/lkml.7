Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6992FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B46A2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="EFvJS0ay";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="iiNPnQaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfCMSZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:25:07 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51620 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbfCMSZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:25:07 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2DIIdbO003908;
        Wed, 13 Mar 2019 11:25:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=aikG9yz0lcCeANUDQoaSydrOSD48pgBFE7UyJ3qbhh4=;
 b=EFvJS0ayLUliwdpHarD7XqwO3TuwLTzzJz/ooI70TeJxS3TutTyBJxBycV7/foSpndlD
 Wb/rPlX/RLtVLC5Lu4FK5SVl4rT16cErRt1S4nJDjfntgqF4VNgHYHFTmnYWt96z1n9T
 Z9J90gkIFWKzcvhkqX73ilNistfag4d3nnQ= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r76fur7ru-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 13 Mar 2019 11:25:00 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 13 Mar 2019 11:23:12 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 13 Mar 2019 11:23:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aikG9yz0lcCeANUDQoaSydrOSD48pgBFE7UyJ3qbhh4=;
 b=iiNPnQaF3nJfclDdowMVP+eDNrMDAE1LvcFRwnLqbpRTUyFhkz471Oj7GlDWgwuqX29lsiSkAp/QOgQewecjEHG/sA6KePKPifBPiva0emzjADjgMFoif5WcDu9ybnSiU7HE8GqoXbeq/e2THx1vcq2swfrkaARMZg/+zUu9ee0=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3192.namprd15.prod.outlook.com (20.179.56.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Wed, 13 Mar 2019 18:23:09 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded%2]) with mapi id 15.20.1686.021; Wed, 13 Mar 2019
 18:23:09 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Roman Gushchin <guroan@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2 5/6] mm: flush memcg percpu stats and events before
 releasing
Thread-Topic: [PATCH v2 5/6] mm: flush memcg percpu stats and events before
 releasing
Thread-Index: AQHU2SPIEdyFRN8G5UOFWOBkO8hY8aYJuWyAgAAn5QA=
Date:   Wed, 13 Mar 2019 18:23:09 +0000
Message-ID: <20190313182301.GA7336@castle.DHCP.thefacebook.com>
References: <20190312223404.28665-1-guro@fb.com>
 <20190312223404.28665-6-guro@fb.com> <20190313160017.GA31891@cmpxchg.org>
In-Reply-To: <20190313160017.GA31891@cmpxchg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0041.namprd21.prod.outlook.com
 (2603:10b6:300:129::27) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::f5e6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41ecc687-2bbb-4fb6-7ac9-08d6a7e0f1f0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB3192;
x-ms-traffictypediagnostic: BYAPR15MB3192:
x-microsoft-antispam-prvs: <BYAPR15MB31926B4BD8449EEA55C2E948BE4A0@BYAPR15MB3192.namprd15.prod.outlook.com>
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(366004)(136003)(396003)(346002)(189003)(199004)(1076003)(6116002)(6486002)(256004)(86362001)(316002)(14444005)(6246003)(7736002)(305945005)(5660300002)(186003)(25786009)(229853002)(52116002)(4326008)(386003)(9686003)(6506007)(76176011)(6916009)(102836004)(81156014)(6436002)(71190400001)(478600001)(53936002)(8676002)(99286004)(97736004)(8936002)(446003)(46003)(14454004)(105586002)(106356001)(476003)(33656002)(11346002)(486006)(6512007)(81166006)(68736007)(2906002)(54906003)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3192;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +7PeFCMLvN9IdE+TWAxqLlkLNg6kxDnNavxXpJVIxUHTzOs0Xph1jCxGT/12gQXDC1+CsbnQHVdfRzdPUlIIp1wWSnf08TcQpkYRw7pUOtNumlOLSUv8907C8Ron+gXL465kcvlHCOvoY3mYcdd7I1zxslykLrL5b/gNEnJEGowO+0rOX+1AUCodvyAQBHW5EEngFVMMjqHtHvi9M6SE89/GZ2zX7RgUrcLjkNOkfU7c6+5mVI9uLXedjqtPhL9tc8U8hTG5Q0dIJRcfwS317VeGzIOESE/yuVB+knyiSQGpH/rOQU6j0Fna6QWKfCRowvprBKC5Wa/G0aDooMCG4l9bI824EXq+nNdZJHNxewwgUhUEH81g+i8GId2vpvKTmK1oG381KiIq7y3Z3lr0mPPxGbfJmvH3tlLP0X7+4Rg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3F987864893FA84898C6B92CCEE1853F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ecc687-2bbb-4fb6-7ac9-08d6a7e0f1f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 18:23:09.6178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3192
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-13_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 12:00:17PM -0400, Johannes Weiner wrote:
> On Tue, Mar 12, 2019 at 03:34:02PM -0700, Roman Gushchin wrote:
> > Flush percpu stats and events data to corresponding before releasing
> > percpu memory.
> >=20
> > Although per-cpu stats are never exactly precise, dropping them on
> > floor regularly may lead to an accumulation of an error. So, it's
> > safer to flush them before releasing.
> >=20
> > To minimize the number of atomic updates, let's sum all stats/events
> > on all cpus locally, and then make a single update per entry.
> >=20
> > Signed-off-by: Roman Gushchin <guro@fb.com>
>=20
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>=20
> Do you mind merging 6/6 into this one? That would make it easier to
> verify that the code added in this patch and the code removed in 6/6
> are indeed functionally equivalent.
>=20

I did try, but the result is the mess of added and removed lines,
which are *almost* the same, but are slightly different (e.g. tabs).
So it's much easier to review it as two separate patches.

Thanks!
