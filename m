Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCB2C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 05:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C4D2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 05:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BCErC1RZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfK0FmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 00:42:14 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37970 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfK0FmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 00:42:14 -0500
Received: by mail-pj1-f65.google.com with SMTP id f7so9402512pjw.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 21:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JVfdiNpIIkZybFlA7Wet324geHsXtasX8Ts1855KGnw=;
        b=BCErC1RZbtWq8kWpws1w7AYLww1/8Vl0xUopMqL00ACtbFnatvh5KIIwEOKVtNZIAP
         gojzpiX5fW908/fpf9c0ehmb6QPARQ7sfBia7whsBYTvBvnhdK03CRHQPxBNKTxDDpTJ
         bggt0TQn3E8lytfiwk30Ne0E1R6jhSBJ7lzvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JVfdiNpIIkZybFlA7Wet324geHsXtasX8Ts1855KGnw=;
        b=UrjX1REU+VEvJtOvYx3eub57AOX9RdJBteMN5Sf0ChWYRVKQMRauPhuvUhoqbd9Qrq
         u8G8dVl2UiScMQ+fw7XcL5FuJcNxYVp8OaAVHYn2I6xe1WhwvXJg4jVHeROKaNkSG4OU
         LerzkQoGITFjSdDqP6lKhO33XOLI/9KZKakbwfWUsntB5mg/8iiOmOpsi87GahKHKxou
         M0esGFZScEo3PmG2GxfDINM0SsattY2oKSuBTlVOrqh7sCJAkst7mtOCtkYeA3PU2bzn
         1dnOJXKwLdlUAgH09eH7rEatfgz1togmrIXrvoB6tX3dDU4erqBCwL1BxOx8uIjdsoh1
         4vgQ==
X-Gm-Message-State: APjAAAVyAnfCAWBQRFRKZy2jHfvfExzbtloWGj3fUkc3VPaixkOORZ6X
        YUCkBGGvQTDq4l9DhVX8qb/pdQ==
X-Google-Smtp-Source: APXvYqwsK3qE004ktAfCs5hNfeC0dRHftIZgavowVz5TW9u42BSN1qcIJ8n61f9eLxX1xcbWAPVAwQ==
X-Received: by 2002:a17:902:7892:: with SMTP id q18mr2295211pll.171.1574833333323;
        Tue, 26 Nov 2019 21:42:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g6sm14230976pfh.125.2019.11.26.21.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 21:42:12 -0800 (PST)
Date:   Tue, 26 Nov 2019 21:42:11 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Alexander Potapenko <glider@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH v2 0/3] ubsan: Split out bounds checker
Message-ID: <201911262134.ED9E60965@keescook>
References: <20191121181519.28637-1-keescook@chromium.org>
 <CACT4Y+b3JZM=TSvUPZRMiJEPNH69otidRCqq9gmKX53UHxYqLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+b3JZM=TSvUPZRMiJEPNH69otidRCqq9gmKX53UHxYqLg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 22, 2019 at 10:07:29AM +0100, Dmitry Vyukov wrote:
> On Thu, Nov 21, 2019 at 7:15 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > v2:
> >     - clarify Kconfig help text (aryabinin)
> >     - add reviewed-by
> >     - aim series at akpm, which seems to be where ubsan goes through?
> > v1: https://lore.kernel.org/lkml/20191120010636.27368-1-keescook@chromium.org
> >
> > This splits out the bounds checker so it can be individually used. This
> > is expected to be enabled in Android and hopefully for syzbot. Includes
> > LKDTM tests for behavioral corner-cases (beyond just the bounds checker).
> >
> > -Kees
> 
> +syzkaller mailing list
> 
> This is great!

BTW, can I consider this your Acked-by for these patches? :)

> I wanted to enable UBSAN on syzbot for a long time. And it's
> _probably_ not lots of work. But it was stuck on somebody actually
> dedicating some time specifically for it.

Do you have a general mechanism to test that syzkaller will actually
pick up the kernel log splat of a new check? I noticed a few things
about the ubsan handlers: they don't use any of the common "warn"
infrastructure (neither does kasan from what I can see), and was missing
a check for panic_on_warn (kasan has this, but does it incorrectly).

I think kasan and ubsan should be reworked to use the common warn
infrastructure, and at the very least, ubsan needs this:

diff --git a/lib/ubsan.c b/lib/ubsan.c
index e7d31735950d..a2535a62c9af 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -160,6 +160,17 @@ static void ubsan_epilogue(unsigned long *flags)
 		"========================================\n");
 	spin_unlock_irqrestore(&report_lock, *flags);
 	current->in_ubsan--;
+
+	if (panic_on_warn) {
+		/*
+		 * This thread may hit another WARN() in the panic path.
+		 * Resetting this prevents additional WARN() from panicking the
+		 * system on this thread.  Other threads are blocked by the
+		 * panic_mutex in panic().
+		 */
+		panic_on_warn = 0;
+		panic("panic_on_warn set ...\n");
+	}
 }
 
 static void handle_overflow(struct overflow_data *data, void *lhs,

> Kees, or anybody else interested, could you provide relevant configs
> that (1) useful for kernel,

As mentioned in the other email (but just to keep the note together with
the other thoughts here) after this series, you'd want:

CONFIG_UBSAN=y
CONFIG_UBSAN_BOUNDS=y
# CONFIG_UBSAN_MISC is not set

> (2) we want 100% cleanliness,

What do you mean here by "cleanliness"? It seems different from (3)
about the test tripping a lot?

> (3) don't
> fire all the time even without fuzzing?

I ran with the bounds checker enabled (and the above patch) under
syzkaller for the weekend and saw 0 bounds checker reports.

> Anything else required to
> enable UBSAN? I don't see anything. syzbot uses gcc 8.something, which
> I assume should be enough (but we can upgrade if necessary).

As mentioned, gcc 8+ should be fine.

-- 
Kees Cook
