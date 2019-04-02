Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DC2C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 22:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE8E2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 22:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="FgHm9rtv";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="DD2G0TBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfDBWJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 18:09:06 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35276 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726078AbfDBWJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 18:09:06 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x32M7Pno032502;
        Tue, 2 Apr 2019 15:09:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=SwsKDjjj7SRUR25hjJd7eLdumKNnAozD6h0qL1PCTxU=;
 b=FgHm9rtvZ7xKbY+J9DIloiRRh2Ps2y0kpK0lwuhVEcp6H7etCSneQC2MWdgdkAo4RjB0
 54v0h3FzYwku0zpA08sVnSsYtIeQXE2WIh/sS7t+v06A01tfU6KePq8uLa1W0YSTUakW
 1CPj6wgJnb2G5yPOVThG+q4x6sVT+V/R09U= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rmdvj8j6e-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 02 Apr 2019 15:09:01 -0700
Received: from frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 2 Apr 2019 15:08:44 -0700
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 2 Apr 2019 15:08:44 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 2 Apr 2019 15:08:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SwsKDjjj7SRUR25hjJd7eLdumKNnAozD6h0qL1PCTxU=;
 b=DD2G0TBXw3/TEhkcUhWGkhMT5K274ncosRlbkbWSvpMjMGIrsAkMpO/vj/RVPdSD+ixpd4kNRaDnbtWyji5duUsy0qCaI0Vz/6cZ2pBn6l2fUUxC/ZKZwAg/XdSYc78ZL4uC4mT51wk/ymc9omsnCsDYZppItlCt5BTKu4C5luE=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2437.namprd15.prod.outlook.com (52.135.198.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Tue, 2 Apr 2019 22:08:42 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded%3]) with mapi id 15.20.1750.017; Tue, 2 Apr 2019
 22:08:42 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 4/9] cgroup: cgroup v2 freezer
Thread-Topic: [PATCH v9 4/9] cgroup: cgroup v2 freezer
Thread-Index: AQHU3CHllXzybPyDGEG0vLR4lYlRjKYpIryAgABmQIA=
Date:   Tue, 2 Apr 2019 22:08:42 +0000
Message-ID: <20190402220836.GA16417@tower.DHCP.thefacebook.com>
References: <20190316175812.6787-1-guro@fb.com>
 <20190316175812.6787-5-guro@fb.com> <20190402160241.GA10425@redhat.com>
In-Reply-To: <20190402160241.GA10425@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:40::19) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:923f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab2d55be-4944-4d2d-0260-08d6b7b7c43f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR15MB2437;
x-ms-traffictypediagnostic: BYAPR15MB2437:
x-microsoft-antispam-prvs: <BYAPR15MB2437D03F6D4D2433D95223BFBE560@BYAPR15MB2437.namprd15.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(396003)(366004)(39860400002)(189003)(199004)(106356001)(6116002)(316002)(99286004)(25786009)(6486002)(6916009)(7736002)(6436002)(229853002)(256004)(14444005)(6506007)(386003)(105586002)(1076003)(478600001)(14454004)(2906002)(97736004)(4326008)(71200400001)(11346002)(6246003)(71190400001)(46003)(102836004)(52116002)(446003)(54906003)(33656002)(5660300002)(76176011)(6512007)(186003)(81166006)(9686003)(8936002)(305945005)(81156014)(53936002)(476003)(68736007)(86362001)(8676002)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2437;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TqgamV6gO78tIdTQf38QBcoNwqux7T0leOyqcE3AU7CjAQHB/jnO6VyZqlOg4nrw1023FRNs5gUfggHC1bB1RBhcL5ObaJuVVLzSf2GU5gM01TWUsqbEDkurVrWg3Zdz9UVeEGYIEEEi8nkGatvsoZ0F9O2adtfbel5r+yYx7FSd2BGtUy1loh7uUH9hWxtoGvwZvrQ4h+/gzF+7kqPlesiv49kK3YCl3iF7Az6wxjqrH78OXhWHGq0fDKZkNvoY8QK7EOwVn6cOuYobhuHPFg6gm+QBogMMTxLt1d8VC3tZf31vdkSqAvUzCiqO3jVY52/TWfAVgXDyqJKf1T2mEUBO7+WLI5nMWWOditX9ZqMprmBt8YE+Xf9uw3y8us/9jbH2KC34oCLhFPOc13bDQ6kvBYPGuqVkPbOVUkqN21g=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EE7121A77379BE499B23894A109E1688@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2d55be-4944-4d2d-0260-08d6b7b7c43f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 22:08:42.3599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2437
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-02_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,


Thank you very much for your time! Really appreciate it.

I'll rebase the patchset, address your comments and send v10 soon-ish.

Please, find some notes below.

On Tue, Apr 02, 2019 at 06:02:41PM +0200, Oleg Nesterov wrote:
> Hi Roman,
>=20
> let me apologize again for the huge delay.
>=20
> I see nothing really wrong in this version, so no objections from me.
>=20
> However, 4/9 doesn't apply, so it seems you will need to make v10 anyway
> to adapt these changes to the recent changes in kernel/signal.c ;)
>=20
> Just a couple of minor nits below...
>=20
> On 03/16, Roman Gushchin wrote:
> >
> > + * If always_leave is not set, and the cgroup is freezing,
> > + * we're racing with the cgroup freezing. In this case, we don't
> > + * drop the frozen counter to avoid a transient switch to
> > + * the unfrozen state. To make sure that the task won't go
> > + * to the userspace before reaching the signal handler loop,
> > + * let's set TIF_SIGPENDING flag.
> > + */
> > +void cgroup_leave_frozen(bool always_leave)
> > +{
> > +	struct cgroup *cgrp;
> > +
> > +	spin_lock_irq(&css_set_lock);
> > +	cgrp =3D task_dfl_cgroup(current);
> > +	if (always_leave || !test_bit(CGRP_FREEZE, &cgrp->flags)) {
> > +		cgroup_dec_frozen_cnt(cgrp);
> > +		cgroup_update_frozen(cgrp);
> > +		WARN_ON_ONCE(!current->frozen);
> > +		current->frozen =3D false;
> > +	} else {
> > +		set_tsk_thread_flag(current, TIF_SIGPENDING);
>=20
> The setting of TIF_SIGPENDING looks unnecessary and even not correct; bec=
ause
> this flag must not be updated without ->siglock held (even if "set" is mo=
re
> or less safe).
>=20
> If JOBCTL_TRAP_FREEZE is already set, then TIF_SIGPENDING must be set too=
.
>=20
> Otherwise set_tsk_thread_flag(TIF_SIGPENDING) can't help because the task=
 can
> do recalc_sigpending() at any moment.
>=20
> In particular, get_signal() does dequeue_signal()->recalc_sigpending() ri=
ght
> after cgroup_leave_frozen(), so I fail to understand why do we need to se=
t
> TIF_SIGPENDING.

So this "else" part is only for vfork path. What I'm trying to do, is to
avoid flipping the cgroup state from frozen to unfrozen and back to frozen.

You're right, TIF_SIGPENDING isn't enough, we need proper cgroup_freeze_tas=
k()
with some additional synchronization.

>=20
>=20
> > @@ -912,6 +912,10 @@ static struct task_struct *dup_task_struct(struct =
task_struct *orig, int node)
> >  	tsk->fail_nth =3D 0;
> >  #endif
> >
> > +#ifdef CONFIG_CGROUPS
> > +	tsk->frozen =3D 0;
> > +#endif
>=20
> Hmm, do we really need this? How can a cgroup_task_frozen() task call
> copy_process() ?

We shouldn't, but let me double check it.

>=20
> > +static void do_freezer_trap(void)
> > +	__releases(&current->sighand->siglock)
> > +{
> > +	/*
> > +	 * If a fatal signal is pending, there is no way back for the process=
,
> > +	 * so let it escape from the freezer trap and exit.
> > +	 * If the task has been frozen, cgroup_leave_frozen() will be invoked
> > +	 * to update the cgroup state, if necessary.
> > +	 */
> > +	if (fatal_signal_pending(current)) {
> > +		current->jobctl &=3D ~JOBCTL_TRAP_FREEZE;
> > +		spin_unlock_irq(&current->sighand->siglock);
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * If there are other trap bits pending except JOBCTL_TRAP_FREEZE,
> > +	 * let's make another loop to give it a chance to be handled.
> > +	 * In any case, we'll return back.
> > +	 */
> > +	if (((current->jobctl & (JOBCTL_PENDING_MASK | JOBCTL_TRAP_FREEZE)) !=
=3D
> > +	     JOBCTL_TRAP_FREEZE) || fatal_signal_pending(current)) {
>                                     ^^^^^^^^^^^^^^^^^^^^
>=20
> We have already checked fatal_signal_pending() at the start?

Yeah, I'll remove the second call. Thanks!

>=20
> And in fact, you can probably remove fatal_signal_pending() altogether...
> Note that with recent changes get_signal() does
>=20
> 	if (signal_group_exit(signal)) {
> 		ksig->info.si_signo =3D signr =3D SIGKILL;
> 		sigdelset(&current->pending.signal, SIGKILL);
> 		recalc_sigpending();
> 		goto fatal;
> 	}
>=20
> before the main loop, so afaics fatal_signal_pending() =3D=3D T in do_fre=
ezer_trap()
> is simply impossible. This means that you can't clear JOBCTL_TRAP_FREEZE,=
 but
> this is probably fine... if not, you can add jobctl &=3D ~JOBCTL_TRAP_FRE=
EZE into
> the "if (signal_group_exit(signal))" above.

I'll try.

>=20
> > @@ -2401,12 +2453,27 @@ bool get_signal(struct ksignal *ksig)
> >  		    do_signal_stop(0))
> >  			goto relock;
> > =20
> > -		if (unlikely(current->jobctl & JOBCTL_TRAP_MASK)) {
> > -			do_jobctl_trap();
> > -			spin_unlock_irq(&sighand->siglock);
> > +		if (unlikely(current->jobctl &
> > +			     (JOBCTL_TRAP_MASK | JOBCTL_TRAP_FREEZE))) {
> > +			if (current->jobctl & JOBCTL_TRAP_MASK) {
> > +				do_jobctl_trap();
> > +				spin_unlock_irq(&sighand->siglock);
> > +			} else if (current->jobctl & JOBCTL_TRAP_FREEZE)
> > +				do_freezer_trap();
> > +
> >  			goto relock;
> >  		}
> > =20
> > +		/*
> > +		 * If the task is leaving the frozen state, let's update
> > +		 * cgroup counters and reset the frozen bit.
> > +		 */
> > +		if (unlikely(cgroup_task_frozen(current))) {
> > +			spin_unlock_irq(&sighand->siglock);
> > +			cgroup_leave_frozen(true);
> > +			spin_lock_irq(&sighand->siglock);
>=20
> I'd suggest to do "goto relock" rather than spin_lock_irq(&sighand->siglo=
ck).
> To ensure we can't miss SIGKILL which can come right after we drop sigloc=
k,
> note again the new signal_group_exit() check above.

Sure, will switch to "goto relock".

Thank you!

Roman
