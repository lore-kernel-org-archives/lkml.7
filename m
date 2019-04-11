Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D82C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC0B2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfDKI2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:28:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:59068 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbfDKI2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:28:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BF575AC69;
        Thu, 11 Apr 2019 08:28:03 +0000 (UTC)
Message-ID: <1554964555.21725.14.camel@suse.com>
Subject: Re: [PATCH] usb/hcd: Send a uevent signaling that the host
 controller has died
From:   Oliver Neukum <oneukum@suse.com>
To:     Raul E Rangel <rrangel@chromium.org>, linux-usb@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>, djkurtz@chromium.org,
        Dmitry Torokhov <dtor@chromium.org>, groeck@chromium.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Roger Quadros <rogerq@ti.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20190410203520.248158-1-rrangel@chromium.org>
References: <20190410203520.248158-1-rrangel@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 11 Apr 2019 08:35:55 +0200
Mime-Version: 1.0
X-Mailer: Evolution 3.26.6 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mi, 2019-04-10 at 14:35 -0600, Raul E Rangel wrote:
> This change will send a CHANGE event to udev with the DEAD environment
> variable set when the HC dies. I chose this instead of any of the other
> udev events because it's representing a state change in the host
> controller. The only other event that might have fit was OFFLINE, but
> that seems to be used for hot-removal.
> 
> By notifying user space the appropriate policies can be applied.
> e.g.,
>  * Collect error logs.
>  * Notify the user that USB is no longer functional.
>  * Perform a graceful reboot.

Could you please make sure this type of event is shared with other
subsystems whose devices can "die"?
It looks to me like SCSI offline should for example create the
same event. This kind of thing needs to be documented.

	Regards
		Oliver

