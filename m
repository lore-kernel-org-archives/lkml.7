Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBB4C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3499120828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TUGwbzRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbfH0PGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 11:06:20 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40672 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfH0PGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 11:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Usqt65qKCjW/SaanMddOsovi4Ansin8CNvgKX8B3UgI=; b=TUGwbzRp9V7EITrN5S0x0Kr1h
        lrjEaPLBpRfSGGvIWY/DanU0uumSNFLQ+DZBNjadjBC5dtkaPpKQDbKx4tDmcEeY4tO7/XgX8Luky
        LNITSD5W7yPZZCwS583g4HvX7RUrqefOSQH0B0WjBPOW0iYfKPI837f61jkbWwdXsMrawP9ZAjWal
        TRJXoD3Ltc62QphcGOMJVGrdWHje9c6QY23nG48l9j8ahEypW29Q8Htops4bei1liVd1Vo6+NcUb/
        qeZKfRcnn65gAExGZc5LqSUDrOhycXc/UrX/yijndaq7BiSDye6rl3a5VMfIC1AznvFvnluy159O7
        IqCh+OMtA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38672)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1i2d32-00058Q-3K; Tue, 27 Aug 2019 16:06:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1i2d30-0005q3-Oj; Tue, 27 Aug 2019 16:06:14 +0100
Date:   Tue, 27 Aug 2019 16:06:14 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Continuous SD IO causes hung task messages
Message-ID: <20190827150614.GN13294@shell.armlinux.org.uk>
References: <20190827134337.GK13294@shell.armlinux.org.uk>
 <CAPDyKFp7e2OD_idam3-2sEd0wJU5OcP=H04G1OvHmAUo2Y-bYw@mail.gmail.com>
 <20190827143634.GL13294@shell.armlinux.org.uk>
 <20190827145216.GM13294@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827145216.GM13294@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 03:52:17PM +0100, Russell King - ARM Linux admin wrote:
> On Tue, Aug 27, 2019 at 03:36:34PM +0100, Russell King - ARM Linux admin wrote:
> > On Tue, Aug 27, 2019 at 03:55:23PM +0200, Ulf Hansson wrote:
> > > On Tue, 27 Aug 2019 at 15:43, Russell King - ARM Linux admin
> > > <linux@armlinux.org.uk> wrote:
> > > >
> > > > Hi,
> > > >
> > > > While dd'ing the contents of a SD card, I get hung task timeout
> > > > messages as per below.  However, the dd is making progress.  Any
> > > > ideas?
> > > >
> > > > Presumably, mmc_rescan doesn't get a look-in while IO is progressing
> > > > for the card?
> > > 
> > > Is it a regression?
> > > 
> > > There not much of recent mmc core and mmc block changes, that I can
> > > think of at this point.
> > 
> > No idea - I just repaired the SD socket after the D2 line became
> > disconnected, and decided to run that command as a test.
> > 
> > > > ARM64 host, Macchiatobin, uSD card.
> > > 
> > > What mmc host driver is it? mmci?
> > 
> > sdhci-xenon.
> > 
> > I'm just trying with one CPU online, then I'll try with two.  My
> > suspicion is that there's a problem in the ARM64 arch code where
> > unlocking a mutex doesn't get noticed on other CPUs.
> > 
> > Hmm, I thought I'd try bringing another CPU online, but it seems
> > like the ARM64 CPU hotplug code is broken:
> > 
> > [ 3552.029689] CPU1: shutdown
> > [ 3552.031099] psci: CPU1 killed.
> > [ 3949.835212] CPU1: failed to come online
> > [ 3949.837753] CPU1: failed in unknown state : 0x0
> > 
> > which means I can only take CPUs down, I can't bring them back
> > online without rebooting.
> 
> Okay, running on a single CPU shows no problems.
> 
> Running on four CPUs (as originally) shows that the kworker thread
> _never_ gets scheduled, so the warning is not false.
> 
> With three CPUs, same problem.
> 
> root@arm-d06300000000:~# ps aux | grep ' D '
> root        34  0.0  0.0      0     0 ?        D    15:38   0:00 [kworker/1:1+events_freezable]
> root@arm-d06300000000:~# cat /proc/34/sched
> kworker/1:1 (34, #threads: 1)
> -------------------------------------------------------------------
> se.exec_start                                :        318689.992440
> se.vruntime                                  :         37750.882357
> se.sum_exec_runtime                          :             9.421240
> se.nr_migrations                             :                    0
> nr_switches                                  :                 1174
> nr_voluntary_switches                        :                 1171
> nr_involuntary_switches                      :                    3
> se.load.weight                               :              1048576
> se.runnable_weight                           :              1048576
> se.avg.load_sum                              :                    6
> se.avg.runnable_load_sum                     :                    6
> se.avg.util_sum                              :                 5170
> se.avg.load_avg                              :                    0
> se.avg.runnable_load_avg                     :                    0
> se.avg.util_avg                              :                    0
> se.avg.last_update_time                      :         318689991680
> se.avg.util_est.ewma                         :                   10
> se.avg.util_est.enqueued                     :                    0
> policy                                       :                    0
> prio                                         :                  120
> clock-delta                                  :                    0
> 
> The only thing that changes there is "clock-delta".  When I kill the
> dd, I get:
> 
> root@arm-d06300000000:~# cat /proc/34/sched
> kworker/1:1 (34, #threads: 1)
> -------------------------------------------------------------------
> se.exec_start                                :        574025.791680
> se.vruntime                                  :         79996.657300
> se.sum_exec_runtime                          :            10.916400
> se.nr_migrations                             :                    0
> nr_switches                                  :                 1403
> nr_voluntary_switches                        :                 1400
> nr_involuntary_switches                      :                    3
> se.load.weight                               :              1048576
> se.runnable_weight                           :              1048576
> se.avg.load_sum                              :                   15
> se.avg.runnable_load_sum                     :                   15
> se.avg.util_sum                              :                15007
> se.avg.load_avg                              :                    0
> se.avg.runnable_load_avg                     :                    0
> se.avg.util_avg                              :                    0
> se.avg.last_update_time                      :         574025791488
> se.avg.util_est.ewma                         :                   10
> se.avg.util_est.enqueued                     :                    0
> policy                                       :                    0
> prio                                         :                  120
> clock-delta                                  :                   40
> 
> so the thread makes forward progress.
> 
> Down to two CPUs:
> 
> root@arm-d06300000000:~# ps aux | grep ' D '
> root        34  0.0  0.0      0     0 ?        D    15:38   0:00 [kworker/1:1+events_freezable]
> 
> Same symptoms.  dd and md5sum switch between CPU 0 and CPU1.

Hmm.

static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
                                    const struct blk_mq_queue_data *bd)

        mq->in_flight[issue_type] += 1;
	get_card = (mmc_tot_in_flight(mq) == 1);

        if (get_card)
	        mmc_get_card(card, &mq->ctx);

mmc_get_card() gets the host lock according to the card.

So, if we always have requests in flight (which is probably the case
here) we never drop the host lock, and mmc_rescan() never gets a look
in - hence blocking the kworker.

So this is a real issue with MMC, and not down to something in the
arch.

I suspect the reason that single-CPU doesn't show it is because it is
unable to keep multiple requests in flight.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
