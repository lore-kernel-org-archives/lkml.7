Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC90C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F54420857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553001259;
	bh=OqrOn8oR5YlYzB0GV/2xChkAM8KCfCYd/N5I685HNdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2P0Z8Fvn4+qL0hi0rynrOUNq/8+u37NGCmiCES2HMyq4hovcui/aVVX41S51D/oBV
	 zTODOd02B5EyLmFf1zW5wDeFqJH5IGc5wdlfTGfWN37uPqpVWSsI3b8R39WOUvpNK/
	 ZzSkil7kOzp+urD7/RcafXXxx9jOd9ZJnYGjhoIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfCSNOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:14:18 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40819 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727271AbfCSNOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:14:16 -0400
Received: by mail-lf1-f66.google.com with SMTP id u68so14346447lff.7;
        Tue, 19 Mar 2019 06:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6eSkc0g7S+et6RRCsMEO44e6Rl667BjhMw1fjXjyZ3A=;
        b=hu9Zgdyf0wUibIgsiRjvdVx0bgDWLJfaDOqBbH79q3Zl5gEAy06cUugvZ+tSLMNSKN
         o7a7QDJ0evaQn+97EJT1LRrAp+ISgYu/PkAK3lEw/ZCXQDJgMVFkZVjTdTVFfVX2bQza
         s2GK/Hd4iIMxKAnYjIRgpsuNNl6EAoJNzURJDDUqVy5aC4v+UkE9M0jhKvKq6n413HPw
         nNg/TFlgpJ1LqNmiNMpj9jyphsj/lWXCZW7V5AD1fyGOKuQQUtifAzRn8xPJWqfdDuam
         +P6T0dclPc7Ns/RgSncYCmYfa2RIDQ9EKYi+dIcgJULYLwWL7z9TFbh2gOVKPAztBKzU
         ZY8g==
X-Gm-Message-State: APjAAAW4LymCvWb/0iscwbIXqg5Qx02d5mLzs2C+Yuu3JXyrAGrkSEgp
        hyrkC0hW0hRbMoGbyvHHdEbkys4Z
X-Google-Smtp-Source: APXvYqzbv/jjqnaoiGN9mbne3PU+E9ABRyQpDyHtey2w/k3LoceQ67XoUdVL6OXsMJiwHut9ohtfrw==
X-Received: by 2002:a19:6d01:: with SMTP id i1mr12744959lfc.118.1553001254446;
        Tue, 19 Mar 2019 06:14:14 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id g24sm2806843lja.75.2019.03.19.06.14.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 06:14:13 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1h6EZF-0001en-3g; Tue, 19 Mar 2019 14:14:09 +0100
Date:   Tue, 19 Mar 2019 14:14:09 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Karoly Pados <pados@pados.hu>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: cp210x: Fix GPIO in autosuspend
Message-ID: <20190319131409.GL6124@localhost>
References: <20190217175901.3986-1-pados@pados.hu>
 <1550481432.11088.4.camel@suse.com>
 <20190319103659.GA3178@localhost>
 <1552994106.14757.34.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552994106.14757.34.camel@suse.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 12:15:06PM +0100, Oliver Neukum wrote:
> On Di, 2019-03-19 at 11:36 +0100, Johan Hovold wrote:
> > On Mon, Feb 18, 2019 at 10:17:12AM +0100, Oliver Neukum wrote:
> > > On So, 2019-02-17 at 18:59 +0100, Karoly Pados wrote:
> > > > Current GPIO code in cp210x fails to take USB autosuspend into account,
> > > > making it practically impossible to use GPIOs with autosuspend enabled
> > > > without user configuration. Fix this like for ftdi_sio in a previous patch.
> > > > Tested on a CP2102N.
> > > your patch is looking good to me, but I am afraid there are issues.
> > > How do the GPIO lines on the device interact with USB reset and system
> > > suspend?
> > 
> > What was your concern here, Oliver?
> 
> If you have a device resetting or losing power (for reset_resume) the
> GPIO lines will revert to the default. But that change is not reported
> to user space, is it?

This driver doesn't support reset_resume() so that shouldn't be an
issue, right? We'd disconnect (deregister the gpiochip) and re-probe
instead.

> So the original patch is correct, but there are more situations rather
> than suspend which could trigger the problem.

This patch just added the missing auto-resume handling, but, yeah,
there may be devices out there for which things may get out of sync if
they lose state over suspend. I think Karoly confirmed this wasn't the
case with cp210x.

Johan
