Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39587C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B8C21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Erq1WUQB";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="RRCpGFX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732122AbfDXWGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:06:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39670 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726904AbfDXWGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:06:49 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x3OM32R5027402;
        Wed, 24 Apr 2019 15:06:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=OO0dT22zQMUOLHjqGwpb/WzX0H3cVmTSMhoD/vmHPmw=;
 b=Erq1WUQBh+vNUNTsq/PfkmWo/GtfO4zSNhQNGMuaKeTwJweEE2mHcB6AjP+3bhvDvF/r
 4I7F8viY3ji/E0u1tldqo+KjEv3y5uJnyOnTUc77jc81IEByxyEE0D35wxkaDETJtgwp
 6s0cGs2MlJ20CuZxS0ZAdobfw7CC8L3v5Cc= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2s28ke5f7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 24 Apr 2019 15:06:44 -0700
Received: from prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 24 Apr 2019 15:06:43 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 24 Apr 2019 15:06:43 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 24 Apr 2019 15:06:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OO0dT22zQMUOLHjqGwpb/WzX0H3cVmTSMhoD/vmHPmw=;
 b=RRCpGFX33OyAXPsQCvKYTK/dbrTiBThKBzb4NOH9H2F6adOzrx8XQsZTKqRFXb3gWJoxZStvewxRoUrLqiTP3tVDlqzR61ncIXw4YFXPTGAhC99GLqIMcZuAAnpTeOzt8iGISPjlcRH4Fzakxq3sDaiJjkL3EPZrCrfYCVYXiq8=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2678.namprd15.prod.outlook.com (20.179.156.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Wed, 24 Apr 2019 22:06:41 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e%5]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 22:06:41 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 4/9] cgroup: cgroup v2 freezer
Thread-Topic: [PATCH v10 4/9] cgroup: cgroup v2 freezer
Thread-Index: AQHU69erRVR2Ctc4e0afYj1p+92aPKZDrswA//+ZOACAAHlyAP//kwkAgAGj1QCAA2tCAIADLnKAgABqQYA=
Date:   Wed, 24 Apr 2019 22:06:41 +0000
Message-ID: <20190424220634.GA22896@tower.DHCP.thefacebook.com>
References: <20190405174708.1010-1-guro@fb.com>
 <20190405174708.1010-5-guro@fb.com> <20190419151912.GA12152@redhat.com>
 <20190419161118.GA23357@tower.DHCP.thefacebook.com>
 <20190419162600.GC12228@redhat.com>
 <20190419165600.GC23357@tower.DHCP.thefacebook.com>
 <20190420105838.GA17468@redhat.com>
 <20190422221116.GA10341@tower.DHCP.thefacebook.com>
 <20190424154619.GG16167@redhat.com>
In-Reply-To: <20190424154619.GG16167@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1201CA0014.namprd12.prod.outlook.com
 (2603:10b6:301:4a::24) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::dc26]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de30aa55-8968-4adb-b825-08d6c9012123
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2678;
x-ms-traffictypediagnostic: BYAPR15MB2678:
x-microsoft-antispam-prvs: <BYAPR15MB2678021D2D5A5BC23A1FE942BE3C0@BYAPR15MB2678.namprd15.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(396003)(39860400002)(376002)(199004)(189003)(81156014)(66446008)(386003)(54906003)(486006)(305945005)(76176011)(6512007)(446003)(476003)(9686003)(52116002)(316002)(66476007)(1076003)(6506007)(66556008)(99286004)(66946007)(6916009)(64756008)(53936002)(25786009)(6246003)(86362001)(73956011)(71190400001)(33656002)(478600001)(186003)(6436002)(2906002)(14454004)(8676002)(5660300002)(81166006)(4326008)(71200400001)(14444005)(102836004)(256004)(11346002)(6486002)(6116002)(7736002)(68736007)(46003)(8936002)(93886005)(97736004)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2678;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pr79FnO3teR0LXK7xZKMa+XgoYnAmKLo86Z3IVVd4GHWe8Q1m1JsYFoK6TeDQMxHSk/BbU717zPDWLUuVOLLuy5E/JHCnPNrY9xHLs+MSal4172oX6WjY64f4cdfAGdpt7HhQ3plq4L2D8ZQHChnF8BP0Yt0PbvVDb4UrYYR45mZO4M6wpkbDtiNRjpvHRmOMxUrTzM1VlIiLGvKLBhEYO0QHbVk4+9FRvu+dhXPB59MRrD5KMAN0kUnn2d9ZIOqW/nQbySmkTSQYcZ6iwNIfkl03K7m1Y2i53+skmfmB1AL5eVLY4fpSUGj3mhoMjkUL6z2ZmxaCk3+SnEyzG544upQR6kFyWvqeiQ04WHyLPj4gtDnPozvx5/4ZXOo6q2OCegP8b7yqIG3OVRmMicPK0eNOjZEU0Syap8Fk5JB5UA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5F0127BE4FF174499F524C4EA730B549@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: de30aa55-8968-4adb-b825-08d6c9012123
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 22:06:41.0935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2678
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-24_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 05:46:19PM +0200, Oleg Nesterov wrote:
> On 04/22, Roman Gushchin wrote:
> >
> > > > Hm, it might work too, but I'm not sure I like it more. IMO, the be=
st option
> > > > is to have a single cgroup_leave_frozen(true) in signal.c, it's jus=
t simpler.
> > > > If a user changed the desired state of cgroup twice, there is no ne=
ed to avoid
> > > > state transitions. Or maybe I don't see it yet.
> > >
> > > Then why do we need cgroup_leave_frozen(false) in wait_for_vfork_done=
() ? How
> > > does it differ from get_signal() ?
> >
> > We need it because sleeping in vfork is a special state which we want t=
o
> > account as frozen. And if the parent process wakes up while the cgroup =
is frozen
> > (because of the child death, for example), we want to push it into the =
"proper"
> > frozen state without changing the state of the cgroup.
>=20
> Again, I do not see how vfork() differs from get_signal() in this respect=
.
>=20
> Let me provide another example. A TASK_STOPPED task reacts to SIGCONT and
> returns to get_signal(), current->frozen is true.
>=20
> If this races with CGRP_FREEZE, the task should not return to user-space,
> just like vfork(). I see no difference.
>=20
> They differ in that wait_for_vfork_done() should guarentee TIF_SIGPENDING
> in this case, but this is another story...

Right, I agree.

>=20
> >
> > > If nothing else. Suppose that wait_for_vfork_done() calls leave(false=
) and this
> > > races with freezer, CGRP_FREEZE is already set but JOBCTL_TRAP_FREEZE=
 is not.
> > >
> > > This sets TIF_SIGPENDING to ensure the task won't return to user mode=
, thus it
> > > calls get_signal().
> > >
> > > get_signal() doesn't see JOBCTL_TRAP_FREEZE, it notices ->frozen =3D=
=3D T and does
> > > cgroup_leave_frozen(true) which clears ->frozen.
> > >
> > > Then the task calls dequeue_signal(), clears TIF_SIGPENDING and retur=
ns to user
> > > mode?
> >
> > Got it, a good catch! So if the freezer races with vfork() completion, =
we might
> > have a spurious frozen->unfrozen->frozen transition of the cgroup state=
.
> >
> > Switching to cgroup_leave_frozen(false) seems to solve it, but I'm slig=
htly
> > concerned that we're basically putting the task in a busy loop between
> > the setting CGRP_FREEZE and setting TRAP_FREEZE.
>=20
> Yes, yes. Didn't I say I dislike the new ->frozen check in recalc() ? ;)
>=20
> OK, how about the ABSOLUTELY UNTESTED patch below? For the start.

It looks good to me (and all freezer selftests pass).

Just to be sure, is it a solution to avoid the busy loop in the signal hand=
ling
loop, right? Because it doesn't allow to drop the ->frozen check from recal=
c().

The JOBCTL_TRAP_FREEZE check without siglock initially looked dangerous to =
me,
but after some thoughts I didn't find any case when it's wrong.

Do you prefer me to master a patch or to do it by yourself?

Thank you!

Roman
