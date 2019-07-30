Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8517BC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 06:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590C4206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 06:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="DjuNVMhM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfG3G4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 02:56:49 -0400
Received: from chill.innovation.ch ([216.218.245.220]:57120 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbfG3G4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 02:56:49 -0400
Date:   Mon, 29 Jul 2019 23:56:48 -0700
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 600D3640134
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1564469808;
        bh=Od2NAmDDJDdKzTDbZFvssSbYkExTHaj6TafsL+/oUOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DjuNVMhMu7SHWoeMq6zE0i6PG8YYfxRz+7wFUy73qJh8QhtnrtfzovnCMHrjm2yKz
         AKrtNOELoUzReoYWHxEEMFcgGwHWOzxYnfh0pDzlWV6rxPasKqMeGY5QXHWBOb7RiD
         RdkLg4q6CTHyGwNwOCUtpcPmbk9g3wzcI0mdOGz/DRO4XP96TMCbdQdi1Jvy/IrG/1
         naPhI9BGsWJvSXwcqvuyb9xew5IKkj+twXxdDT3xxfbLmzkBcSFzBbWiRoZ91MkGz2
         yCuICdJUaUoS4U/08SxrnZsD86Qcdz7OtIbRPfsxhbKt0WpaJ/TmIx+qRj9cUsqlC1
         3E5yYoM+KaSZQ==
From:   "Life is hard, and then you die" <ronald@innovation.ch>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mao Wenan <maowenan@huawei.com>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: applespi - register touchpad device
 synchronously in probe
Message-ID: <20190730065648.GA20206@innovation.ch>
References: <20190721070523.24695-1-ronald@innovation.ch>
 <20190729132203.GB1201@penguin>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190729132203.GB1201@penguin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi Dmitry,

On Mon, Jul 29, 2019 at 03:22:03PM +0200, Dmitry Torokhov wrote:
> Hi Ronald,
> 
> On Sun, Jul 21, 2019 at 12:05:23AM -0700, Ronald Tschalär wrote:
> > This allows errors during registration to properly fail the probe
> > function.
> > 
> > Doing this requires waiting for a response from the device inside the
> > probe function. While this generally takes about 15ms, in case of errors
> > it could be arbitrarily long, and hence a 3 second timeout is used.
> > 
> > This also adds 3 second timeouts to the drain functions to avoid the
> > potential for suspend or remove hanging forever.
> 
> Question: is it possible to read command response synchronously as well?
> I.e. I was wondering if we could add 2 (or 1?) more read xfers for the
> actual result that is coming after the status response, and then we
> could use spi_sync() to send the command and read the whole thing.

Yes'ish. But you still need to wait for the GPE to know when to read
the response, and while you're doing so any number of keyboard and
trackpad events may arrive (i.e. you may need to do any number of read
xfers). I suppose those events could all just be discarded, though. So
something like this:

    assemble-info-cmd(write_msg)
    spi_sync(write_msg)
    
    while (1) {
        wait_event_timeout(wait_queue, gpe_received, timeout)
        spi_sync(read_msg)
        if (is-info-cmd-response(read_msg))
            break
    }

and also modify the gpe-handler to wake the wait_queue instead of
issuing an spy_async() while doing the above.

I guess the advantage would certainly be the need to avoid the
spi-flushing in case of a timeout, at the expense of some slight
duplication of some of the received-message handling logic (would
refactor make most re-usable, of course).

So would this be the preferred approach then?


  Cheers,

  Ronald

