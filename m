Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ECBCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC3521783
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 09:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572253750;
	bh=06/Pl06TvqrXiyjDtIoxIRWAVHdXaluNLujJ17bIh4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R5cDAfq99Ivk+3W8l/EYSK/3vHI+lOAHRXKZu/p/W96TpiOYKebGA8dkt4mGZQFd5
	 2Dl/2i2TTistJBNvZTWQmPla1STi7AGukOzYTCI/0Rp7CIlBqHzzCvmaru3oAo8/T2
	 R9nOXEXtMf8iOXbUTbP3aToKe9REV8CGMW/gDZNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387791AbfJ1JJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 05:09:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727586AbfJ1JJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 05:09:09 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BDCD214E0;
        Mon, 28 Oct 2019 09:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572253748;
        bh=06/Pl06TvqrXiyjDtIoxIRWAVHdXaluNLujJ17bIh4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EBpmOOZvz8D75YXXw5BE4NMAxLmPkk4uRgXlWiSOa+2sSC9luD5Q59idDmSFPN3eJ
         B81Mrp05O/LmiHhbSVWvidUXzVN726SMI+lsJSQxXzdwF8/vmlf13GkjdZQuH7p1rK
         lhS+yjVBczlGPfK9NMXlE3MPPpU1O8hJTmF5hcA8=
Date:   Mon, 28 Oct 2019 17:08:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     linux@armlinux.org.uk, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 0/9] Add SoC serial number support for i.MX6/7 SoCs
Message-ID: <20191028090846.GA16985@dragon>
References: <1572232370-31580-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572232370-31580-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 11:12:41AM +0800, Anson Huang wrote:
> i.MX6/7 SoCs have 64-bit unique ID stored in OCOTP bank 0, word 1/2,
> read them out as SoC serial number which can be used from userspace:
> 
> root@imx7dsabresd:~# cat /sys/devices/soc0/serial_number
> 0000028FF618B953
> 
> Add support for i.MX6Q/6DL/6SL/6SX/6SLL/6UL/6ULL/6ULZ/7D, as they have
> same unique ID layout in OCOTP.
> 
> Anson Huang (9):
>   ARM: imx: Add serial number support for i.MX6Q
>   ARM: imx: Add serial number support for i.MX6DL
>   ARM: imx: Add serial number support for i.MX6SLL
>   ARM: imx: Add serial number support for i.MX6ULL
>   ARM: imx: Add serial number support for i.MX6UL
>   ARM: imx: Add serial number support for i.MX6ULZ
>   ARM: imx: Add serial number support for i.MX6SL
>   ARM: imx: Add serial number support for i.MX6SX
>   ARM: imx: Add serial number support for i.MX7D

For this particular case, I think one single patch is even better than
a series.  So please squash them.

Shawn

> 
>  arch/arm/mach-imx/cpu.c | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 
> -- 
> 2.7.4
> 
