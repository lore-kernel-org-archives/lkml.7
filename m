Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37EFC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B4C206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 08:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gt1gQKmP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbfD0Il6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 04:41:58 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37405 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfD0Il6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 04:41:58 -0400
Received: by mail-qt1-f195.google.com with SMTP id e2so6076264qtb.4;
        Sat, 27 Apr 2019 01:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tpv0VL0PhkErnPbDE5/hr7y61YK1BGOkvZrSmt4pw54=;
        b=Gt1gQKmPMxTAWik+BbOEYf4RPw3PLoEetcLp4Z7ot5b0lihEKxPElrRRKx4GyKGuLR
         pjLWoY2n+h0wcMb60speOiE8I2gr2sgfjvi/0JREP0J83FkBVgFVgDAIyHBOvwanbXa9
         TjXMWfdeQixVJQH0YHmdtNiokHLzehTMqHLfGF1qenpPJz8m+39YK+YepmP2oXwsEPlB
         uVOoSkj827ENUVfhn4zzFHVvsxesx4ttvds9S4jObD1ZpH+5CMikAXODtxVxc5cGqFQa
         n9WkbjbIw7GET4O1kGe/9VcWT2c3+FJ3APe+YU+CBgRulMY9qx52EklTie4xkfREYl7L
         03Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tpv0VL0PhkErnPbDE5/hr7y61YK1BGOkvZrSmt4pw54=;
        b=dtTMeBpQI814yQchXob6u0DKpYX1xkA8/QJ6Ci4Aa1rNIxSNrKuxTe6CmE20ge7+6r
         dfM0zzOZxdc0+yOvz4wQmFMkcglsOe8PDtanLBDvrcOIqcKhuHErh2082OW9TQxnYJSK
         wqxv+FanVHRF+xNdDKmnAyo5jO0C9pLWrunRfXgZEWn3qQJEOeIaWM/cF0SY+Gteosez
         Ivb0i2buWXfEf3gjqbxDMm0a/46xjz/WbHHTnj025zuH/2dW+nB9pGUOK0tlHXBwxjYL
         Z/Pa69BGm6XI5sFB2/qyFc1DYl9Lm+HZ1p7lFJQ3+dW+qUBbBt3Wm2B5mjEsSdIPlcv2
         SL3Q==
X-Gm-Message-State: APjAAAXViBjPdNg4dGFo+w69rzNwFV5SacBMnVIGmEURlIaSsQSnrtKK
        9SnkecI66s9R6mSEshm6cEQzg6/6zmr0p5SH2Y50IwPVekM=
X-Google-Smtp-Source: APXvYqzkmoNpDA4Vi7VrqPU24TuOzSDPRolu1Uo45ETydBWuJ4pqVIotvL6aO75B6zpiadad4rNUB00Jt9+Ka+HMHgg=
X-Received: by 2002:a0c:9b09:: with SMTP id b9mr26407544qve.240.1556354517509;
 Sat, 27 Apr 2019 01:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190427080013.GA3624@haolee.io> <20190427080942.GA8218@kroah.com>
In-Reply-To: <20190427080942.GA8218@kroah.com>
From:   Hao Lee <haolee.swjtu@gmail.com>
Date:   Sat, 27 Apr 2019 16:41:44 +0800
Message-ID: <CA+PpKPkdpkC9nqL4NzKK=5Xys0H6-ZBAUmjE91WSRg=b1LyiOQ@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: 8250: Fix type field in format string
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Apr 2019 at 16:09, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Apr 27, 2019 at 04:00:15PM +0800, Hao Lee wrote:
> > The variable type and the type field is inconsistent.
>
> In what way?  Please be very specific when you resend this.

The main problem is the dev_dbg statement should print the value of
uart.port.mapbase instead of its address. Besides that, uart.port.irq
and uart.port.iotype are all unsigned types, so using %u is more
appropriate.

Regards,
Hao Lee
