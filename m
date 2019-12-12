Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA133C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 08:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F005214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 08:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQ1aCrQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfLLIFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 03:05:35 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33850 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbfLLIFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 03:05:35 -0500
Received: by mail-lj1-f196.google.com with SMTP id m6so1218435ljc.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 00:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D5CdL72oAGFzvBY6QtxAW/opFYUrS0DCzRtDcLARPlM=;
        b=RQ1aCrQt71scdxmVYOs2+irsGBO5mXSKza7aFK6gEHkMShYqAzp3Af4m8OgE7nr9do
         BJ4cxPCyx9FNdHcrgGZsI7CNzBwLEfhCtNnq3C6+MGvk3TuAlDcX4U7H5qHgjssSVGlv
         oaT8SX3p3JhPmB+dPkYoOIg+J/1mM936nKSLZqt0Y0owt6igrVdNc4x58M4DFS7ph3JZ
         St3jtX7Vh0Z/Z1ZffIHG1AUZem7ldcu+fkwlsSzSOWK8w9FneZEl78Mf2Pxx/MqZshe2
         EXw1ZEE5bblU4EzHGmfpQjLtvLb792Ntlh/0wkS/48iYQWQdqUxnp97ZsmzmkX6bvEgg
         4dBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D5CdL72oAGFzvBY6QtxAW/opFYUrS0DCzRtDcLARPlM=;
        b=WoaNOXVNgSIrhiruxdUxdJlzmAB9LLusqCv7Edm0bOJYdsoDoTTiidVU6/JKL6IdEc
         /RchZBP2EFOf681gi94HzVGjAKeHHfxf1zKoq39NVzbXBpBSg5xs7fERE9h3ekcNdcog
         HUPqKjJ8ISKksf31uCwdzjHoRNaMRBCT1CCcpVHFKrQvF6dmVN2BOwNLPZL70qm53N6u
         Qvi+4mhSMm16VZlslvbFkX/CYgwirTkV6EzztrsxwYxcU/7qxehnTTThbBbzHP9sCcN0
         syzh9U9fRgz7A73C+dxbekbfduWPoLj1gkvLyWneJMII7ukNuevFf3QV3kz8H9p05lQy
         nGlA==
X-Gm-Message-State: APjAAAWIGB/VpEMZYdJ8JoDrzA/307MyiQozlygCW54QD4DuQbxFMht3
        7mIMXM/pF0ctPFVbJ2gr+QutITiQTfPaBfSC9A3L6A==
X-Google-Smtp-Source: APXvYqyJ91Gn19rm2vbXdmqFvecFunxEEmuukfA/2HLCASaiDbzlXeysBPII1SPb5zskNnpuKg/gJwiqCSQ0Kw4J9J4=
X-Received: by 2002:a2e:9a04:: with SMTP id o4mr5216093lji.214.1576137932881;
 Thu, 12 Dec 2019 00:05:32 -0800 (PST)
MIME-Version: 1.0
References: <20191204200623.198897-1-joshdon@google.com> <CAKfTPtBZUUtJ=ZvQOWmKx_1zUXtNoqcS0M85ouQmgi36xzfM2A@mail.gmail.com>
 <CABk29NsCjgMVf-xrhpyzFBTpyTvyWxZc4RJSarnHVzdOXyVPMw@mail.gmail.com>
In-Reply-To: <CABk29NsCjgMVf-xrhpyzFBTpyTvyWxZc4RJSarnHVzdOXyVPMw@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 12 Dec 2019 09:05:21 +0100
Message-ID: <CAKfTPtCJGT0axT5=E=hLWtMav_kLGVFrSvjZS8+cfvjYS72vqQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Do not set skip buddy up the sched hierarchy
To:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

On Fri, 6 Dec 2019 at 23:13, Josh Don <joshdon@google.com> wrote:
>
> Hi Vincent,
>
> Thanks for taking a look.
>
> > There is a mismatch between the author Venkatesh Pallipadi and the
> > signoff Josh Don
> > If Venkatesh is the original author and you have then done some
> > modifications, your both signed-off should be there
>
> Venkatesh no longer works at Google, so I don't have a way to get in
> touch with him.  Is my signed-off insufficient for this case?

Maybe you can add a Co-developed-by tag to reflect your additional changes
I guess that as long as you agree with the DCO, it's ok :
https://www.kernel.org/doc/html/v5.4/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

Ingo, Peter, what do you think ?


>
>
> On Thu, Dec 5, 2019 at 11:57 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > Hi Josh,
> >
> > On Wed, 4 Dec 2019 at 21:06, Josh Don <joshdon@google.com> wrote:
> > >
> > > From: Venkatesh Pallipadi <venki@google.com>
> > >
> > > Setting skip buddy all the way up the hierarchy does not play well
> > > with intra-cgroup yield. One typical usecase of yield is when a
> > > thread in a cgroup wants to yield CPU to another thread within the
> > > same cgroup. For such a case, setting the skip buddy all the way up
> > > the hierarchy is counter-productive, as that results in CPU being
> > > yielded to a task in some other cgroup.
> > >
> > > So, limit the skip effect only to the task requesting it.
> > >
> > > Signed-off-by: Josh Don <joshdon@google.com>
> >
> > There is a mismatch between the author Venkatesh Pallipadi and the
> > signoff Josh Don
> > If Venkatesh is the original author and you have then done some
> > modifications, your both signed-off should be there
> >
> > Apart from that, the change makes sense to me
> >
> > > ---
> > > v2: Only clear skip buddy on the current cfs_rq
> > >
> > >  kernel/sched/fair.c | 18 +++++++++++-------
> > >  1 file changed, 11 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 08a233e97a01..0b7a1958ad52 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -4051,13 +4051,10 @@ static void __clear_buddies_next(struct sched_entity *se)
> > >
> > >  static void __clear_buddies_skip(struct sched_entity *se)
> > >  {
> > > -       for_each_sched_entity(se) {
> > > -               struct cfs_rq *cfs_rq = cfs_rq_of(se);
> > > -               if (cfs_rq->skip != se)
> > > -                       break;
> > > +       struct cfs_rq *cfs_rq = cfs_rq_of(se);
> > >
> > > +       if (cfs_rq->skip == se)
> > >                 cfs_rq->skip = NULL;
> > > -       }
> > >  }
> > >
> > >  static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
> > > @@ -6552,8 +6549,15 @@ static void set_next_buddy(struct sched_entity *se)
> > >
> > >  static void set_skip_buddy(struct sched_entity *se)
> > >  {
> > > -       for_each_sched_entity(se)
> > > -               cfs_rq_of(se)->skip = se;
> > > +       /*
> > > +        * One typical usecase of yield is when a thread in a cgroup
> > > +        * wants to yield CPU to another thread within the same cgroup.
> > > +        * For such a case, setting the skip buddy all the way up the
> > > +        * hierarchy is counter-productive, as that results in CPU being
> > > +        * yielded to a task in some other cgroup. So, only set skip
> > > +        * for the task requesting it.
> > > +        */
> > > +       cfs_rq_of(se)->skip = se;
> > >  }
> > >
> > >  /*
> > > --
> > > 2.24.0.393.g34dc348eaf-goog
> > >
