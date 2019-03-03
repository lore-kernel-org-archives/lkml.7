Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D1DC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A8E20643
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551632649;
	bh=8AJHS4UMKpFflvwz+4BeOpgi2G3Gdp/pzVPWguHeoWE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q0ow3ZU4V9jhTpyDYI/o8Vdfr1uZipjWUrAoVRaHcXBSRr8RZY5pK2FP9liFGQZuw
	 z/e6sFtZHf6evqXiCy1M4nXK4WB9URghQ/wZFQreGWux7qqTI6moYGq0FiDyN/E8AE
	 UVBddUEduKVrXOJPEhOO7UPzVCHJTe4enUjdpfPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfCCREI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 12:04:08 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34110 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfCCREH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 12:04:07 -0500
Received: by mail-oi1-f193.google.com with SMTP id g16so2037424oib.1;
        Sun, 03 Mar 2019 09:04:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8AJHS4UMKpFflvwz+4BeOpgi2G3Gdp/pzVPWguHeoWE=;
        b=RNctCHLruNk+iYv/s/g5a8MvOShq47hrOcMipzSpo0f17gx2SSEnc+tQ7yVPx8cpZd
         wqSq1kNTnvg8G2HI0x24THa/Ph8hX2ilE6kN6NJvP9GL30k7yrqMePb+Hsn0A6SQc/+5
         57rMJZR+SCrrIITW7P5q14sPMuy3I/AbMMkZktO+sLwTzt4G1NChQitYPyZQfHkh5ODI
         boNMtiNhm7cxvkRtmQEbTEI8zJT97TwdY0Hz9xbjUf/O/z8T2bCwVh0F1parMk6oink+
         DIu/JdEVm+5mP7MPb5zpWPGx99oh1X271ZtrQtyiyQ6S3LwXQRxcLLxku6sl/te2hxeN
         5gOw==
X-Gm-Message-State: APjAAAWP2OI2H2nl8x18iTUPWYGFOtuTGgNXj+BYdOMMwtrakIn674p/
        /M7h6oqNHq9VActSA2N6v30L0HroZC8jFv4tccA=
X-Google-Smtp-Source: AHgI3IYQE/2ewjgwk93Zc2OzyszoAZTq4F0d/5H2a3oeSoahktqUyJrRMeHXmPxocdRA3V35gjjmHy/wUqA8jH+KS/w=
X-Received: by 2002:aca:f4d3:: with SMTP id s202mr9526663oih.178.1551632646648;
 Sun, 03 Mar 2019 09:04:06 -0800 (PST)
MIME-Version: 1.0
References: <9956076.F4luUDm1Dq@aspire.rjw.lan> <fa5e3e09eb32f5197bef2a50ced952850bf70748.camel@linux.intel.com>
In-Reply-To: <fa5e3e09eb32f5197bef2a50ced952850bf70748.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 3 Mar 2019 18:03:52 +0100
Message-ID: <CAJZ5v0ik6oHCXD23tURsRXRj1-C-Z=S6y+KEiRxe0zJpGrKa+Q@mail.gmail.com>
Subject: Re: [RFT][PATCH 0/2] cpufreq: intel_pstate: Handle _PPC updates on
 global turbo disable/enable
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 6:39 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Fri, 2019-03-01 at 13:43 +0100, Rafael J. Wysocki wrote:
> > Hi All,
> >
> > This is how I would fix the issue reported in BZ 200759 (see this
> > patch series
> > from Yu too: https://marc.info/?l=linux-pm&m=155137672924029&w=2).
> >
> > Patch [1/2] causes intel_pstate to update all policies if it gets a
> > _PPC change
> > notification and sees a global turbo disable/enable change.
> >
> > Patch [2/2] makes it update cpuinfo.max_freq for all policies in
> > those cases.
> >
> > The patches here have not been tested yet, so testing would be much
> > appreciated.
> >
> > Of course, comments are welcome too!
>
> This is the only platform, someone reported such issue.

I don't think this matters.

First, it doesn't mean that no other problems have this problem.

Second, the current handling of MSR_IA32_MISC_ENABLE_TURBO_DISABLE
changes in intel_pstate is not sufficient if the changes is from set
to unset anyway.
