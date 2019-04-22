Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D44DC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7342075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="hMylz/i7";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hfEBlBPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbfDVWLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 18:11:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53796 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727455AbfDVWLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 18:11:30 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3MM2QNs018891;
        Mon, 22 Apr 2019 15:11:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=OYV/QkCLKRJvFA326Z6+sTKwufHsZL75V0CTOKVRIV8=;
 b=hMylz/i7ddF3Idn4qvCvoWlhZecQho0UkzO/9BAX0tPH9SA7XBIL+Mxk3tyapDrk7l8G
 4eH84ToYjb+Qhi9k8ecMzVcwqBgSZubjEB98pb2vbCAZP8HBn998kbIZuMa2DYvLBYdf
 8KSLkV8Toy06AdHSsWjKGKMAqQOXW6sEMmk= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0001303.ppops.net with ESMTP id 2s1p0f81hc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Apr 2019 15:11:25 -0700
Received: from frc-mbx04.TheFacebook.com (192.168.155.19) by
 frc-hub05.TheFacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 22 Apr 2019 15:11:25 -0700
Received: from frc-hub01.TheFacebook.com (192.168.177.71) by
 frc-mbx04.TheFacebook.com (192.168.155.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 22 Apr 2019 15:11:24 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 22 Apr 2019 15:11:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYV/QkCLKRJvFA326Z6+sTKwufHsZL75V0CTOKVRIV8=;
 b=hfEBlBPSiv394G3gx4d3mvw8FKrE3NKqY84G2Wx2AIV6p7pwk36yMhgiE978Obl6eCOmrMmVoGwz+TAPYLrQTjnSoVFDHQFfhhQZnk33pLqcDzLvhdDS9U6fOdnS/WnXCfej6825QkBBdss5hxyeDk26NE2WmqLrCdbUU2BaXqQ=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2502.namprd15.prod.outlook.com (52.135.199.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Mon, 22 Apr 2019 22:11:22 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e%5]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 22:11:22 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 4/9] cgroup: cgroup v2 freezer
Thread-Topic: [PATCH v10 4/9] cgroup: cgroup v2 freezer
Thread-Index: AQHU69erRVR2Ctc4e0afYj1p+92aPKZDrswA//+ZOACAAHlyAP//kwkAgAGj1QCAA+CcgA==
Date:   Mon, 22 Apr 2019 22:11:22 +0000
Message-ID: <20190422221116.GA10341@tower.DHCP.thefacebook.com>
References: <20190405174708.1010-1-guro@fb.com>
 <20190405174708.1010-5-guro@fb.com> <20190419151912.GA12152@redhat.com>
 <20190419161118.GA23357@tower.DHCP.thefacebook.com>
 <20190419162600.GC12228@redhat.com>
 <20190419165600.GC23357@tower.DHCP.thefacebook.com>
 <20190420105838.GA17468@redhat.com>
In-Reply-To: <20190420105838.GA17468@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR12CA0071.namprd12.prod.outlook.com
 (2603:10b6:300:103::33) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::9840]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85b1a644-c101-4717-f2bd-08d6c76f7442
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2502;
x-ms-traffictypediagnostic: BYAPR15MB2502:
x-microsoft-antispam-prvs: <BYAPR15MB2502526581093B02F570A6D8BE220@BYAPR15MB2502.namprd15.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(51234002)(199004)(189003)(54094003)(446003)(11346002)(14454004)(93886005)(71200400001)(25786009)(486006)(97736004)(478600001)(7736002)(4326008)(86362001)(6436002)(6512007)(33656002)(9686003)(71190400001)(476003)(6486002)(8936002)(6246003)(81166006)(76176011)(53936002)(6916009)(256004)(6116002)(14444005)(99286004)(186003)(46003)(73956011)(64756008)(66556008)(66446008)(66476007)(66946007)(102836004)(316002)(229853002)(305945005)(8676002)(2906002)(6506007)(386003)(81156014)(1076003)(54906003)(68736007)(5660300002)(52116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2502;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WaDS9XoxLu7w80OY4m4B37lWKK4zK811ZPJ4AwpZgv9AT82ntrK8bnYmpXhm7vvUeHGtEtwYYEjq53+D2TpCk3U+JFOvR8CWsjP1C4OQ0GRMxBIJ1EAD0eUY6maiElYkCLc8Cr8FAJ+z8H6g5340PEXXtWQ/KOle3DbV/IQMmn919y88dlZIhLs5tQDVgSFv8v3VXnmwRX/PPC/blkEaNrgD3zO+otzdI3+EZPlE9IoHwVkXWL7yYT53q107JD5dIZf8lk0gUdCeH39as4gN2/pLhKy5NwZ6o4gMi9UH1kWjvWzEHwgIwvWZDx7X4f3E/F+W38fBGLM1zFXg+2myPDNFj6epKv/OYp+wlhMma61S3xP3P4rSd/3IP0GR55qhN6nCKoQ7btCZcjtPSVDZjoEYw1y+2qsCYi7luouFjxg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B91AB6C224AD854BBF2B3FE7BC05ED8D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b1a644-c101-4717-f2bd-08d6c76f7442
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 22:11:22.8267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2502
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-22_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 12:58:38PM +0200, Oleg Nesterov wrote:
> On 04/19, Roman Gushchin wrote:
> >
> > > > >
> > > > > wake_up_interruptible() ?
> > > >
> > > > Wait_up_interruptible() is supposed to work with a workqueue,
> > > > but here there is nothing like this. Probably, I didn't understand =
your idea.
> > > > Can you, please, elaborate a bit more?
> > >
> > > Not sure I understand... We need to wake up the task if it sleeps in
> > > do_freezer_trap(), right? do_freezer_trap() uses TASK_INTERRUPTIBLE, =
so
> > > why can't wake_up_interruptible() =3D=3D __wake_up(TASK_INTERRUPTIBLE=
) work?
> >
> > Right, but __wake_up is supposed to wake threads blocked on a waitqueue=
:
>=20
> Ugh sorry ;) of course I meant wake_up_state(task, TASK_INTERRUPTIBLE).

Agh, then it makes total sense to me. I'll master a follow-up patch.

>=20
> > > > > > +		if (unlikely(cgroup_task_frozen(current))) {
> > > > > >  			spin_unlock_irq(&sighand->siglock);
> > > > > > +			cgroup_leave_frozen(true);
> > > > > >  			goto relock;
> > > > > >  		}
> > > > >
> > > > > afaics cgroup_leave_frozen(false) makes more sense here.
> > > >
> > > > Why? I don't see any reasons why the task should remain in the froz=
en
> > > > state after this point.
> > >
> > > But cgroup_leave_frozen(false) will equally clear ->frozen if !CGRP_F=
REEZE ?
> > > OTOH, if CGRP_FREEZE is set again, why do we need to clear ->frozen?
> >
> > Hm, it might work too, but I'm not sure I like it more. IMO, the best o=
ption
> > is to have a single cgroup_leave_frozen(true) in signal.c, it's just si=
mpler.
> > If a user changed the desired state of cgroup twice, there is no need t=
o avoid
> > state transitions. Or maybe I don't see it yet.
>=20
> Then why do we need cgroup_leave_frozen(false) in wait_for_vfork_done() ?=
 How
> does it differ from get_signal() ?

We need it because sleeping in vfork is a special state which we want to
account as frozen. And if the parent process wakes up while the cgroup is f=
rozen
(because of the child death, for example), we want to push it into the "pro=
per"
frozen state without changing the state of the cgroup.

>=20
> If nothing else. Suppose that wait_for_vfork_done() calls leave(false) an=
d this
> races with freezer, CGRP_FREEZE is already set but JOBCTL_TRAP_FREEZE is =
not.
>=20
> This sets TIF_SIGPENDING to ensure the task won't return to user mode, th=
us it
> calls get_signal().
>=20
> get_signal() doesn't see JOBCTL_TRAP_FREEZE, it notices ->frozen =3D=3D T=
 and does
> cgroup_leave_frozen(true) which clears ->frozen.
>=20
> Then the task calls dequeue_signal(), clears TIF_SIGPENDING and returns t=
o user
> mode?

Got it, a good catch! So if the freezer races with vfork() completion, we m=
ight
have a spurious frozen->unfrozen->frozen transition of the cgroup state.

Switching to cgroup_leave_frozen(false) seems to solve it, but I'm slightly
concerned that we're basically putting the task in a busy loop between
the setting CGRP_FREEZE and setting TRAP_FREEZE. Do you think it's ok?
I wonder if there are better solutions.

Thank you!
