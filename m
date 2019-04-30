Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DB3C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 01:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321FE21655
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 01:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAjeYmvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbfD3Be0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 21:34:26 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39596 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbfD3BeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 21:34:25 -0400
Received: by mail-lf1-f68.google.com with SMTP id d12so9496748lfk.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 18:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Px2HDvlpr9ZJs28KIEGLc/qo2W8gInuIIUp/QPqQLO0=;
        b=MAjeYmvAsjsesDrTfwF1D1uaWMmvkfK6xjwZvcj0e70ZlUrcLacS0rVZejX0cAVT8I
         C8vLGWq0fzGlf6zkPvxOqkiyCJU+DEYOVScOtRMzXxtXGHZM35Z8m8jY1el08zgZb0BC
         la6Y9ukyQLZRMPwQLttmyDWejfJgmWH+KHXNWAYj9g7ZGEoqcE42svz1bfwlCba078ac
         f5s++PXFhtWjA7KPsRice6+9nVzsXT7BK7N5qSeToU3MTJoyku/PKFQRHwBZlZHJrapb
         7Dqb9U3l2Rpc/1+4O8ixTgiDPIHGU1MD3Jqao6X71CtY2TouZK2d/GXBWXki2tIhNLoK
         cCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Px2HDvlpr9ZJs28KIEGLc/qo2W8gInuIIUp/QPqQLO0=;
        b=B+9Y2JsR4eSVSTrKbLl1Csu7OsvzSaWoPYqntpUiidhSd/WWhx+9V5NTr9qoTfMIVN
         kWYFZnMVF17jwQjlgfuFSbCTqnIagOzg8T1tqu5+gYmJ7cODbBvDXsMbdj9OjQQkpvKf
         V/mIw/yYYjvGujAXInfXxIzghRHGekeOkWK/CdflFp978ykGZXIXZxfD191m4GHwKK+h
         L4gbVPV2kJP+3FMBIz3Oh4OaxvdpSRvDMicZOmCYh2UVPWqUKUaKZNkl/Ws9Sy6UIehX
         s8rqGdWISmZr2uK53gGINUcOSTmaVtVQVaPMActUC60JVoz3n8XRcG23AhKNzuOHfKpo
         62Cw==
X-Gm-Message-State: APjAAAVgXXYlaKwmQiWWnmOkBprZR1+5Au+bpfxXhi8/Rld8S38HDWhn
        7yLgR6S1QJ+owGKL9A2xMAJqQels/c4aJjWpTSs=
X-Google-Smtp-Source: APXvYqx7k9pMGidKchV/CLoBTzzFrA03TvtFpXl/GnvWUqvyLQoWqG2XLyvDHcFta8zLqp8KbUi0uOWWpIcMPLUlCjs=
X-Received: by 2002:a19:6a06:: with SMTP id u6mr35537795lfu.26.1556588063599;
 Mon, 29 Apr 2019 18:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190427091716.GC99668@gmail.com> <CAERHkruEAVBsh6FphMKqgR2+HjsVVegxjnpOFRNfbrfZDNpc9w@mail.gmail.com>
 <20190427142137.GA72051@gmail.com> <CAERHkrtaU=Y-Lxypu_7uBbe-mJtG-3friz=ZLhV53X4FXHcEyA@mail.gmail.com>
 <20190428093304.GA7393@gmail.com> <CAERHkrvaSSR1wRECF1AcLOhpmCAH0ecvFEL5MOFjK05F0xSuzA@mail.gmail.com>
 <20190428121721.GA121434@gmail.com> <db7c3e51-d013-b3d9-7bce-c247aa2e7144@linux.intel.com>
 <20190429061422.GA20939@gmail.com> <24bca399-5370-c4b5-725f-979db06bfc29@linux.intel.com>
 <20190429160058.GA82935@gmail.com>
In-Reply-To: <20190429160058.GA82935@gmail.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Tue, 30 Apr 2019 09:34:12 +0800
Message-ID: <CAERHkrvhggb8nkGOx1GHUftGhh5b0qLvq4HvuHJreNrRC1RXow@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
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
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 12:01 AM Ingo Molnar <mingo@kernel.org> wrote:
> * Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>
> > > I.e. showing the approximate CPU thread-load figure column would be
> > > very useful too, where '50%' shows half-loaded, '100%' fully-loaded,
> > > '200%' over-saturated, etc. - for each row?
> >
> > See below, hope this helps.
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
>
> Very nice, thank you!
>
> What's interesting is how in the over-saturated case (the last three
> rows: 128, 256 and 512 total threads) coresched-SMT leaves 20-30% CPU
> performance on the floor according to the load figures.

Yeah, I found the next focus.

>
> Is this true idle time (which shows up as 'id' during 'top'), or some
> load average artifact?
>

vmstat periodically reported intermediate CPU utilization in one second, it was
running simultaneously when the benchmarks run. The cpu% is computed by
the average of (100-idle) series.

Thanks,
-Aubrey
