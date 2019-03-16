Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E97C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B83218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 03:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552706803;
	bh=vcPbxEEyBQ+XwDpCFMpuUDkKFHHj0dFnmtzNBgEksKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bLDPq2JmojOKkOlriz0+OYxQb0ZQlDqCacyu3A5KnekQBid4OyvUa6fD0DPogHtbW
	 9UPuLNTPPFzECQ6JWmlYIJoIIu1sp29yH8IHbGX/9aTcy4HgJa0I8JQMhT6vVmugKC
	 4fFSPGTaJesZFyqc6cGntellbRmkDq3Do//WYdKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfCPD0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 23:26:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbfCPD0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 23:26:41 -0400
Received: from localhost (unknown [104.153.224.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3B2221872;
        Sat, 16 Mar 2019 03:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552706800;
        bh=vcPbxEEyBQ+XwDpCFMpuUDkKFHHj0dFnmtzNBgEksKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PdMUkM4qi3tR/Oa/oKAmyhq86vFXnCl99BhmoZZ8eY9gfKvFinEpn7Dy7ou6D9z0d
         IW+0kEMTshBf2ZkvXzvfIbWrmj1J1H4ZLsyU29EgoCK/x+dqGcGJpNWDsOR0ZqOKEj
         mqzxRdYoJvNauYjdWrM+9UjFTWzkGauvmjK5Jwss=
Date:   Fri, 15 Mar 2019 20:18:31 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Okash Khawaja <okash.khawaja@gmail.com>
Cc:     speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Christopher Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>, linux-kernel@vger.kernel.org
Subject: Re: Staging status of speakup
Message-ID: <20190316031831.GA2499@kroah.com>
References: <20190315130035.6a8f16e9@narunkot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315130035.6a8f16e9@narunkot>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 01:01:27PM +0000, Okash Khawaja wrote:
> Hi,
> 
> We have made progress on the items in TODO file of speakup driver in
> staging directory and wanted to get some clarity on the remaining
> items. Below is a summary of status of each item along with the quotes
> from TODO file.
> 
> 1. "The first issue has to do with the way speakup communicates
> with serial ports.  Currently, we communicate directly with the hardware
> ports. This however conflicts with the standard serial port drivers,
> which poses various problems. This is also not working for modern
> hardware such as PCI-based serial ports.  Also, there is not a way we
> can communicate with USB devices.  The current serial port handling
> code is in serialio.c in this directory."
> 
> Drivers for all external synths now use TTY to communcate with the
> devices. Only ones still using direct communication with hardware ports
> are internal synths: acntpc, decpc, dtlk and keypc. These are typically
> ISA cards and generally hardware which is difficult to make work. We
> can leave these in staging.

Ok, that's fine.

> 2. "Some places are currently using in_atomic() because speakup
> functions are called in various contexts, and a couple of things can't
> happen in these cases. Pushing work to some worker thread would
> probably help, as was already done for the serial port driving part."
> 
> There aren't any uses of in_atomic anymore. Commit d7500135802c
> "Staging: speakup: Move pasting into a work item" was the last one that
> removed such uses.

Great, let's remove that todo item then.

> 3. "There is a duplication of the selection functions in selections.c.
> These functions should get exported from drivers/char/selection.c
> (clear_selection notably) and used from there instead."
> 
> This is yet to be done. I guess drivers/char/selection.c is now under
> drivers/tty/vt/selection.c.

Yes, someone should update the todo item :)

> 4. "The kobjects may have to move to a more proper place in /sys.The
> discussion on lkml resulted to putting speech synthesizers in the
> "speech" class, and the speakup screen reader itself
> into /sys/class/vtconsole/vtcon0/speakup, the nasty path being handled
> by userland tools."
> 
> Although this makes logical sense, the change will mean changing
> interface with userspace and hence the user space tools. I tried to
> search the lkml discussion but couldn't find it. It will be good to
> know your thoughts on this.

I don't remember, sorry.  I can review the kobject/sysfs usage if you
think it is "good enough" now and see if I find anything objectionable.

> Finally there is an issue where text in output buffer sometimes gets
> garbled on SMP systems, but we can continue working on it after the
> driver is moved out of staging, if that's okay. Basically we need a
> reproducer of this issue.
> 
> In addition to above, there are likely code style issues which will
> need to be fixed.
> 
> We are very keen to get speakup out of staging both, for settling the
> driver but also for getting included in distros which build only the
> mainline drivers.

That's great, I am glad to see this happen.  How about work on the
selection thing and then I can review the kobject stuff in a few weeks,
and then we can start moving things for 5.2?

thanks,

greg k-h
