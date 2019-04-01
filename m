Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A40C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5DDB20663
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zb+mT81K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbfDASHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:07:32 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39739 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbfDASH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:07:28 -0400
Received: by mail-lj1-f195.google.com with SMTP id l7so9057275ljg.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 11:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L1lKCMSu+yUtXpbeonHggfuZodsrR2XdaEg57sCklMY=;
        b=Zb+mT81K27QtJ9PTbGBiTQ/TpIidhzHhj2JpuWVh3D4wzANvmjxBbZBmL8UOXzsw5N
         i0KInvK4tJXhQ1mX414TnSR36srYk3WeEAk3MX9DeGzxUzJW3A/SZs+07iP6ilo3biLA
         AZ6N3zAyuCOKJi9XZHDLtW6SaCwjTGVzR16hI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L1lKCMSu+yUtXpbeonHggfuZodsrR2XdaEg57sCklMY=;
        b=aS5AYVaeZxnH5LcUSJPjE/0oZZshEfR5nwTVP+l+4dCWjgpgqAx4KOuk02wqqjSrQo
         tGDzA9UNr1/e5HUE7cta5Qae3O1y+T16lXShNKllc3Enh1Q0snb3QuG0zSXEoUGdGNQ6
         JvkMss6B4B/cITA6bs0Hc27wfhvNUyt/kYY7JUs4brHrQcRIT0N/z5uzc7A3WBNVSdTt
         vd0WueI5bnpM3pKdtec9bbAbIT45X70V0E2H1wDYIdoHIUydyUqiZzp5ieXUoNn/m1Mq
         sQl6IfdvAXtfP1lNnairrAMCR955MIKEjFBDlt1iIIS7dymY32MHu0S17Ef8+BHbUIIf
         iNDA==
X-Gm-Message-State: APjAAAW3aDn5fnf+JJdMoFdGXsH6/RXQyqpc04UMs+pM14Ig8em1b5jY
        C9WxoK5gEb+eEyzd3IW9PqbA+zdzOi8=
X-Google-Smtp-Source: APXvYqyuaSR4kWIBKLDaFMgcNSAtRilNp6i3QX5/ASulelg/EOGtdM6jj1pdNYI1mGHQMqerv+VA5A==
X-Received: by 2002:a2e:84ce:: with SMTP id q14mr2606049ljh.80.1554142046295;
        Mon, 01 Apr 2019 11:07:26 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id m23sm2015093lfj.89.2019.04.01.11.07.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 11:07:24 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id u21so7001595lfu.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 11:07:23 -0700 (PDT)
X-Received: by 2002:a05:6512:248:: with SMTP id b8mr25322931lfo.140.1554142043372;
 Mon, 01 Apr 2019 11:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190222003051.127006-1-briannorris@chromium.org> <CA+ASDXNYZhOeef_7nhZf1GYhdxubE7v+ustG8zDigGHVOYWRFg@mail.gmail.com>
In-Reply-To: <CA+ASDXNYZhOeef_7nhZf1GYhdxubE7v+ustG8zDigGHVOYWRFg@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 1 Apr 2019 11:07:11 -0700
X-Gmail-Original-Message-ID: <CA+ASDXM9ciP6uxxA1ewhkK-Xh-DSKGzedw1UJH59sC7JsOtHoQ@mail.gmail.com>
Message-ID: <CA+ASDXM9ciP6uxxA1ewhkK-Xh-DSKGzedw1UJH59sC7JsOtHoQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: request wake pin with NOAUTOEN
To:     Andrew Morton <akpm@linux-foundation.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ akpm, in case he can help out

Another week, another buggy 5.1 RC.

On Tue, Mar 26, 2019 at 11:48 AM Brian Norris <briannorris@chromium.org> wrote:
>
> On Thu, Feb 21, 2019 at 4:30 PM Brian Norris <briannorris@chromium.org> wrote:
> >
> > Badly-designed systems might have (for example) active-high wake pins
> > that default to high (e.g., because of external pull ups) until they
> > have an active firmware which starts driving it low. This can cause an
> > interrupt storm in the time between request_irq() and disable_irq().
> >
> > We don't support shared interrupts here, so let's just pre-configure the
> > interrupt to avoid auto-enabling it.
> >
> > Fixes: fd913ef7ce61 ("Bluetooth: btusb: Add out-of-band wakeup support")
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
>
> Ping! v5.1 is enabling wake support on Scarlet, and without this
> patch, that causes interrupt storms at boot. Please apply this patch
> for v5.1-rc!
>
> See also:
> https://lkml.kernel.org/lkml/CA+ASDXMePkQDRfaSwNGnRYyGdsuvfUCXBtDK79o2mP=1hdNQUA@mail.gmail.com

Ping x 2!

Marcel merged my other series first, which enabled this feature,
without applying the bugfix (which was sent first). So right now, my
RK3399/Scarlet board is in very bad shape. Can somebody please merge
this bugfix for 5.1? If not, I'll probably just send Linus a pull
request myself.

Original patch link, in case this helps someone:

http://lkml.kernel.org/lkml/20190222003051.127006-1-briannorris@chromium.org
https://lore.kernel.org/patchwork/patch/1044896/

Thanks,
Brian
