Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3A6C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F23208C4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="P2d7x2Id"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgAFUYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:24:15 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33335 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbgAFUYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:24:15 -0500
Received: from carbon-x1.hos.anvin.org ([IPv6:2601:646:8600:3280:1098:42a1:36db:233c])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 006KO0mC3018392
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 6 Jan 2020 12:24:00 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 006KO0mC3018392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019122001; t=1578342241;
        bh=BKrFhGxobdHh8ywtvYFy3UuKFIE28vDuyhmxb4g1D4E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=P2d7x2IdJqxGB9N4nqkQIcJxlm6QMJ4+OJi1vlrUXtNwSbzNgRbdCGUhgCKR/ga4S
         fXTsfiNvWl4r2tKGbIFjBapDj3SNQ7KnJWaXQrSxTTK1dADL9n/LKzGDhAYhtS3yBp
         lCUnctSyH6Q4uevLC+lRnaH31Vu0a617qJysMsFRJh1kXdPD7QqjqbURFKgYT3sE7a
         fscZVwxVELjLHFHkg5RaCQp3wbnGv/d6ush6l+B+8eucFcJc5xmY1bP6DDJ2u2lTXW
         goprr6bAcGMZEt1pJx1zSZYsBIdpCyZnldr9HCWXQGOHDHvcPLeEyWxXbRlB1p0+AQ
         EJQqUGThqhezA==
Subject: Re: [PATCH v1 0/3] Add virtual serial null modem emulation driver
To:     Rishi Gupta <gupt21@gmail.com>, gregkh@linuxfoundation.org,
        robh+dt@kernel.org
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1578235515.git.gupt21@gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <be5b7b29-97e6-41ad-7ae8-cff83dfab95f@zytor.com>
Date:   Mon, 6 Jan 2020 12:23:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <cover.1578235515.git.gupt21@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-05 23:21, Rishi Gupta wrote:
> The driver named ttyvs creates virtual tty/serial device which emulates
> behaviour of a real serial port device. Serial port events like parity,
> frame, overflow errors, ring indications, break assertions, flow controls
> are also emulated.
> 
> It supports both device-tree and non device-tree platforms. And works in
> both built-in and loadable driver methods.
> 
> Use cases
> ~~~~~~~~~~~~~~~~~
> This driver saves time to market and have following use cases including
> but not limited to; automated testing, GPS and other data simulation, data
> injection for corner case testing, scaleability testing, data sniffing,
> robotics emulator/simulator, application development when hardware,
> firmware and driver is still not available, identifying hardware issues
> from software bugs quickly during development, development cost reduction
> across team, product demo where data from hardware needs to be sent to the
> GUI application, data forwarding, serial port redirection etc.
> 
> Basic idea
> ~~~~~~~~~~~~~~~~~
> 
> This driver implements a virtual multi-port serial card in such a
> way that the virtual card can have 0 to N number of virtual serial
> ports (tty devices). The devices created in this card are used in
> exactly the same way as the real tty devices using standard termios
> and Linux/Posix APIs.

OK, I believe I have asked this before, at least when this has come up in
other contexts: any reason not to do this by adding the missing elements to
the pty interface? For fixed-name nodes, the legacy PTY interface is basically
what you need.

It would probably have other benefits, as well.

	-hpa


