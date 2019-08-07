Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DBEC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 18:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CEFB22305
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 18:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388985AbfHGSAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 14:00:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58680 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387953AbfHGSAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 14:00:50 -0400
Received: from c-67-180-61-213.hsd1.ca.comcast.net ([67.180.61.213] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1hvQEp-0007lv-G6; Wed, 07 Aug 2019 18:00:39 +0000
Date:   Wed, 7 Aug 2019 20:00:34 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v3 1/2] fork: extend clone3() to support CLONE_SET_TID
Message-ID: <20190807180033.lucbhob6wfunp5xf@wittgenstein>
References: <20190806191551.22192-1-areber@redhat.com>
 <20190807142609.GC24112@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190807142609.GC24112@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 04:26:10PM +0200, Oleg Nesterov wrote:
> On 08/06, Adrian Reber wrote:
> >
> > +struct pid *alloc_pid(struct pid_namespace *ns, int set_tid)
> >  {
> >  	struct pid *pid;
> >  	enum pid_type type;
> > @@ -186,12 +186,35 @@ struct pid *alloc_pid(struct pid_namespace *ns)
> >  		if (idr_get_cursor(&tmp->idr) > RESERVED_PIDS)
> >  			pid_min = RESERVED_PIDS;
> >  
> > -		/*
> > -		 * Store a null pointer so find_pid_ns does not find
> > -		 * a partially initialized PID (see below).
> > -		 */
> > -		nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
> > -				      pid_max, GFP_ATOMIC);
> > +		if (set_tid) {
> > +			/*
> > +			 * Also fail if a PID != 1 is requested
> > +			 * and no PID 1 exists.
> > +			 */
> > +			if ((set_tid >= pid_max) || ((set_tid != 1) &&
> > +				(idr_is_empty(&tmp->idr)))) {
> 
> too many parentheses ;) this is purely cosmetic, up to you, but to me
> 
> 			if (set_tid >= pid_max ||
> 			   (set_tid != 1 && idr_is_empty(&tmp->idr))) {
> 
> looks a bit more readable.
> 
> 
> > +				spin_unlock_irq(&pidmap_lock);
> > +				retval = -EINVAL;
> > +				goto out_free;
> 
> This doesn't look right, you need idr_preload_end() before goto out_free.
> 
> But I'd suggest to simply do
> 
> 			nr = -EINVAL;
> 			if (set_tid < pid_max &&
> 			   (set_tid != 1 || idr_is_empty(&tmp->idr)))
> 				nr = idr_alloc(&tmp->idr, NULL, set_tid,
> 						set_tid + 1, GFP_ATOMIC);
> 
> 			...
> 
> this is more robust.

That all sounds reasonable to me.
