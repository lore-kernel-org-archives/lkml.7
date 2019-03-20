Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE0AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E831E2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553073114;
	bh=7wRoTF/KVY5LeUVkKBqgz/MW2OyKOhZvyph2zQ8fDcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0utwEc6Q4cuny5rqcoo7VIEgQAdISKI2dZBVMu8wU8syNYweuwyQcpbfPa5Fuh6VY
	 valjoDsL3h4A8RG3e1EDDNBAvdwu+/PDYa/k2VIHmJWXOb7IiiW/MFv0Um+LUmj6j9
	 87wPxVOf7YQm8Um71jRViSbjeRdePg1D6q9+Lo18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfCTJLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:11:52 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38975 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfCTJLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:11:52 -0400
Received: by mail-lf1-f65.google.com with SMTP id m13so1285721lfb.6;
        Wed, 20 Mar 2019 02:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=btOMT7QRkuhWVpua4gKLUAPZD0OivMtG3xPDwW9giK8=;
        b=LPNU4tL+87hwzB5knX8VwnK3CsAkimZl1kk/6tS7JPYgURzyaWHQze4VL94lxL5Vy8
         G0ZK4gwVigRpCp5OqvS8mroxp3/SsTHHn1bdY6EAOji/Tg5J6OrILiEIvlL6AndOX67h
         8WCEtMsJZt6yZePZjbOoJfmWdTB3/AOrGObXvcimlu+5QCogIBNPE7dbaNsof79adTpR
         vif/ZNnSWFd/v4iWSPLQSNe5I1pe4BMfhBaw4rSBThXHPzrIBcB+PWgF/1xo4yPpitHM
         /+1PSz63v8GlwvuDfUIpQpGx+a05ErnguwB55XcuC20vo2YeN3XcBrJ54zLWE9coQRb2
         owzA==
X-Gm-Message-State: APjAAAWRk5fIuWOf3ZLQUzuhKqTDKvlerwAtEkvGZB2WZQkqcG84krzu
        1M5v6Fuyp9TU9wB6A3G7fyo=
X-Google-Smtp-Source: APXvYqzCKrRNkV+mlfgz8K665TCN7eOFvEwxQY9TyTQs1kZWXU7/Xcm8LaNcK3B67pnrJIOjGex9gA==
X-Received: by 2002:ac2:4343:: with SMTP id o3mr5645129lfl.129.1553073110033;
        Wed, 20 Mar 2019 02:11:50 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id u142sm257582lff.14.2019.03.20.02.11.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 02:11:49 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1h6XGC-0005rF-RY; Wed, 20 Mar 2019 10:11:44 +0100
Date:   Wed, 20 Mar 2019 10:11:44 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>, Oliver Neukum <oneukum@suse.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: cp210x: Fix GPIO in autosuspend
Message-ID: <20190320091144.GE15782@localhost>
References: <20190319131409.GL6124@localhost>
 <20190217175901.3986-1-pados@pados.hu>
 <1550481432.11088.4.camel@suse.com>
 <20190319103659.GA3178@localhost>
 <1552994106.14757.34.camel@suse.com>
 <b01d128ac25cdd574856b53d9483cb73@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b01d128ac25cdd574856b53d9483cb73@pados.hu>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 05:19:24PM +0000, Karoly Pados wrote:
> >> On Di, 2019-03-19 at 11:36 +0100, Johan Hovold wrote:

> > This patch just added the missing auto-resume handling, but, yeah,
> > there may be devices out there for which things may get out of sync if
> > they lose state over suspend. I think Karoly confirmed this wasn't the
> > case with cp210x.
> 
> The way I tested this is very simple: I just toggled an output pin. If
> the device would lose its state during suspend, then the pin state
> would return to its factory default as soon the it went into suspend.
> Since the LED stayed stable over suspend (I connected an LED), it
> seems these devices don't lose state. I did not, however, test all
> device state in detail to see if every setting remained. I cannot
> vouch for whether *all* state is retained.

I think your test should be sufficient.

Thanks,
Johan
