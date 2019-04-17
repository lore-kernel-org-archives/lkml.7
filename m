Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E76C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07AD4206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbfDQUUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:20:24 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42366 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDQUUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:20:24 -0400
Received: by mail-io1-f66.google.com with SMTP id c4so107596ioh.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 13:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O4pCrnxLXWayh/eepptBQW+yvPCJPF417E+knnis96Q=;
        b=hyzX99O4UMvWCuMPzJx7srqK2VqqPtqrzfHblZ9AXl4AMk+47axf8WS/wgLqgMS5UH
         RyXQYIA6h5/QC3NIrPvHhKaqKiELxYw+/TG4fmNbcUGu36uHHP2hLiywY+fRX8Cw+PJI
         jQ3xHfPYp5IOn4sOj3/7TMt9ztAm/5ZingEQ24yh4pRulx8M41nD5Kisicz22ttrmx+w
         N6sOplEvdw5K7TdBXMaygLqbrd1cDxNZsfcyolMwXX3xsOn+Fa2q3965POYMC7bQKyPy
         cis1eErTPulO3T+FxD3qGi8vGfqpQ8aJjTsoPeuEU5vUjikLqY2+ntY1NT3Olgke4mJ2
         Ok9A==
X-Gm-Message-State: APjAAAU4OwOGHT53TaULcWemPE3QPlxGkyod49sfDU6nkY55GKM7UjHK
        4JPj1Lq8YtLHEbCnduahS8ipyg==
X-Google-Smtp-Source: APXvYqz+me+cP4Ktrbn6nkL/GPEtxv/ewXmQLOGL4/VoTgWPqzsYP67GYpTqH2mQkfAdAue/TZ4TwA==
X-Received: by 2002:a5d:84d9:: with SMTP id z25mr1273052ior.301.1555532423359;
        Wed, 17 Apr 2019 13:20:23 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id t67sm1767160ita.35.2019.04.17.13.20.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Apr 2019 13:20:22 -0700 (PDT)
Date:   Wed, 17 Apr 2019 14:20:17 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, groeck@chromium.org, oneukum@suse.com,
        djkurtz@chromium.org, zwisler@chromium.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dmitry Torokhov <dtor@chromium.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Raul Rangel <rrangel@chromium.org>
Subject: Re: [PATCH v3] usb/hcd: Send a uevent signaling that the host
 controller had died
Message-ID: <20190417202017.GA204974@google.com>
References: <20190417190316.10032-1-rrangel@chromium.org>
 <Pine.LNX.4.44L0.1904171511510.1400-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1904171511510.1400-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 03:14:14PM -0400, Alan Stern wrote:
> On Wed, 17 Apr 2019, Raul E Rangel wrote:
> 
> > +/* Workqueue routine for when the root-hub has died. */
> > +static void hcd_died_work(struct work_struct *work)
> > +{
> > +	struct usb_hcd *hcd = container_of(work, struct usb_hcd, died_work);
> > +	char *env[] = {
> > +		"ERROR=DEAD",
> > +		NULL
> > +	};
> 
> This can now be
> 
> 	static const char *env[] = ...
> 
> right?  There's no need for the array to be reinitialized every time 
> the routine runs.
I originally tried to make it const, but kobject_uevent_env doesn't
declare the parameter as const, so the compiler yelled at me. I could
make it static, but a static without a const makes me wary. I can add it
if you think it's fine.
> 
> Alan Stern
> 
