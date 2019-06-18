Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2173C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878B221479
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560891352;
	bh=9yzm3qVL4jDaJpWBIVHmYyswQW4HD28MsHbdWH2MR2s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jT+M/mJ3sNoBlLO4CWcOkYexOwD52gmRFUIeMjODMNCxc450RGN9wKvA+f4vSZ4Xj
	 ygWq2D2Gt6x3eQNHeX/z6FWI1rtW7fBmzH/xXxfU77OSC561njK+u1I7G75/02errg
	 /kuq0cvZoFcT0SIifrkJf9byMFpANWsI/ubkOzxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbfFRUzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 16:55:51 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35252 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730851AbfFRUzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 16:55:49 -0400
Received: by mail-lf1-f66.google.com with SMTP id a25so10343321lfg.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 13:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rgyz2cVF6lciICHj9aRxm3g8t9416ctrHS5B3PoGzGM=;
        b=er8IX2IUKbXU9cahan+PR49raLMPgXXPPUR2yIHqZPbkQsvl37yRNMqfD0QJCdAjv/
         Js7XnzEYA+84AFVz+WBmB839fafHCxPz6VNvQMgMq5clTEv658MFIY2euF6/qDtGFn5n
         /mCm3ynK8OYbMKS6yBEJaYs5AYJ0Te0crzo84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rgyz2cVF6lciICHj9aRxm3g8t9416ctrHS5B3PoGzGM=;
        b=uYEPxC+4NAixwpZy7ca7rxyOiKqK8FopW6atlE7/+sYgOea8gFOpSA3V+rOMiL1ELH
         l1SNR38SyoK8Wo3OYRAYEWHqPfAn+26LK7OZoEurwkjx4NvUciq0d/MgSj21uDkuB1Eu
         0HtDHYF2yYaE4r0/fEB4CLorjIJXwvJyLUJRxS87CquXfcK0c6g9wXukvc/x0+VlHpf8
         ZCl6NuADu/MKY6f2JapLrZSkzVre4yFxhRz8qpZ8GfAmGZWngbmqcy+dniYHehliygoy
         +hKi8hqBhu5c1HUuONqa7Vc7stgGfBCAT/JIqMu+c+Pp+nERKtUM2vzwQgXVxHsYatPY
         6Yyg==
X-Gm-Message-State: APjAAAVoUfXG6OfWS+CjxG7oPyPbWOrVKEmBiDMKh+hqaIeq+3NgdNOu
        wX37CNWdf6HxvL1jx6zsHfFHO6s/exA=
X-Google-Smtp-Source: APXvYqzoc7bR4/eXX8wpWiL+XCe+dFu1BR2a2mfV5V5tjViyPdHstKZwOgA9iW43Ta+/FoADWhc+2w==
X-Received: by 2002:ac2:42ca:: with SMTP id n10mr19654405lfl.121.1560891346826;
        Tue, 18 Jun 2019 13:55:46 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id q1sm2360140lfc.79.2019.06.18.13.55.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 13:55:45 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id u10so10313215lfm.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 13:55:45 -0700 (PDT)
X-Received: by 2002:a19:f808:: with SMTP id a8mr6231181lff.29.1560891345414;
 Tue, 18 Jun 2019 13:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTL5sYCGxX8+xQqyBRWRUE05GAdL58+UTG8bYwjFxMkw@mail.gmail.com>
 <20190617190605.GA21332@mwanda> <20190618081645.GM16364@dell>
In-Reply-To: <20190618081645.GM16364@dell>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Jun 2019 13:55:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wghW+AKvRGevUiVWwTqWObygSZSdq6Dz2ad81H73VeuRQ@mail.gmail.com>
Message-ID: <CAHk-=wghW+AKvRGevUiVWwTqWObygSZSdq6Dz2ad81H73VeuRQ@mail.gmail.com>
Subject: Re: [PATCH] mfd: stmfx: Fix an endian bug in stmfx_irq_handler()
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 1:16 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
>
> Ideally we can get a review too.

Looks fine to me, but obviously somebody should actually _test_ it too.

              Linus
