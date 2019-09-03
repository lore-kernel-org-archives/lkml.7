Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9221EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E15E22CED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567542464;
	bh=Xo3JmxG1Xn+/3QMtyBlY/OrPIc3ddtJe0NaS40GlwsY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nL2jBlOFH6ntPvH92TZOjDEDvnRRul5PsYw1A+z8EkOhyl3IBex+huTiJtOSFk72j
	 9nyUaa+6sXXQKmYXMYpkdgSBtLvrc2E0Be2D9K/G/TRq82nLJUzWT3DWjKyADYx6Ir
	 NjgHRKJu0yvYJ713mbrmcG32x26X/XywXcUYT/eY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfICU1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:27:43 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35756 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfICU1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:27:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id l14so17405256lje.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 13:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NttQlTrgoQqeJsrwFCIQEzQDFFhogn465ZV/EkbS+7E=;
        b=LIrW6+s+UdxIvDPx++Jy0TZph0UYUw/kNm6sZL/xUdiBOdgDh0YOw7rU5moz8m/Gap
         JhY7huteA/txS9RL1A0skkkaaV7ZR8uX3k/eyXNVWiVZLNmNRW/lsKoBvj7dOhH0HFSR
         fXNNjDw48A/NMTNvYE0lKb7n9d4acztXdqt+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NttQlTrgoQqeJsrwFCIQEzQDFFhogn465ZV/EkbS+7E=;
        b=q7oomfp3IaqOqHDvaMMtJ6ngEeSrChai9nMgjA7ZIveT/MfIzHx3DKkhZY3OqCefT+
         yKSmzeknxy3aaKHcc1i6FzCazP0lUfK563kgHl8cCAaAvjDFZkcHN2X+S3SQV8ibcHN3
         NMjuOYQq3dd/LzAlKxh9sHZdZlrV9YHkRKEaswPLoWSZyaD5jxECtf49lNfX90LFyzEU
         o+RlXfhTEj2bshRP00WqSwwd6vAmc99Idh0vZU/hw8ILBSM1I6QRM4eMo19nxHv5Lq6Q
         pMImqhw1do85XeSaorrc7IMwSPz8PFsPMdFIA2Qae8PIOK/pYBaUIZMQ+nnegGBVZgLU
         bWHw==
X-Gm-Message-State: APjAAAUYa9AXbVcR/IKvohtcmJtwtKr23sPn5GqG0p842VTUdJMpfbqU
        OPsohbP3hlXB9kbw1k41ZzOGC3DsqyI=
X-Google-Smtp-Source: APXvYqwSF2e+hj9OZT45MDLewm5vFCXFjFLozQL7fiJ4MeJ/7baT+00BBZxF/sl2baqpXCcA8tcAoA==
X-Received: by 2002:a2e:96da:: with SMTP id d26mr11862911ljj.7.1567542460732;
        Tue, 03 Sep 2019 13:27:40 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id d28sm2325786lfq.88.2019.09.03.13.27.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2019 13:27:39 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id x18so17423416ljh.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 13:27:39 -0700 (PDT)
X-Received: by 2002:a2e:8507:: with SMTP id j7mr7221358lji.156.1567542459326;
 Tue, 03 Sep 2019 13:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190903201135.1494-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20190903201135.1494-1-mathieu.desnoyers@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Sep 2019 13:27:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg61zhuzhnrh_t=cAhgm+adNfsnS0A_cD=TOQAriHNDew@mail.gmail.com>
Message-ID: <CAHk-=wg61zhuzhnrh_t=cAhgm+adNfsnS0A_cD=TOQAriHNDew@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] Fix: sched/membarrier: p->mm->membarrier_state
 racy load
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 1:11 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> +       cpus_read_lock();
> +       for_each_online_cpu(cpu) {

This would likely be better off using mm_cpumask(mm) instead of all
online CPU's.

Plus doing the rcu_read_lock() inside the loop seems pointless. Even
with a lot of cores, it's not going to loop _that_ many times for RCU
latency to be an issue.

              Linus
