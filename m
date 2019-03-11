Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400EAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB6A206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552295348;
	bh=qPJmZY1vnYEvVKahx2PP8hRcrnJnDjhr/LAOlB5UScs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j7ZWtOT7qev/ItGHuYEEzQs9vAQZ7ZZIE58FoGm0VBSFzPUO4K/h39Q6VlA9qZHCn
	 TUnENDTRs9RQKcwF/+bmAZVZ/7v2gUPkh/0yLAb+UYxZW5LTAP/XvwyIIJOfGPQWee
	 hufbx+HEIejAodukbvRpqAEBDmS7pmhiKiW298RY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfCKJJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:09:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33078 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfCKJJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:09:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id i8so4164378wrm.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 02:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NNZVPb2K3M8mrikZFB4dPK1dxCzfHjeONxF73GfQ7G8=;
        b=SX0bpm2SbYUWTjEeaZiwgVrWLEN767k5DbtPsvUlzoW14bOT1Dx+R2qj486/X428Qs
         NEXt40n36hvD4fMvj3HGyQOiXixq3clnEH4J3uU7e7lJR++KoerIGTbtZsnhpie7SRvV
         OYuTrdN0GNENvtw7+jE/tM6khxQCSE0Vqx8bbHwla9p97PKDW7mm9Ycc8dJ8syH2sWPV
         aKCK4yVWVMO87V/f5QXVzFt6U7KD4M/H1cIBuBQwKTk6aFIYlqw7L1Pocp6eS/jrqiDk
         xwQbh39aIgH5X8cQz8G01dXhYY6JblUq1SaWfnyI+lfoxnbauUii/vdoFH3xyKkQFWoB
         UAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=NNZVPb2K3M8mrikZFB4dPK1dxCzfHjeONxF73GfQ7G8=;
        b=klmRo2OQjjeV4tdtOGw82UHooEY8t3GE2sjgjP8ldM8xYuVMBoLBUxHKMJuGWX5IYn
         pvCxIz3jFewsQEQpBU5HdlE4a9rGAgEnqgKNgyL+xRi7eX+xNcU8LuCGboPJ3Y8oukfo
         U9LTxjCEmKML7iFnKwvBjyHOc+sbauZydsEYoeQtRmj8f6JXy5QaSWtBlrVVKVVDaTF9
         PM4nEiIoMdY41GfTjBTjd6syvhEWHD87tHJr4Oo6YEKNXn2ykmqXntnkoBLzVoLjD9SR
         ojgs81356nJaLFIMphDQlfXInn8Ymb6eBKeDxP0jBeRev9nKoE6ZWReelBYvccrKp4xV
         t/dg==
X-Gm-Message-State: APjAAAWH/7/a6aecJU8ieDYO/Vscne/tDROo9DtD4xmMqRCvi9vw4FvX
        t5SfNyTaSHw2lqJy3PhSqzI=
X-Google-Smtp-Source: APXvYqw4OuHlHBbK46vqlR+9ca0Dvw7ikEm/l6CySYgPJ3wd+t3yRIW3Uc1zKAkQlhWilxVq4KZXkA==
X-Received: by 2002:adf:ba12:: with SMTP id o18mr20652199wrg.326.1552295343954;
        Mon, 11 Mar 2019 02:09:03 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id o12sm19431745wre.0.2019.03.11.02.09.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 02:09:03 -0700 (PDT)
Date:   Mon, 11 Mar 2019 10:09:01 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] scheduler updates for 5.1
Message-ID: <20190311090901.GA22570@gmail.com>
References: <155221755096.13878.3370977359110476046.tglx@nanos.tec.linutronix.de>
 <155221755097.13878.2888459223557668046.tglx@nanos.tec.linutronix.de>
 <CAHk-=wi_krg9B2B0i7+mV4rRCdowiNw3bOC9rssaZTVFQvKMxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wi_krg9B2B0i7+mV4rRCdowiNw3bOC9rssaZTVFQvKMxQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, Mar 10, 2019 at 4:33 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > A small set of fixes for the scheduler:
> 
> What? No.
> 
> This is completely broken, and even warns loudly about it.
> 
>   kernel/sched/cpufreq_schedutil.c: In function ‘sugov_iowait_boost’:
>   ./include/linux/kernel.h:827:29: warning: comparison of distinct
> pointer types lacks a cast
>   kernel/sched/cpufreq_schedutil.c:346:26: note: in expansion of macro ‘min’
>      sg_cpu->iowait_boost = min(sg_cpu->iowait_boost << 1,
> SCHED_CAPACITY_SCALE);
>                             ^~~
> 
> because 'SCHED_CAPACITY_SCALE' is of type 'long' and 'iowait_boost' is
> 'unsigned int'.
> 
> Why are you sending me code that hasn't even been compiled, and call it a "fix"?

Sorry about that - we'll sort this out!

Thanks,

	Ingo
