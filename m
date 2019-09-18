Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77D4C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEE5218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 15:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGgeI6B0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbfIRPcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 11:32:11 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33649 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfIRPcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 11:32:11 -0400
Received: by mail-io1-f65.google.com with SMTP id m11so284822ioo.0;
        Wed, 18 Sep 2019 08:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5hHyYF5L2cgk61bB7AKoE7ghGd7YLktDIb71RXFYwSY=;
        b=YGgeI6B01Qbog0Pa8A7w51DPvf6RmdRxnRonGsnP62fuwGd88IDN4UG+lpD6Ddc7xq
         M+ty3J2sAtJwaP6/ch1pJsoyndUWaw/Ub+pS5MixJO1WTrlL/g85/PgB0AqOHxZWJ5ku
         UB6/nJVXTJ4SNxqv1vkhVLB4nAr7no1B5Ux7DR973UTvJ6+Xm5eOQCi3hQryWMqWP4dL
         ggJZqKslPKINu2g/xR4e0Ot7fATqFIXXCz0oQO2mKQudImW1IKjISqfz99SjP9wc8r0j
         cy2m4J16+7lqIDur6yQhPftxjN8F7DpVh6DLNoGvCHae2IbITtYI5w12iOuM9KILqSX0
         yPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5hHyYF5L2cgk61bB7AKoE7ghGd7YLktDIb71RXFYwSY=;
        b=qe2eXOVczynb5tFNJNHPDxL0i2o5xiNcVFcQuW2FGmMFQ6wb53bRnPr/yJEzb5+kN1
         kgLLWvM5Gh+wFt7vc9jefHQiKJft3h53litQcQ76TcrKuzwU58DdN01OSHVeQ0Uisty5
         8bx63o9WlGcD8nalCQWv937dyu6yc4ytrHeVrdz+iNJBlfwCwYpCIIJWyI3AmEUpCkSi
         /9GZ+rZfN7Ot92yDO7gPiGSbbqt2DAmRJIvGPdXcGkziLA/PonLYpV1d+kdRwhzfUFrA
         szdO4TApgt5Z+fjNnI3dlcAVPZGM+SbGdEin1a8phHMClcZzMaU50CMu3Ie9lUrO0R+I
         M/Lg==
X-Gm-Message-State: APjAAAX0KKmgAsIOtltv78EpVCOR3I8YwGxWbzI5FPWWP3AOM62OtCA6
        FUB4u/C79vNJCFPHXR9Axv55p0vATU/hzlzgXclSJOoK
X-Google-Smtp-Source: APXvYqwk4f9W7fDif2wT0qTh3jeOw9SsTKj3pGjsr5Z9tYewP5UlYXoB5pDU86HPHtHxIvu0cXMLbgMMc0CrPu6wwAI=
X-Received: by 2002:a5e:c749:: with SMTP id g9mr5644589iop.7.1568820728787;
 Wed, 18 Sep 2019 08:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <1568626884-5189-1-git-send-email-peng.fan@nxp.com>
 <1568626884-5189-2-git-send-email-peng.fan@nxp.com> <20190917183115.3e40180f@donnerap.cambridge.arm.com>
 <CABb+yY2CP1i9fZMoPua=-mLCUpYrcO28xF5UXDeRD2XTYe7mEg@mail.gmail.com>
 <20190918104347.285bd7ad@donnerap.cambridge.arm.com> <CABb+yY3drgYHk2_SZMgGhgSisB7wMVKFSx8VVabCcXkGByvgwg@mail.gmail.com>
 <20190918154654.6fb7e7f5@donnerap.cambridge.arm.com>
In-Reply-To: <20190918154654.6fb7e7f5@donnerap.cambridge.arm.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 18 Sep 2019 10:31:57 -0500
Message-ID: <CABb+yY3gJpK5ghS1u-e=f-msO+=oVvX=zDNj3Jg2i0-uJHrLiA@mail.gmail.com>
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

On Wed, Sep 18, 2019 at 9:46 AM Andre Przywara <andre.przywara@arm.com> wro=
te:
>
> On Wed, 18 Sep 2019 09:19:46 -0500
> Jassi Brar <jassisinghbrar@gmail.com> wrote:
>
> Hi,
>
> > On Wed, Sep 18, 2019 at 4:44 AM Andre Przywara <andre.przywara@arm.com>=
 wrote:
> >
> > >
> > > > which needs 9 arguments to work. The fact that the fist argument is
> > > > always going to be same on a platform is just the way we use this
> > > > instruction.
> > > >
> > > > > We should be as strict as possible to avoid any security issues.
> > > > >
> > > > Any example of such a security issue?
> > >
> > > Someone finds a way to trick some mailbox client to send a crafted me=
ssage to the mailbox.
> > >
> > What if someone finds a way to trick the block layer to erase 'sda' ?
>
> Yes, the Linux block driver control the whole block device, it can do wha=
tever it wants.
>
Sorry, it doesn't make any sense.

> >  That is called "bug in the code".
> > It does happen in every subsystem but we don't stop implementing new
> > features .... we write flexible code and then fix any bug.
> >
> >
> > > Do you have any example of a use case where the mailbox client needs =
to provide the function ID?
> > >
> > FSL_SIP_SCMI_1/2 ?
>
> Huh? Where does the SCPI or SCMI driver provide this? Those clients don't=
 even provide any arguments. Adding some would defeat the whole point of ha=
ving this mailbox in the first place, which was to provide a drop-in replac=
ement for a hardware mailbox device used on other platforms.
>
SCPI/SCMI implementation is broken. I did NAK it.
With the 'smc' mailbox you may get away without have to program the
channel before transmit, but not every controller is natively so.

> > But that is not the main point, which is to be consistent (not
> > ignoring first argument because someone may find a bug to exploit) and
> > flexible.
>
> Please read the SMCCC[1]: The first argument is in r1/w1/x1. r0/w0 is the=
 function ID, and this is a specific value (fixed by the firmware implement=
ation, see Peng's ATF patch) and not up to be guessed by a client.
>
The first argument of smc call is the function-id
  arm_smccc_hvc(function_id, arg0, arg1, arg2, arg3, arg4, arg5, 0, &res);


>
> That's why I think the function ID (which is part of the SMCCC protocol, =
not of the mailbox service!) should just be set in the controller DT node a=
nd nowhere else.
>
Actually that is the very reason func-id should be a client thing and
passed via client's DT node :)
It is general understanding that protocol specific bits should not be
a part of controller driver, but the client(protocol) driver.

Page-7 Function-ID specifies :-
1) The service to be invoked.
2) The function to be invoked.
3) The calling convention (32-bit or 64-bit) that is in use.
4) The call type (fast or yielding) that is in use.

Even if we turn blind to 2,3 & 4, but (1) shouts like a runtime property.

Thanks.
