Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CC4C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F0420833
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TElP45/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfDHSlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:41:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34773 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbfDHSlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:41:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id y6so7834843plt.1;
        Mon, 08 Apr 2019 11:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ak5oe05a/Wjim9Pmg5/vpEGktaM5SyuHiXmryKJDbkw=;
        b=TElP45/yjYFHg11Apky2Q6oUIW4P8zgxqvxcv+IxyzwdimfurEFksLKl+Ls3IjVK8W
         A1tddO7pC4CpSKAqQZ76E7gMmXLhmF5XoRycJE7uo2r6yhRjrhvNde1VHtBv5tuEXrYd
         GuTeuZzPQW0EI23XCmD0lHl3ccYJvDHjDUuy5FK0cXnCTc/Fm8XbSccPJxnn6lyN6jem
         EpefDMHXW2ro+y4XC97Qx27aYmq8WpsBD9dYGPqjAqK7mynhYmdJTUSVa/n93c0ZcMEW
         KOjMPLjf8JuLP1b7TcS1v4DZxS4nDllBsQtSdgLc0M2xXPpUethtBcu7SrNKmKEZ15mI
         GPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ak5oe05a/Wjim9Pmg5/vpEGktaM5SyuHiXmryKJDbkw=;
        b=YskkDrEIsu7yEEY9ud3bw1B7L0rAFk+clC18qnU/Pkb8pPwQEVKskEougN0b//wTvR
         QdsdIIxsxw71/qeaUzS6l1Pt/T0Wmzu0XhHrQsWtqXYSCxXKFA40lINFl9Qdj3AEEHVx
         r6nXPHqHhZCPtLdjQsBIvNTOLpqPIT1cay5rWQV7c2djBiNorL/dJWA68VCRYdZJGhyq
         yp1/TntQt3YiZAdr5tArNNLCTiuqBQrntb96chDbKGWYPeGSsVKgGczvvYE6b70EXONe
         ggKH0u3su7a4CBl7T1o1R2EQoG0wHZA4P1DYVaAZJadeusl7ixrhTcKlvkud3oW8Ujae
         jFkg==
X-Gm-Message-State: APjAAAW7glIlpUQBPeUUqj2+Pnoq4LOkD7IqCh8W49QtzKohvf2qnOlh
        hix2Dx3PzGiHMvXllpsEVulorOZ9JwjQCU4MXrk=
X-Google-Smtp-Source: APXvYqzo6g4f1UiVbNqnMDIvRcK/+NVeKuSGx3EU9EH+MCQgpZyju/93ybghN/VkGXFHyKOOAjUy0t6Cw/J3CbmdLMA=
X-Received: by 2002:a17:902:2d01:: with SMTP id o1mr32187919plb.155.1554748879362;
 Mon, 08 Apr 2019 11:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <20190405203558.19160-1-rajatja@google.com>
 <20190405203558.19160-2-rajatja@google.com> <CAHp75VehpYPm1ApFozisSsNi1g0EtbKBm3C97jxXC2u04tpt0A@mail.gmail.com>
 <CACK8Z6FGFiS_jN_5ctWmjKbrcUyjGkV0MsVs7_2TsaS7UAoydA@mail.gmail.com>
In-Reply-To: <CACK8Z6FGFiS_jN_5ctWmjKbrcUyjGkV0MsVs7_2TsaS7UAoydA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Apr 2019 21:41:07 +0300
Message-ID: <CAHp75Ve9zq2MWbiHhNV6RSV8xgmWQdqaMi=UdE7RFiZ9QgmH5Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] platform/x86: intel_pmc_core: Allow to dump debug
 registers on S0ix failure
To:     Rajat Jain <rajatja@google.com>
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wysocki@google.com, Rafael J <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Furquan Shaikh <furquan@google.com>,
        Evan Green <evgreen@google.com>,
        Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 9:36 PM Rajat Jain <rajatja@google.com> wrote:
> On Mon, Apr 8, 2019 at 10:02 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, Apr 5, 2019 at 11:36 PM Rajat Jain <rajatja@google.com> wrote:

> > Perhaps something like
> >
> > pmcdev->check_counters = false;
> > /* User doesn't want to be warned */
> > if (!warn_on...)
> >  return 0;
> > /* We do suspend via firmware */
> > if (...)
> >  return 0;
> > ...
> >
> > ?
>
> I guess what you mean is one conditional per line. Sure, I will do that.

Yes

> > > +static inline bool pc10_failed(struct pmc_dev *pmcdev)
> >
> > To be or not to be? :-)
> > Perhaps names of the functions should be
> >
> > pmc_code_is_pc10_failed()
> >
> > and so on
>
> I think the suggestion is to use pmc_core_* as the function names. OK,
> I will rename the functions to:
>
> pmc_core_pc10_failed()
> and
> pmc_core_s0ix_failed()

And verb "to be". See above.

> > Can't we utilize existing print helpers?
>
> I didn't quite see any existing print helpers in this file. I took
> this code from pmc_core_slps0_dbg_show(), and I think although I can
> abstract out this code into a static function, the calling code need
> to use seq_printf(s,...) and dev_warn(dev,...) respectively. - so
> might be overkill (did not feel that the benefits were worth it).
> Please let me know if you have any suggestions and will be happy to
> use them.

Instead of adding module parameter and doing these prints, perhaps
introduce another debugfs node.

-- 
With Best Regards,
Andy Shevchenko
