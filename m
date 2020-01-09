Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF1BC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F1D2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbLb1Qsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgAIJXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:23:05 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46213 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbgAIJXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:23:05 -0500
Received: by mail-qt1-f196.google.com with SMTP id g1so5255467qtr.13;
        Thu, 09 Jan 2020 01:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZNEWexwbWV4/Y4n8YL366sXiCK+ppFaR6AvdseVOio4=;
        b=LbLb1QswYWw5ps8cz68rMwsRqdWX2eZDJuRveaH0EXw0Y++v/3xqPnSzKnLCeF0Jv9
         9jcUUz7I5HwrDnnY3vBiuayKkl2EiyYrvZFNsOMRzmcovEFsjRZnp7fAKB3qIidDpzqX
         F9uDXc442EqaLD0jcLrZ4KMQw5yqkx9zeAq4BN1XIOrZJbHXKuL+78FzVy5f4JVNvQJn
         aLcsfoKWpS5sm3aKyWPf1v513yUXttPstQhT3516+XjQxpjVUHQ4sUNWBfag1UYiXCdB
         Q9EnftndOnEcP5fUN22cYubmnSInJ/C4tQKbAg9Mfr7I7QhmSteZ6/YKH9tQNPzVm+g4
         52zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZNEWexwbWV4/Y4n8YL366sXiCK+ppFaR6AvdseVOio4=;
        b=CRKYsAwwj9ZF9uwMZQcuxIrE3TzFjz95k11XvLn2Lkma69ZlK2OL176LNLZ71L2oKC
         7VbRquM3+jASk33OCzFLuKfEUbRgtEHhBqwfQCC/iEV15kKJS/EuSkDEW19YRhQ00vBG
         cytuEFuiD54quEC7HO+/n3XX9DZF98vWY07GMlMFZWxgWFNpOuEYYvizXPzGUfv1JvAu
         soXmcsnObFMje53wXqMNWSsm/XMCmoDpgLamTGX03/PSwqLEJE9EBMhwdnfTVO7DcrUK
         CT/5JnDXi6vaUq/G+VJZLbowY8NgerCQKPWy922/9HG6W4am8rDw8liOiM4ME/6tUVbs
         z+sQ==
X-Gm-Message-State: APjAAAVH5Zj3tHWfhU23l4TEMXW5Tm66J+d1c35+qam/NNCmhRCNz1Z+
        baPgdQy9cRH7ZoKP2sEhqx5ODB1EdcH4g78LJ0c=
X-Google-Smtp-Source: APXvYqyVUFN4B7S1O8D2KMogC343n3KBCaYguM8blYI5CZZ11sewM+Eiqy/YfhNHdZLFF5WB17DAeHOlDhoNn23rl9U=
X-Received: by 2002:ac8:108:: with SMTP id e8mr7374989qtg.101.1578561783936;
 Thu, 09 Jan 2020 01:23:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1578235515.git.gupt21@gmail.com> <7d7c949890c4bdb12ecc9f8b15a5c0a69b7604a8.1578235515.git.gupt21@gmail.com>
 <20200106192912.GB754821@kroah.com>
In-Reply-To: <20200106192912.GB754821@kroah.com>
From:   rishi gupta <gupt21@gmail.com>
Date:   Thu, 9 Jan 2020 14:52:52 +0530
Message-ID: <CALUj-gt6FGJEMqfsbfZUCeY3Jmz5B-xwEY9+yPUPXP9YusuOaA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] tty: documentation: abi: add ttyvs null modem
 driver sysfs nodes
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh+dt@kernel.org, jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh sorry, I will update this.

On Tue, Jan 7, 2020 at 12:59 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jan 06, 2020 at 12:51:55PM +0530, Rishi Gupta wrote:
> > The ttyvs driver exposes sysfs files to emulate various serial
> > port events. This commit document these files.
> >
> > Signed-off-by: Rishi Gupta <gupt21@gmail.com>
> > ---
> >  .../ABI/testing/sysfs-devices-virtual-tty_ttyvs        | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-devices-virtual-tty_ttyvs
> >
> > diff --git a/Documentation/ABI/testing/sysfs-devices-virtual-tty_ttyvs b/Documentation/ABI/testing/sysfs-devices-virtual-tty_ttyvs
> > new file mode 100644
> > index 0000000..69b04e0
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-devices-virtual-tty_ttyvs
> > @@ -0,0 +1,18 @@
> > +What:                /sys/devices/virtual/tty/ttyvsN/event
> > +Date:                January 2020
> > +Contact:     Rishi Gupta <gupt21@gmail.com>
> > +KernelVersion:       5.5
> > +Description:
> > +             The ttyvs driver will emulate serial port event; parity error,
> > +             framing error, overrun error, asserting or de-asserting break
> > +             conditions and ring indication when user space application
> > +             writes an event code on this sysfs file.
>
> You did not actually document any of the values read/written to this
> file, like you did in your 0/X patch description :(
>
> greg k-h
