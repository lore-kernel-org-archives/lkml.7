Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CCBC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6E220879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lEXht/Yz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbfEVP6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 11:58:01 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41327 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbfEVP6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:58:01 -0400
Received: by mail-vs1-f66.google.com with SMTP id w19so1711194vsw.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 08:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s+WN2NSpn2jB+QUHcx4gNYGLsVtBRRfA1ymT26broI0=;
        b=lEXht/YzHUZXrnvdt5qubD90lRzX9j1Hhl5VcHyTADFl7HzlKZD3QAkyg2J05xaB+W
         v+yjOf3FT4gNaluoicvNLlvsh1zpPzq7MIKXk+qQ8OfuPhgWCfjUsNBtvbFFQfLZmmaS
         pRfHWOPDr0Svw9fuTxYmtViBinOwFT8aK1hpeHXxkVPlFJYXmEAeS//9FgBg4FlU26Lm
         GD035e+60AW9wjRfTojUD/fXVAhoYtaTlMk9wq9qwgvlOS0yRD5tbXYTtmBa/dmL9uGb
         pAKj37gKgvWH/F1SOhOG5rKvqXgptpqEM3fRlIrPwElyc92ah4Y4Jd/79Du7582TE1IF
         IUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s+WN2NSpn2jB+QUHcx4gNYGLsVtBRRfA1ymT26broI0=;
        b=rdXcW0F26cHN3ycVJphBAgjG3jykDkgb38sNaTT0gGaJZlU+37SlMcWiIa3iMivuyu
         lF0xpIpoocFArDBfjhnwDKHTnH0yM73Y+ZZykQOb4FrxL2/RUbSV1yNYuEEM16Z2H+wR
         ks+vcueHJJHrhlG0hq4bbJr2y33hw1jmSW5vI4ZQqeKDKtX9LBUIYeABofcXqezay1q0
         FW1sXfFJ4FJTrGm2o2M+Psfmn5uRKOzxRrBhQVZxdAO2jNs6+v9WdtNcBSA31d2yM/iM
         LHwTaggOHGc+PB63mCnugPzaUJQtPtJ1NvctUAhl0Vh5GUu+YJw6q0yByqHRKTCWBcaD
         cr4g==
X-Gm-Message-State: APjAAAVao2jbAy5zqYqaiF0or/4VYrsU36Z5REKYRIccm8pO+kT6/cOm
        GuP8W0ldH5GFsSLDcU0/AGmZOts8BoK03644ItfOxQ==
X-Google-Smtp-Source: APXvYqyweCTnIudqCQoYfR74UirDb+xbgaCwS7136xNVmk5dacdDUaPrVVugetVcSqKqiDfJrOtZO/R40hLE8CE7dbA=
X-Received: by 2002:a67:1485:: with SMTP id 127mr15146284vsu.77.1558540679719;
 Wed, 22 May 2019 08:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190520035254.57579-1-minchan@kernel.org> <20190521084158.s5wwjgewexjzrsm6@brauner.io>
 <20190521110552.GG219653@google.com> <20190521113029.76iopljdicymghvq@brauner.io>
 <20190521113911.2rypoh7uniuri2bj@brauner.io> <CAKOZuesjDcD3EM4PS7aO7yTa3KZ=FEzMP63MR0aEph4iW1NCYQ@mail.gmail.com>
 <CAHrFyr6iuoZ-r6e57zp1rz7b=Ee0Vko+syuUKW2an+TkAEz_iA@mail.gmail.com>
 <CAKOZueupb10vmm-bmL0j_b__qsC9ZrzhzHgpGhwPVUrfX0X-Og@mail.gmail.com>
 <20190522145216.jkimuudoxi6pder2@brauner.io> <CAKOZueu837QGDAGat-tdA9J1qtKaeuQ5rg0tDyEjyvd_hjVc6g@mail.gmail.com>
 <20190522154823.hu77qbjho5weado5@brauner.io>
In-Reply-To: <20190522154823.hu77qbjho5weado5@brauner.io>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 22 May 2019 08:57:47 -0700
Message-ID: <CAKOZuev97fTvmXhEkjb7_RfDvjki4UoPw+QnVOsSAg0RB8RyMQ@mail.gmail.com>
Subject: Re: [RFC 0/7] introduce memory hinting API for external process
To:     Christian Brauner <christian@brauner.io>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 8:48 AM Christian Brauner <christian@brauner.io> wrote:
>
> On Wed, May 22, 2019 at 08:17:23AM -0700, Daniel Colascione wrote:
> > On Wed, May 22, 2019 at 7:52 AM Christian Brauner <christian@brauner.io> wrote:
> > > I'm not going to go into yet another long argument. I prefer pidfd_*.
> >
> > Ok. We're each allowed our opinion.
> >
> > > It's tied to the api, transparent for userspace, and disambiguates it
> > > from process_vm_{read,write}v that both take a pid_t.
> >
> > Speaking of process_vm_readv and process_vm_writev: both have a
> > currently-unused flags argument. Both should grow a flag that tells
> > them to interpret the pid argument as a pidfd. Or do you support
> > adding pidfd_vm_readv and pidfd_vm_writev system calls? If not, why
> > should process_madvise be called pidfd_madvise while process_vm_readv
> > isn't called pidfd_vm_readv?
>
> Actually, you should then do the same with process_madvise() and give it
> a flag for that too if that's not too crazy.

I don't know what you mean. My gut feeling is that for the sake of
consistency, process_madvise, process_vm_readv, and process_vm_writev
should all accept a first argument interpreted as either a numeric PID
or a pidfd depending on a flag --- ideally the same flag. Is that what
you have in mind?
