Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07729C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD12F2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Iq3SXQXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbfDJRod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:44:33 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:46538 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfDJRod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 13:44:33 -0400
Received: by mail-lf1-f41.google.com with SMTP id r25so2455353lfn.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 10:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PWNTa5XtaGcqQddICIj/u1u1P3x6fsMZqIHoPhhy7bI=;
        b=Iq3SXQXSIrTf8ACEKNUw53XQgf2a1eN5kC/uU23V5dIGCAH1kprxy0rRx2iXQ3d3tu
         DmFZlXKCgPahCxlnoXDhGCAtX+ZF3uyx0abT8elvKn9u8LR2Udu+uyrJ1gl21RVKaeDb
         MXsd4naw3YOBCja44JFyC1XxcVEuGoPRdUs7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PWNTa5XtaGcqQddICIj/u1u1P3x6fsMZqIHoPhhy7bI=;
        b=NmO1w6JYqBnLiOfqJGAFHYF3NFAHAE3Jlko4IB4LVrBPg7SY6B5rtV/TzumDsJFqkG
         3rW0o1vBvZGDQGP+UQ5TPxrmc+c5Ta9YrUeJ/gVnFdlgepUOMPsU1FkyYwMLdkQ4DwuW
         XRwVZN0Fn14d2R8E4OacuMIfnF/OWtctxPc/Vdor1Ltk0CGkVzKpAP0bgdEYR05BpoHP
         oCNXD8oYnPZkxqW7YAPxqz5oSHq0p+oUeBLXpaXQcBDRlxQYMRXaZhOMmcnUiZRufflE
         Hy/TGhfy3sOU3g0aQvzu/XvPrrXykGa2E1rtB2LfoSUUoxRxCDbEA0S7CihE13EiOpQi
         zPQQ==
X-Gm-Message-State: APjAAAWlarpFNEIjRv/lY3mHfwQkUK+TQhR88ZT7dJvlfrRzgQCOQV2G
        bTtkSF28M5LYbGNaV2ziglwUsYj5nY4=
X-Google-Smtp-Source: APXvYqwxcEp2KG7k2AAoS49Ce7gMptaybf35fjcwXEb9P8aNOvRtUP1iRKuJjWFGvg+TW2U0uLRSrQ==
X-Received: by 2002:ac2:482e:: with SMTP id 14mr5513254lft.1.1554918270881;
        Wed, 10 Apr 2019 10:44:30 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id v26sm7326445lja.60.2019.04.10.10.44.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 10:44:29 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id k8so2918368lja.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 10:44:29 -0700 (PDT)
X-Received: by 2002:a2e:84ce:: with SMTP id q14mr23555389ljh.80.1554918268885;
 Wed, 10 Apr 2019 10:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190409184917.65062-1-briannorris@chromium.org>
 <CAHk-=wg6_i9WcqiGu4kg97yAg1du26RpXdxd=uEjo4yXjotdiQ@mail.gmail.com>
 <CA+ASDXMptGi2H+E77xRJQEryWgEeqWYb8Xn=XxkK8Tio8RBkMw@mail.gmail.com> <CAHk-=whL3UEnKTpmr0bqL_6cW8cOn8mSCFAjAtpCfeMVq7Serw@mail.gmail.com>
In-Reply-To: <CAHk-=whL3UEnKTpmr0bqL_6cW8cOn8mSCFAjAtpCfeMVq7Serw@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 10 Apr 2019 10:44:17 -0700
X-Gmail-Original-Message-ID: <CA+ASDXMYiDpYx06LDrZcn5gVWu_7q3DK5G0Eb1jmwjUJZAA_KQ@mail.gmail.com>
Message-ID: <CA+ASDXMYiDpYx06LDrZcn5gVWu_7q3DK5G0Eb1jmwjUJZAA_KQ@mail.gmail.com>
Subject: Re: [PULL -- 5.1 REGRESSION] Bluetooth: btusb: request wake pin with NOAUTOEN
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 8:43 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Either it's edge-triggered and you'll get one possibly spurious
> interrupt for an old issue, or it's level-triggered and setting up the
> hw should bring the irq line inactive and you'll be ok.

I think our key difference here is in how much we trust the device:
knowing the quality of the firmware running on some of these devices,
I wouldn't totally trust that they get it right. (It's not fatal if we
allow a buggy firmware to provide an occasional spurious wakeup, but
it's much less OK to allow it a window for flooding us with
interrupts.) So while your suggestion is indeed correct for
well-behaved devices, I think both approaches have value.

> But I've applied your patch for now simply because it seems to be a
> smaller change.

Awesome, thanks!

> But I think you should look into whether it can be fixed by just
> requesting the irq once the hardware is really up (which may indeed be
> as late as open time).

Yes, I will take a look at that for future release cycles. It's a nice
addition regardless, I think.

Brian
