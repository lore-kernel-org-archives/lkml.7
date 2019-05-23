Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E54C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 01:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9E220B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 01:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNfaqtv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbfEWBf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 21:35:27 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41128 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfEWBf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 21:35:26 -0400
Received: by mail-ot1-f67.google.com with SMTP id l25so3920307otp.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 18:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Py6c/Iu/9IaiaLPHGtJCGvpx9eg89xJPkl6DsJ/JuAE=;
        b=QNfaqtv6AqfoF3fsF+nZn+mJrS1Es390itSMlBewn6ygvwxvqvHIl8GzmJYMu+upt0
         LPSdwZi9n0Eimidg0zKa4Y8MrIO7on4UbGXNJ+h6caxchun/Wr8Kmsh7dyIpyrVIBOuj
         12BlWS60Kh2JPX+ugupWfHGEGllWVlfrJSP7fPRdtw4FccK9DR0EgEP3jwJW/tlMNB7G
         qs2OT/HwnvtYO/5hJQJ/grjjlzWjl74SioOHMaCvCqvA0lnnQ0eshzHII3WNvIS+2UNs
         QjIQNV5ARnnEXvmxTRH7+EHy0pziRnasH1T8ieQnAEXzlFKQgq2MfAod+Ty83GFrDX75
         SaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Py6c/Iu/9IaiaLPHGtJCGvpx9eg89xJPkl6DsJ/JuAE=;
        b=V5UeaJXz1iDz748kQalV1I2l6/NFTT9MVr/PM2cDuSEXJmDrJTPqTEg3BUg39M4cGW
         0LnJZ3iwgdrqvLtUVxmLeLbogsWa0rc6QWw8VcIvZPp6vqQlJWRqGqXUhW174iYCaW+S
         iMsDi4mqiHksfZf58qzNe0RR6DMBATR6kfE6Q5M53QZmGq4c6SUGH7ShX5ySdaHwAv9w
         2djdjiZc/WC622brJ8Dsj7SzyriMu5z3QRAxeX9rGNeDIR6KWk47cVMEov1tQsXvHHOi
         oVlzUWB22vZ1xsokVL6I/DB4CEY5QLul7U6pwu82u7QBNTw3oamYPTIj0bCUi6cPdSGZ
         CAGA==
X-Gm-Message-State: APjAAAXWz4jDhHqvQmpi9Dw6znMieSqkmnCMpFhGRAKlfrCXX15m+6D0
        LmThpshBI51pbqUVEHv2biXfw19xDhduigSZ5g0=
X-Google-Smtp-Source: APXvYqzyV+0g6YcgYh0pf1dd1V/6yGNW5OOp2cYuAA9VVcsWFyG1b2eqtqLCB13lEPVEuWnFMV4qE+rX6dzMtudL34M=
X-Received: by 2002:a9d:57cd:: with SMTP id q13mr37664016oti.327.1558575326154;
 Wed, 22 May 2019 18:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1558526487.git.gneukum1@gmail.com> <932843299b814f3a22dd176771b46be14ceefeea.1558526487.git.gneukum1@gmail.com>
 <20190522122714.GA2270@kroah.com>
In-Reply-To: <20190522122714.GA2270@kroah.com>
From:   Geordan Neukum <gneukum1@gmail.com>
Date:   Thu, 23 May 2019 01:35:02 +0000
Message-ID: <CA+T6rvEXCBukwmFS-Z4DFNoFBv9OToWwAYA2AXWBVa5mUG10zA@mail.gmail.com>
Subject: Re: [PATCH 1/6] staging: kpc2000: make kconfig symbol 'KPC2000'
 select dependencies
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 12:27 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> depends on is better than select.  There's a change to depend on UIO for
> this code already in my -linus branch which will show up in Linus's tree
> in a week or so.

Noted on both accounts. Thanks for the feedback and sorry for the
inconvenience on the latter.

> Are you sure we need MFD_CORE as well for this code?

I noticed the build issue when working locally. I was doing
something along the lines of: 'make distclean && make x86_64_defconfig',
selecting 'CONFIG_KPC2000' and 'CONFIG_UIO' via menuconfig, then
running a good old 'make'. From make, I received an error along the
lines of:

ERROR: "mfd_remove_devices"
[drivers/staging/kpc2000/kpc2000/kpc2000.ko] undefined!
ERROR: "mfd_add_devices" [drivers/staging/kpc2000/kpc2000/kpc2000.ko] undefined!
make[1]: *** [scripts/Makefile.modpost:91: __modpost] Error 1
make: *** [Makefile:1290: modules] Error 2

which appears to indicate that those two symbols are undefined. When
I looked, it appeared that those symbols were exported from the
mfd-core which is why I also threw in a select for that Kconfig
symbol. Assuming that I didn't do something silly above, I'd be happy
to submit a new patch (with only a depends on for MFD_CORE) as I
continue trying to fix up the i2c driver.

>Why hasn't that been seen on any build errors?

To be honest, I can't say that I'm familiar with all of the different
build bots out there so I can't even begin to speculate on that one.
If someone could point me in the right direction there, I'd be happy
to investigate further.

Thanks again for your feedback all,
Geordan Neukum
