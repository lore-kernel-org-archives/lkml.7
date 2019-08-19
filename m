Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4106C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 08:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96FFE2086C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 08:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566204740;
	bh=V3bEpzcr7rQ7sD1OkmeZDEOWlY2EL+WSGgjtsPF1OzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rcKPXCyT9vUevM+20Os1D3307lqpwdg+npcUejCN4KCDs0CO8pxc/D/Mw7pJjwbRg
	 C4MgQpKbioO5Isl/WVkML1Zb3lL30T5yPSS4UBrdOXASmy9SHieuIaEaabQ+1Yk6ru
	 YpPODCVBOy38j2eFjHPFrb7uwJDQHgZR8Qfcpiq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfHSIwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 04:52:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38590 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfHSIwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 04:52:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so7828886wrr.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 01:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+nHglollrHVKC0eXjlkarsXrHrwDl041gN5SnKyze4Y=;
        b=k/hlP5YXwU52GHnUCxf91tDmbCPcdm9uUVeM2RO1FZYUCcgQes3kTO8SxHQZG2yuMf
         NjbmkMThlhCQLI3OgpYce/GYUKgNLTNpPyzzIWhBUWh5oNROBAWEh4rkntLlt5TB2UbJ
         qeavlHAZTg1wGZWjtmEME7kA+t5kJzEvJOGdP/VpIIizkQ108Z3FMBZmvo9S4QVLNKKI
         VoylYVBIgF2KiV6jMDlfndYZD8Z2VENpOE/MlZ7nNFyf2j24MQt4p6ypxGCbM/Rjc5y7
         H7scwDEtBhvn5IoPDeu8UC/pyTE2Cng0ry30gebU48JQko4wMne0rI7Tof/Moki06Epi
         3Wlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+nHglollrHVKC0eXjlkarsXrHrwDl041gN5SnKyze4Y=;
        b=M/CSj7gHYZD52BhDvmJtoCY2QY5V/8FFaBZlWHLysQKQ9Iltil5mFQIDWS/Jf3jsYh
         T1vaIy/iK0MAfWPn2erVGXzHs3iIgxrQrvgY3MMNeW6AMLYQ4TaqlCKAftN6GbclKlmo
         87qgrCR7Hj0BccstKV4yd5I5rfnwCuyxH7aHqNjePe9xvdzn9pbyT+A7K8wIkx3N7RZ3
         evWp+hlNbVc1mt6GHSeaq9St+/kp2LzZxqQT+bBGkv4UuPpKTIBvk+Cw5FFklHK0pvHT
         ZgI7lTKSZhWFmKb2ciO2QHLxwWYG3H/PtSlJ0okACh/9BGELwNRfW9S5QcOVz7p1e9Cy
         IcGg==
X-Gm-Message-State: APjAAAULiAiumF0gloIo0JejTyCpZHctCI02ReSwurJD+DJTlSH5YpKz
        v3kEtWeZhZz/8V0uV3I0tgc=
X-Google-Smtp-Source: APXvYqzT7IcNAGY4m0i/2CEPnPKvcP/MoLWWJi9bRwhmTzOSoD0UNhDYg5BXXNazPL6VSCdw6PF+mA==
X-Received: by 2002:adf:dd88:: with SMTP id x8mr27392644wrl.331.1566204736816;
        Mon, 19 Aug 2019 01:52:16 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id t19sm12144418wmi.29.2019.08.19.01.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 01:52:16 -0700 (PDT)
Date:   Mon, 19 Aug 2019 10:52:13 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>, kan.liang@intel.com,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/9] sched/core: add is_kthread() helper
Message-ID: <20190819085213.GA15409@gmail.com>
References: <20190814104131.20190-1-mark.rutland@arm.com>
 <20190814104131.20190-2-mark.rutland@arm.com>
 <CAMuHMdV_hZ-uMmKdqEutLL5+XkhhcKdSaurMUS2N46AhZwDNKQ@mail.gmail.com>
 <20190814113232.GE17931@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814113232.GE17931@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark Rutland <mark.rutland@arm.com> wrote:

> On Wed, Aug 14, 2019 at 01:26:43PM +0200, Geert Uytterhoeven wrote:
> > Hi Mark,
> > 
> > On Wed, Aug 14, 2019 at 12:43 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > > Code checking whether a task is a kthread isn't very consistent. Some
> > > code correctly tests task->flags & PF_THREAD, while other code checks
> > > task->mm (which can be true for a kthread which calls use_mm()).
> > >
> > > So that we can clean this up and keep the code easy to follow, let's add
> > > an obvious helper function to test whether a task is a kthread.
> > > Subsequent patches will use this as part of cleaning up and correcting
> > > open-coded tests.
> > >
> > > At the same time, let's fix up the kerneldoc for is_idle_task() for
> > > consistency with the new helper, using true/false rather than 0/1, given
> > > the functions return bool.
> > >
> > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > 
> > Thanks for your patch!
> > 
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -1621,13 +1621,24 @@ extern struct task_struct *idle_task(int cpu);
> > >   * is_idle_task - is the specified task an idle task?
> > >   * @p: the task in question.
> > >   *
> > > - * Return: 1 if @p is an idle task. 0 otherwise.
> > > + * Return: true if @p is an idle task, false otherwise.
> > >   */
> > >  static inline bool is_idle_task(const struct task_struct *p)
> > >  {
> > >         return !!(p->flags & PF_IDLE);
> > >  }
> > >
> > > +/**
> > > + * is_kthread - is the specified task a kthread
> > > + * @p: the task in question.
> > > + *
> > > + * Return: true if @p is a kthread, false otherwise.
> > > + */
> > > +static inline bool is_kthread(const struct task_struct *p)
> > > +{
> > > +       return !!(p->flags & PF_KTHREAD);
> > 
> > The !! is not really needed.
> > Probably you followed is_idle_task() above (where it's also not needed).
> 
> Indeed! I'm aware of the implicit bool conversion, but kept that for
> consistency.
> 
> Peter, Ingo, do you have a preference?

So the !! pattern is useful where the return value is an integer (i.e. 
there's a risk of non-bool use) - but the return value is an explicit 
bool here, so !! is IMO an entirely superfluous obfuscation.

Should probably be fixed for is_idle_task() as well?

Thanks,

	Ingo
