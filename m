Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FE1C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4F4216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ul7zAO/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbfDYVT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:19:26 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34589 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730398AbfDYVTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:19:25 -0400
Received: by mail-vs1-f65.google.com with SMTP id n17so759285vsr.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 14:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L6tyEQ+xiDHf88n3rnhe8o/O9Df/iUTpDHnv4RhBmH4=;
        b=Ul7zAO/Vwni7xutDyyZ5lbLCOWGB7bw/bnHlaSel/PxIDAOocTpSAlOnou/C5f/sih
         ZrcrPJE/J4b9nKc/QRXM5vy7klWKdviwrb+0QGyfu+lampJx57GajH+6C677xYgi9Wo+
         TKG1NC3K1y1S4D+vFO7f9mOqoOrszGcDFPhto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L6tyEQ+xiDHf88n3rnhe8o/O9Df/iUTpDHnv4RhBmH4=;
        b=CdiCcz69d4/1NNYOh0lgE5U+zH+30yFEWPNAGzZKKtAZmwO7AYc0nTGNxeu/WglanN
         RCtXoSPioPB39CeeZ1Kd374MeNaFxUwjec3fgdGP/b9j6Ft/7CgFNaT/+JA9dbX0MhRq
         afv9VEMb6D/boZ8qH5WZDSyblGCBTybh4B7lFwlp5c0VNcBNyNJhI03YfbaJCmYmhAiU
         geEFX3htbzkjtCOBJyDsFxXW2dAP93C6TDWhqy72ssAKH+P5TJW4RZBy90FUefj5zNSn
         VCdcFBV/5Edgpr1LIgs2sohosKx3edtf0s2/R/q3TJ3kWJer2BcgGLx95ObDm83kkpaM
         hkvg==
X-Gm-Message-State: APjAAAW8pcGh8KL0ZHGxqfb0rueCLB/GzQCKZgJBgWOZPgitqSuY4Tn/
        3hAxRU+JmkpZxO4HC/P9bXfod+3lQ90=
X-Google-Smtp-Source: APXvYqxl1S59BmBY3wyITa2fiY2s6uvm2OTmjte/7yDhlgJHn80IWEFv4UZOfdkZCkoDk3wSKhELnA==
X-Received: by 2002:a67:7444:: with SMTP id p65mr21566997vsc.104.1556227163415;
        Thu, 25 Apr 2019 14:19:23 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id s16sm1363940vks.39.2019.04.25.14.19.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 14:19:22 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id g63so302918vke.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 14:19:22 -0700 (PDT)
X-Received: by 2002:a1f:2e07:: with SMTP id u7mr22557449vku.44.1556227161716;
 Thu, 25 Apr 2019 14:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190424231237.14776-1-keescook@chromium.org> <a3ca267e-8e1e-65da-77c8-c7010a39354b@kernel.org>
 <CAGXu5jJChvx-_E8RMTi3ioUZGuQGViy6gcAMpmvYZzms=zc6dQ@mail.gmail.com> <1afe0a17-c539-6ef2-ecff-f4ade4a865e7@kernel.org>
In-Reply-To: <1afe0a17-c539-6ef2-ecff-f4ade4a865e7@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 25 Apr 2019 14:19:09 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKe72A5sU3Fz85R4aUp0VupNjd=yzu92QnRAi-u0e0Ehw@mail.gmail.com>
Message-ID: <CAGXu5jKe72A5sU3Fz85R4aUp0VupNjd=yzu92QnRAi-u0e0Ehw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] selftests: Move test output to diagnostic lines
To:     shuah <shuah@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        Serge Hallyn <serge@hallyn.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 1:39 PM shuah <shuah@kernel.org> wrote:
> Pushed all 8 patches to
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
> ksft-tap-refactor topic branch
>
> I will have time to test tomorrow.

Awesome! I'm excited. :)

Next I want to update kselftest_harness.h to do header/plan printing...

-- 
Kees Cook
