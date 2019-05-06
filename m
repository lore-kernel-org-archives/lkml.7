Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25BBC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 22:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2022054F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 22:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ABG4sOkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfEFWUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 18:20:11 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34714 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEFWUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 18:20:10 -0400
Received: by mail-ua1-f66.google.com with SMTP id f9so5271948ual.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 15:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LFigoZJymqmAaPzjvAFIhkqDgKas3FocYI4lCQ70qnE=;
        b=ABG4sOkPQqPowCgFecCPGKupz44mONVpCKnynPqbD1PBGzbJqzFzk7rgRpOY/O+YM1
         Trx119D7VlwsARtPhJ2zsjkzziHTWrE0bXmWqFXdHnEDiyHV+Vn05EYT4zYqTMg6yNcq
         d+IBEMobGQ+IHeDSQ4cy77I4r/gGPKXy6dXWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LFigoZJymqmAaPzjvAFIhkqDgKas3FocYI4lCQ70qnE=;
        b=XcEbfHunCZPGM2A7qprXsSsapEwvJ3qrcuBg9t+TjElhmSLaaOm9FtUsLUaDx1V1eC
         Ua09OXE70FTFaTyyEZsy99PI5aOOfNU/CKTPz7PK03wONht7PUayLwjiJYS5y/vD2KWL
         uMu3O3RJM61Tggr9dlTCmVWNoHY3qRBW4j2baXvgMxLXMy5bQlYYKkdQd09o8s+hxAyj
         1wDg4ejW79BcjwQ1Kzb+v/8oxLBQ0FaMKScBY2+vbFCYwe1esKjASSodz63YXI3AR2jq
         KJS2A3Rma+jcePTzXbmX9zGxpjYdZkC6qU9JYNXTjH1wZr2AsysjNDdDcPRu85JZ07Ga
         DNyg==
X-Gm-Message-State: APjAAAVGeu2/C5KqTOnVjf3tbv8B+jPRBPAxL/HrL3MI9JKBJ3vlYJqG
        bE3vqRe10HtjpwCq9wdJAZX4o7nQhuE=
X-Google-Smtp-Source: APXvYqzQ1dV8oe/V3hVQceqDPT1R7S2T0pid2eroY9zmcN5m2iYf0TFTEsfNyGOZys+h+HI2RWdO0A==
X-Received: by 2002:ab0:7348:: with SMTP id k8mr288589uap.64.1557181208906;
        Mon, 06 May 2019 15:20:08 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id i14sm3472331vsf.29.2019.05.06.15.20.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 15:20:07 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id g127so9133867vsd.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 15:20:07 -0700 (PDT)
X-Received: by 2002:a05:6102:397:: with SMTP id m23mr5277776vsq.222.1557181207040;
 Mon, 06 May 2019 15:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190506191950.9521-1-jmoreira@suse.de> <20190506191950.9521-4-jmoreira@suse.de>
In-Reply-To: <20190506191950.9521-4-jmoreira@suse.de>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 6 May 2019 15:19:55 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKt9NuGeHumTkO2aD1MoBdP-OwRTXu1_qq0r8_t=Y6sMw@mail.gmail.com>
Message-ID: <CAGXu5jKt9NuGeHumTkO2aD1MoBdP-OwRTXu1_qq0r8_t=Y6sMw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] Fix twofish crypto functions prototype casts
To:     Joao Moreira <jmoreira@suse.de>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 12:20 PM Joao Moreira <jmoreira@suse.de> wrote:
> RFC: twofish_enc_blk_ctr_3way is assigned both to .ecb and to .ctr,
> what makes its declaration through the macro undoable, as thought in
> this patch. Suggestions on how to fix this are welcome.

This looks like a typo in the original code (due to the lack of type checking!)

typedef void (*common_glue_func_t)(void *ctx, u8 *dst, const u8 *src);
...
#define GLUE_FUNC_CAST(fn) ((common_glue_func_t)(fn))
...
void twofish_enc_blk_ctr_3way(void *ctx, u128 *dst, const u128 *src,
                             le128 *iv)

static const struct common_glue_ctx twofish_ctr = {
...
               .fn_u = { .ecb = GLUE_FUNC_CAST(twofish_enc_blk_ctr_3way) }
...
        return glue_ctr_req_128bit(&twofish_ctr, req);

int glue_ctr_req_128bit(const struct common_glue_ctx *gctx,
                        struct skcipher_request *req)
...
                                gctx->funcs[i].fn_u.ctr(ctx, dst, src, &ctrblk);

The twofish_ctr structure is actually only ever using the .ctr
assignment in the code, but it's a union, so the assignment via .ecb
is the same as .ctr.

-- 
Kees Cook
