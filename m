Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E457C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F30620693
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732241AbfDQSb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:31:59 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39661 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbfDQSb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:31:58 -0400
Received: by mail-it1-f195.google.com with SMTP id 139so6010132ita.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 11:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QE+zGVHcn4rBOczPAxq5RUTI7rRUphfsm3Pb8osPQq8=;
        b=Q0lWj+8KIR1CGIK3iRV49IvWdLk2dfYNyzSMmFWdXgpfVyxeOQoWh82qPerdYbF5M4
         xXch0ZSVQ9UStDwa3TzwSq5xFft+esvoX9x3uAcGh0bP1VKU2E3ZojP9/OoAWvR431Er
         8WdF/9VktjpTCDdTmbylDv5Z6fwcV6QhL7gzhK+9VCH2YXV+jdDYhYpG2B1LvfOOFgMp
         WamPdUE2cenErVA2hMu++yiP4YpXxxQbOPjWq4f2e+oinX1TPll6PHEcLKEwf2cJICB6
         r2jCfxTr1EAXPBeJthN/yRt3DuLer/bykQb9+vJCWAjLNGXiQ02W0tRgfsBeTWL/5csH
         ZFmw==
X-Gm-Message-State: APjAAAWTmWsS5kbrKIe4C26ovgSSLbOUc1MIuyjeGzQc0i57IpYthaTn
        LBE52KeGdtElQTbCKSIqLZaOtg==
X-Google-Smtp-Source: APXvYqwxix+g5cmcRkKRStucRzDA4g1mUK1NrnV8ZH7ST/w4wToB4nt0cMQ7X52DuKYvA6LIH7Izug==
X-Received: by 2002:a24:42ce:: with SMTP id i197mr4592itb.27.1555525917906;
        Wed, 17 Apr 2019 11:31:57 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id x10sm2711397ita.4.2019.04.17.11.31.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Apr 2019 11:31:56 -0700 (PDT)
Date:   Wed, 17 Apr 2019 12:31:52 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, groeck@chromium.org, oneukum@suse.com,
        djkurtz@chromium.org, zwisler@chromium.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        Suwan Kim <suwan.kim027@gmail.com>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Johan Hovold <johan@kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Raul Rangel <rrangel@chromium.org>
Subject: Re: [PATCH v2] usb/hcd: Send a uevent signaling that the host
 controller has died
Message-ID: <20190417183152.GA118957@google.com>
References: <20190417175300.GA74282@google.com>
 <Pine.LNX.4.44L0.1904171419260.1400-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1904171419260.1400-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 02:24:06PM -0400, Alan Stern wrote:
> On Wed, 17 Apr 2019, Raul Rangel wrote:
> 
> > > > Also where would be a good place to document this?
> > > 
> > > Documentation/ABI/ is a good start.
> > I'll add something to Documentation/ABI/testing/xhci-uevent
> 
> Your patch will apply to all host controllers, not just xhci.  The
> documentation filename should reflect this.  Perhaps "usb-uevent"?
I realized that after I had sent the email :) I'll do usb-uevent.
> 
> > > Why do you need to lock something that is "dead"?  And why is the idr
> > > lock the correct one here?
> > We need to ensure that root_hub is not null. Though I'm not sure the
> > lock is entirely necessary in this case. usb_remove_hcd stops the work
> > item before it sets the rhdev to null. The reason I picked
> > usb_bus_idr_lock was because it's the same lock that usb_remove_hcd uses
> > when setting rhdev = NULL.
> > 
> > Alan, what do you think? Should I remove the lock?
> 
> You're both right; the lock isn't needed because the work is stopped
> before the root hub gets removed.  Acquiring the lock doesn't do any
> harm, but it isn't needed so you probably should remove it.  In fact, 
> you don't even need to test for whether hcd->self.root_hub is 
> non-NULL.
Sounds good, I'll clean it up.
> 
> Alan Stern
> 
> 
