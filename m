Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790FBC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DE820449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="e7CFt7HT";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="HPpM7tBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfDSShI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:37:08 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49332 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726088AbfDSShH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:37:07 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3JFvZjV017195;
        Fri, 19 Apr 2019 09:11:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=5YQBS8B9MDPxpYoO7RSF7J4DXEBiM8f9IyCWcDXCCd8=;
 b=e7CFt7HTnE/UKSLolWTsuDB+wIH0W4CudiAgr0RxeR5oXPF8a56vmntSXe/7Nw/fr1rS
 bgjxj44Ns5uZbw/FyWHcMFhyJDKRL9S3221w9bNzv+h6x9ODuR/S6cJk3i+Hrcdeg6p4
 x8DviBSDgqIIbBOCdj5PTQZyCWHytx5iAcU= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ryg3r0b05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 19 Apr 2019 09:11:27 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Fri, 19 Apr 2019 09:11:26 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Fri, 19 Apr 2019 09:11:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YQBS8B9MDPxpYoO7RSF7J4DXEBiM8f9IyCWcDXCCd8=;
 b=HPpM7tBSMi4mmBxfGp7DPeNP1NAQ/XU228y/lFI7k+q93ZjojCY6xW/9VzK/i/hBWWD4gY4V4A9rSzVS7aJhdFdbSmiXWBfNUCYoSUBMjOCgOq91N3yF5+sA1I1MfhwQnFZipqLj9Hp6Ruq1oJFX3r9n6VcBJO9AhxyIh9MCiFY=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3096.namprd15.prod.outlook.com (20.178.239.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Fri, 19 Apr 2019 16:11:24 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d1a1:d74:852:a21e%5]) with mapi id 15.20.1792.023; Fri, 19 Apr 2019
 16:11:24 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 4/9] cgroup: cgroup v2 freezer
Thread-Topic: [PATCH v10 4/9] cgroup: cgroup v2 freezer
Thread-Index: AQHU69erRVR2Ctc4e0afYj1p+92aPKZDrswAgAAOkoA=
Date:   Fri, 19 Apr 2019 16:11:23 +0000
Message-ID: <20190419161118.GA23357@tower.DHCP.thefacebook.com>
References: <20190405174708.1010-1-guro@fb.com>
 <20190405174708.1010-5-guro@fb.com> <20190419151912.GA12152@redhat.com>
In-Reply-To: <20190419151912.GA12152@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR08CA0049.namprd08.prod.outlook.com
 (2603:10b6:a03:117::26) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:66a3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af988e00-ee6e-49ac-5be1-08d6c4e1ab07
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR15MB3096;
x-ms-traffictypediagnostic: BYAPR15MB3096:
x-microsoft-antispam-prvs: <BYAPR15MB30961C40623EE7CB8458E72CBE270@BYAPR15MB3096.namprd15.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(346002)(136003)(396003)(189003)(199004)(6116002)(478600001)(25786009)(8936002)(14454004)(99286004)(33656002)(52116002)(186003)(316002)(8676002)(54906003)(53936002)(66946007)(71190400001)(81166006)(71200400001)(68736007)(81156014)(6916009)(446003)(229853002)(6486002)(5660300002)(97736004)(2906002)(486006)(6246003)(46003)(6506007)(11346002)(476003)(386003)(9686003)(4326008)(1076003)(102836004)(14444005)(6512007)(6436002)(305945005)(76176011)(256004)(64756008)(66556008)(73956011)(66476007)(66446008)(86362001)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3096;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Dfgvp8JPlMMKq1JR1LqVkqKP4e3ClGHYEZuV/lXYHNoGbL5WLbe2KTOgy1yWtHtvEz6AqQk51c3dE8x2oPM2piWN7bj12ILOB9FqnyoUgoHpkti7I7btVNbkqsJvNBvmfDMoX+fNZSL3RT5lDvdeS2OyWeKbhE2ZJVMNxgjxzBk7/YUWouPFQlzGyFwEwt7Dv6ZeCUIz/329/kBV3rP0oQR8HJfPR5xcCLIljg0y3UJIiLeM4tlxwlcAAza2st4s6DfD8J/LMMqYRLtiaBMU6hhlzzaJgNAEGzr1oWgnSyatWGmlAgrQ5U38hO4KWjAYSm/LnI96wM3xWjo661o5xl2uyS7OVh6EAI15rE8qAp9CO2XqgnTjazFFFB4k8lst28JAcSAXKG47PZ3iLGvz5tGIDGkyrDWaLlQljUhclgQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DB4FE982D79AB247B8AC1B1E520F88C1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: af988e00-ee6e-49ac-5be1-08d6c4e1ab07
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 16:11:23.9848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3096
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-19_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg!

On Fri, Apr 19, 2019 at 05:19:12PM +0200, Oleg Nesterov wrote:
> On 04/05, Roman Gushchin wrote:
> >
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
> > +	}
> > +	spin_unlock_irq(&css_set_lock);
> > +
> > +	if (unlikely(current->frozen)) {
> > +		/*
> > +		 * If the task remained in the frozen state,
> > +		 * make sure it won't reach userspace without
> > +		 * entering the signal handling loop.
> > +		 */
> > +		spin_lock_irq(&current->sighand->siglock);
> > +		recalc_sigpending();
> > +		spin_unlock_irq(&current->sighand->siglock);
>=20
> I still can't understand this logic.
>=20
> Once again, suppose we race with CGRP_FREEZE. If JOBCTL_TRAP_FREEZE is al=
ready
> set then signal_pending() must be already T and we do not need recalc_sig=
pending?
> If JOBCTL_TRAP_FREEZE is not set yet, how can recalc_sigpending() help?

This is paired with cgroup_task_frozen() check in recalc_sigpending_tsk().
If the task is waking from waiting in vfork(), and it races with
unfreezing of the cgroup, we should guarantee that the task won't
return to userspace with task->frozen flag set, otherwise it would break
accounting of frozen tasks.
We can't rely solely on JOBCTL_TRAP_FREEZE bit, as it can be cleared
in parallel at any moment. So we backup it with the task->frozen check.

>=20
> > +static void cgroup_freeze_task(struct task_struct *task, bool freeze)
> > +{
> > +	unsigned long flags;
> > +
> > +	/* If the task is about to die, don't bother with freezing it. */
> > +	if (!lock_task_sighand(task, &flags))
> > +		return;
> > +
> > +	if (freeze) {
> > +		task->jobctl |=3D JOBCTL_TRAP_FREEZE;
> > +		signal_wake_up(task, false);
> > +	} else {
> > +		task->jobctl &=3D ~JOBCTL_TRAP_FREEZE;
> > +		wake_up_process(task);
>=20
> wake_up_interruptible() ?

Wait_up_interruptible() is supposed to work with a workqueue,
but here there is nothing like this. Probably, I didn't understand your ide=
a.
Can you, please, elaborate a bit more?

>=20
> >  static int ptrace_signal(int signr, kernel_siginfo_t *info)
> >  {
> >  	/*
> > @@ -2442,6 +2483,10 @@ bool get_signal(struct ksignal *ksig)
> >  		ksig->info.si_signo =3D signr =3D SIGKILL;
> >  		sigdelset(&current->pending.signal, SIGKILL);
> >  		recalc_sigpending();
> > +		current->jobctl &=3D ~JOBCTL_TRAP_FREEZE;
> > +		spin_unlock_irq(&sighand->siglock);
> > +		if (unlikely(cgroup_task_frozen(current)))
> > +			cgroup_leave_frozen(true);
>=20
> Oh, and another leave_frozen below...

Yeah, because of this new "goto fatal" shortcut.

>=20
> I feel this must be simplified somehow, but nothing comes to my mind righ=
t now.
>=20
> > +		/*
> > +		 * If the task is leaving the frozen state, let's update
> > +		 * cgroup counters and reset the frozen bit.
> > +		 */
> > +		if (unlikely(cgroup_task_frozen(current))) {
> >  			spin_unlock_irq(&sighand->siglock);
> > +			cgroup_leave_frozen(true);
> >  			goto relock;
> >  		}
>=20
> afaics cgroup_leave_frozen(false) makes more sense here.

Why? I don't see any reasons why the task should remain in the frozen
state after this point. Can you, please, provide an example?

Thank you for looking into it!

Roman
