Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFD7CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42202087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xH+f76fF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbfJ2VSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 17:18:06 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35529 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfJ2VSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 17:18:06 -0400
Received: by mail-ot1-f66.google.com with SMTP id z6so230914otb.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 14:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k+lof7k7UQw8OWzjqMvhsPhGiM5bCAdWAJ4xCnTV+BI=;
        b=xH+f76fFbXKqh+7qsqw9xod2NKWPThyefhfGZF2rsd/IR8EjLdVxFmsiE6rvYXb1TC
         AKu85TtcKAHAbOAmcSe3lv82DPFNzdfXU6DLzIvAp1WV4mmL3IZEwFaDW0uZNt7jpCPl
         RRnCHb9/5wIiEohg3Ac+JYhUD/zzfJT0X/rdUwvs6mezEF/nm7FDU7d0wQ5JdimnUayx
         oTh9MHhXv5dL1GVsLkL42ekcYydFfgoNtOVcFgLkXw0BvN3pHpUCCX3MebY+rJ4xBWT5
         5inauOZL/d8WALOZ1xrWtQ5rVsABAzOa+rXWJQxh2+tzUvjEYEHj6fVcGzrNC6u/i3EZ
         Gr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+lof7k7UQw8OWzjqMvhsPhGiM5bCAdWAJ4xCnTV+BI=;
        b=PeybdyNZfON1dCqmwxXzR7xjjZlVZI0DmzG+5LBlG/J5Ot3tHs5XvKUn4u53TydNKE
         bPRsVvEE27JjeqHTv01bfT2GT/aHZizKXsTXX6P1EzkQAnABRQsMRTNEGOp8vMyzEq0R
         otuaCpV927WayZiQgU8h1HdbiPdbfrwqjpEqBHhx6QLHFxs8yECZp3sgkA8zFrSvqFjW
         lg0xDeuh9awskoizDfYgmk9BipbvGaBbF0HyNRxdgEu0vy+4yCdmQfiBhI1I4FM2IUuP
         Grh3bV35XcrOtNOHsXYBSNT1OHUIfLIzIWiezD2xNpiX8KnPmgl8lGUEqpAAo0KZe/hm
         1u9g==
X-Gm-Message-State: APjAAAXoYEZgZJl3R3UpPxtKQm2Q4nAx/34LGu1Mt+/jqVj1DcRZPX/5
        k5H/EkwkW7tAMOikSnCZPWnZ5qn+DBb5jiRFYUiEaA==
X-Google-Smtp-Source: APXvYqz9bxq6SQCx5y6RV65TPgRFUQTPKSOiFVfkv4eumgw9YTu20bPWChoYFWgrbzJrNph2HvhZobqfBQU4hku3gYA=
X-Received: by 2002:a9d:5a0b:: with SMTP id v11mr20371012oth.102.1572383883580;
 Tue, 29 Oct 2019 14:18:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191028215919.83697-1-john.stultz@linaro.org>
 <20191028215919.83697-4-john.stultz@linaro.org> <87mudjj4rc.fsf@gmail.com>
In-Reply-To: <87mudjj4rc.fsf@gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 29 Oct 2019 14:17:51 -0700
Message-ID: <CALAqxLU+9uEcdRVaLfh+eQrDtZbDGod9pRXhBX=prAhg9MXagw@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] usb: dwc3: Increase timeout for CmdAct cleared by
 device controller
To:     Felipe Balbi <balbi@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 2:11 AM Felipe Balbi <balbi@kernel.org> wrote:
> John Stultz <john.stultz@linaro.org> writes:
> > From: Yu Chen <chenyu56@huawei.com>
> >
> > It needs more time for the device controller to clear the CmdAct of
> > DEPCMD on Hisilicon Kirin Soc.
>
> Why does it need more time? Why is it so that no other platform needs
> more time, only this one? And which command, specifically, causes
> problem?

Hrm. Sadly I don't have that context (again I'm picking up a
semi-abandoned patchset here), which is unfortunate, as I'm sure
someone spent a number of hours debugging things to come up with this.
:)

But alas, I've dropped this for now in my stack, and things seem to be
working ok so far. I suspect there's some edge case I'll run into, but
hopefully I'll be able to debug and get more details when that
happens.

I do appreciate the review and pushback here!

thanks
-john
