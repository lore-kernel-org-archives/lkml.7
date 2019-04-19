Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BE4C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B821A222AF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="WwlMPuTQ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="CxrHla/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbfDSS0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:26:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40870 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727320AbfDSS0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:26:05 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3JGqtJu032497;
        Fri, 19 Apr 2019 09:56:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=aUtD2dvdoWlCiuZxW4hirXpeSoo6J+kqWFCSozxGfj0=;
 b=WwlMPuTQxpf0pz5Hm3FbO2Y3seY+SFo3uJo13A54y17kk4dpS+F+pqBqI2mcB2rClLId
 ktWKEOded6Z2QSpVPxAXuQb+BGT04PgdTXSnpVjp+LtU67B9N60HjWwH2824333DjnZy
 /e1f/adpN4X5wvWCBxsqKexyK7aoxmv/ycw= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rycafs3um-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 19 Apr 2019 09:56:10 -0700
Received: from frc-mbx04.TheFacebook.com (192.168.155.19) by
 frc-hub05.TheFacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 19 Apr 2019 09:56:06 -0700
Received: from frc-hub04.TheFacebook.com (192.168.177.74) by
 frc-mbx04.TheFacebook.com (192.168.155.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 19 Apr 2019 09:56:06 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 19 Apr 2019 09:56:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUtD2dvdoWlCiuZxW4hirXpeSoo6J+kqWFCSozxGfj0=;
 b=CxrHla/Uf0ZcD8McTBiu3blbQoAE+U3NGxMzwukL7ncDw+mgqgwMdWi7BH66nIfa7I8JHTg2w406J48yUjxTU8lkfA5U8yl0a2eQ5VJ5p36ZxIpoH1fTQ5qv6s1EdbLcXU08fRDugButn0vAZ8rxBBAujLVw1mxGLICEnFztlf4=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2389.namprd15.prod.outlook.com (52.135.198.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Fri, 19 Apr 2019 16:56:04 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e%5]) with mapi id 15.20.1792.023; Fri, 19 Apr 2019
 16:56:04 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 4/9] cgroup: cgroup v2 freezer
Thread-Topic: [PATCH v10 4/9] cgroup: cgroup v2 freezer
Thread-Index: AQHU69erRVR2Ctc4e0afYj1p+92aPKZDrswA//+ZOACAAHlyAIAACGIA
Date:   Fri, 19 Apr 2019 16:56:04 +0000
Message-ID: <20190419165600.GC23357@tower.DHCP.thefacebook.com>
References: <20190405174708.1010-1-guro@fb.com>
 <20190405174708.1010-5-guro@fb.com> <20190419151912.GA12152@redhat.com>
 <20190419161118.GA23357@tower.DHCP.thefacebook.com>
 <20190419162600.GC12228@redhat.com>
In-Reply-To: <20190419162600.GC12228@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0068.namprd04.prod.outlook.com
 (2603:10b6:102:1::36) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:66a3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be4b065b-51e6-45e0-a90d-08d6c4e7e8f7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2389;
x-ms-traffictypediagnostic: BYAPR15MB2389:
x-microsoft-antispam-prvs: <BYAPR15MB2389242FDEA54ED0BEEB6C44BE270@BYAPR15MB2389.namprd15.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(39860400002)(136003)(346002)(51234002)(189003)(199004)(6246003)(14444005)(256004)(33656002)(4326008)(25786009)(93886005)(66556008)(66476007)(9686003)(66446008)(64756008)(66946007)(5660300002)(6512007)(1076003)(6116002)(186003)(52116002)(97736004)(478600001)(446003)(76176011)(11346002)(8676002)(99286004)(14454004)(486006)(476003)(46003)(316002)(2906002)(54906003)(102836004)(6506007)(386003)(7736002)(305945005)(73956011)(229853002)(6486002)(71190400001)(6916009)(6436002)(81166006)(68736007)(81156014)(86362001)(8936002)(71200400001)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2389;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jYUkY4ZtPEkcNb5ehCO7rr9Tk914lFa5QKketvmcWi0cB72cIGJ98xD/oiyp8+6MaOxPTEQwNK0FCvZs2tW0joDWcogs/QJt8czOSQQLY16M5pfeHfJAuspf0NQU7/Uh/tTXIzLrmYX/W1EppJJnDHMSddwv2lsA6iC959w7rXPH1VYnLSwKxmpL4/P3DjXo+1lSNiIjn+XFDxtNvvllo+Mmemj2joWEU+TDJoDb+xwc127WoZQA/PYeg7uOSDpIs8q5hMrOEISubGp6khjP8P2kOok/57ahE7l6CmPHcCst0i20noCPrx78zmDU816YEvn7LTsuePfLrOVaGGig1j1jwC+68y8FbXu6SHFLQJ/7iIwRE4ODHuyj0K31LhTWXbte9Y7ofr0H1TvqUXtzRnf53WTSutdy2xfYxbVow/o=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F937F0E16108E8498B9720C7BDC65529@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: be4b065b-51e6-45e0-a90d-08d6c4e7e8f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 16:56:04.7340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2389
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-19_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 06:26:00PM +0200, Oleg Nesterov wrote:
> On 04/19, Roman Gushchin wrote:
> >
> > > Once again, suppose we race with CGRP_FREEZE. If JOBCTL_TRAP_FREEZE i=
s already
> > > set then signal_pending() must be already T and we do not need recalc=
_sigpending?
> > > If JOBCTL_TRAP_FREEZE is not set yet, how can recalc_sigpending() hel=
p?
> >
> > This is paired with cgroup_task_frozen() check in recalc_sigpending_tsk=
().
>=20
> Ooh, I didn't notice this version added cgroup_task_frozen() into
> recalc_sigpending_tsk() ...
>=20
> Honestly, I don't like this. But see another email I sent, we can cleanup
> this code later.

Yeah, totally agree: it's not pretty. But honestly I've no better ideas,
so let's fix it later.

>=20
> > > > +static void cgroup_freeze_task(struct task_struct *task, bool free=
ze)
> > > > +{
> > > > +	unsigned long flags;
> > > > +
> > > > +	/* If the task is about to die, don't bother with freezing it. */
> > > > +	if (!lock_task_sighand(task, &flags))
> > > > +		return;
> > > > +
> > > > +	if (freeze) {
> > > > +		task->jobctl |=3D JOBCTL_TRAP_FREEZE;
> > > > +		signal_wake_up(task, false);
> > > > +	} else {
> > > > +		task->jobctl &=3D ~JOBCTL_TRAP_FREEZE;
> > > > +		wake_up_process(task);
> > >
> > > wake_up_interruptible() ?
> >
> > Wait_up_interruptible() is supposed to work with a workqueue,
> > but here there is nothing like this. Probably, I didn't understand your=
 idea.
> > Can you, please, elaborate a bit more?
>=20
> Not sure I understand... We need to wake up the task if it sleeps in
> do_freezer_trap(), right? do_freezer_trap() uses TASK_INTERRUPTIBLE, so
> why can't wake_up_interruptible() =3D=3D __wake_up(TASK_INTERRUPTIBLE) wo=
rk?

Right, but __wake_up is supposed to wake threads blocked on a waitqueue:

    /**
     * __wake_up - wake up threads blocked on a waitqueue.
     * @wq_head: the waitqueue
     * @mode: which threads
     * @nr_exclusive: how many wake-one or wake-many threads to wake up
     * @key: is directly passed to the wakeup function
     *
     * If this function wakes up a task, it executes a full memory barrier =
before
     * accessing the task state.
     */
    void __wake_up(struct wait_queue_head *wq_head, unsigned int mode,
			int nr_exclusive, void *key)

What should I pass as wq_head?

>=20
> > > >  static int ptrace_signal(int signr, kernel_siginfo_t *info)
> > > >  {
> > > >  	/*
> > > > @@ -2442,6 +2483,10 @@ bool get_signal(struct ksignal *ksig)
> > > >  		ksig->info.si_signo =3D signr =3D SIGKILL;
> > > >  		sigdelset(&current->pending.signal, SIGKILL);
> > > >  		recalc_sigpending();
> > > > +		current->jobctl &=3D ~JOBCTL_TRAP_FREEZE;
> > > > +		spin_unlock_irq(&sighand->siglock);
> > > > +		if (unlikely(cgroup_task_frozen(current)))
> > > > +			cgroup_leave_frozen(true);
> > >
> > > Oh, and another leave_frozen below...
> >
> > Yeah, because of this new "goto fatal" shortcut.
>=20
> I understand, but the code doesn't look nice... but again, I can't sugges=
t
> anything better at least right now, so please forget.
>=20
> > > > +		if (unlikely(cgroup_task_frozen(current))) {
> > > >  			spin_unlock_irq(&sighand->siglock);
> > > > +			cgroup_leave_frozen(true);
> > > >  			goto relock;
> > > >  		}
> > >
> > > afaics cgroup_leave_frozen(false) makes more sense here.
> >
> > Why? I don't see any reasons why the task should remain in the frozen
> > state after this point.
>=20
> But cgroup_leave_frozen(false) will equally clear ->frozen if !CGRP_FREEZ=
E ?
> OTOH, if CGRP_FREEZE is set again, why do we need to clear ->frozen?

Hm, it might work too, but I'm not sure I like it more. IMO, the best optio=
n
is to have a single cgroup_leave_frozen(true) in signal.c, it's just simple=
r.
If a user changed the desired state of cgroup twice, there is no need to av=
oid
state transitions. Or maybe I don't see it yet.

Thank you!
