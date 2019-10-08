Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E11C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0742A2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGuXSD/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbfJHM7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:59:02 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40436 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730301AbfJHM7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:59:01 -0400
Received: by mail-lf1-f67.google.com with SMTP id d17so11875990lfa.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 05:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AV2pJyjjWDwaKVr64wvB1gpLkau4/A2cAtbwElrboN4=;
        b=oGuXSD/dVaEASsZJf+mji2Xv+VvKyMFsMJQ+WdQ1Zjo+hIjf9g014Lf5UtWrM3qZBf
         d6YccpRj6rQgfNJ707o7eH1QlvHWoB+NbzbkgF6kEnpMiljHT6H0Or7EMiOEkmTLoNj0
         lIAMjdRMBbOw43sjodUfnROuAIV7S8YaOlV7Qz2q3DKEQjC9EZuJnPDbGaD9tymsNc7R
         QP2CWVtGSPsqXWo27Wql0VGs35NvkswD0gal8ggzU0AtDIVmPei4YYrL1elT5rrtw06r
         HlHX5SKI1lik+LzT7FhBCb4mAYUPIesMiKLEBr+NMDpehk8v138yQr2qdfB1asGo8tZg
         60Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AV2pJyjjWDwaKVr64wvB1gpLkau4/A2cAtbwElrboN4=;
        b=KTnYg6E3jxo7l8A1Er3tQMcaH9RxmGVlddhQFkaBITErVwC++NyOPFRp6hf5lRW523
         +vrdZV3XudrTlQ/xsxOaaQMSsE2gItXbw5LlgyQAeYOTkBxDvkU1bvCPGW1Zoi9i24Ne
         qM2wStz5T4HCZ4Kwfz74qSBYPruqm/tv+hfRszHVy9zJBhKD4UBaK6OwtpC2qEPW20Be
         JF4qPU5D0ufRsWg1DeXa9Xswz7sxfajOx4IiAZ3dlQJ9VnkYRP99CKT4MZWiXuVPJ0OV
         Y/o2qbARwFGiGVfB2ZSYblGfLlnsUEOli/l7K+izCI/zFILzHyCvezkrloX/dxk2RfAT
         re7w==
X-Gm-Message-State: APjAAAUnQMzUzvVaShBCLerbSEA9qwOTLSXk4IVu7M0JzQC3/KMliq7q
        Cup2A/xisCYHyuNIHrzrKrUW6qGOAlSPfH19NGM=
X-Google-Smtp-Source: APXvYqxXOFwGfBK9ieLGJo8RtWtyB4xoZfFG6/Ct2ex1SYLUc1Ra7p1FKiOvG7/fqUQFRk3AUXVw3A+HqkTRstr5CRk=
X-Received: by 2002:a19:711e:: with SMTP id m30mr20571268lfc.63.1570539539703;
 Tue, 08 Oct 2019 05:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <CADkTA4PBT374CY+UNb85WjQEaNCDodMZu=MgpG8aMYbAu2eOGA@mail.gmail.com>
 <20191002020100.GA6436@castle.dhcp.thefacebook.com> <CADkTA4Mbai=Q5xgKH9-md_g73UsHiKnEauVgMWev+-sG8FVNSA@mail.gmail.com>
 <20191002181914.GA7617@castle.DHCP.thefacebook.com> <CADkTA4PmGBR7YdOXvi6sEDJ+uztuB7x2G95TCcW2u_iqjwhUNQ@mail.gmail.com>
 <20191004000913.GA5519@castle.DHCP.thefacebook.com> <CADkTA4OJok3cmYCcDKtxBXQ5xtK1EMujh7_AgLnVaeRr18TH9w@mail.gmail.com>
 <CADkTA4PKc6VEQYvXk4-EWMJPyOrzWQEsk4p6O_BMFo6kvT2jYg@mail.gmail.com>
 <20191007232754.GB11171@tower.DHCP.thefacebook.com> <CADkTA4NKDn4jd2BQaGk+JEnM3B5GMDudsBi6V4YwK3Soq9q9pA@mail.gmail.com>
 <20191008123601.GA28621@redhat.com>
In-Reply-To: <20191008123601.GA28621@redhat.com>
From:   Bruce Ashfield <bruce.ashfield@gmail.com>
Date:   Tue, 8 Oct 2019 08:58:47 -0400
Message-ID: <CADkTA4Oh5+fTEqpNFJjPOfTYhiVQEdUO4Cx2LXpPyPfO+96X1w@mail.gmail.com>
Subject: Re: ptrace/strace and freezer oddities and v5.2+ kernels
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Roman Gushchin <guro@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        Richard Purdie <richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 8:36 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 10/08, Bruce Ashfield wrote:
> >
> > So I've been looking through the config delta's and late last night, I was
> > able to move the runtime back to a failed 4 minute state by adding the
> > CONFIG_PREEMPT settings that we have by default in our reference
> > kernel.
>
> Aha... Can you try the patch below?

Confirmed. 4 second runtime with that change, 4 minutes with it in the
original position.

.. I'm kind of shocked I just didn't try that myself, since I spent
plenty of time staring
at the innards of cgroup_enter_frozen() for enough time to at least
get an inkling
to try that.

I'll run this through some additional testing, but initial results are
good. I'm not
familiar enough with the semantics at play to even guess at any
possible side effects.

But do let me know if i can do anything else on this .. and thanks for
everyone's
patience.

Bruce

>
> Oleg.
>
> --- x/kernel/signal.c
> +++ x/kernel/signal.c
> @@ -2205,8 +2205,8 @@ static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t
>                  */
>                 preempt_disable();
>                 read_unlock(&tasklist_lock);
> -               preempt_enable_no_resched();
>                 cgroup_enter_frozen();
> +               preempt_enable_no_resched();
>                 freezable_schedule();
>                 cgroup_leave_frozen(true);
>         } else {
>


-- 
- Thou shalt not follow the NULL pointer, for chaos and madness await
thee at its end
- "Use the force Harry" - Gandalf, Star Trek II
