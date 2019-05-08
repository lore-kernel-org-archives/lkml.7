Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19980C04AAE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 21:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BAB20989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 21:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UwXq7RG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfEHVIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 17:08:43 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39386 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfEHVIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 17:08:43 -0400
Received: by mail-vs1-f67.google.com with SMTP id g127so26786vsd.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 14:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=85jAqiZ3rdqGfRvDGF/DUutEfAhFjbADqQZ1rKThcjI=;
        b=UwXq7RG5GbFeEc83Dhtk4yt40YEVN6o9JoBGv+9ERexPqq8oo2r5vW6MQbaxvQJruM
         qVzsMwdsJFIKh1gnJ1TchbHrGKlvv65iFVA+AjaqqHluvK1ywrlFGVWuNt/JOMxqwlQU
         IDVJi+FZd3XpMZTQkuqI4l6ltLywx1nG4LFLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=85jAqiZ3rdqGfRvDGF/DUutEfAhFjbADqQZ1rKThcjI=;
        b=tgBnrTgQ2agQw37rkeINPMx/CU7xsAiR47E++R7NBK4chnsg6wlRjlHnXYtDohJhUz
         H7LElQYaT3QWYWs2Nm9fzRYOUnymwVBXif75UMwyzNheCg9gHlP6TAedn/CI4/EEg/6y
         AFxuSr1FZpl/CnbOyLgR1FzdgEqLYNCwqBQaH/kuUzqz0ZI5voZVc+SgRqgWUrPLIBPN
         IkUfLvzW0wQZ9saOAN4BrsaMBWp45CpofaWX5raeqEeCN+2nKuaZQwNCR2N5rt2cYyus
         IBUTLYygieu+SDlZEZI/d0D9Dae6xbNCRTaF65sEhlJxRE6LkPwyIVxXaqAE2U9WqPBm
         nO5A==
X-Gm-Message-State: APjAAAX7Gi4Mbe83rfkod6EHqaVODY6vcPBrJqaypsWUN7XC2zRMKRhx
        cXDmyxo3FoXv0oO8B37qu7zbU0cDA9o=
X-Google-Smtp-Source: APXvYqzj4jYXpqvlZwYSvnusBGcim5WqsSUEAx/dl5/M4OHSOoNexOPQ9DIsegnojSJmw2fgQ86cig==
X-Received: by 2002:a05:6102:cd:: with SMTP id u13mr238223vsp.151.1557349721603;
        Wed, 08 May 2019 14:08:41 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id v124sm35049vke.42.2019.05.08.14.08.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 14:08:40 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id d128so12797vsc.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 14:08:39 -0700 (PDT)
X-Received: by 2002:a67:7c8a:: with SMTP id x132mr251877vsc.172.1557349719455;
 Wed, 08 May 2019 14:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190507161321.34611-1-keescook@chromium.org> <20190507170039.GB1399@sol.localdomain>
 <CAGXu5jL7pWWXuJMinghn+3GjQLLBYguEtwNdZSQy++XGpGtsHQ@mail.gmail.com>
 <20190507215045.GA7528@sol.localdomain> <20190508133606.nsrzthbad5kynavp@gondor.apana.org.au>
In-Reply-To: <20190508133606.nsrzthbad5kynavp@gondor.apana.org.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 8 May 2019 14:08:25 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKdsuzX6KF74zAYw3PpEf8DExS9P0Y_iJrJVS+goHFbcA@mail.gmail.com>
Message-ID: <CAGXu5jKdsuzX6KF74zAYw3PpEf8DExS9P0Y_iJrJVS+goHFbcA@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] crypto: x86: Fix indirect function call casts
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Joao Moreira <jmoreira@suse.de>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 6:36 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Tue, May 07, 2019 at 02:50:46PM -0700, Eric Biggers wrote:
> >
> > I don't know yet.  It's difficult to read the code with 2 layers of macros.
> >
> > Hence why I asked why you didn't just change the prototypes to be compatible.
>
> I agree.  Kees, since you're changing this anyway please make it
> look better not worse.

Do you mean I should use the typedefs in the new macros? I'm not aware
of a way to use a typedef to declare a function body, so I had to
repeat them. I'm open to suggestions!

As far as "fixing the prototypes", the API is agnostic of the context
type, and uses void *. And also it provides a way to call the same
function with different pointer types on the other arguments:

For example, quoting the existing code:

asmlinkage void twofish_dec_blk(struct twofish_ctx *ctx, u8 *dst,
                                const u8 *src);

Which is used for ecb and cbc:

#define GLUE_FUNC_CAST(fn) ((common_glue_func_t)(fn))
#define GLUE_CBC_FUNC_CAST(fn) ((common_glue_cbc_func_t)(fn))
...
static const struct common_glue_ctx twofish_dec = {
...
                .fn_u = { .ecb = GLUE_FUNC_CAST(twofish_dec_blk) }

static const struct common_glue_ctx twofish_dec_cbc = {
...
                .fn_u = { .cbc = GLUE_CBC_FUNC_CAST(twofish_dec_blk) }

which have different prototypes:

typedef void (*common_glue_func_t)(void *ctx, u8 *dst, const u8 *src);
typedef void (*common_glue_cbc_func_t)(void *ctx, u128 *dst, const u128 *src);
...
struct common_glue_func_entry {
        unsigned int num_blocks; /* number of blocks that @fn will process */
        union {
                common_glue_func_t ecb;
                common_glue_cbc_func_t cbc;
                common_glue_ctr_func_t ctr;
                common_glue_xts_func_t xts;
        } fn_u;
};

What CFI dislikes is calling a func(void *ctx, ...) when the actual
function is, for example, func(struct twofish_ctx *ctx, ...).

This needs to be fixed at the call site, not the static initializers,
and since the call site is void, there needs to be a static inline
that will satisfy the types.

I'm open to suggestions! :)

Thanks,

-- 
Kees Cook
