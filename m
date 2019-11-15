Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC96C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422DA2073C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfKONIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 08:08:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44171 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfKONIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:08:09 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iVbKU-0000T5-1V; Fri, 15 Nov 2019 13:08:02 +0000
Date:   Fri, 15 Nov 2019 14:08:01 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrei Vagin <avagin@gmail.com>, Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v10 1/2] fork: extend clone3() to support setting a PID
Message-ID: <20191115130800.zntefr5ptabdngph@wittgenstein>
References: <20191114142707.1608679-1-areber@redhat.com>
 <20191114191538.GC171963@gmail.com>
 <20191115093419.GA25528@redhat.com>
 <20191115095854.4vr6bgfz6ny5zbpd@wittgenstein>
 <20191115104909.GB25528@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191115104909.GB25528@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 11:49:10AM +0100, Oleg Nesterov wrote:
> On 11/15, Christian Brauner wrote:
> >
> > +static int set_tid_next(pid_t *set_tid, size_t *size, int idx)
> > +{
> > +	int tid = 0;
> > +
> > +	if (*size) {
> > +		tid = set_tid[idx];
> > +		if (tid < 1 || tid >= pid_max)
> > +			return -EINVAL;
> > +
> > +		/*
> > +		 * Also fail if a PID != 1 is requested and
> > +		 * no PID 1 exists.
> > +		 */
> > +		if (tid != 1 && !tmp->child_reaper)
> > +			return -EINVAL;
> > +
> > +		if (!ns_capable(tmp->user_ns, CAP_SYS_ADMIN))
> > +			return -EPERM;
> > +
> > +		(*size)--;
> > +	}
> 
> this needs more args, struct pid_namespace *tmp + pid_t pid_max
> 		if (set_tid_size) {
> 			tid = set_tid[ns->level - i];
> 
> 			retval = -EINVAL;
> 			if (tid < 1 || tid >= pid_max)
> 				goto out_free;

I'm not a fan of this pattern of _not_ setting error codes in the actual
error path t but I won't object.

	Christian
