Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE11C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BDF2077C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BNAjnQMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfDITjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:39:09 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38404 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfDITjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 15:39:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id p14so15566335ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 12:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aLJa84kbHmO1Fsm6UHiJGcVq+nXBPwgLIQVtIw5VTpA=;
        b=BNAjnQMrx1jTP02XSpeyKAmUyPGbfmwOhm6oHtXyqeeAUuZ5R9mKtbaOUfWAWNzYh/
         E5emPY2f9r4q3mFSdQN6Kxj6EIcUJh4QnHrombCOoisrTexeVoZvTQ61mtzUblbmapHb
         5ivYQeU1Wxbzj6pWL6KWg/d6gdMc+BB8tyBaiJGQr0jh55QkuvgvFDLaFS0IuJroY+l0
         Y7BvGLN2S8bpN9hrNDR08VohAwa3ebOXIY4GtuA/tC7DcKK4qa08WJZjG7apcD1ttS66
         tM7hX5nmSQ9CnpzzeyIOOzebvKTvHfnveznyah0w02WeSw+52/tgHQike+PdoHHgFTxM
         ws1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aLJa84kbHmO1Fsm6UHiJGcVq+nXBPwgLIQVtIw5VTpA=;
        b=PEu+nFY3uc/maSi0CJHSzzbiAYjWK3YlJHCx93o7SfnyG4wfKyFZJOaxxfPlVIJsrE
         jUILSuD0o/EvRtvv5O4mzLfKNXrzDlS6Y2AAGG9kpACsLPh43lcvIMbJ0DW6juBzikD/
         NPGFu1brEH93n5nu6ltTHEH3igwCQxlVe1dDctp77nzVOGOiValNbziFf7xY5S/mh/3H
         b8v9dXgr32Yh+EKK9Ui3NQrXLlAy8Z5KE3SAEh+nJgHgiHq+m9PUDGDVdT1WmLyliNeH
         +18H0tYfKmpb6BZnzXjCUPQFpVZNd6Yy3KKiEePHEfXQvUjj9/gftzn5OqxVqZFcla8W
         6S6g==
X-Gm-Message-State: APjAAAX7iSBMLLgO0Khsgjx1+trBVZvhjpqXVED1MN/bnBZiR5X95l68
        TiJqKlkm3QoUPu/Dff6uhVnQTsiiukK97HC3Uuu9zA==
X-Google-Smtp-Source: APXvYqx0lbkxcX837K3J4ttnrfToYnq4T3y+WoT+Htebr+HExKAHPcz0GdbupPDVXxtSNRrtXO6xYGNV8ZiRXyv9HXc=
X-Received: by 2002:a2e:99d2:: with SMTP id l18mr20152993ljj.27.1554838746399;
 Tue, 09 Apr 2019 12:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <20190405203558.19160-1-rajatja@google.com>
 <20190405203558.19160-2-rajatja@google.com> <CAHp75VehpYPm1ApFozisSsNi1g0EtbKBm3C97jxXC2u04tpt0A@mail.gmail.com>
 <CACK8Z6FGFiS_jN_5ctWmjKbrcUyjGkV0MsVs7_2TsaS7UAoydA@mail.gmail.com>
 <CAHp75Ve9zq2MWbiHhNV6RSV8xgmWQdqaMi=UdE7RFiZ9QgmH5Q@mail.gmail.com>
 <CACK8Z6Fb603NV-CreX6mxgj=JF0VmfP0kORHZg5T8L5vOeTsQA@mail.gmail.com> <CAHp75VcU9VvV3M5jVxE6ezii7d4JtFXPG7D-0zRF_amW+bEGdQ@mail.gmail.com>
In-Reply-To: <CAHp75VcU9VvV3M5jVxE6ezii7d4JtFXPG7D-0zRF_amW+bEGdQ@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 9 Apr 2019 12:38:29 -0700
Message-ID: <CACK8Z6G=8_fQrBcYeGkyY1B81PoGxH_eRaR-BNP2EZMKGb8ZJg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] platform/x86: intel_pmc_core: Allow to dump debug
 registers on S0ix failure
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Mon, Apr 8, 2019 at 12:34 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Apr 8, 2019 at 9:58 PM Rajat Jain <rajatja@google.com> wrote:
> > On Mon, Apr 8, 2019 at 11:41 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Mon, Apr 8, 2019 at 9:36 PM Rajat Jain <rajatja@google.com> wrote:
>
> > > Instead of adding module parameter and doing these prints, perhaps
> > > introduce another debugfs node.
> >
> > Uh, I actually did wanted to print them at the resume time in kernel
> > logs, because I think this is something kernel developers would be
> > responsible for debugging and thus would be great to have this
> > included within the kernel logs. User space tools may differ on
> > different distros and may or may not be looking for S0ix failures, and
> > particularly may not dump this new debugfs attribute.
> >
> > The other thing is that seemingly this could also help in situations
> > where debugfs is not configured?
>
> The keywords above "developers", "debugging",  so, the concept of this
> driver is almost all about debugging, debugfs is not for users or esp.
> user space tools.
> So, I don't see any issue here with creating another node and use it
> for *debugging* whenever it's needed.

Hi Andy,

In the past, we did see random suspend (S0ix) failures after the
devices were released to users (S0ix failures reasons can be a lot so
was not possible to catch all in lab testing). Rajneesh (@Intel) is
aware of the context. In most of these cases, it was very difficult to
reproduce the issue in developer environment, so really difficult to
arrive at what component was causing those failures without these
logs. So I'd still like to make one last request to allow to these
debugs in the kernel at resume time, to make this feature very useful
(it still doesn't change anything for anyone not enabling the module
parameter). However if you still have a strong opinion against this,
I'll add it as a new debugfs attribute in the new re-spin of the
patch.

Thanks & Best Regards,

Rajat

>
> --
> With Best Regards,
> Andy Shevchenko
