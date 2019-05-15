Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72854C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432E32084A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+UZ57l1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfEOJP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 05:15:29 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34258 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfEOJP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 05:15:29 -0400
Received: by mail-oi1-f195.google.com with SMTP id v10so1309701oib.1;
        Wed, 15 May 2019 02:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8l+XsAWtzDO+iVF8T+43qDNahyoPM+IYYP74fL9auB0=;
        b=p+UZ57l126N1SmeVU3MI6F+D8dLYxvuEP2cSlhSnFkK2cWvQzhBrKHTv/XXifW9cJp
         n9xvtEVQnB8G8b1fE36eBGkSIkJvqTUjsDQ1j2kXyW5IGKrrGuT0TLiA/Sm/yLAs6xM9
         HYVfVeWmueaGTSKGcYzDKlQaf98U4NXxkLZEe7NNsx8x+1pafuZeH3Cx1is+pub2tv0A
         3cHcEfTyE+jmGNmTpLq0sNKUo3bKIiZkR65Dh+LwGE3jCSEs4X1I1JFjROZ1BvXQ16Pj
         tr1zzZ0HqoUurxgMJbwXDi5lvJ88/oBP0H0Y1/RolqAMPOOhmNwOJzG6XvKGvyMuX8t2
         IG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8l+XsAWtzDO+iVF8T+43qDNahyoPM+IYYP74fL9auB0=;
        b=EvfFmmn+I81iuFRlnM4FzcDDvNwiKk3u0M7ijxZZFRapWdz95thJRzREtE4QNL02qZ
         nYMPBr5U5nD3c/aweIbKAGZEAgtD0r7qIBqbIDB7wffIyca+luYlYso8wkmxu997boDL
         LJTRIoBrVCOdO6WdINWooTx3wODWnQcxPwWJ2EW+yn1Mnk+Rc0zT077psWeD62hY6ovw
         Zsz20CT/pHUWHjnDtoldm51oW94lOWjPdcHQTP8KcY6BVxxfYooFfNokxHV1whLsuKAU
         RU6svvO6pqgNEyeDxxL+lfQlm5oWeLqDGpVpgOCtaeFdpmkjMGQnWqni2OLJNkVPhIIl
         G1Gg==
X-Gm-Message-State: APjAAAXbwbEKts34RFG9yty7F+NMDtonnyUsEWGjm7o4B72ByKhZQ6Rv
        hpRO3LX9Yb6ffGI9H+jnNfI4ZZUHXnsI0ju8s5k=
X-Google-Smtp-Source: APXvYqxTdaRgRjYNW4hVS2P6W8+KG+Z6TQ1MlwfaunbmBTnAF75Npc2yQcnDpFb4TJhy/VAo5mQgzJafRp494U3hWMI=
X-Received: by 2002:aca:df09:: with SMTP id w9mr5504644oig.94.1557911728083;
 Wed, 15 May 2019 02:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <a8bd7d19de25b799098659334de7e19670a806fc.1557379676.git.liuhhome@gmail.com>
 <20190514073457.GI9651@localhost>
In-Reply-To: <20190514073457.GI9651@localhost>
From:   hhome liu <liuhhome@gmail.com>
Date:   Wed, 15 May 2019 17:15:16 +0800
Message-ID: <CAHshu7NGmPO+7KjjPBtJT77vTobk0m7iX1FPnMfzh_G4SCKkRw@mail.gmail.com>
Subject: Re: [PATCH] tty: serial_core: Fix the incorrect configuration of baud
 rate and data length at the console serial port resume
To:     Johan Hovold <johan@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        baolin.wang@unisoc.com, Baolin Wang <baolin.wang@linaro.org>,
        jslaby@suse.com,
        =?UTF-8?B?5YiY5bKa5riFIChMYW5xaW5nIExpdSk=?= 
        <lanqing.liu@unisoc.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, chunyan.zhang@unisoc.com,
        orson.zhai@unisoc.com, zhang.lyra@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Hovold <johan@kernel.org> =E4=BA=8E2019=E5=B9=B45=E6=9C=8814=E6=97=A5=
=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=883:35=E5=86=99=E9=81=93=EF=BC=9A

>
> On Thu, May 09, 2019 at 01:42:39PM +0800, Lanqing Liu wrote:
> > When userspace opens a serial port for console, uart_port_startup()
> > is called. This function assigns the uport->cons->cflag value to
> > TTY->termios.c_cflag, then it is cleared to 0. When the user space
> > closes this serial port, the TTY structure will be released, and at
> > this time uport->cons->cflag has also been cleared.
> >
> > On the Spreadtrum platform, in some special scenarios, like charging mo=
de,
> > userspace needs to close the console, which means the uport->cons->cfla=
g
> > has also been cleared. But printing logs is still needed in the kernel.=
 So
> > when system enters suspend and resume, the console needs to be configur=
e
> > the baud rate and data length of the serial port according to its own c=
flag
> > when resuming the console port. At this time, the cflag is 0, which wil=
l
> > cause serial port to produce configuration errors that do not meet user
> > expectations.
>
> This is actually yet another regression due to 761ed4a94582 ("tty:
> serial_core: convert uart_close to use tty_port_close") which
> incidentally removed the call to uart_shutdown() where the cflag was
> being saved precisely to avoid the problem you're describing:
>
>         ae84db9661ca ("serial: core: Preserve termios c_cflag for console=
 resume")

Yes, agree with you.

>
> Judging from a quick look it seems the xmit buf, which is released in
> that function may now be leaking too.

We haven't found this issue before, but we can try to reproduce it on
our platform.

>
> > To fix this, assigning the TTY->termios.c_cflag value to uport->cons->c=
flag
> > before the userspace closes this console serial port. It will ensure th=
at
> > the correct cflag value can be gotten when the console serial port was
> > resumed.
>
> Not sure this is the right fix, but I don't have time to look at this
> right now.

OK. Thanks for your comments.
