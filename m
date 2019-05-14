Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A23FC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 07:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A28620843
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 07:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557819305;
	bh=982K9qZCcr4ZzOrEMiEJhD/HnRZdhyfVHwIt/L1kfCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NIvFpUa1m2mUDZ52z77jMfV3wqPHocyu7Hk9skpAA2AeNiopOXK3sLqonyQqDGulI
	 vhntlrzpwTTOOigJ5saKY2DFtQv5Oep8+xIXSkUEXUGte0RiPo5WGKEyc71Gk3he4h
	 1EK4sdG3TqZRZxCKflyOh8aAuQI0nRGtdGO5l1X0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfENHfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 03:35:04 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40583 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfENHfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 03:35:03 -0400
Received: by mail-lf1-f67.google.com with SMTP id h13so11026733lfc.7;
        Tue, 14 May 2019 00:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ypxcL+Y2IvMWn09TLf/QK34oXMbYOcjJzriH87EFApU=;
        b=Zt61CVWfeJRKPEEh7jwVW2RaAhOUVD+pyubobdEXvlsLpnyJIzpjHRZVneaQCRYw+g
         ADDd+MfAL3U8ndjB0hm6Y0v5tA5QN25XqRTPwWINJ4IO4puLYVsIVoJqxt/+drxFEQsY
         0uJ9s3Y61qocUec1imklZbCixKguZl2btNcn23AWHFXLR1cOhQzWrO8xE6pY0HBh/5oR
         5CEMw4jq224OF9p/4dm9Q9Jxh3++dL0VlvW2YlEeHupQp3mWHcqque8KeFLhimhrugCu
         G3Li4vI8Q+YwOM+x0hxtu3In1aL2IrQE8+rKFJf2PBUM2usvIlFXL+V2ZaUxr9zKqxfY
         3Lhg==
X-Gm-Message-State: APjAAAVTJ7Pj5LP2aHEeb6MPC7FELGPhIWATlwFWAy9JgD29F7S3vPfN
        j7txJAHUViX/puic4ya1rSk=
X-Google-Smtp-Source: APXvYqwvIVbr1t/VMMtD1U3VMsknRUaH0j4RtqgHXjcjMa0T4yPZPIKf0rw2L5S9o797Mn8xRnVIKA==
X-Received: by 2002:a19:2d1a:: with SMTP id k26mr16477193lfj.104.1557819301422;
        Tue, 14 May 2019 00:35:01 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id m5sm3625700lfb.47.2019.05.14.00.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 00:35:00 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hQRxh-0001Dz-9k; Tue, 14 May 2019 09:34:57 +0200
Date:   Tue, 14 May 2019 09:34:57 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Lanqing Liu <liuhhome@gmail.com>, Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     baolin.wang@unisoc.com, baolin.wang@linaro.org, jslaby@suse.com,
        lanqing.liu@unisoc.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, chunyan.zhang@unisoc.com,
        orson.zhai@unisoc.com, zhang.lyra@gmail.com
Subject: Re: [PATCH] tty: serial_core: Fix the incorrect configuration of
 baud rate and data length at the console serial port resume
Message-ID: <20190514073457.GI9651@localhost>
References: <a8bd7d19de25b799098659334de7e19670a806fc.1557379676.git.liuhhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8bd7d19de25b799098659334de7e19670a806fc.1557379676.git.liuhhome@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 01:42:39PM +0800, Lanqing Liu wrote:
> When userspace opens a serial port for console, uart_port_startup()
> is called. This function assigns the uport->cons->cflag value to
> TTY->termios.c_cflag, then it is cleared to 0. When the user space
> closes this serial port, the TTY structure will be released, and at
> this time uport->cons->cflag has also been cleared.
> 
> On the Spreadtrum platform, in some special scenarios, like charging mode,
> userspace needs to close the console, which means the uport->cons->cflag
> has also been cleared. But printing logs is still needed in the kernel. So
> when system enters suspend and resume, the console needs to be configure
> the baud rate and data length of the serial port according to its own cflag
> when resuming the console port. At this time, the cflag is 0, which will
> cause serial port to produce configuration errors that do not meet user
> expectations.

This is actually yet another regression due to 761ed4a94582 ("tty:
serial_core: convert uart_close to use tty_port_close") which
incidentally removed the call to uart_shutdown() where the cflag was
being saved precisely to avoid the problem you're describing:

	ae84db9661ca ("serial: core: Preserve termios c_cflag for console resume")

Judging from a quick look it seems the xmit buf, which is released in
that function may now be leaking too.

> To fix this, assigning the TTY->termios.c_cflag value to uport->cons->cflag
> before the userspace closes this console serial port. It will ensure that
> the correct cflag value can be gotten when the console serial port was
> resumed.

Not sure this is the right fix, but I don't have time to look at this
right now.

Johan
