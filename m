Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD26DC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A150220709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfKNK5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 05:57:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40297 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfKNK5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 05:57:11 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iVCoC-0008OC-T1; Thu, 14 Nov 2019 11:57:04 +0100
Date:   Thu, 14 Nov 2019 11:57:04 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 21/23] y2038: itimer: change implementation to
 timespec64
In-Reply-To: <CAK8P3a27OV864GfvLK_wjO7dK__r59dZ_dNQACp4G00gJrAwMw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911141153350.2507@nanos.tec.linutronix.de>
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108211323.1806194-12-arnd@arndb.de> <alpine.DEB.2.21.1911132306070.2507@nanos.tec.linutronix.de> <CAK8P3a27OV864GfvLK_wjO7dK__r59dZ_dNQACp4G00gJrAwMw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2019, Arnd Bergmann wrote:
> On Wed, Nov 13, 2019 at 11:28 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Fri, 8 Nov 2019, Arnd Bergmann wrote:
> > > @@ -197,19 +207,13 @@ static void set_cpu_itimer(struct task_struct *tsk, unsigned int clock_id,
> > >  #define timeval_valid(t) \
> > >       (((t)->tv_sec >= 0) && (((unsigned long) (t)->tv_usec) < USEC_PER_SEC))
> >
> > Hrm, why do we have yet another incarnation of timeval_valid()?
> 
> No idea, you have to ask the author of commit 7d99b7d634d8 ("[PATCH]
> Validate and
> sanitze itimer timeval from userspace") ;-)

I don't know that guy. :)

> > Can we please have only one (the inline version)?
> 
> I'm removing the inline version in a later patch along with most of the rest of
> include/linux/time32.h.
> 
> Having the macro version is convenient for this patch, since I'm using it
> on two different structures (itimerval/__kernel_old_timeval and
> old_itimerval32/old_timeval32), neither of which is the type used in the
> inline function.

Fair enough.

Thanks,

	tglx
