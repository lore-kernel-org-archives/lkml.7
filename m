Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCAEC606C7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF59217F9
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562613879;
	bh=nfuCbuGXKpK0NuYpq9EY7a/0AlwUFIIV3Vwh4oAVKY0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Jxl75rQTkxdig5xITEaipUuXoX+u00S+K2q/04YVjW2VWaI8gsUcuOvtF/64C4zcv
	 y+t+y3MjiR6+2PO85JrNQ+zyIAuMTa5Vb3s9n3D45FtkdC4TLTHBmc5/EBYGoBBMJF
	 /9HUyY8Ss5EoAtAMh/DvESCUc/0a+ZVAUyHxfeac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391656AbfGHTYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:24:38 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43718 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfGHTYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:24:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id 16so17060955ljv.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 12:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/YMFfKrvW6F5kcUFdwQ5Pz7KLZ0LRlO+3PUvO+U5Yf4=;
        b=P0EOQkfRfUTEkqGcIM1NlWskwhbGhI1oH5Xgxripnmv2ciZfyvhk5lBJr0FCIQQa8l
         cTH2Apkj6rw8JEw4xSGtiJGGl+7fbuZ0YCTP2VVJuI9sCVUUfsStJVCwbFSlLqumvv3y
         aEza6T8vMijG6BL/3etICYfAALdjbx7iGE7YM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/YMFfKrvW6F5kcUFdwQ5Pz7KLZ0LRlO+3PUvO+U5Yf4=;
        b=nX1v/FL+EiPNtDckT69JbImcdJVABKlhXHl+vI9DC3zLZQreebTC6lz+zPN1rJJMgH
         MHdvTajkOleE7d0dWajZERz9JoqOXG0V45hy/8AQ6ITZUSTQf0MytTXJdkELeZyP9zwr
         kedC5Tt4vz67Ir1xsaTq1cueXFrSty2MEW3ITPE3OLWkMlkvrBh/H7KCRvDsAunVpTO+
         lGVcR+9UbeSca4cuBhc7iMbMUMyv7DWBtTkEKMYIKPk9srNgXxL+UlQkQGBaxBedUskw
         wDSDexQoKerirZ2/IJu6IfcUBYxyxB48Ihz/k9OUFKvYYGqPzcxja6opCCG/NY5BnvOv
         rwOw==
X-Gm-Message-State: APjAAAUIT4aWY4gyRTSZjZKBj/cpjD5HkwTKuWWyus//ksWw4w9455Ho
        f9JBl2kOZA+G91p1yCXMgIjWvHdC2bA=
X-Google-Smtp-Source: APXvYqy3V+u0oyUUEtpXw12D4cgBMoV7j6ubf4GABTc3O6FuVMddAjtXry7otpHrSjaNFQhi4CrLwg==
X-Received: by 2002:a2e:50e:: with SMTP id 14mr11541254ljf.5.1562613875335;
        Mon, 08 Jul 2019 12:24:35 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id t63sm3820148lje.65.2019.07.08.12.24.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 12:24:34 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id u10so11689671lfm.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 12:24:34 -0700 (PDT)
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr9656408lfp.61.1562613874094;
 Mon, 08 Jul 2019 12:24:34 -0700 (PDT)
MIME-Version: 1.0
References: <156257673794.14831.1593297636367057887.tglx@nanos.tec.linutronix.de>
 <156257673796.14831.2572103765106531133.tglx@nanos.tec.linutronix.de>
In-Reply-To: <156257673796.14831.2572103765106531133.tglx@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 8 Jul 2019 12:24:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whhq5RQYNKzHOLqC+gzSjmcEGNJjbC=Psc_vQaCx4TCKg@mail.gmail.com>
Message-ID: <CAHk-=whhq5RQYNKzHOLqC+gzSjmcEGNJjbC=Psc_vQaCx4TCKg@mail.gmail.com>
Subject: Re: [GIT pull] x86/pti for 5.3-rc1
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 2:22 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> @@ -643,9 +644,11 @@ static unsigned long ptrace_get_debugreg(struct task_struct *tsk, int n)
>  {
>         struct thread_struct *thread = &tsk->thread;
>         unsigned long val = 0;
> +       int index = n;
>
>         if (n < HBP_NUM) {
> -               struct perf_event *bp = thread->ptrace_bps[n];
> +               index = array_index_nospec(index, HBP_NUM);
> +               struct perf_event *bp = thread->ptrace_bps[index];

This causes a new warning:

   warning: ISO C90 forbids mixed declarations and code

and I'm fixing it up in the merge as follows:

@@@ -633,9 -644,11 +634,10 @@@ static unsigned long ptrace_get_debugre
  {
        struct thread_struct *thread = &tsk->thread;
        unsigned long val = 0;
 -      int index = n;

        if (n < HBP_NUM) {
-               struct perf_event *bp = thread->ptrace_bps[n];
 -              index = array_index_nospec(index, HBP_NUM);
++              int index = array_index_nospec(n, HBP_NUM);
+               struct perf_event *bp = thread->ptrace_bps[index];

                if (bp)
                        val = bp->hw.info.address;

Holler if I did something stupid.

                Linus
