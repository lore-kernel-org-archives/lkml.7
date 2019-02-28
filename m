Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C151C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121E32184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a85WidkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733138AbfB1Qt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:49:56 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42961 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfB1Qt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 11:49:56 -0500
Received: by mail-ed1-f67.google.com with SMTP id j89so17537597edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 08:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l0SiZm/5Ri0JIZtNktKmGoCnlw+XEv0PXHkRedDB7Io=;
        b=a85WidkP/hVjx/ZgEXRNO/pxLsFrbfsNzx0TYWmiTYNBwZRiEK2quAbN9EmaJIu+PB
         wX4bmp7c8AIkT993rSwo4qX5iUparq1nnKzXlXNHJsK4sx3/fEv7We9cENzW23Ioq0U3
         TeMlkkRDUrgv+Y6U3dglqGDOkZWCi13FJn9Bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l0SiZm/5Ri0JIZtNktKmGoCnlw+XEv0PXHkRedDB7Io=;
        b=sEARIbu6XmYR+R0aLQgvG58hPiUDGX8HuVFn/wHu22PKLQgK49kLmnh6NQKRuo9+Mi
         5V+bG/q/aFMraUG89nw9AZPbEn+aXOFzHMOFqvNwlE9RWTVaCZwLilGS/BUt6Ync4hqa
         pC2xPAxdhs3h7cc+Gmr4Pj7oSN1xH8rr0XxtvDf73O4RUwzs+enEt8bs7reU9WR3t4BM
         bdondlTVEuQbky0aBvyByWC8t8W82LTdTf4f6K5m/Xvu477fLIzFdyOG7Atu2KWTr/4n
         HfGMRsRS38CwXzquEe2oB9IPsicUoars5ek0G8B+/S8UBXM07HJx1TpBOnskZtrTCHwZ
         JYLQ==
X-Gm-Message-State: APjAAAWGYxDTCfo+kZ81AcSVyL9PPf5W1T6VrNKPs5avEogm7e4ghuPt
        cx5vXBP2a5++xIbDB6vCKqiQzeL8zxE=
X-Google-Smtp-Source: APXvYqw8Z/Z2y2XxIu1f4mNJoX82U9AeD3C6ZLVP81u3VTlDpwMffS8GVN6V6KjGu4j4DiDmmguuMg==
X-Received: by 2002:a50:a545:: with SMTP id z5mr472165edb.208.1551372594043;
        Thu, 28 Feb 2019 08:49:54 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id p7-v6sm3250448ejf.64.2019.02.28.08.49.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 08:49:53 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id x7so9859176wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 08:49:52 -0800 (PST)
X-Received: by 2002:a1c:ce02:: with SMTP id e2mr365590wmg.29.1551372592470;
 Thu, 28 Feb 2019 08:49:52 -0800 (PST)
MIME-Version: 1.0
References: <20190227221917.62567-1-djkurtz@chromium.org> <20190228070950.GB27446@kroah.com>
In-Reply-To: <20190228070950.GB27446@kroah.com>
From:   Daniel Kurtz <djkurtz@chromium.org>
Date:   Thu, 28 Feb 2019 09:49:39 -0700
X-Gmail-Original-Message-ID: <CAGS+omCf5FAoNye59A99ry+j9j6_JsNjLxSq3pxDMbe=jnvY0w@mail.gmail.com>
Message-ID: <CAGS+omCf5FAoNye59A99ry+j9j6_JsNjLxSq3pxDMbe=jnvY0w@mail.gmail.com>
Subject: Re: [PATCH] xhci: use iopoll for xhci_handshake
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rrangel@chromium.org, Mathias Nyman <mathias.nyman@intel.com>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 12:09 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Feb 27, 2019 at 03:19:17PM -0700, Daniel Kurtz wrote:
> > In cases such as xhci_abort_cmd_ring(), xhci_handshake() is called with
> > a spin lock held (and local interrupts disabled) with a huge 5 second
> > timeout.  This can translates to 5 million calls to udelay(1).  By its
> > very nature, udelay() is not meant to be precise, it only guarantees to
> > delay a minimum of 1 microsecond. Therefore the actual delay of
> > xhci_handshake() can be significantly longer.  If the average udelay(1)
> > is greater than 2.2 us, the total time in xhci_handshake() - with
> > interrupts disabled can be > 11 seconds triggering the kernel's soft lockup
> > detector.
> >
> > To avoid this, let's replace the open coded io polling loop with one from
> > iopoll.h that uses a loop timed with the more presumably reliable ktime
> > infrastructure.
> >
> > Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
>
> Looks sane to me, nice fixup.
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Is this causing problems on older kernels/devices today such that we
> should backport this?

We detected that xhci_handshake timing out can lead to softlockup
while debugging a USB issue on a new product.  The xhci_handshake
timeout itself is a symptom of another underlying problem causing some
commands to be aborted.  I don't know if any such underlying problems
exist on other older devices, but the potential is there so a backport
is reasonable.  Although, it may just shift the symptom of an
underlying problem from a softlockup/oops to some other symptom, like
USB just being dead.

-Dan

>
> thanks,
>
> greg k-h
