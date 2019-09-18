Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCA8C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F182218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRJPtt+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbfIROT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 10:19:59 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38706 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfIROT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 10:19:58 -0400
Received: by mail-io1-f68.google.com with SMTP id k5so16559931iol.5;
        Wed, 18 Sep 2019 07:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xb5vsk4ByYCljpamUYnVxquRDCd6LrWhyHEatUcXjEM=;
        b=DRJPtt+UbulKRjdneJ2UT4q1JUjML/4NsZiGrCwo2c7Xb4USN12uvqFXWVERs96Cwq
         agE93np1t9X86TTE3G3P/eiIpuJ8OVpxc5wmz4GnMJZUDOw7ENNJN+h5WdSFNN3bkeV+
         labaSZQVeOaK7iryprDPXELi8wPSNN4h3+n4FES1yVE1urQHPYKpw2lXg8hKDj7p2xHf
         C4TrKYNi6OB2lZ2c6YOVlayMbxold6kTUOZXMwtOnmue3FRXI8uClbqExAb7bbLXJMH1
         1rnyrJKLJENJq2Q4WFOVRPKCLPB9Rfn7qBOm6wKwq8XLwCg9IQ6zTNykhqBKtzjWLAEd
         C2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xb5vsk4ByYCljpamUYnVxquRDCd6LrWhyHEatUcXjEM=;
        b=GJ73Jn4sR9gsM51TXUfHTh8kCuztXC/ttsQQkGGO4z+/oDfJTUKkN5gmV3d251sC8O
         QYyB2faiVhvqmdxCkhK7MWmd8lg5bH+9k3djtT8hvG7oHh+C9jMw3Xm7uzuKLyyzZIhC
         Daya9eY+ArQQJfqiucfyhCEClfipiY8V0ab4LNgZpXSUZ//RWB0agLLo0bIw4xFFs2RW
         GV2TzVvCd3FARK3HfR2Vdbc48JXrMI9zUx5xc/34PQmNKC2A2XLMF4oBsrkPEuuMpJNT
         Dv8/wuLYLEQ0WcsALSf1xV7/bz3SxIDYt49zAzdbVueGKGsmp5qbe8tv7knNQSxVIPda
         R9Ug==
X-Gm-Message-State: APjAAAXQtiM+Fs0D7EIKfRrLbb7FJLP9i0NHVjWmy6wB5Qpa+bmb9lSG
        tj4BantAMO1JsledBT7meINvGv6/9fCAcKxlm7I=
X-Google-Smtp-Source: APXvYqzMQMLbBq8xhQ3ml0Zr84HLMY5zqvHRHb+h9kEWI3tjwCDwFV3H74tFrd3astszgsxxFHaTt7KjUdOULfAqCpk=
X-Received: by 2002:a6b:f319:: with SMTP id m25mr5043536ioh.33.1568816398022;
 Wed, 18 Sep 2019 07:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <1568626884-5189-1-git-send-email-peng.fan@nxp.com>
 <1568626884-5189-2-git-send-email-peng.fan@nxp.com> <20190917183115.3e40180f@donnerap.cambridge.arm.com>
 <CABb+yY2CP1i9fZMoPua=-mLCUpYrcO28xF5UXDeRD2XTYe7mEg@mail.gmail.com> <20190918104347.285bd7ad@donnerap.cambridge.arm.com>
In-Reply-To: <20190918104347.285bd7ad@donnerap.cambridge.arm.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 18 Sep 2019 09:19:46 -0500
Message-ID: <CABb+yY3drgYHk2_SZMgGhgSisB7wMVKFSx8VVabCcXkGByvgwg@mail.gmail.com>
Subject: Re: [PATCH V6 1/2] dt-bindings: mailbox: add binding doc for the ARM
 SMC/HVC mailbox
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 4:44 AM Andre Przywara <andre.przywara@arm.com> wro=
te:

>
> > which needs 9 arguments to work. The fact that the fist argument is
> > always going to be same on a platform is just the way we use this
> > instruction.
> >
> > > We should be as strict as possible to avoid any security issues.
> > >
> > Any example of such a security issue?
>
> Someone finds a way to trick some mailbox client to send a crafted messag=
e to the mailbox.
>
What if someone finds a way to trick the block layer to erase 'sda' ?
 That is called "bug in the code".
It does happen in every subsystem but we don't stop implementing new
features .... we write flexible code and then fix any bug.


> Do you have any example of a use case where the mailbox client needs to p=
rovide the function ID?
>
FSL_SIP_SCMI_1/2 ?
But that is not the main point, which is to be consistent (not
ignoring first argument because someone may find a bug to exploit) and
flexible.


> > > The firmware certainly knows the function ID it implements. The firmw=
are controls the DT. So it is straight-forward to put the ID into the DT. T=
he firmware could even do this at boot time, dynamically, before passing on=
 the DT to the non-secure world (bootloader or kernel).
> > >
> > > What would be the use case of this functionality?
> > >
> > At least for flexibility and consistency.
>
> I appreciate the flexibility idea, but when creating an interface, especi=
ally a generic one to any kind of firmware, you should be as strict as poss=
ible, to avoid clashes in the future.
>
I really don't see how there can be clashes with more complete and
flexible implementation.

Thanks.
