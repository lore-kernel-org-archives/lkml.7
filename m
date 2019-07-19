Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF73C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446092184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKJdENoz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfGSLs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 07:48:59 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33576 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbfGSLs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 07:48:56 -0400
Received: by mail-lf1-f68.google.com with SMTP id x3so21622082lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 04:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iticw4tcihZ+07VhgZfVUmt5G5vuNCB2orcBTVaQzy4=;
        b=YKJdENozcfSHfpIPcIFN0eEP24xcLJYRBr/2HswHgNsQlSymIPeXI5Z915L1C+CfvC
         paovF7vRic2NHO7c0B0UxbxOpyMnt8ZU/VIoGUdvRT6AANFuKIxNpJ3qQ4dxeiBHnhBt
         9pK7UPxgzQyfc5e0UgbeEqK7B0whaRG7axOtSx8FVaOhqatQIbzX7iACeDa/49ovYDGA
         vpnJdPVWG6qqL+w2GIo/2FNWcMgD8NMFPdB3yMTalmYMxA0DnpP7X2OY/1Nz4yiJLNHv
         j9//ZC78nlVdmiC1pWjEGRsXv02AxckZZ6Mf+tHEjrv6RXgpxgriG23Y6udyUS43OjQF
         VUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iticw4tcihZ+07VhgZfVUmt5G5vuNCB2orcBTVaQzy4=;
        b=AIkQzYZJSp55oB/R0Pe9omWH21iEQmwPzw9y6Q+ycvww4zTYo8VD7iJ+HvzIBHJ/bO
         BNYJWdZGqdE9m9BC3fMudB5EQ0bfErskWW+VNlJg+QRFK4JakOwWckdtvD+MJhb+jCvU
         cHeTA9HWqq3nDao/7lOuFfnCOvg3lYQ6gwTMfpiOGjoB2AIEAAEjGw21KdJ652TqQUln
         iw9yJ9Er+ovxm3QrBvVOZax1Oh8g+kIU4T27nEtk/hs8Gp5vgGZ6ID3d7/gzEegHzDWp
         cckfJFwrJ5fkOQJFY79JTB2xaLY6V7Bj4sEbaNOdddh/xvFYN+8DYi1o3M9JdooCOLsQ
         gi9g==
X-Gm-Message-State: APjAAAXiV0Dn2lOc2NmYYafETax8/aeO07cWlVXPvV60nVphcSAUG5OS
        HuIqyrwyM/5XRgWzcDNnt3WZ/8dRh1UN/TV97NU=
X-Google-Smtp-Source: APXvYqymGrgw/089/6XHyfPjYaYN56y+q7KROCrfg2jRO2RI0Apr6JtYx/vQK86SnBbeDOEPn8jWWJ5v7DUPCuznrHM=
X-Received: by 2002:a05:6512:146:: with SMTP id m6mr23731306lfo.90.1563536934097;
 Fri, 19 Jul 2019 04:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <e8872bd9-1c6b-fb12-b535-3d37740a0306@linux.alibaba.com>
 <20190531210816.GA24027@sinkpad> <20190606152637.GA5703@sinkpad>
 <20190612163345.GB26997@sinkpad> <635c01b0-d8f3-561b-5396-10c75ed03712@oracle.com>
 <20190613032246.GA17752@sinkpad> <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
 <20190619183302.GA6775@sinkpad> <20190718100714.GA469@aaronlu>
 <5f869512-3336-d9f0-6fff-e1150673a924@linux.intel.com> <20190719055238.GA536@aaronlu>
In-Reply-To: <20190719055238.GA536@aaronlu>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Fri, 19 Jul 2019 19:48:42 +0800
Message-ID: <CAERHkruB82OT7giLh+yCA8igqN8H=HE+RkK7_qbXNKJGCQRpqg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 1:53 PM Aaron Lu <aaron.lu@linux.alibaba.com> wrote:
>
> On Thu, Jul 18, 2019 at 04:27:19PM -0700, Tim Chen wrote:
> >
> >
> > On 7/18/19 3:07 AM, Aaron Lu wrote:
> > > On Wed, Jun 19, 2019 at 02:33:02PM -0400, Julien Desfossez wrote:
> >
> > >
> > > With the below patch on top of v3 that makes use of util_avg to decide
> > > which task win, I can do all 8 steps and the final scores of the 2
> > > workloads are: 1796191 and 2199586. The score number are not close,
> > > suggesting some unfairness, but I can finish the test now...
> >
> > Aaron,
> >
> > Do you still see high variance in terms of workload throughput that
> > was a problem with the previous version?
>
> Any suggestion how to measure this?
> It's not clear how Aubrey did his test, will need to take a look at
> sysbench.
>

Well, thanks to post this at the end of my vacation, ;)
I'll go back to the office next week and give a shot.
I actually have a new setup of co-locating AVX512 tasks with
sysbench MYSQL. Both throughput and latency was unacceptable
on the top of V3, Looking forward to seeing the difference of
patch.

Thanks,
-Aubrey
