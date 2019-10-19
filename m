Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F02CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 20:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356C6222BD
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 20:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWhMVZR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfJSUYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 16:24:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39721 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfJSUYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 16:24:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id v17so9103177wml.4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 13:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y7m956o0kMuo/g9lESMhxXhm/hsWQOul6vryxA8/gSg=;
        b=dWhMVZR6m9wkxDNwnDCb2mPO5qfGJl3KYlO5YtVqJVgRKtg6CECDuV2osJloKb6H4u
         SreZ98z3Fh/dyVCdsRptwIL/dlbnl7EWyY8bEIEdegi0llnkA0aKjLo+xU/9DH/nvTop
         yiuHN8OwlISKpoeagYgGmDYmIPXsnz52GKdPkX9/q2wGy985Ox2ommS+QqQRlZdNP9cA
         ozHXMeQG0OmHHEXOgISE5iUwJ2xRBbSSCCOcXIHil9IvnYi3YPFb9OM7kF/lUnN3wnzN
         hyHlNpXVo60ePT/B2l+gN/3Ewx0TaKgOfRP19+eJQXwvAyfmgpD0a7duvqDJN8Ag78bw
         rCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y7m956o0kMuo/g9lESMhxXhm/hsWQOul6vryxA8/gSg=;
        b=Idlw2mL/OZlHqHvmllcmC9ADMjerd1HByK7+An82CG5vmwROzyW6O8yKek457TOcCB
         dTYxpEZMVGyNdLuVkW7EwW4809BK5ITYMKq432dA86cGsJrvBetXHg/s407tk3Sw7UFN
         m68etHD3jE9ZexMLs6SXe+8fjAn/hc0w7O2d4fxse34HHEtovBGClkzkzsEeeXtxXd7Y
         0VbG8VimSuCUOr+dyOhz0X4aNlvNLsUKA959xECVpgsb8scVWlraWs5Qfmg+4aK/VsaV
         177W56fFFCRBhNWw62gS1UJ5NlDgidTTaN2adDTM0kIRIMG0E0JB8aB4MN6HFOVoX/er
         n3EA==
X-Gm-Message-State: APjAAAXMuNV2ztu9HwgKqIBdQn5byarfzTjKjoRxvHlzBuZMCLcFHPz1
        FEoNEahPVjRNqPxMwzrlQsYqQX6S
X-Google-Smtp-Source: APXvYqyg1y/qKEhIuOlxr935NXWXi2qDmFTwGT5UOLQLyDwTElLeZL4sHKrZnrpcwxkSA8EY+grDkA==
X-Received: by 2002:a1c:1a4c:: with SMTP id a73mr12543944wma.124.1571516654450;
        Sat, 19 Oct 2019 13:24:14 -0700 (PDT)
Received: from giga-mm ([62.68.26.146])
        by smtp.gmail.com with ESMTPSA id a9sm12563301wmf.14.2019.10.19.13.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2019 13:24:13 -0700 (PDT)
Date:   Sat, 19 Oct 2019 22:24:13 +0200
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Hubert Feurstein <hubert.feurstein@contec.at>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH 2/6] ARM: ep93xx: enable SPARSE_IRQ
Message-Id: <20191019222413.52f7b79369d085c4ce29bc23@gmail.com>
In-Reply-To: <CAK8P3a0LWeGJshr=AdeE3QXHYe2jVmc90K_2prc=4=ZFk0hr=g@mail.gmail.com>
References: <20191018163047.1284736-1-arnd@arndb.de>
        <20191018163047.1284736-2-arnd@arndb.de>
        <20191019184234.4cdb37a735fe632528880d76@gmail.com>
        <CAK8P3a0LWeGJshr=AdeE3QXHYe2jVmc90K_2prc=4=ZFk0hr=g@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sat, 19 Oct 2019 22:08:40 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> > # cat /proc/interrupts
> >            CPU0
> >  39:        146       VIC   7 Edge      eth0
> >  51:     162161       VIC  19 Edge      ep93xx timer
> >  52:        139       VIC  20 Edge      uart-pl010
> >  53:          4       VIC  21 Edge      ep93xx-spi
> >  60:          0       VIC  28 Edge      ep93xx-i2s
> > Err:          0
> 
> I guess that is partial success: some irqs do work ;-)

Yep, VIC1 is working, while VIC0 is not.

> The two interrupts that did not get registered are for the
> dmaengine driver, and that makes sense given the error
> message about the DMA not working. No idea how
> that would be a result of the irq changes though.

Seems, that it has exposed some incompatibilities of
starting IRQ 0 in EP93xx platform fir VIC0 and VIC code
itself, which assumes 0 means "auto assignment" (refer
to vic_init()).

But there are more problems I didn't resolve yet.

-- 
Alexander Sverdlin.
