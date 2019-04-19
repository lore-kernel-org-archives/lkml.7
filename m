Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FEBC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419AB205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Np96Wt8z";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="dGrwTUEA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfDSSpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:45:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39496 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725844AbfDSSpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:45:22 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3JGSkM5021712;
        Fri, 19 Apr 2019 09:36:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=tXZXTuwJqmvt1Osg9KUTD91OtdRWmwNNeUxLicW6EG0=;
 b=Np96Wt8z/X+t0sDqG3WbeHzOTyoQoEdGrO35IeLCHdzUDr3djQkTWwgEbAEltdVbNOW+
 cjiZyAnPHBI4bC5pXssu/0u/jVgKB7d57cYBAEgBlrA0WIWqvUJ8dbJ0qcWsvIGyyvO8
 NOqrgwRnaMmYi4VlhF64R8KzrZVB/SjH/ok= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2rxqp0vwqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 19 Apr 2019 09:36:29 -0700
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 19 Apr 2019 09:36:28 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 19 Apr 2019 09:36:28 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 19 Apr 2019 09:36:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXZXTuwJqmvt1Osg9KUTD91OtdRWmwNNeUxLicW6EG0=;
 b=dGrwTUEAWZg5kW9d3K7VGj9BqBm1ft5axjvxAeeSSjk0WKjBjKKlzfucc2vqfQxE7S+7qbw4WNO1RVtixqaFNzUdHwxm6qkNUUgdjlmN4lPTQgttKO2GiVIH3FgShH0HEyQzAWA6Bs344/dui6wekdrk2C4WOAEwuZVJ6wcUgk8=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2695.namprd15.prod.outlook.com (20.179.156.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Fri, 19 Apr 2019 16:36:25 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e%5]) with mapi id 15.20.1792.023; Fri, 19 Apr 2019
 16:36:25 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 4/9] cgroup: cgroup v2 freezer
Thread-Topic: [PATCH v10 4/9] cgroup: cgroup v2 freezer
Thread-Index: AQHU69erRVR2Ctc4e0afYj1p+92aPKZDrswAgAANqgCAAAfkgA==
Date:   Fri, 19 Apr 2019 16:36:25 +0000
Message-ID: <20190419163621.GB23357@tower.DHCP.thefacebook.com>
References: <20190405174708.1010-1-guro@fb.com>
 <20190405174708.1010-5-guro@fb.com> <20190419151912.GA12152@redhat.com>
 <20190419160806.GA12790@redhat.com>
In-Reply-To: <20190419160806.GA12790@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR01CA0037.prod.exchangelabs.com (2603:10b6:300:101::23)
 To BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:66a3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a60e66b2-85ef-46c6-6099-08d6c4e529fb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR15MB2695;
x-ms-traffictypediagnostic: BYAPR15MB2695:
x-microsoft-antispam-prvs: <BYAPR15MB26956BEECCBBE663D273864DBE270@BYAPR15MB2695.namprd15.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(136003)(39860400002)(366004)(52314003)(189003)(199004)(71200400001)(73956011)(486006)(446003)(93886005)(86362001)(14454004)(2906002)(6916009)(4744005)(76176011)(256004)(66476007)(66446008)(6116002)(64756008)(68736007)(66556008)(33656002)(46003)(102836004)(305945005)(7736002)(6436002)(6506007)(5660300002)(186003)(81156014)(9686003)(476003)(53936002)(11346002)(478600001)(8676002)(81166006)(6512007)(99286004)(386003)(97736004)(1076003)(4326008)(52116002)(71190400001)(8936002)(54906003)(6246003)(316002)(229853002)(6486002)(25786009)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2695;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JRBYYl2/NKRJhP08iSk3QIW0AU1ONZR71aYxc8ZgfwOvW5yazegDWuouY5o3huT/zHZG7SDHJoh0dUH8WQef4nkhVAbbm90MeJiMIvdklTJf6CmO5uOkimYGuwWdOvKNg06yJbpZCyzdvHDLVaK5C5kwNK+1wMkpK8kIN+RSaFKHN334nYogZjxeilT/bcnpEg+rtt+gV2QMkKFK1ONgP7J+jnqHum8mShSl8/6RiOqD+8B/KXioo3FZ8l+b29xrOL95cRdgIkBDj5cv6e5k4ennPtFgKwtMxCGI7JtOCI7yCVr4Qr40yzDL1iGIQMW1VtscQEiWIJ74TomYrYPbw8HRDQu6sU/VpsxReX6it6ZNm9rd2pgMIVRI07EpsANnWoUez2yv20nWIqH1HBq4GsYdK0Lus/T2BKqyDYP78Oc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5F46C0AB64172A469D33882B0DB73797@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a60e66b2-85ef-46c6-6099-08d6c4e529fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 16:36:25.3741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2695
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-19_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 06:08:06PM +0200, Oleg Nesterov wrote:
> Anyway, I do not want to delay this feature. Even if I am right we can
> cleanup this code later. I see nothing really wrong, so no objections
> from me. Sorry for delay.

This is great!

Thank you so much for your time spent reviewing all these iterations!
I hope the patchset is in a much better state now.

Roman
