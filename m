Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D08BC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 19:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633402184E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 19:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558724480;
	bh=4BntHzxNSZY+htbXWCCKtxCxy329Qt59rWAj3VNRm0Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MudHVdc7z3KoP69eoaYi+MyuA+1p7f4r4pd1Au1GoVNp28zK9YEU7p5LDXnrXLoEv
	 TmmoY0W7A+fQtOXlW9ii3vZxkuoC1s59n76FPjvOWGKRMlcVxkqCUNXe3WD5Phj93L
	 FD56Mlg7jRXSSWA8/ZJSSi27NAjmxVnwUACDYitI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391744AbfEXTBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 15:01:19 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46241 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391721AbfEXTBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 15:01:19 -0400
Received: by mail-lf1-f65.google.com with SMTP id l26so7873638lfh.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 12:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cDkQX8qCSoWrX115oSr9zofD1+0ruYH1fEhWifiyRxM=;
        b=Pk+BlSiLbwUQaLKDdH24vB4dVsRjVSrbj7yOZgruz/ePm98ckD4O+0a4bg/URK0efj
         sL3Su7ffvPsmQjPZl4kx+Og8oREJlzjsEZL5lXZmw6SoXb6hUNoICLS+udVYze0GkhhS
         zlLxiSH6dMBqDv3z3Z/XTfEXAmZ2Qp5vtV7UY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cDkQX8qCSoWrX115oSr9zofD1+0ruYH1fEhWifiyRxM=;
        b=aRYlFFoDg3esFIi4iHoygptlwTofFPM2exiMKm7ts+4ZcR3a0oMXCkiMpwP3c+qy9o
         R/WQzrRgNUfzF6BpUo3+dKrqQ3udraY36trQpguHMJN/4Fms+HO6YDhcr2FLMGYzQUT+
         DSBv97+sD0uUnOTFRX8GjJlBml9Zv19WGAV3L2/a4W+SFA36vZmbEFcMFbZrFk1RpXdJ
         TO2Bac49mnYCRPC5YN/k60auK+NFLO+SfQC8Zs+JuDkJMDKSmF7nau4V6VWkQQk9HbiM
         p+HfTuqdmLc64HJltHgpPcXMMLeM7IPpjRmcPEObgYbsDBUW0xRs0INTYSaW8xcB6XRW
         gRjA==
X-Gm-Message-State: APjAAAWrCm2+MGxFtGgVO2Gy9MZigvl1Guz5Fr1+Gd+9uqCQn5oKvV8T
        rS1NZiemV7wqMSvVYdgkjH4dK2u7+zE=
X-Google-Smtp-Source: APXvYqy3NEVxFkA+OGp7NEhG4wTSjvWgjlBm4pWgbvhfkKT+ZGzvcPet4iphSxQSOKCuVZmHyMs6kw==
X-Received: by 2002:a19:2149:: with SMTP id h70mr51505776lfh.77.1558724476709;
        Fri, 24 May 2019 12:01:16 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id c10sm745487lfh.79.2019.05.24.12.01.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 12:01:15 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id f1so7883786lfl.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 12:01:15 -0700 (PDT)
X-Received: by 2002:ac2:5337:: with SMTP id f23mr14782738lfh.52.1558724475245;
 Fri, 24 May 2019 12:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190524185343.4137-1-longman@redhat.com>
In-Reply-To: <20190524185343.4137-1-longman@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 May 2019 12:00:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgmB8BVrOZEqDysvC21MNmWcWXh1-DYzctsZYmZomkkog@mail.gmail.com>
Message-ID: <CAHk-=wgmB8BVrOZEqDysvC21MNmWcWXh1-DYzctsZYmZomkkog@mail.gmail.com>
Subject: Re: [PATCH v3] locking/lock_events: Use this_cpu_add() when necessary
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 11:54 AM Waiman Long <longman@redhat.com> wrote:
>
>  v2: Simplify the condition to just preempt or !preempt.
>  v3: Document the imprecise nature of the percpu count.

My point was that if they are imprecise., then you shouldn't use CONFIG_PREEMPT.

Because CONFIG_PREEMPT doesn't matter, and the count is imprecise with
it or without it.

So if they are imprecise, then what matters isn't whether the
operation is atomic or not, and the real issue is avout whether it
causes that "BUG: using __this_cpu_add() in preemptible" message.

IOW, you should use the config option that matters and is relevant,
namely CONFIG_DEBUG_PREEMPT.

                 Linus
