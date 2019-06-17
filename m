Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2772AC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 17:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0016208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 17:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560792822;
	bh=YuE2INjOsxUeycUffYBSPVVrzfCkrlneUIGZUoaoUQE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=g6CbkU5EtJcb5Ym4sRjikrckRcpyLNh4p6p/yb7Nl7Pp/jV4EUJ5PpyKj2vCm7Vcd
	 FOCAU5lzfL656UrWjC1+1EQ8VukwrH8JV5098lH5AWfbuAQK/10PegGSfoicaU4/J2
	 g5ER7snbaTt1IH2ORSBSpYpaKnl4jWj2yBUhC77w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbfFQRdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 13:33:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43168 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQRdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 13:33:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id j29so7116375lfk.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 10:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kPeZWPeOlJYlBzjRlIHHkQyI0YMC6Dz5bpJ7RNJSUrk=;
        b=hPuAYBY8T01CpdgBaRIDiJBrCpZoAo/nzsD2dlDnvZsTebZC/F0zORqPtsQ6uSAEHB
         lDa0zhp0BTQV5tFE41btAFyA1TV0akzxRbq3uhhSKQsVskU55/FG7+Uiola+pi/1CkkP
         MCF9RLnz1wToHFA9+ZO6e25L0Ss83jL7UO3R8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kPeZWPeOlJYlBzjRlIHHkQyI0YMC6Dz5bpJ7RNJSUrk=;
        b=rNCw3plGL5phQTw0NA+Gej5Kw5nDZ1n2rAkBnCXw7ClPeekfyPHVsjEyV1YrHc7hyg
         fBAWDTs2S38hgNtAEGK2grQ20+LvlbR9oq6+EFvGx/GONVZeT94TlsVbN/rpWFGAjGxV
         9mCKQwC0nQ4dKScmrfZGbblbDAQ1nS6I7xsfR+qBjO7G0owy30fO5gDtwTXULjpYYiwu
         jzMzyLIMk5YbEVrvuB2rBudGBJLmgR8GOCwQfdmqr3tNbek11mFgPstwGMELW/MhdmhH
         8hgesPtMfl7fQw21Sea0LSBjtyK7B2pswDDWuWz/8Wt6TdNqVzXfXUQk8f1UINPshqj+
         Fk0g==
X-Gm-Message-State: APjAAAUpalzatZPRlAALztqNIA0UBRMmNDRI4HjCez1vbIUDfnexlx1h
        781Yu94tl8dpq6LtDmVYMNmgHYSh55Y=
X-Google-Smtp-Source: APXvYqyIpz6URiDEREcaCNlEjpVWB0J3tedKO0Lbtswc+n82lJn90WmXnjqpjjj7V2KZbc1ImdF1HA==
X-Received: by 2002:a19:3f16:: with SMTP id m22mr16630162lfa.104.1560792817750;
        Mon, 17 Jun 2019 10:33:37 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id r24sm2435334ljb.72.2019.06.17.10.33.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 10:33:36 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id y13so7113536lfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 10:33:36 -0700 (PDT)
X-Received: by 2002:ac2:5601:: with SMTP id v1mr42206211lfd.106.1560792816442;
 Mon, 17 Jun 2019 10:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190617100054.GE16364@dell>
In-Reply-To: <20190617100054.GE16364@dell>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jun 2019 10:33:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgTL5sYCGxX8+xQqyBRWRUE05GAdL58+UTG8bYwjFxMkw@mail.gmail.com>
Message-ID: <CAHk-=wgTL5sYCGxX8+xQqyBRWRUE05GAdL58+UTG8bYwjFxMkw@mail.gmail.com>
Subject: Re: [GIT PULL] MFD fixes for v5.2
To:     Lee Jones <lee.jones@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 3:01 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Enjoy!

No.

This is still entirely wrong.

You can't just randomly cast an "u32 *" to "unsigned long *".

It wasn't correct when you did it the other way in regmap_read(), but
it's also not correct when you now for it this way for
for_each_set_bit().

You can do

    u32 regmap_bits;
    unsigned long bits;

and then

    ret = regmap_read(stmfx->map, STMFX_REG_IRQ_PENDING, &regmap_bits);
    ...
    bits = regmap_bits;
    for_each_set_bit(n, &bits, STMFX_REG_IRQ_SRC_MAX) ..

but casting pointers at either point is *completely* wrong.

Yes, yes, it happens to work on little-endian, but on a 64-bit
big-endian machine, the low 32 bits of the "unsigned int" will have
absolutely _zero_ overlap with the low 32 bits of the "unsigned long"
in memory.

When you moved the cast to for_each_set_bit(), it only moves the
access of the bogus bits to another place instead.

So that patch doesn't fix anything at all, it only moves the same error around.

                      Linus
