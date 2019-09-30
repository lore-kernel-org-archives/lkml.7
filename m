Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2E0C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF1521855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Ke+Nx55i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbfI3ObH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:31:07 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32901 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730902AbfI3ObG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:31:06 -0400
Received: by mail-lj1-f194.google.com with SMTP id a22so9751788ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 07:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zBL7epC00p9U9++zGccJDAwUuYYIfHYJAHuYq0NGhKI=;
        b=Ke+Nx55iXZQfZSHRoqDLY786VnrQjJgoe/GD/uOlYu8+tDQ9EAUgLcqHGlUm6BTKpb
         WX5654MwqqZ+4GZEY92XR6gll89SPNvhOQD60cXDcMBMQxuvCBnI/oi+9OcSMb9YhvVR
         U2f3yCuw6i91i3dKrEsYVFk1FGdpYawZKGy0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zBL7epC00p9U9++zGccJDAwUuYYIfHYJAHuYq0NGhKI=;
        b=ubSpMFFlPhWu9GKDyHiKxj2bojJeYSAA8XDjsxCsWo4dJ6RakxQp10js/w/9Gb/zEk
         nqejsFdPMmkpkroevNnxqC/f2N7R/8rNQSDB/yeypueqCwHwapKP7dhV4bg+v8kkxlGl
         z68/35jHI1l+bfmfI3hLihMfywSOnxWh7n9r7wJgaliHIwUbFMcgzCU2HAKanp9IDoIz
         nYUoSwnF4I1qTIxO18AphefY8IYMuMW62wZQ6upmYp1j9E7tyWaI30nBN3EJd+LusXai
         rV/pMmuZCW+lui2y2ibQ+J0Ux+7uIDyd9uLyltBu1wf4zal8ukcaAbhAgeGy/VYQE1fD
         tAJA==
X-Gm-Message-State: APjAAAUil/0dNauZS/U/TTCaqVbLdtniIlarkTQAwz2nmCInAaDBLyj3
        KtW7rElQAy08S9IVL+K9lt5c1Q==
X-Google-Smtp-Source: APXvYqyIcLy55HB3x/wsB1A7V+gCME1VE6tR84DBLqOOAZkx1QX/h9HdcAKeuQHRVXy8LcRSx7k+/A==
X-Received: by 2002:a2e:8ec6:: with SMTP id e6mr12257813ljl.231.1569853864490;
        Mon, 30 Sep 2019 07:31:04 -0700 (PDT)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id q11sm3301932lje.52.2019.09.30.07.31.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 07:31:03 -0700 (PDT)
Subject: Re: [PATCH v2] lib/string-choice: add yesno(), onoff(),
 enableddisabled(), plural() helpers
To:     Jani Nikula <jani.nikula@intel.com>, linux-kernel@vger.kernel.org
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org,
        Vishal Kulkarni <vishal@chelsio.com>, netdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <julia.lawall@lip6.fr>
References: <20190930141842.15075-1-jani.nikula@intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <8e697984-03b5-44f3-304e-42d303724eaa@rasmusvillemoes.dk>
Date:   Mon, 30 Sep 2019 16:31:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190930141842.15075-1-jani.nikula@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2019 16.18, Jani Nikula wrote:
> The kernel has plenty of ternary operators to choose between constant
> strings, such as condition ? "yes" : "no", as well as value == 1 ? "" :
> "s":
> 
> 
> ---
> 
> v2: add string-choice.[ch] to not clutter kernel.h and to actually save
> space on string constants.
> 
> +EXPORT_SYMBOL(enableddisabled);
> +
> +const char *plural(long v)
> +{
> +	return v == 1 ? "" : "s";
> +}
> +EXPORT_SYMBOL(plural);
> 


Say what? I'll bet you a beer that this is a net loss: You're adding
hundreds of bytes of export symbol overhead, plus forcing gcc to emit
actual calls at the call sites, with all the register saving/restoring
that implies.

Please just do this as static inlines. As I said, the linker is
perfectly capable of merging string literals across translation units
(but of course not between vmlinux and modules), so any built-in code
that uses those helpers (or open-codes them, doesn't matter) will
automatically share those literals.

Rasmus

