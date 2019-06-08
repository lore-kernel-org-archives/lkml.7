Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDE5C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 22:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0486A212F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 22:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560034385;
	bh=Gz6g0yeY0RG4LkDvFBuz5QqQPaWoRLrR4xGwFT2W134=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QdHYgAWK10K7VSU7lpkHxRnQRxkTMHi8KLLirHRAoTqnUG8QUKs9vQNH76pbWz93e
	 KFXlN2O6XZvxcCRH/TiDiJdPdltirkFZwOPwOyoOFnEk8KCHtp1wG56bcsIx6Lld/c
	 tTiYzjFy6yuQhufDqiU67ia7e4uEowExJ2OoUe/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfFHWxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 18:53:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727981AbfFHWw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 18:52:56 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE69A212F5
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2019 22:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560034375;
        bh=Gz6g0yeY0RG4LkDvFBuz5QqQPaWoRLrR4xGwFT2W134=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=udq1sM/xAIYKlkgcF+5cFTrRws4MQApRJUyDzMeNBqe7HmavppG+Z/bKoEDvFL4Ma
         pBfzlwuiqQP7hD+7TT+5bePc3HOsvQzmvrDI/QXw0r16PHmHMoXlZAyNnXzEqBSAmS
         kd7sb5dLGRc96l0t7Y9F8yN8X66rACHYO/9GDOWI=
Received: by mail-wr1-f54.google.com with SMTP id v14so5546664wrr.4
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 15:52:55 -0700 (PDT)
X-Gm-Message-State: APjAAAXXD/TBlPi2uego8DBuC2ZQbYBQbUUOPfCZu+T7DI0wqNCMoxc3
        iOzUpsw3rIDYYh5gkdWIpZX0kyMKwh7oUYthdUrwxw==
X-Google-Smtp-Source: APXvYqxYxweXIdj0iLu8Jc7KBY3I15SNXOKWVmiy3sinwstilddxLWYvFZBIUT+OQZ4qV3IljypcovYABphZI4XlefA=
X-Received: by 2002:a5d:6207:: with SMTP id y7mr19841894wru.265.1560034374329;
 Sat, 08 Jun 2019 15:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com> <1559944837-149589-3-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1559944837-149589-3-git-send-email-fenghua.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 8 Jun 2019 15:52:42 -0700
X-Gmail-Original-Message-ID: <CALCETrWtmrwqjThkMKU9YpTDK4o95V4HBb2_yQF2tvx5JZ9Ukw@mail.gmail.com>
Message-ID: <CALCETrWtmrwqjThkMKU9YpTDK4o95V4HBb2_yQF2tvx5JZ9Ukw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] x86/umwait: Initialize umwait control values
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 3:10 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
>
> umwait or tpause allows processor to enter a light-weight
> power/performance optimized state (C0.1 state) or an improved
> power/performance optimized state (C0.2 state) for a period
> specified by the instruction or until the system time limit or until
> a store to the monitored address range in umwait.
>
> IA32_UMWAIT_CONTROL MSR register allows kernel to enable/disable C0.2
> on the processor and set maximum time the processor can reside in
> C0.1 or C0.2.
>
> By default C0.2 is enabled so the user wait instructions can enter the
> C0.2 state to save more power with slower wakeup time.

Sounds good, but:

> +#define MSR_IA32_UMWAIT_CONTROL_C02            BIT(0)

> +static u32 umwait_control_cached = 100000;

The code seems to disagree.
