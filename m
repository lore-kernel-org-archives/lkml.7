Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F95C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906A321655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="T8iue3pi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404208AbfG2Tz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:55:27 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:38256 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404195AbfG2TzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:55:24 -0400
Received: by mail-pg1-f182.google.com with SMTP id f5so19954672pgu.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 12:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PoQj5bEbw5DgB4+Vtw/Kx+8Nt4AUC+W30y4VQmAUYGQ=;
        b=T8iue3piNchupgT7mqf964+e9/b6WAOSlJxP/kBLBqRb1BlhgM8bAY36UH5r/OK5bU
         QmAEbI3/srBFsvqcE7iUGNuL2VSPV0F7etn2zsD08ym41FcSuk9iJxueCUwO13QIhbfq
         xCMP0VZhLmiVfK+xuWP8aghLbD5jj6yopDHxsqR17PP734CeIh/+qF1/Jv7x8HjbmL9Z
         lx3l/XDdQEX9KwJUmTjosgyMfK87SLkSaeQNc2mI1UOOQ680QPuLAnuuN58nYzeKAE0w
         Pr1TYBeh5iBrhlo3ZPLGdXl/pKCyhUaeWwh9pewtZ9sYRJkPOVQfYf/skcZwLna6xdZz
         iTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PoQj5bEbw5DgB4+Vtw/Kx+8Nt4AUC+W30y4VQmAUYGQ=;
        b=G22gQ6rS3/V7BbjQlcOqA6o2ojna2jKluv7aU2VA5R8MoJkeN7Xer5hJnp+NmOMbvf
         XFRLszVi3m1x+4VEHPaGoPdyL7ana6H1Tfs9qAvUIhBt4eLbMeUteYKGvKfXW6YcgDA3
         +wEi5N7ZLW9szB8twQk2vc5A7YlLk7HFU1lwdx6s3DzFwrB2t8VuZkskwv3t8HKmdPL9
         35IfDiLwPOxoOk8p+qnGopjW9TG91Tsk5sPL5XnsNW+nJ2kTORUCWXun2SN+fE3hYlN6
         aeXzacbNiLw/vmGb5vzJXJa4TWe/JHQmrPge7zCrrL0KKfkCRBTQRicAQc35W+jfELtD
         TEPA==
X-Gm-Message-State: APjAAAU1nOl8222z1i7oVtASlIkkhtOrsf1fa7rTPapaU1/warf1neDX
        nkYVNEU8y/bvfJgEXzvc2vg=
X-Google-Smtp-Source: APXvYqzqSHFFeD0eCklaF+WfzV+ZbTBUstqmn+iGofPGNz4Jx53Fxtdl9ETANxsnifUV2i54HTElkg==
X-Received: by 2002:a62:b411:: with SMTP id h17mr36628377pfn.99.1564430123468;
        Mon, 29 Jul 2019 12:55:23 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id y10sm63212568pfm.66.2019.07.29.12.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 12:55:22 -0700 (PDT)
Subject: Re: BUG: KASAN: global-out-of-bounds in
 ata_exec_internal_sg+0x50f/0xc70
To:     Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>,
        Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        tobin@kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>
References: <CAG=yYw=S197+2TzdPaiEaz-9MRuVtd+Q_L9W8GOf4jKwyppNjQ@mail.gmail.com>
 <CAKwvOdmg2b2PMzuzNmutacFArBNagjtwG=_VZvKhb4okzSkdiA@mail.gmail.com>
 <201907181423.E808958@keescook>
 <CAG=yYwmTdW0THoVGJc-Le+TyGMaHKZD-NHTRfXczNes65T8qWA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ec210573-dada-bb6e-b0ee-f54bea62e2ce@kernel.dk>
Date:   Mon, 29 Jul 2019 13:55:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAG=yYwmTdW0THoVGJc-Le+TyGMaHKZD-NHTRfXczNes65T8qWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/19 1:34 PM, Jeffrin Thalakkottoor wrote:
> hello Kees Cook,
> 
> i tested your fix and i think it worked like a charm !
> kasan message related disappeared during boot time and it does not
> show in the output of "sudo dmesg -l err"
> anyway thanks a lot !

Kees, could you send that out as a proper patch?

-- 
Jens Axboe

