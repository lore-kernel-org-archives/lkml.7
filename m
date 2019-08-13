Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B176C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 06:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BA3206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 06:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565676175;
	bh=kJ96xqBqis4xHI+c7truTxjduXzoYlD8qHcJ3Kt4MEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t6mlWE9CDoLgq/V0GZHUPBp8fftNLANNLJHt+k09u7s8AJKgiA7rPmyu+uSZoqw6A
	 C84Ixaz8Nab1ZB//sDt6PvDEdjPJGdPTG7o3plq60wYSQ0Nn9rhXb1gYXwChYq775Q
	 a4fF5E2KE0xPWcGs/YdzzT9yt4pUjy8PnBJ8w1Os=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfHMGCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 02:02:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfHMGCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 02:02:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEA88206C2;
        Tue, 13 Aug 2019 06:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565676172;
        bh=kJ96xqBqis4xHI+c7truTxjduXzoYlD8qHcJ3Kt4MEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tQ5wZNjfM8txaVcLCJbol8woF3MjTlo5c7ZHjHbSyw9UphFSueGRsroKDQ1MrJA2+
         9g7Ctv7dt9LT0CxrtRwRZ+YxWvwiAE9qGtfM20EG8MjhTubDKDD9e/7QMacFnGhKCN
         oIA/kAkyV4yK9AcNtdYuOTIBX8jzYj/zbIInUGto=
Date:   Tue, 13 Aug 2019 08:02:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nick Crews <ncrews@chromium.org>
Cc:     linux-usb@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Daniel Kurtz <djkurtz@google.com>
Subject: Re: Policy to keep USB ports powered in low-power states
Message-ID: <20190813060249.GD6670@kroah.com>
References: <CAHX4x86QCrkrnPEfrup8k96wyqg=QR_vgetYLqP1AEa02fx1vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHX4x86QCrkrnPEfrup8k96wyqg=QR_vgetYLqP1AEa02fx1vw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 06:08:43PM -0600, Nick Crews wrote:
> Hi Greg!

Hi!

First off, please fix your email client to not send html so that vger
does not reject your messages :)

> I am working on a Chrome OS device that supports a policy called "USB Power
> Share," which allows users to turn the laptop into a charge pack for their
> phone. When the policy is enabled, power will be supplied to the USB ports
> even when the system is in low power states such as S3 and S5. When
> disabled, then no power will be supplied in S3 and S5. I wrote a driver
> <https://lore.kernel.org/patchwork/patch/1062995/> for this already as part
> of drivers/platform/chrome/, but Enric Balletbo i Serra, the maintainer,
> had the reasonable suggestion of trying to move this into the USB subsystem.

Correct suggestion.

> Has anything like this been done before? Do you have any preliminary
> thoughts on this before I start writing code? A few things that I haven't
> figured out yet:
> - How to make this feature only available on certain devices. Using device
> tree? Kconfig? Making a separate driver just for this device that plugs
> into the USB core?
> - The feature is only supported on some USB ports, so we need a way of
> filtering on a per-port basis.

Look at the drivers/usb/typec/ code, I think that should do everything
you need here as this is a typec standard functionality, right?

thanks,

greg k-h
