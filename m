Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB3CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB3F22CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cp/+56qd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbfH1Kch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:32:37 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:42743 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfH1Kce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:32:34 -0400
Received: by mail-ua1-f68.google.com with SMTP id n13so649040uap.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 03:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oF7a1jbNbbfi/DhdEHpIDQz29C1JdgCAJx5IOgrXi30=;
        b=cp/+56qdxFuDpbtqG8L1bmfC561P9jMlzO5urm8esQqmM2W3gBfNZdp+scUb/KB4iB
         qcXCcj0I8yeqS2BGaoF9CiIPWreZXVneX4W1Luzt07p5wChbYfShdsHS3Osr888EAF4O
         RScUdSCEqK46D6wtZMBAHaY4yiVC8aYfB6mGWVtzG3imiZbLNGysfDNsRb7tFf/GBT6V
         CwlWUrgju0whJHM+pQVqIXg8HYwHqJ6hv87myiJUck4Ad6jQ3fVS8ujj1t1NLvmLwkIt
         KelRcR3YS364Ab3ZM6Cn/7sCdOvHfmtXLeXE5SuqM4gDlsWlwoySuoE7niD/nBoacqZp
         nOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oF7a1jbNbbfi/DhdEHpIDQz29C1JdgCAJx5IOgrXi30=;
        b=i/TnwdrW1uu7tCkkW4oPPTjg6TTbxk28djmvZ1/Mn/f/bIzqUiaLrF0Ae8H9Ep2OfI
         xYh3m2HWgLV3ra2QrEnYN9KE5xbljlHreUG4ycYjfpGxCdnq43x5ziwLuXLa287wkznh
         2TUlZuOJBEx6o4yOUE++IpUPWCGvGC4lsGOdOI6MY/KgevnVIFw8jJyobbxgLmlXmRsf
         qgN2wn1Ace1zbySwICe0qMIdW0a75ZzSj+eOR5wyH2YFGjPDNR/Kf2+1BQRGyxY/wb2e
         NJLHIPcodif9YL4H8NFsNE3cgzgEC+5u5RkyNawG9txAoSg7EememRn4RfJpJKMeA4Ev
         3uuw==
X-Gm-Message-State: APjAAAWM6vIVOj9b3LlcJ3XVajP9zFmrH01HGIQMiByJx+Yl+qaERTBV
        bjw3vJuLq9ghNlabhopaR/kqE06MqDwicSajhjhzzQ==
X-Google-Smtp-Source: APXvYqxu8e7ouZlP59+4Xx/1uo07ZtNJgW3EppKd0LP9dwxPGjEFMRvCUHleqLWo7lXKmtIi0s8NylMLuJFV+YuvBNo=
X-Received: by 2002:ab0:6883:: with SMTP id t3mr1585466uar.104.1566988353183;
 Wed, 28 Aug 2019 03:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190827134337.GK13294@shell.armlinux.org.uk> <CAPDyKFp7e2OD_idam3-2sEd0wJU5OcP=H04G1OvHmAUo2Y-bYw@mail.gmail.com>
 <20190827143634.GL13294@shell.armlinux.org.uk> <20190827145216.GM13294@shell.armlinux.org.uk>
 <20190827150614.GN13294@shell.armlinux.org.uk>
In-Reply-To: <20190827150614.GN13294@shell.armlinux.org.uk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 28 Aug 2019 12:31:56 +0200
Message-ID: <CAPDyKFoJgT9kRnARcP+snZkqC7rrp3UCd=mA=n3GL_brr2SHBw@mail.gmail.com>
Subject: Re: Continuous SD IO causes hung task messages
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2019 at 17:06, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Tue, Aug 27, 2019 at 03:52:17PM +0100, Russell King - ARM Linux admin wrote:
> > On Tue, Aug 27, 2019 at 03:36:34PM +0100, Russell King - ARM Linux admin wrote:
> > > On Tue, Aug 27, 2019 at 03:55:23PM +0200, Ulf Hansson wrote:
> > > > On Tue, 27 Aug 2019 at 15:43, Russell King - ARM Linux admin
> > > > <linux@armlinux.org.uk> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > While dd'ing the contents of a SD card, I get hung task timeout
> > > > > messages as per below.  However, the dd is making progress.  Any
> > > > > ideas?
> > > > >
> > > > > Presumably, mmc_rescan doesn't get a look-in while IO is progressing
> > > > > for the card?
> > > >
> > > > Is it a regression?
> > > >
> > > > There not much of recent mmc core and mmc block changes, that I can
> > > > think of at this point.
> > >
> > > No idea - I just repaired the SD socket after the D2 line became
> > > disconnected, and decided to run that command as a test.
> > >
> > > > > ARM64 host, Macchiatobin, uSD card.
> > > >
> > > > What mmc host driver is it? mmci?
> > >
> > > sdhci-xenon.
> > >
> > > I'm just trying with one CPU online, then I'll try with two.  My
> > > suspicion is that there's a problem in the ARM64 arch code where
> > > unlocking a mutex doesn't get noticed on other CPUs.
> > >
> > > Hmm, I thought I'd try bringing another CPU online, but it seems
> > > like the ARM64 CPU hotplug code is broken:
> > >
> > > [ 3552.029689] CPU1: shutdown
> > > [ 3552.031099] psci: CPU1 killed.
> > > [ 3949.835212] CPU1: failed to come online
> > > [ 3949.837753] CPU1: failed in unknown state : 0x0
> > >
> > > which means I can only take CPUs down, I can't bring them back
> > > online without rebooting.
> >
> > Okay, running on a single CPU shows no problems.
> >
> > Running on four CPUs (as originally) shows that the kworker thread
> > _never_ gets scheduled, so the warning is not false.
> >
> > With three CPUs, same problem.
> >
> > root@arm-d06300000000:~# ps aux | grep ' D '
> > root        34  0.0  0.0      0     0 ?        D    15:38   0:00 [kworker/1:1+events_freezable]
> > root@arm-d06300000000:~# cat /proc/34/sched
> > kworker/1:1 (34, #threads: 1)
> > -------------------------------------------------------------------
> > se.exec_start                                :        318689.992440
> > se.vruntime                                  :         37750.882357
> > se.sum_exec_runtime                          :             9.421240
> > se.nr_migrations                             :                    0
> > nr_switches                                  :                 1174
> > nr_voluntary_switches                        :                 1171
> > nr_involuntary_switches                      :                    3
> > se.load.weight                               :              1048576
> > se.runnable_weight                           :              1048576
> > se.avg.load_sum                              :                    6
> > se.avg.runnable_load_sum                     :                    6
> > se.avg.util_sum                              :                 5170
> > se.avg.load_avg                              :                    0
> > se.avg.runnable_load_avg                     :                    0
> > se.avg.util_avg                              :                    0
> > se.avg.last_update_time                      :         318689991680
> > se.avg.util_est.ewma                         :                   10
> > se.avg.util_est.enqueued                     :                    0
> > policy                                       :                    0
> > prio                                         :                  120
> > clock-delta                                  :                    0
> >
> > The only thing that changes there is "clock-delta".  When I kill the
> > dd, I get:
> >
> > root@arm-d06300000000:~# cat /proc/34/sched
> > kworker/1:1 (34, #threads: 1)
> > -------------------------------------------------------------------
> > se.exec_start                                :        574025.791680
> > se.vruntime                                  :         79996.657300
> > se.sum_exec_runtime                          :            10.916400
> > se.nr_migrations                             :                    0
> > nr_switches                                  :                 1403
> > nr_voluntary_switches                        :                 1400
> > nr_involuntary_switches                      :                    3
> > se.load.weight                               :              1048576
> > se.runnable_weight                           :              1048576
> > se.avg.load_sum                              :                   15
> > se.avg.runnable_load_sum                     :                   15
> > se.avg.util_sum                              :                15007
> > se.avg.load_avg                              :                    0
> > se.avg.runnable_load_avg                     :                    0
> > se.avg.util_avg                              :                    0
> > se.avg.last_update_time                      :         574025791488
> > se.avg.util_est.ewma                         :                   10
> > se.avg.util_est.enqueued                     :                    0
> > policy                                       :                    0
> > prio                                         :                  120
> > clock-delta                                  :                   40
> >
> > so the thread makes forward progress.
> >
> > Down to two CPUs:
> >
> > root@arm-d06300000000:~# ps aux | grep ' D '
> > root        34  0.0  0.0      0     0 ?        D    15:38   0:00 [kworker/1:1+events_freezable]
> >
> > Same symptoms.  dd and md5sum switch between CPU 0 and CPU1.
>
> Hmm.
>
> static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>                                     const struct blk_mq_queue_data *bd)
>
>         mq->in_flight[issue_type] += 1;
>         get_card = (mmc_tot_in_flight(mq) == 1);
>
>         if (get_card)
>                 mmc_get_card(card, &mq->ctx);
>
> mmc_get_card() gets the host lock according to the card.
>
> So, if we always have requests in flight (which is probably the case
> here) we never drop the host lock, and mmc_rescan() never gets a look
> in - hence blocking the kworker.

Ahh, you are right. However, this isn't a new problem I believe.

Even if we did some re-work of the locking mechanism while converting
to blk-mq, I still think the worker could starve the mmc_rescan work
before.

In practice this shouldn't be a problem though, unless I am
overlooking something. This is because it's not until there is an I/O
error, that causes the block worker to release the host, to it makes
sense to let mmc_rescan to claim the host to check for card removal.

>
> So this is a real issue with MMC, and not down to something in the
> arch.

Yep, thanks for running the test and providing more details!

>
> I suspect the reason that single-CPU doesn't show it is because it is
> unable to keep multiple requests in flight.

Yes, most likely.

Now, how to solve this problem I need to think more about....

FYI: The long term goal has been to try to remove the big fat host
lock altogether and slowly we have moved more an more things to be
executed as a part of the block worker, which is one of the needed
steps. Like the mmc ioctls for example...

Kind regards
Uffe
