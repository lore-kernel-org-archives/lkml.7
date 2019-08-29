Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27117C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DEB2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c29yf1bh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfH2Qe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:34:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37051 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfH2Qe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:34:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id z11so4116996wrt.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 09:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qpanO385XMKPNBmgQ90ht9XRbAH606WeW99mEjSVvVY=;
        b=c29yf1bhYfl0RZdawBGl7I49nhSZZSRY0hl6QJQAiqJCXrKcg/uIgy/7083pZzg7rX
         grHC1gMYlrAA5wl+k15WnI224Pa1HjnEa46Fp7iJ93m3vx7rrqIQHC4wwG1cmYPYbqkm
         OVQEf6ZxDcF0fiaSwFtWhLJLHPC68JOR3u9UPG48iyoC1tIorjP74WeiYz0itqFjgX2M
         X3NW6urBo6wr0f2aW52MLhPI3trmAJ/UNEzhRTLZicILXxXuL2KIDXZFv64Zt1QfJsAx
         20dNPxrJzoxmGJl2MM5j1WWFKR0a12ndp1CRrWJUnOu2NL4PLNlIA2Ak+tpDByGkxqnv
         f6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qpanO385XMKPNBmgQ90ht9XRbAH606WeW99mEjSVvVY=;
        b=EH87CoPTAG+vDf7X/TSYCOEt/QfXMD66UUJCl0PsJph2TSYS7NsEIKQNq7LASFyA5g
         hhzyyS6tT7Fwt8pzz/ep1VPmWBo2MgRYFNlkCyeYBCQi8QhFsKzQOTvgPHsVEuB8uPF2
         fRDisMAHQqPW3Udli5NDv7gUHWt7XzbT44rLYmObM/JYAnY9JobAQjCfCq7bn6rDEMZ0
         TPu3GkN/0tnMaafJzu8y2v1msud1WZcKlRxmAke5BOq9XC4AAPl5yVtXbH7NN6ZNB/Hm
         keiYBuF9VX+PenAvPK188SGubHV/RDXl9GMOSVwUsrf8jPAl+0pWR63cNapD9zl2H4DK
         6fcw==
X-Gm-Message-State: APjAAAXWcDScM8haaRwMEkLj+c2mMUjILNkiZLotc+XTKVgQ6C/o4+5Y
        iwd0eP1S+fBDoQiW7C9K0L8GKQ==
X-Google-Smtp-Source: APXvYqzwkyl+arYcLkVl8UKy4eKXEIOA5iMHMNzJcrBTD+BVUCP6YPkNaqprGlXLZT0HMEHjckVcKQ==
X-Received: by 2002:a5d:4108:: with SMTP id l8mr12623917wrp.113.1567096465889;
        Thu, 29 Aug 2019 09:34:25 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id o9sm1994254wrm.88.2019.08.29.09.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 09:34:25 -0700 (PDT)
Date:   Thu, 29 Aug 2019 17:34:23 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <masneyb@onstation.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 03/15] drivers: thermal: tsens: Add __func__
 identifier to debug statements
Message-ID: <20190829163423.2ibdsx6etsl6v5ua@holly.lan>
References: <cover.1566907161.git.amit.kucheria@linaro.org>
 <93fa782bde9c66845993ff883532b3f1f02d99e4.1566907161.git.amit.kucheria@linaro.org>
 <20190829140459.szauzhennltrwvg4@holly.lan>
 <CAHLCerNuycWTLmCvdffM0=GdG7UZ7zNoj0Jb0CeLTULzVmfSJw@mail.gmail.com>
 <20190829151912.z6cflsaox2qnmqxw@holly.lan>
 <CAP245DWqbFnKVW9BYCzUMH=Ub+0j=3ycj-=MiPzRRW1Zv5LUmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP245DWqbFnKVW9BYCzUMH=Ub+0j=3ycj-=MiPzRRW1Zv5LUmw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 09:44:04PM +0530, Amit Kucheria wrote:
> On Thu, Aug 29, 2019 at 8:49 PM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Thu, Aug 29, 2019 at 07:58:45PM +0530, Amit Kucheria wrote:
> > > On Thu, Aug 29, 2019 at 7:35 PM Daniel Thompson
> > > <daniel.thompson@linaro.org> wrote:
> > > >
> > > > On Tue, Aug 27, 2019 at 05:43:59PM +0530, Amit Kucheria wrote:
> > > > > Printing the function name when enabling debugging makes logs easier to
> > > > > read.
> > > > >
> > > > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > > > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > > > > Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > >
> > > > This should need to be manually added at each call site; it is already
> > > > built into the logging system (the f flag for dynamic debug)?
> > >
> > > I assume you meant "shouldn't".
> >
> > Quite so. Sorry about that.
> >
> > > I haven't yet integrated dynamic debug into my daily workflow.
> > >
> > > Last time I looked at it, it was a bit bothersome to use because I
> > > needed to lookup exact line numbers to trigger useful information. And
> > > those line numbers constantly keep changing as I work on the driver,
> > > so it was a bit painful to script. Not to mention the syntax to frob
> > > the correct files in debugfs to enable this functionality.
> > >
> > > As opposed to this, adding the following to the makefile is so easy. :-)
> > >
> > > CFLAGS_tsens-common.o          := -DDEBUG
> > >
> > > Perhaps I am using it all wrong? How would I go about using dynamic
> > > debug instead of this patch?
> >
> > Throwing dyndbg="file <fname>.c +pf" onto the kernel command line is a
> > good start (+p enables debug level prints, +f causes messages to include
> > the function name).
> 
> That's useful to know.
> 
> $ git grep __func__ | wc -l
> 30914
> 
> Want to send some patches? :-)

I know. Sad isn't it?

To be fair plenty of patches already circulate tidying up this sort of
thing (along with the removal of inane messages such as informing us
that a function run).


> > When the C files map to module names (whether the modules are actually
> > built-in or not) then <module>.dyndbg=+pf is a bit cleaner and allows
> > you to debug the whole of a driver without how it is decomposed into
> > files.
> 
> And if changing the kernel cmdline options isn't possible or is inconvenient?

Architectures where this problem offer CONFIG_CMDLINE_FORCE meaning if
you are already building a custom kernel you can override whatever
cmdline the bootloader gives you.


> > There are (many) other controls to play with[1] but the above should be
> > sufficient to simulate -DDEBUG .
> 
> The "hard" bit is explicitly poking the line number in a file to
> activate a paricular pr_dbg statement. Even if I scripted it, those
> lines numbers keep changing in an actively developed driver.

Line numbers? Nothing I suggested contained a line number.


Daniel.

> 
> Somehow, I've always felt dyndbg was more useful to debug a production
> system where recompiling the kernel wasn't an option e.g. reporting an
> issue back to a distro-kernel vendor.
> 
> > Daniel.
> >
> > [1]
> > https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html
