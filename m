Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB69C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C7C21850
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387720AbfDQWlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:41:37 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52862 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQWlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:41:36 -0400
Received: by mail-it1-f193.google.com with SMTP id x132so397681itf.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 15:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tAY3tqZpNl1puGrkgrVxxOuIRHZ6LBNHbIdJbLHFZr0=;
        b=QcqMt4L2Q78w3re+kyt8jVeN/x+fbXdp8+R6Qjrm9x29tzjYY0xT/4ScnnkCSrIsXp
         x3Rh5hN4KQU2+TABTxioyMsWnqpI4MGPkoxd4GHXZm7DORUOWMc8H/+RGgTVv3KVDHFA
         Gr4C5fyQWNTVSQNRmSkCZv2Dw6u3Utzw6FsDLtQxE+Ok+L0MMfVUJv2ixZz7YHp5Ugq5
         2GWThcXvTbgfbyxbfjSs68eSPxTSr3h5BOPgKV6qoJDHblr9bI/Y5zdpCVhVPZltuTLI
         hzyXg/6iM5dtLZ2klaGlBIP1eUK9GpR2FgPXpui99eAIFaJXyH36diOi3BLfJTLvXLRU
         1ZNg==
X-Gm-Message-State: APjAAAWWukXyIvRnqdWtXNg/NCz3uU0KaLx2NfukEbaTY/FCNzXbpamm
        aPwVvb8H7a1O3hMwB7w0UU9kFQ==
X-Google-Smtp-Source: APXvYqwi7ZqoAmXMXDAm93P7ERl8NcVH2RuxzvRAA67ZR245zA+jaTDcpK6GTOSCkuHeMW4+t3h43Q==
X-Received: by 2002:a02:c510:: with SMTP id s16mr432119jam.51.1555540895170;
        Wed, 17 Apr 2019 15:41:35 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id p1sm180143itp.19.2019.04.17.15.41.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 15:41:33 -0700 (PDT)
Date:   Wed, 17 Apr 2019 16:41:29 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Oliver Neukum <oneukum@suse.com>,
        Daniel Kurtz <djkurtz@chromium.org>, zwisler@chromium.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Raul Rangel <rrangel@chromium.org>
Subject: Re: [PATCH v3] usb/hcd: Send a uevent signaling that the host
 controller had died
Message-ID: <20190417224129.GA255388@google.com>
References: <20190417202017.GA204974@google.com>
 <Pine.LNX.4.44L0.1904171635460.1400-100000@iolanthe.rowland.org>
 <CAHQZ30B3+gzuw0=tofwW3yUwJ_MkN6GWPgVg0Qq_6S2tJHkcFQ@mail.gmail.com>
 <CABXOdTcjr6zw9sceC-i_Za3uOaOVmKGFaJsyMxhLUPEhtKn_Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTcjr6zw9sceC-i_Za3uOaOVmKGFaJsyMxhLUPEhtKn_Jg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 03:23:52PM -0700, Guenter Roeck wrote:
> On Wed, Apr 17, 2019 at 3:11 PM Raul Rangel <rrangel@chromium.org> wrote:
> >
> > On Wed, Apr 17, 2019 at 04:39:23PM -0400, Alan Stern wrote:
> > >
> > > This sounds like a golden opportunity!  Submit a separate patch making
> > > the parameter to kobject_uevent_env be const (actually const char *
> > > const []), then submit this patch on top of that one.
> > So there are other parts of the code base that dynamically create their
> > array values. So by making the function take const, it breaks :(
> 
> Confused. The calling code can still be non-const. I don't see the
> parameter modified in kobject_uevent_env(), so declaring it const
> should be possible. Can you give an example of code that no longer
> works ?
static int notify_user_space(struct thermal_zone_device *tz, int trip)
{
	char *thermal_prop[5];
	int i;

	mutex_lock(&tz->lock);
	thermal_prop[0] = kasprintf(GFP_KERNEL, "NAME=%s", tz->type);
	thermal_prop[1] = kasprintf(GFP_KERNEL, "TEMP=%d", tz->temperature);
	thermal_prop[2] = kasprintf(GFP_KERNEL, "TRIP=%d", trip);
	thermal_prop[3] = kasprintf(GFP_KERNEL, "EVENT=%d", tz->notify_event);
	thermal_prop[4] = NULL;
	kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE, thermal_prop);
	for (i = 0; i < 4; ++i)
		kfree(thermal_prop[i]);
	mutex_unlock(&tz->lock);
	return 0;
}

drivers/thermal/user_space.c:48:52: error: passing 'char *[5]' to parameter of type 'const char *const *' discards qualifiers in nested pointer types [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
        kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE, thermal_prop);
                                                          ^~~~~~~~~~~~
include/linux/kobject.h:238:22: note: passing argument to parameter 'envp' here
                        const char *const envp[]);
                                          ^

http://c-faq.com/ansi/constmismatch.html explains why it fails.

Raul

> 
> Thanks,
> Guenter
> 
> > >
> > > Alan Stern
> > >
