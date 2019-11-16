Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42D9C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 22:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C17620730
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 22:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfKPW42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 17:56:28 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:32807 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfKPW42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 17:56:28 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iW6zR-00045u-Lo; Sat, 16 Nov 2019 15:56:25 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iW6zQ-00013I-9s; Sat, 16 Nov 2019 15:56:25 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Andrei Vagin <avagin@gmail.com>,
        Adrian Reber <areber@redhat.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
References: <20191114142707.1608679-1-areber@redhat.com>
        <20191114191538.GC171963@gmail.com>
        <20191115093419.GA25528@redhat.com>
        <20191115095854.4vr6bgfz6ny5zbpd@wittgenstein>
        <20191115104909.GB25528@redhat.com>
        <20191115130800.zntefr5ptabdngph@wittgenstein>
Date:   Sat, 16 Nov 2019 16:55:59 -0600
In-Reply-To: <20191115130800.zntefr5ptabdngph@wittgenstein> (Christian
        Brauner's message of "Fri, 15 Nov 2019 14:08:01 +0100")
Message-ID: <87wobz5t34.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iW6zQ-00013I-9s;;;mid=<87wobz5t34.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+4XRjpnruo5pIuKkWB7ifyFXo5kT+vzeM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v10 1/2] fork: extend clone3() to support setting a PID
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> On Fri, Nov 15, 2019 at 11:49:10AM +0100, Oleg Nesterov wrote:
>> On 11/15, Christian Brauner wrote:
>> >
>> > +static int set_tid_next(pid_t *set_tid, size_t *size, int idx)
>> > +{
>> > +	int tid = 0;
>> > +
>> > +	if (*size) {
>> > +		tid = set_tid[idx];
>> > +		if (tid < 1 || tid >= pid_max)
>> > +			return -EINVAL;
>> > +
>> > +		/*
>> > +		 * Also fail if a PID != 1 is requested and
>> > +		 * no PID 1 exists.
>> > +		 */
>> > +		if (tid != 1 && !tmp->child_reaper)
>> > +			return -EINVAL;
>> > +
>> > +		if (!ns_capable(tmp->user_ns, CAP_SYS_ADMIN))
>> > +			return -EPERM;
>> > +
>> > +		(*size)--;
>> > +	}
>> 
>> this needs more args, struct pid_namespace *tmp + pid_t pid_max
>> 		if (set_tid_size) {
>> 			tid = set_tid[ns->level - i];
>> 
>> 			retval = -EINVAL;
>> 			if (tid < 1 || tid >= pid_max)
>> 				goto out_free;
>
> I'm not a fan of this pattern of _not_ setting error codes in the actual
> error path t but I won't object.

If you can show a compiler that actually manages to reliably perform
that code motion it is worth discussing making it go away.  Last I
checked gcc will emit an extra basic block just to handle setting
the error code before jumping to the out_free.  That extra basic block
because of the extra jump tends to be costly.

Not a huge cost but in these days when branches are getting increasingly
expensive and Moore's law wrapping up I prefer code patterns that
generate cood code.

Eric
