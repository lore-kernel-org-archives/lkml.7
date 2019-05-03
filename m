Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1FBC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 01:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B84206C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 01:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfECBuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 21:50:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbfECBuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 21:50:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE5FB59450;
        Fri,  3 May 2019 01:50:02 +0000 (UTC)
Received: from x230.aquini.net (ovpn-120-12.rdu2.redhat.com [10.10.120.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CFBF32B9D0;
        Fri,  3 May 2019 01:49:57 +0000 (UTC)
Date:   Thu, 2 May 2019 21:49:56 -0400
From:   Rafael Aquini <aquini@redhat.com>
To:     Yury Norov <norov.maillist@gmail.com>
Cc:     Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Micah Morton <mortonm@chromium.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>, yury.norov@gmail.com
Subject: Re: [PATCH v2 2/2] prctl.2: Document the new PR_GET_TASK_SIZE option
Message-ID: <20190503014955.GB15494@x230.aquini.net>
References: <1556830342-32307-1-git-send-email-jsavitz@redhat.com>
 <1556830342-32307-3-git-send-email-jsavitz@redhat.com>
 <CAJu-Uz5xVQGVirjJXpC4Nyg8HZ=pUXEq7rN1kZz2Zg3hnUf=AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJu-Uz5xVQGVirjJXpC4Nyg8HZ=pUXEq7rN1kZz2Zg3hnUf=AQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 03 May 2019 01:50:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 03:23:12PM -0700, Yury Norov wrote:
> чт, 2 мая 2019 г. в 13:52, Joel Savitz <jsavitz@redhat.com>:
> >
> > Add a short explanation of the new PR_GET_TASK_SIZE option for the benefit
> > of future generations.
> >
> > Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> > ---
> >  man2/prctl.2 | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/man2/prctl.2 b/man2/prctl.2
> > index 06d8e13c7..35a6a3919 100644
> > --- a/man2/prctl.2
> > +++ b/man2/prctl.2
> > @@ -49,6 +49,7 @@
> >  .\" 2013-01-10 Kees Cook, document PR_SET_PTRACER
> >  .\" 2012-02-04 Michael Kerrisk, document PR_{SET,GET}_CHILD_SUBREAPER
> >  .\" 2014-11-10 Dave Hansen, document PR_MPX_{EN,DIS}ABLE_MANAGEMENT
> > +.\" 2019-05-02 Joel Savitz, document PR_GET_TASK_SIZE
> >  .\"
> >  .\"
> >  .TH PRCTL 2 2019-03-06 "Linux" "Linux Programmer's Manual"
> > @@ -1375,6 +1376,14 @@ system call on Tru64).
> >  for information on versions and architectures)
> >  Return unaligned access control bits, in the location pointed to by
> >  .IR "(unsigned int\ *) arg2" .
> > +.TP
> > +.B PR_GET_TASK_SIZE
> > +Copy the value of TASK_SIZE to the userspace address in
> > +.IR "(unsigned long\ *) arg2" .
> 
> This is a bad idea to use pointers to size-undefined types in interface because
> that way you have to introduce compat versions of interface functions.
> I'd recommend you to use u64 or unsigned long long here.
>
unsigned long long seems to make little sense too as prctl(2) extra arguments 
are of unsigned long type (good for passing the pointer address, in this case).

a pointer to an unsigned long var is OK for native builds, and for the
compat mode issue you correctly pointed out, the storage size needs to be 
dealt with at the kernel side, by checking test_thread_flag(TIF_ADDR32), 
before proceeding with copy_to_user().

 
> The comment not clear for reader not familiar with kernel internals.
> Can you rephrase
> TASK_SIZE like 'the (next after) highest possible userspace address',
> or similar?
> 
> For the updated version could you please CC to yury.norov@gmail.com?
> 
> > +Return
> > +.B EFAULT
> > +if this operation fails.
> > +
> >  .SH RETURN VALUE
> >  On success,
> >  .BR PR_GET_DUMPABLE ,
> > --
> > 2.18.1
> >
