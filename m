Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853A5C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534D720879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sazS80Cw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfDHS6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:58:46 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36319 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfDHS6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:58:45 -0400
Received: by mail-lj1-f196.google.com with SMTP id r24so517571ljg.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 11:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qEyLIYd+jzHclGjIT9PLtyASZ28Kzy/vNGmvo5if7H8=;
        b=sazS80CwX+rRoUG4ucFCFrCBFbO29OQhRRC+xtU7jvILfGvm0Dah8Z3xdJQR5yHqeu
         CvSZxt7Anf/EmTuJTM4AhsSx0QhFf4NkfMSLWmOXRG4Ww+7pB3FTDqeeB6d0SaVPWN6v
         FP6j9Xm3iBkTbjg3nicjRcJlACc15MuoCEr87LtzWeufSm69U0ij6iEf07dQou4msDS/
         1m3yQTyB1/lADCHPmJZD2+MRpVM5eKxP8M0B8Vc3BTSNDMM8yvElHDOxVlKWqjeX974+
         7IAwiU6CaNRlpvt3ePlkecZ9VE354ap5fYf5ElreTzA5hKohXCsYt7WVv9QAoxtOB6lp
         GOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qEyLIYd+jzHclGjIT9PLtyASZ28Kzy/vNGmvo5if7H8=;
        b=ZdAfOrLqwYxa59tih4usmlJp1jDJvkWyKBq0TliWFr+V65hMeHppfuu0l7MOIK1Wjj
         S25fPHhAfN96Ux54/8peoKCJaU4lFlkTXU28UQkevoXAnIX7k7ae/KpC6aHkiofyBl4y
         uK71k9s8faXdgGdKi4ya+p6PJLumRz+NV3lykeOzlLHZSofwS4RR/HSlBUXlguoEp+xM
         mYhqr2UMDV0BSNIjR081r/HJUKSQU8WsfzolSybBMggnTdaR5isPoffaYJpOxHmGfVRd
         xvkchKYiwTEZA4j8WuEsOSfYETfxu7fZo97l3sDbspgZdt2NwfAweeTMqGJ0467SFEGt
         +WzA==
X-Gm-Message-State: APjAAAU2fj8gJF6+WubHT3eNqi6vNw/ELOPDceyXTskHklLaXkXOBT3U
        y1Kxf9n6rTjAA1C5Qhy54J+MMtSNVYk4E5oI/Q7Mjw==
X-Google-Smtp-Source: APXvYqyCqRHXdZDh/dQ+gkRNLZiIwHz/RUTYU2qlss6iT8/Z49mAiigMPMO2Z6Td/jpX6t8TBa9kQfk06e5Pz8A4OWk=
X-Received: by 2002:a2e:9a0f:: with SMTP id o15mr16851279lji.130.1554749922721;
 Mon, 08 Apr 2019 11:58:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <20190405203558.19160-1-rajatja@google.com>
 <20190405203558.19160-2-rajatja@google.com> <CAHp75VehpYPm1ApFozisSsNi1g0EtbKBm3C97jxXC2u04tpt0A@mail.gmail.com>
 <CACK8Z6FGFiS_jN_5ctWmjKbrcUyjGkV0MsVs7_2TsaS7UAoydA@mail.gmail.com> <CAHp75Ve9zq2MWbiHhNV6RSV8xgmWQdqaMi=UdE7RFiZ9QgmH5Q@mail.gmail.com>
In-Reply-To: <CAHp75Ve9zq2MWbiHhNV6RSV8xgmWQdqaMi=UdE7RFiZ9QgmH5Q@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 8 Apr 2019 11:58:06 -0700
Message-ID: <CACK8Z6Fb603NV-CreX6mxgj=JF0VmfP0kORHZg5T8L5vOeTsQA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] platform/x86: intel_pmc_core: Allow to dump debug
 registers on S0ix failure
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Wysocki <Wysocki@google.com>,
        Rafael J <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Furquan Shaikh <furquan@google.com>,
        Evan Green <evgreen@google.com>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 11:41 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Apr 8, 2019 at 9:36 PM Rajat Jain <rajatja@google.com> wrote:
> > On Mon, Apr 8, 2019 at 10:02 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Fri, Apr 5, 2019 at 11:36 PM Rajat Jain <rajatja@google.com> wrote:
>
> > > Perhaps something like
> > >
> > > pmcdev->check_counters = false;
> > > /* User doesn't want to be warned */
> > > if (!warn_on...)
> > >  return 0;
> > > /* We do suspend via firmware */
> > > if (...)
> > >  return 0;
> > > ...
> > >
> > > ?
> >
> > I guess what you mean is one conditional per line. Sure, I will do that.
>
> Yes
>
> > > > +static inline bool pc10_failed(struct pmc_dev *pmcdev)
> > >
> > > To be or not to be? :-)
> > > Perhaps names of the functions should be
> > >
> > > pmc_code_is_pc10_failed()
> > >
> > > and so on
> >
> > I think the suggestion is to use pmc_core_* as the function names. OK,
> > I will rename the functions to:
> >
> > pmc_core_pc10_failed()
> > and
> > pmc_core_s0ix_failed()
>
> And verb "to be". See above.
>
> > > Can't we utilize existing print helpers?
> >
> > I didn't quite see any existing print helpers in this file. I took
> > this code from pmc_core_slps0_dbg_show(), and I think although I can
> > abstract out this code into a static function, the calling code need
> > to use seq_printf(s,...) and dev_warn(dev,...) respectively. - so
> > might be overkill (did not feel that the benefits were worth it).
> > Please let me know if you have any suggestions and will be happy to
> > use them.
>
> Instead of adding module parameter and doing these prints, perhaps
> introduce another debugfs node.

Uh, I actually did wanted to print them at the resume time in kernel
logs, because I think this is something kernel developers would be
responsible for debugging and thus would be great to have this
included within the kernel logs. User space tools may differ on
different distros and may or may not be looking for S0ix failures, and
particularly may not dump this new debugfs attribute.

The other thing is that seemingly this could also help in situations
where debugfs is not configured?

Thanks,

Rajat


>
> --
> With Best Regards,
> Andy Shevchenko
