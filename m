Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC56C76196
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FDA21841
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 10:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxurNJzi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389549AbfGRKsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 06:48:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38196 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfGRKsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 06:48:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id y15so12445800pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 03:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SbcPjhdF+suMzd88MPO5ixlbzpIc4xg94mrAvhp7oMk=;
        b=PxurNJzihZStpZ8MD1AgL1W5GUwtFgOfyNQ936cPVRzsgz8IDQ+ilf0+zRFzySs+V3
         CZleM4xrXHzUJjM0OYr0oScauBWpgF0rk3DoW4ZjM+jUFZA0928m1LcSPfJ0OUMGi1Vz
         IAivhKnauZwNorQ4/PmzYUxdgL3poQ/8SO7KK2AleKkui+2e3/rUvFAS2xqxInWDgNAW
         y6EOBTGjE6KOmWjfAv9JprhILG4oS3eQ3yfPeq/x2vIZX9tcTE9s5SwYPMdhHrS6E2Cz
         WTQK+I/SI1N+s9P+1cR8rjFc/DCLt3K412qeDhDxd24lNAe1LIQSwu5znuefmcQY799y
         H+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SbcPjhdF+suMzd88MPO5ixlbzpIc4xg94mrAvhp7oMk=;
        b=i2HH/nWtcDX4UTD8Xrn2R1R5UbXFTpSczAn+Ftf2VI1GZO9WFS+x4OAacC/qaQSzXD
         dRHXD5Fc6e6FhkxN2qskUKEXmLKPo1/t2xxuGIML3OD8I1wUKirYfinYQ5Zw3QXXqjXD
         //D6Xymo4ji+XoSlPie84XI5GUl+l+DDX8k1IGpAS6Y73Z+/7PidqiPOnixf71trt7n2
         piqQ0N0R6uAmt6DkK24wyTO2Cxx5s/BsUAnMgwxth0v3PqrkWbTZNHhVfM7RmOwlzGKG
         FSLyegkWmPRnJnvkOgXYEtuXIBkCKU7bTHPmaXPGIVGKApbtj9mwJ/qBMl55QN8v4+9N
         AoLQ==
X-Gm-Message-State: APjAAAWQRR5TvJl6PskU8IhQTDizyPF4hR0iMIgyHuCpMHc7JvU2CxqW
        g8ArxRFOOHTm+20za/ulteA=
X-Google-Smtp-Source: APXvYqzaL+l73O4+prWewfDY1emqVNhLNI7Sbzlu6cwpNvPO43ctXEdI2fYsLD/jZPXD4rmATzUNJA==
X-Received: by 2002:a63:cc14:: with SMTP id x20mr124136pgf.142.1563446880739;
        Thu, 18 Jul 2019 03:48:00 -0700 (PDT)
Received: from localhost ([39.7.59.92])
        by smtp.gmail.com with ESMTPSA id 85sm27942816pfv.130.2019.07.18.03.47.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 03:47:59 -0700 (PDT)
Date:   Thu, 18 Jul 2019 19:47:56 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Tesarik <ptesarik@suse.cz>,
        Konstantin Khlebnikov <koct9i@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] printk/panic/x86: Allow to access printk log buffer
 after crash_smp_send_stop()
Message-ID: <20190718104756.GA22851@jagdpanzerIV>
References: <20190716072805.22445-1-pmladek@suse.com>
 <20190716072805.22445-3-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716072805.22445-3-pmladek@suse.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (07/16/19 09:28), Petr Mladek wrote:
[..]
> +int printk_bust_lock_safe(bool kdump_smp_stop)
>  {
>  	if (!raw_spin_is_locked(&logbuf_lock))
>  		return 0;
>  
> -	if (num_online_cpus() == 1) {
> +	if (num_online_cpus() == 1 || kdump_smp_stop)  {
>  		debug_locks_off();
>  		raw_spin_lock_init(&logbuf_lock);
>  		return 0;

Let me test the waters. Criticize the following idea:

Can we, sort of, disconnect "supposed to be dead" CPUs from printk()
so then we can unconditionally re-init printk() from panic-CPU?

We have per-CPU printk_state; so panic-CPU can set, let's say,
DEAD_CPUS_TELL_NO_TALES bit on all CPUs but self, and vprintk_func()
will do nothing if DEAD_CPUS_TELL_NO_TALES bit set on particular
CPU. Foreign CPUs are not even supposed to be alive, and smp_send_stop()
waits for IPI acks from secondary CPUs long enough on average (need
to check that) so if one of the CPUs is misbehaving and doesn't want
to die (geez...) we will just "disconnect" it from printk() to minimize
possible logbuf/console drivers interventions and then proceed with
panic; assuming that misbehaving CPUs are actually up to something
sane. Sometimes, you know, in some cases, those CPUs are already dead:
either accidentally powered off, or went completely nuts and do nothing,
etc. etc. but we still can kdump() and console_flush_on_panic().

	-ss
