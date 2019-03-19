Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED5BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA182085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfCSL0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 07:26:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:47318 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725934AbfCSL0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 07:26:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C78CFAB76;
        Tue, 19 Mar 2019 11:26:49 +0000 (UTC)
Message-ID: <1552994106.14757.34.camel@suse.com>
Subject: Re: [PATCH v2] USB: serial: cp210x: Fix GPIO in autosuspend
From:   Oliver Neukum <oneukum@suse.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Karoly Pados <pados@pados.hu>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Tue, 19 Mar 2019 12:15:06 +0100
In-Reply-To: <20190319103659.GA3178@localhost>
References: <20190217175901.3986-1-pados@pados.hu>
         <1550481432.11088.4.camel@suse.com> <20190319103659.GA3178@localhost>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Di, 2019-03-19 at 11:36 +0100, Johan Hovold wrote:
> On Mon, Feb 18, 2019 at 10:17:12AM +0100, Oliver Neukum wrote:
> > On So, 2019-02-17 at 18:59 +0100, Karoly Pados wrote:
> > > Current GPIO code in cp210x fails to take USB autosuspend into account,
> > > making it practically impossible to use GPIOs with autosuspend enabled
> > > without user configuration. Fix this like for ftdi_sio in a previous patch.
> > > Tested on a CP2102N.
> > your patch is looking good to me, but I am afraid there are issues.
> > How do the GPIO lines on the device interact with USB reset and system
> > suspend?
> 
> What was your concern here, Oliver?

If you have a device resetting or losing power (for reset_resume) the
GPIO lines will revert to the default. But that change is not reported
to user space, is it?
So the original patch is correct, but there are more situations rather
than suspend which could trigger the problem.

	Regards
		Oliver

