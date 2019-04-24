Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99711C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DAD21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="MpIWquBj";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="OhbFAyqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbfDXWKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:10:46 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56926 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727769AbfDXWKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:10:46 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3OMA2Jp017102;
        Wed, 24 Apr 2019 15:10:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=wN0uqsOEAlN5gbm42aioBCXkRH3nbdzfGrpFjkDuuC0=;
 b=MpIWquBjh/jiJKO1IO6zE7Zf4pifcKqHvci/TrFOiUPM8PXcJ7japOF7cLMwsXrr+5sJ
 HyOXWQaoLYcxG1JgzDWnW/GssXG0OVolOUSNqRtc+X30mCYTmWV0s5W4Yd+I0cXQfv4b
 i7pTmpySbGNnYas76ZpeLvymdMx9y51p3nU= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2s2x8e8srx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 24 Apr 2019 15:10:42 -0700
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 24 Apr 2019 15:10:41 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 24 Apr 2019 15:10:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wN0uqsOEAlN5gbm42aioBCXkRH3nbdzfGrpFjkDuuC0=;
 b=OhbFAyqg98LTgVFSVM7/u9iY5DhfYA/EvGYKfZAU/PBvGTRIR1+zPH2eyZhG7YW12VoWVohsVYQbeZ3yex/hORx0bUq0hBDnsHrPbXJAGngP4CqxmdjD1UZK8DIPwJx5UUYmsSzXFnXaGmr8QgRBwN4qwHe2PevYAmw43sN36kM=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3206.namprd15.prod.outlook.com (20.179.56.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Wed, 24 Apr 2019 22:10:39 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e%5]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 22:10:39 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 4/9] cgroup: cgroup v2 freezer
Thread-Topic: [PATCH v10 4/9] cgroup: cgroup v2 freezer
Thread-Index: AQHU69erRVR2Ctc4e0afYj1p+92aPKZLlpcAgABmzoA=
Date:   Wed, 24 Apr 2019 22:10:39 +0000
Message-ID: <20190424221034.GB22896@tower.DHCP.thefacebook.com>
References: <20190405174708.1010-1-guro@fb.com>
 <20190405174708.1010-5-guro@fb.com> <20190424160237.GH16167@redhat.com>
In-Reply-To: <20190424160237.GH16167@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR08CA0040.namprd08.prod.outlook.com
 (2603:10b6:300:c0::14) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::dc26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a38ba96d-48c6-416c-2afc-08d6c901af24
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3206;
x-ms-traffictypediagnostic: BYAPR15MB3206:
x-microsoft-antispam-prvs: <BYAPR15MB320621CB67EF00376FA3B836BE3C0@BYAPR15MB3206.namprd15.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(376002)(366004)(136003)(189003)(199004)(7736002)(6512007)(486006)(6436002)(2906002)(73956011)(5660300002)(6486002)(186003)(52116002)(478600001)(66476007)(8936002)(14454004)(446003)(9686003)(476003)(66946007)(25786009)(66556008)(4326008)(33656002)(46003)(66446008)(64756008)(71190400001)(305945005)(71200400001)(6246003)(11346002)(53936002)(54906003)(14444005)(316002)(1076003)(6116002)(97736004)(102836004)(256004)(8676002)(229853002)(68736007)(386003)(99286004)(6506007)(4744005)(81166006)(81156014)(86362001)(76176011)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3206;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: W9ilIOj3kU1zWE9PtDSD+eFmkJH+4bYGooQIGqL/wHLHaO/uNSd2KvVrN9Ha6kGbJr35K+gs3WMN0N4VRN36Va7DXs+Y5Zefdb+M8+JFi51SeYcJLa9nyEc5Ii/+UMy1NakPrkpRDLfT3+QzcTAH6UjFY/161aSMWvP1KYfdFXn5Uk5g1gqHcdg0IwPq/FwVM+pYtdUmxgiC0lYkEt7qggd6IrZy6IcmqNS5SiqLgMWuO+mqvKT330olGdkVL0m2bGe81QSa1F65p4tcr/6/Q2ybSUWUUt3tJBnBWaoeBf4m8PiwYmcTCbFK1HPOQNbB5c8WU59fQcDvpgFIoII/NTT5AOc8sBM3t6TM06gpJmZ8ENoHEuilZbU945YV2o1Pki9BSNFIOM3+j5OlKfgTzNCzq3gs6YG/ljtPiQlaecM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <035051AE993AB54E989E234EC71E7440@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a38ba96d-48c6-416c-2afc-08d6c901af24
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 22:10:39.2869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3206
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 06:02:38PM +0200, Oleg Nesterov wrote:
> On 04/05, Roman Gushchin wrote:
> >
> > @@ -5830,6 +5926,12 @@ void cgroup_exit(struct task_struct *tsk)
> >  		spin_lock_irq(&css_set_lock);
> >  		css_set_move_task(tsk, cset, NULL, false);
> >  		cset->nr_tasks--;
> > +
> > +		if (unlikely(cgroup_task_frozen(tsk)))
> > +			cgroup_freezer_frozen_exit(tsk);
> > +		else if (unlikely(cgroup_task_freeze(tsk)))
> > +			cgroup_update_frozen(task_dfl_cgroup(tsk));
> > +

Hello, Oleg!

A good catch! It's actually a leftover from one of the previous versions
of the patchset. In the current iteration I'd replace it with:

	WARN_ON_ONCE(cgroup_task_frozen(tsk));

just to make sure we're not leaking the frozen bit.
Do you agree?

Thank you!

Roman
