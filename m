Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41EDC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4272218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556183227;
	bh=9E/KkLkc4pMsCJFhdpqY1UmQo8aTqEaaKyuJuvnQXPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C45Xw5Xg3H33vJvHSYFTa/80b+STWQrq6kHjr/MW1HzlzLZk3GQkjeQ6NQfqEe4Ma
	 AbNOHLjLEFtKUVL6FS9gxw1hWpV63n36dmdq/7CId7RE4pgcF19GiMYVaNJOv9CWtt
	 2v0NvPe495SmRQuZTieFcaos2AK91XIIEDe+KF0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfDYJHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:07:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfDYJHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:07:06 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E435214C6;
        Thu, 25 Apr 2019 09:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556183225;
        bh=9E/KkLkc4pMsCJFhdpqY1UmQo8aTqEaaKyuJuvnQXPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P9palEnX1BXTAIVpUdBCvbkXQPfNhc3eKHvrzPdhjNyt8W/GFCD5WJd0/Dw2dMCPr
         OTcOAb1ZQII17/2SvJz5lZPdBp6Kk96f2s93ZQ7ciIfuoN9KKvKS9OCMijPBE8D8E7
         GsignS7Bl30bIHXgK3EMr77Z41ZN/fLrK9EJazEk=
Date:   Thu, 25 Apr 2019 11:07:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     linux-usb@vger.kernel.org, groeck@chromium.org, oneukum@suse.com,
        djkurtz@chromium.org, zwisler@chromium.org,
        kbuild test robot <lkp@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Torokhov <dtor@chromium.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Johan Hovold <johan@kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v4] usb/hcd: Send a uevent signaling that the host
 controller had died
Message-ID: <20190425090703.GB15975@kroah.com>
References: <20190419153022.107358-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419153022.107358-1-rrangel@chromium.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 09:30:22AM -0600, Raul E Rangel wrote:
> This change will send an OFFLINE event to udev with the ERROR=DEAD
> environment variable set when the HC dies.
> 
> By notifying user space the appropriate policies can be applied.
> i.e.,
>  * Collect error logs.
>  * Notify the user that USB is no longer functional.
>  * Perform a graceful reboot.
> 
> Reported-by: kbuild test robot <lkp@intel.com>

kbuild did not report the need for this feature, they only found bugs in
your previous submissions.  So no need for that line here.

I'll clean it up, thanks.

greg k-h
