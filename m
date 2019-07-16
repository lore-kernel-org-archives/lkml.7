Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF498C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 20:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12922173E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 20:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563310752;
	bh=GzbC4HaYjTrPOLHdkN0rJ9H0cVhGLXq4suuub3KQuYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DBLOQ1LRJAIX4tRB4KXDrS/JgKVodkN6SDeSI9ptLtyZ9MbOMNb0dOaDywi5FXjj0
	 fV7DZAE4sx98aZDynp/7YWswYHqPfyhqIOvyR3xoSWsXVu15dDJcKqW2GtfkH3mSUE
	 HUnaILncoxsfT8uqYIJpXkiMWl90FVt91/90avIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388820AbfGPU7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 16:59:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728781AbfGPU7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 16:59:11 -0400
Received: from localhost (lfbn-ncy-1-174-150.w83-194.abo.wanadoo.fr [83.194.254.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D551220665;
        Tue, 16 Jul 2019 20:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563310750;
        bh=GzbC4HaYjTrPOLHdkN0rJ9H0cVhGLXq4suuub3KQuYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ozXYFkp9k7i2LnsFB7XujdrrA0JWPsAE+Flg1q+9Cs+s5Hds/Dg2wWGpL64SrHBRX
         7yJkxDO9hcGrBB4kU+IeZdrEzzfkb2gvSPBgtbmXD7q31JZthmISbXWUYzz5H7LL9I
         1Hz+Z62JfFc2JicLtg6gJLmlT3/15/YoJ4Q3Z4QA=
Date:   Tue, 16 Jul 2019 22:59:07 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <clark.williams@gmail.com>,
        Julia Cartwright <julia@ni.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [patch 1/1] Kconfig: Introduce CONFIG_PREEMPT_RT
Message-ID: <20190716205907.GC4000@lenoir>
References: <20190715150402.798499167@linutronix.de>
 <20190715150601.205143057@linutronix.de>
 <20190716151040.04ef9122@torg>
 <e245e8ac-d55d-89c8-424a-432e0481cd2a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e245e8ac-d55d-89c8-424a-432e0481cd2a@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 10:18:00PM +0200, Daniel Bristot de Oliveira wrote:
> On 16/07/2019 22:10, Clark Williams wrote:
> > Excited to see this Thomas. Now I can start planning to build from a single tree
> > rather than an RT tree off to the side of RHEL :)
> > 
> > Acked-by: Clark Williams <williams@redhat.com>
> > 
> 
> yeah! We (Red Hat) are committed with maintaining and testing the PREEMPT RT
> mainstream in the long term. Including the development of more tests and formal
> verification for it!

AND MY AXE!!! (Suse)

Acked-by: Frederic Weisbecker <frederic@kernel.org>

> 
> Acked-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> 
> Thanks!
> -- Daniel
