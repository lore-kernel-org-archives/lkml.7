Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084BCC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 06:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C183F2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 06:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552892095;
	bh=ZGmUs5uovJT/lgGLDGQXleGpqS32VGMXzLnhvJPKqmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jaCG+abLrbAcMG5FAJ4HgXoNKF1qt7xz5JLfG81AFT0E1ORVADgrcHIkp4FNO4SFS
	 QAsakYxTmhip02qUtk0ZyA9QYMhKCwhC3o0Opzq+1JMbsBSMpPm5dWDBHHQi5dCtD4
	 jUJtzm43Mc4VkttLAGHQ95wpjp7Tg7AlMRmhLrf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfCRGyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 02:54:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:42808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbfCRGyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 02:54:53 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1CF920828;
        Mon, 18 Mar 2019 06:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552892093;
        bh=ZGmUs5uovJT/lgGLDGQXleGpqS32VGMXzLnhvJPKqmU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aWB2Vl05jhG4H45XQ0PlfrmUQ0ilkUwlVC7I1I9Uo4GQ87ayWt8TAm/whWgiuU8v2
         7eirbzqiXLRTXyfhHcgdJWwtY7IFMACxO2AZTm8bPgmc/MYD8Eo/YXio2xVz0XvP74
         qOroZPa+pLIxgi2KWN/G4gGWXqiMte4Z8Rxm2sCw=
Date:   Mon, 18 Mar 2019 07:54:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     devel@driverdev.osuosl.org,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Spencer E . Olson" <olsonse@umich.edu>
Subject: Re: [PATCH] staging: comedi: ni_mio_common: Fix divide-by-zero for
 DIO cmdtest
Message-ID: <20190318065426.GA11577@kroah.com>
References: <20190304143354.4964-1-abbotti@mev.co.uk>
 <a8c166a9-5362-227d-bd57-f14b2932f5a1@mev.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8c166a9-5362-227d-bd57-f14b2932f5a1@mev.co.uk>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 06:57:17PM +0000, Ian Abbott wrote:
> On 04/03/2019 14:33, Ian Abbott wrote:
> > `ni_cdio_cmdtest()` validates Comedi asynchronous commands for the DIO
> > subdevice (subdevice 2) of supported National Instruments M-series
> > cards.  It is called when handling the `COMEDI_CMD` and `COMEDI_CMDTEST`
> > ioctls for this subdevice.  There are two causes for a possible
> > divide-by-zero error when validating that the `stop_arg` member of the
> > passed-in command is not too large.
> > 
> > The first cause for the divide-by-zero is that calls to
> > `comedi_bytes_per_scan()` are only valid once the command has been
> > copied to `s->async->cmd`, but that copy is only done for the
> > `COMEDI_CMD` ioctl.  For the `COMEDI_CMDTEST` ioctl, it will use
> > whatever was left there by the previous `COMEDI_CMD` ioctl, if any.
> > (This is very likely, as it is usual for the application to use
> > `COMEDI_CMDTEST` before `COMEDI_CMD`.) If there has been no previous,
> > valid `COMEDI_CMD` for this subdevice, then `comedi_bytes_per_scan()`
> > will return 0, so the subsequent division in `ni_cdio_cmdtest()` of
> > `s->async->prealloc_bufsz / comedi_bytes_per_scan(s)` will be a
> > divide-by-zero error.  To fix this error, call a new function
> > `comedi_bytes_per_scan_cmd(s, cmd)`, based on the existing
> > `comedi_bytes_per_scan(s)` but using a specified `struct comedi_cmd` for
> > its calculations.  (Also refactor `comedi_bytes_per_scan()` to call the
> > new function.)
> > 
> > Once the first cause for the divide-by-zero has been fixed, the second
> > cause is that `comedi_bytes_per_scan_cmd()` can legitimately return 0 if
> > the `scan_end_arg` member of the `struct comedi_cmd` being tested is 0.
> > Fix it by only performing the division (and validating that `stop_arg`
> > is no more than the maximum value) if `comedi_bytes_per_scan_cmd()`
> > returns a non-zero value.
> > 
> > The problem was reported on the COMEDI mailing list here:
> > https://groups.google.com/forum/#!topic/comedi_list/4t9WlHzMhKM
> > 
> > Fixes: f164cbf98fa8 ("staging: comedi: ni_mio_common: add finite regeneration to dio output")
> 
> Greg,
> If it's not too late, it would be nice if the following "Reported-by:" and
> "Tested-by:" lines could be added (or I can resend with these lines included
> if necessary).  It's no big deal if this is too late.  I'll live with it.
> Thanks.
> 
> Reported-by: Ivan Vasilyev <grabesstimme@gmail.com>
> Tested-by: Ivan Vasilyev <grabesstimme@gmail.com>

Not too late, I'll go add it now, thanks.

greg k-h
