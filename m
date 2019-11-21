Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF8CC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FCDC2068F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFDdbTaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfKUSGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:06:00 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36723 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUSGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 13:06:00 -0500
Received: by mail-pf1-f194.google.com with SMTP id b19so2102914pfd.3;
        Thu, 21 Nov 2019 10:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lCjuPZUgh1uY1Xjtj7SA9xchMMnUEKnUFOjicdUpYFc=;
        b=oFDdbTaMjmYu2Q3J52JspMdeDYx4f0r8dAH1XGHn3sAWM25xWgWHZXccr3L0Ve/g5M
         I0u8DR7GRKinnPygRJHqiSfrGi8MdJsLQ/uhNX5/x1Uq/Vx2+rgW9XfSTvuEqMQTvcYF
         UDWfXR2waQrHDoDhHu2yCOFyKdMuSERpvrz8Ur+lepq0C2/HaIuR3DoFWaGoISHoKfDx
         MfCf+YPXPbo0I3Kq0jAcT2dSi+Cw/4WgyszGPZZnFmNXCm/ERhG0qjy+OTgn0Q6b91rp
         /D3KJj0FMnLu3pXE1fUaXRhwsrCyE+YkbTG+CXnVbYvdDOoTpN90lo3X/aFAwj95hQSv
         ldWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lCjuPZUgh1uY1Xjtj7SA9xchMMnUEKnUFOjicdUpYFc=;
        b=khL8S3c2BhfXvARitwDvFVMhm8NvjJQ9JFzaEWwm3yL1USwB2s5YBvALXa7X6NLs8i
         u4EXzJBK42BSW2tMFcQAoLwdZyy2fFXBMbBfypNNcabiYOcVpkkXTZht+uD8oU5k9vpM
         ONhE7yPIKYTTxxnknnbJU0FvH9WSSt1u6P3mM49koukrETSPMeGVDmfNMPnHcFHXtkxF
         6MOxZL38h2GsbYB+H16c8/GwwX1gGN+NzUIhlgsY8POeSkJEc0MsgEpKjJBYU0AVzBwM
         VlrZrfoMqy87JWJ5xc77IG0MZFT/kfx1XokdiqVpn7uHSTjjT9WlXNjX27BRSEohQPVW
         Qtlg==
X-Gm-Message-State: APjAAAXnubpoN0bF7SvelGWsu2AefTd6Mten0LQkzOsOPPtTM2K30fIn
        WDQjqjM5HJ5CUYBP/v7ageI=
X-Google-Smtp-Source: APXvYqy0vWa3bkr0qlNGdLDMuWYOumjkNmdn6VqyV+6Lm18B9qVv9tYJ7x+mA3pQAXmcCOl5d14jLw==
X-Received: by 2002:aa7:980c:: with SMTP id e12mr12543194pfl.165.1574359558948;
        Thu, 21 Nov 2019 10:05:58 -0800 (PST)
Received: from gmail.com ([2620:0:1008:fd00:25a6:3140:768c:a64d])
        by smtp.gmail.com with ESMTPSA id x21sm4078891pfi.122.2019.11.21.10.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 10:05:57 -0800 (PST)
Date:   Thu, 21 Nov 2019 10:05:55 -0800
From:   Andrei Vagin <avagin@gmail.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCHv8 00/34] kernel: Introduce Time Namespace
Message-ID: <20191121180555.GA440967@gmail.com>
References: <20191112012724.250792-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20191112012724.250792-1-dima@arista.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

What is your plan on this series? We know you are probably busy with
the next merge window. We just want to check that this is still in your
TODO list.

On Tue, Nov 12, 2019 at 01:26:49AM +0000, Dmitry Safonov wrote:
> 
> v7..v8 Changes:
> * Fix compile-time errors:
>   - on architectures without the support of time namespaces.
>   - when CONFIG_POSIX_TIMERS isn't set.
> * Added checks in selftests for CONFIG_POSIX_TIMERS.
> * Inline do_hres and do_coarse.
>   (And added Tested-by Vincenzo - thanks!)
> * Make TIME_NS depends on GENERIC_VDSO_TIME_NS and set it per-arch.
> 
> [v1..v7 Changelogs is at the very bottom here]
> 
> Our performance measurements show that the price of VDSO's clock_gettime()
> in a child time namespace is about 8% with a hot CPU cache and about 90%

Here is a typo. The price of VDSO's clock_gettime() in a child time
namespace is about 12% with a cold CPU cache. The table with
measurements for a cold CPU cache contains correct data.

> with a cold CPU cache. There is no performance regression for host
> processes outside time namespace on those tests.
> 

....

> 
> Cold CPU cache (lesser tsc per cycle - the better):
> 
>            | before    | CONFIG_TIME_NS=n | host      | inside timens
> --------------------------------------------------------------
> tsc        | 476       | 480              | 487       | 531
> stdev(tsc) | 0.6       | 1.3              | 4.3       | 5.7
> diff (%)   | 100       | 100.9            | 102       | 112
> 
