Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027EAC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 01:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBAF21655
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 01:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDsGb1GP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfD3BZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 21:25:00 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:42487 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729626AbfD3BZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 21:25:00 -0400
Received: by mail-lj1-f177.google.com with SMTP id r72so6801438ljb.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 18:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=46L6eXe4RML6HEmnWiBfNC91mI6xVPDAh1z5zZsGazo=;
        b=SDsGb1GPwQgNgKpKbSygafBW/pgKbimw8lbnAy03Nzrf/TSYC0bYNNeoHhkuiPZS1N
         rt2bZziWH0toD71eYItMP3f7ILu0dtOU5fGBeN+FMnl1H8ZWzBuBlUvg80VX1w45LzM3
         XtOVVlC6yE2Y5iaO/iz9yU7Llk9j86CPB37VwtDIWSWLxaLCUEn++vCtkZ7jUKXwmD1x
         3q2oFIctOmuj/JFmGvI4H6kTZGz0FpSSTotvUWNdbBsAR2y42ZSnLzMWURdtQiWQGWd0
         o9XWpGHSryY3HPJRZtjE7V+q+WX6jd/Uh3k2EpIM3+cSHHy/Ka3TIYJbtphApMttUWZH
         Mlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=46L6eXe4RML6HEmnWiBfNC91mI6xVPDAh1z5zZsGazo=;
        b=jI9buyHFISfRHab4w0K/vi2671IqfmRW2yv+FFh6KMBrtYja8RXu6ii9oaq4i/XCaW
         98klA2qc389GN+9BXrUc132znnCbAp59eULr4x17YM50sjnKwsMHaee0RusbYl793aLx
         AAB1DXltP8ct6tz9erqqsDn2+txPPyTqDoA6dWwSm9DswaGFgQYV1xN88m0rhCt5eVNT
         SDq3ArgizYMOGdeRfwNgx9OCLlnMtvScNFmvrJ3Y8I4MAP7Vz8VDEgCb0cOuRDo4YNX4
         rj4iuSk7o+4HyAuN8eg5GlHfcDXE8U9GJMFYc0+spQYGiRieGg91rMNzFnx9qOfY9Z1L
         9gMQ==
X-Gm-Message-State: APjAAAXY/qhwJAZwRU43ZbI8PI9+FHFXpat3BGuSBU0cpF0F364oyQWW
        Rp6ESYZ4VS94gblLiKRiWybSJbRnor4eG/V6E+U=
X-Google-Smtp-Source: APXvYqxEY9DWbG+NdeFaYsH2OOxfIeR1r3pJOz1HV1CPpoBEutymY/YoRNUOBj1+zxp7VErTJnMYCIV5u6aRp3/utzs=
X-Received: by 2002:a2e:2b16:: with SMTP id q22mr34984426lje.20.1556587497889;
 Mon, 29 Apr 2019 18:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190427091716.GC99668@gmail.com> <CAERHkruEAVBsh6FphMKqgR2+HjsVVegxjnpOFRNfbrfZDNpc9w@mail.gmail.com>
 <20190427142137.GA72051@gmail.com> <CAERHkrtaU=Y-Lxypu_7uBbe-mJtG-3friz=ZLhV53X4FXHcEyA@mail.gmail.com>
 <20190428093304.GA7393@gmail.com> <CAERHkrvaSSR1wRECF1AcLOhpmCAH0ecvFEL5MOFjK05F0xSuzA@mail.gmail.com>
 <20190428121721.GA121434@gmail.com> <db7c3e51-d013-b3d9-7bce-c247aa2e7144@linux.intel.com>
 <20190429061422.GA20939@gmail.com> <24bca399-5370-c4b5-725f-979db06bfc29@linux.intel.com>
 <20190429153916.GB26806@pauld.bos.csb>
In-Reply-To: <20190429153916.GB26806@pauld.bos.csb>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Tue, 30 Apr 2019 09:24:46 +0800
Message-ID: <CAERHkrs31scmsmTW18bbCj8+NwS+jPg0=SFjFUPP2y0oJCod1w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
To:     Phil Auld <pauld@redhat.com>
Cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 11:39 PM Phil Auld <pauld@redhat.com> wrote:
>
> On Mon, Apr 29, 2019 at 09:25:35PM +0800 Li, Aubrey wrote:
> > .--------------------------------------------------------------------------------------------------------------------------------------.
> > |NA/AVX vanilla-SMT     [std% / sem%]     cpu% |coresched-SMT   [std% / sem%]     +/-     cpu% |  no-SMT [std% / sem%]   +/-      cpu% |
> > |--------------------------------------------------------------------------------------------------------------------------------------|
> > |  1/1        508.5     [ 0.2%/ 0.0%]     2.1% |        504.7   [ 1.1%/ 0.1%]    -0.8%    2.1% |   509.0 [ 0.2%/ 0.0%]   0.1%     4.3% |
> > |  2/2       1000.2     [ 1.4%/ 0.1%]     4.1% |       1004.1   [ 1.6%/ 0.2%]     0.4%    4.1% |   997.6 [ 1.2%/ 0.1%]  -0.3%     8.1% |
> > |  4/4       1912.1     [ 1.0%/ 0.1%]     7.9% |       1904.2   [ 1.1%/ 0.1%]    -0.4%    7.9% |  1914.9 [ 1.3%/ 0.1%]   0.1%    15.1% |
> > |  8/8       3753.5     [ 0.3%/ 0.0%]    14.9% |       3748.2   [ 0.3%/ 0.0%]    -0.1%   14.9% |  3751.3 [ 0.4%/ 0.0%]  -0.1%    30.5% |
> > | 16/16      7139.3     [ 2.4%/ 0.2%]    30.3% |       7137.9   [ 1.8%/ 0.2%]    -0.0%   30.3% |  7049.2 [ 2.4%/ 0.2%]  -1.3%    60.4% |
> > | 32/32     10899.0     [ 4.2%/ 0.4%]    60.3% |      10780.3   [ 4.4%/ 0.4%]    -1.1%   55.9% | 10339.2 [ 9.6%/ 0.9%]  -5.1%    97.7% |
> > | 64/64     15086.1     [11.5%/ 1.2%]    97.7% |      14262.0   [ 8.2%/ 0.8%]    -5.5%   82.0% | 11168.7 [22.2%/ 1.7%] -26.0%   100.0% |
> > |128/128    15371.9     [22.0%/ 2.2%]   100.0% |      14675.8   [14.4%/ 1.4%]    -4.5%   82.8% | 10963.9 [18.5%/ 1.4%] -28.7%   100.0% |
> > |256/256    15990.8     [22.0%/ 2.2%]   100.0% |      12227.9   [10.3%/ 1.0%]   -23.5%   73.2% | 10469.9 [19.6%/ 1.7%] -34.5%   100.0% |
> > '--------------------------------------------------------------------------------------------------------------------------------------'
> >
>
> That's really nice and clear.
>
> We start to see the penalty for the coresched at 32/32, leaving some cpus more idle than otherwise.
> But it's pretty good overall, for this benchmark at least.
>
> Is this with stock v2 or with any of the fixes posted after? I wonder how much the fixes for
> the race that violates the rule effects this, for example.
>

Yeah, this data is based on v2 without any fixes after.
I also tried some fixes potential to performance impact but no luck so far.
Please let me know if anything I missed.

Thanks,
-Aubrey
