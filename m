Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2D4C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262A5218BE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YGw56eDe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388523AbfGWHqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 03:46:38 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45835 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730807AbfGWHqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 03:46:37 -0400
Received: by mail-io1-f65.google.com with SMTP id g20so79804565ioc.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 00:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BF1c8d41jsg6oXp3S/3NT2wDSVy305T/qra53xABPzg=;
        b=YGw56eDe098/wOw+xMSGrLdq0mYtDf01/Mu1NugbtN6kcsCxY0xgoR7+S/yHkBiaob
         nTh9CUYL1ratekF8t0QaEYPxMymSgkbZTHW6bP+WH57qdBWBuMimRIAxf8J3RuPf4Zzf
         F70iTVz7EnwJ0JohhZh8W2GcJL5Mc7ONRTt6dApWytTsMwdX0CxVKe+nzS06EYdl9XYy
         Fh9mXLn2aRERynRBvaF3fdg6brTUn1lNhlWrjYAcvxOR3R2ZY4DL1D8NLh7K3wNiJMEQ
         6HSkgDGC0seBNYMIm2vGJSXGDnMgUAuOoInV8ZTLoCdoEB9xi3BFBISaV2a8PYw9jrZx
         Rduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BF1c8d41jsg6oXp3S/3NT2wDSVy305T/qra53xABPzg=;
        b=AdpMQXFqKFzTeVGhfPZjNtaqRqOtw5k3+NvtW/NAd8uYR8tK/1AmZRuBJbjRi9/WQj
         7vzKdwo/WcVhn0aawgtqYWW5mF1i3Ski8FgYOOG9BhnEKsnH/Ibn9eKtvcI3hibAjtST
         j0y4AntpF+vFVPWdVHJcbDWjmaXcIfsrcugkDd9bUVm49ArXD41vWP8cH0N4PZXcAKbK
         PrSEcOAvP1afkIMb8gHtlx38qhSPOY6wIUNwz8N7J+ykxaSRMowin9Q9wEds/O4ucRVu
         EI0opLLWt16G8kbGW3/UW7tfouw1wta+xrjuyW4ezFjWGdGMFNVmiijjuwhqp6FoyvU6
         +sTw==
X-Gm-Message-State: APjAAAUL9M+BKggsqwMgbGoMa8rp5u3+2X1MZpOTCce+Hfjl4VDTJyat
        ps6cANBX+Wgcx8+sGRWL5OQSFv1GBMUOASQYdxciQA==
X-Google-Smtp-Source: APXvYqwRo2VqyjI06/c7XjDdrM0HTAr8VaXoKKIMCZu49KVV2OV7WBJZvo86mnsoGFh9tbGAVqktHOLla+omBoqHRCw=
X-Received: by 2002:a05:6638:81:: with SMTP id v1mr28465649jao.72.1563867996401;
 Tue, 23 Jul 2019 00:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190723072605.103456-1-drinkcat@chromium.org>
In-Reply-To: <20190723072605.103456-1-drinkcat@chromium.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 23 Jul 2019 09:46:25 +0200
Message-ID: <CACT4Y+bi5KkZ8igSeYVxjwtr8t0Vjz55gzWfAu_c8VMAqw0zPA@mail.gmail.com>
Subject: Re: [PATCH] kmemleak: Increase maximum early log entries to 1000000
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 9:26 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> When KASan is enabled, a lot of memory is allocated early on,
> and kmemleak complains (this is on a 4GB RAM system):
> kmemleak: Early log buffer exceeded (129846), please increase
>   DEBUG_KMEMLEAK_EARLY_LOG_SIZE
>
> Let's increase the upper limit to 1M entry. That would take up
> 160MB of RAM at init (each early_log entry is 160 bytes), but
> the memory would later be freed (early_log is __initdata).

Interesting. Is it on an arm64 system? On syzbot we use 16000 and it's
enough for a very beefy config:

https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-leak.config

If it's freed later, I would increase the default as well. 400 never
worked for me and I've seen people being confused and wasn't able to
use kmemleak, e.g.:

https://groups.google.com/forum/#!searchin/syzkaller/CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE|sort:date/syzkaller/Rzf2ZRC9Qxw/tLog4DHXAgAJ

https://groups.google.com/forum/#!searchin/syzkaller/CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE|sort:date/syzkaller/5HxmTuQ7U4A/XM8s2o2CCAAJ



> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
>  lib/Kconfig.debug | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index f567875b87657de..1a197b8125768b9 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -595,7 +595,7 @@ config DEBUG_KMEMLEAK
>  config DEBUG_KMEMLEAK_EARLY_LOG_SIZE
>         int "Maximum kmemleak early log entries"
>         depends on DEBUG_KMEMLEAK
> -       range 200 40000
> +       range 200 1000000
>         default 400
>         help
>           Kmemleak must track all the memory allocations to avoid
> --
> 2.22.0.657.g960e92d24f-goog
>
