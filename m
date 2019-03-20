Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E319DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B441E218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FM/iqSzl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfCTUyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:54:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33256 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfCTUyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:54:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id z6so667143wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/gjxewSVR3uzSO/xeF56lvReGGPDJMv2NWUY31AtQBs=;
        b=FM/iqSzlqdQVFzO8wnOI/srKD8Yy7qdo7Jf+JMqZo7HEmyXBQFZfL/iLYiecvQdi9b
         f5lVmjhNgoYBD11b3ZU2eTBtIBG4Xfz/puMgZdCKsFMjgKfB4lXLt7A08h+rOtEzneJw
         gck6XwktdIsgIQvnEnoxZfCMTweSJGe7R5RCXtN3kIM1KWv5xKwe+Fi2mWvtGZPyRchD
         hYAmb7QG22WG5YJh6p5qUnBCGhlBc7l7q0H+uDEKq4CamBkyzmK8VJN5/0Hl0yKh8Jzg
         6m6U1jqNzO1rmTwpy1URB7fk7RTjMHBkX850wO2PEw2bevbXNWvZpC897qN3DJHBLHPd
         txFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/gjxewSVR3uzSO/xeF56lvReGGPDJMv2NWUY31AtQBs=;
        b=Rgj6yg6FpLQUdPxaUN2jnylaSt0uII9nXYW7V87CmNhtbLxN1nrDicsj4HcIOkzQ8K
         +NqGMg8yNIDiae7gLoKP87II8W9jvZgDXHoyAWki/XEBB9lACM1Gzsz3WJaUa8k/M9Xb
         nexzxSDHME4NYrRCvo7KLxaiKIv0qfwCwflVEYuisF42zy6CZOi602U0zYGp0xPCagGP
         W1L9qG+gycrx4gbAnx5Ll1UQvq0SncbixcUO/pah+2dIGh7ybdyuN82wyMqodERAo16b
         FRiv10f7m4najtuqpDC49Unv1Eby7JvKihoGatdZAAVyG+vCyrtq6oYS+0hVRoPmGGW8
         1ZwQ==
X-Gm-Message-State: APjAAAU3Xd863E2wPGpRMI+es5sGdAZy5rNGYwU4JZ4tdqrbC2lWGWBr
        Drjq6pwdOyaY9MaTD14/+/4=
X-Google-Smtp-Source: APXvYqzptZ0XtBnwh8c9aXr5D4q1+EeCuiC/WgRd1/KW0qU8sCzALEuco/FQonaKs6XMuB+C6wfBmQ==
X-Received: by 2002:a1c:1a53:: with SMTP id a80mr188081wma.15.1553115253157;
        Wed, 20 Mar 2019 13:54:13 -0700 (PDT)
Received: from narunkot ([94.11.212.65])
        by smtp.gmail.com with ESMTPSA id r12sm5353108wrr.71.2019.03.20.13.54.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 13:54:12 -0700 (PDT)
Date:   Wed, 20 Mar 2019 20:54:02 +0000
From:   Okash Khawaja <okash.khawaja@gmail.com>
To:     Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Chris Brannon <chris@the-brannons.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        William Hubbs <w.d.hubbs@gmail.com>,
        Kirk Reiser <kirk@reisers.ca>, linux-kernel@vger.kernel.org
Subject: Re: Staging status of speakup
Message-ID: <20190320205402.394e3b6a@narunkot>
In-Reply-To: <20190319163121.5e7ab8c7@alans-desktop>
References: <20190315130035.6a8f16e9@narunkot>
        <87ef77obtg.fsf@cmbmachine.messageid.invalid>
        <20190316093543.w4i6djt5uuqtx5xr@function>
        <20190319163121.5e7ab8c7@alans-desktop>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019 16:31:21 +0000
Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:

> On Sat, 16 Mar 2019 10:35:43 +0100
> Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:
> 
> > Chris Brannon, le ven. 15 mars 2019 18:19:39 -0700, a ecrit:  
> > > Okash Khawaja <okash.khawaja@gmail.com> writes:    
> > > > Finally there is an issue where text in output buffer sometimes
> > > > gets garbled on SMP systems, but we can continue working on it
> > > > after the driver is moved out of staging, if that's okay.
> > > > Basically we need a reproducer of this issue.    
> > > 
> > > What kind of reproducer do you need here?  It's straightforward to
> > > reproduce in casual use, at least with a software synthesizer.    
> > 
> > The problem is that neither Okash nor I are even casual users of
> > speakup, so we need a walk-through of the kind of operation that
> > produces the issue. It does not have to be reproducible each time
> > it is done. Perhaps (I really don't know what that bug is about
> > actually) it is a matter of putting text in the selection buffer,
> > and try to paste it 100 times, and once every 10 times it will be
> > garbled, for instance.  
> 
> paste_selection still says
> 
> /* Insert the contents of the selection buffer into the
>  * queue of the tty associated with the current console.
>  * Invoked by ioctl().
>  *
>  * Locking: called without locks. Calls the ldisc wrongly with
>  * unsafe methods,
>  */
> 
> from which I deduce that with everyone using X nobody ever bothered to
> fix it. So before you look too hard at the speakup code you might
> want to review the interaction with selection.c too.

Hi,

This is a good point. At the moment speakup uses its own set of
selection and paste functions but I am in process of changing speakup
to use these functions from drivers/tty/vt/selection.c instead. This
lack of locking will be worth watching out for.

Thanks!
Okash
