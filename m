Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270CEC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0232089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561126559;
	bh=KnheiynqKeoZwoHdCdEweRfN/gvyS/gjMvNh7Bd20eE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oCTQdZm67v6LD3dTWyfbst/D5eHIdgVdJsEM448tJHqAtlthwgUQ4F5sTaZQEwByl
	 aCKQ3lMNpjZYz3Re2tIU6bOssnPIWXGTkypqHK5pwW8DlBZpDTgA/zTSyv0cN2d1oK
	 YXexpPib3tc9rrat3mH5jd6MLkyHe/3Wa0ck1b50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfFUOP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:15:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:46104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfFUOP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:15:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A38C12083B;
        Fri, 21 Jun 2019 14:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561126556;
        bh=KnheiynqKeoZwoHdCdEweRfN/gvyS/gjMvNh7Bd20eE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zWVUnpPZJ6u936vpwxIZB5uRenD2hXnnNmZsh6i9lHoSSfk8z8IG6f/5l4FNXo9hX
         uki+1fApoZuYR4y6sKBVHHcCkkV/bMN4VzVtIT07SN2VO92alMF7LA5jOGiD1lnHKt
         SW4n3+4UZVS//VzA3YqSXo+EBntGNX8cSBHEJbqk=
Date:   Fri, 21 Jun 2019 16:15:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     arnd@arndb.de, michal.simek@xilinx.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: Re: [PATCH V7 00/11] misc: xilinx sd-fec drive
Message-ID: <20190621141553.GA16650@kroah.com>
References: <1560274185-264438-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560274185-264438-1-git-send-email-dragan.cvetic@xilinx.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 06:29:34PM +0100, Dragan Cvetic wrote:
> This patchset is adding the full Soft Decision Forward Error
> Correction (SD-FEC) driver implementation, driver DT binding and
> driver documentation.
> 
> Forward Error Correction (FEC) codes such as Low Density Parity
> Check (LDPC) and turbo codes provide a means to control errors in
> data transmissions over unreliable or noisy communication
> channels. The SD-FEC Integrated Block is an optimized block for
> soft-decision decoding of these codes. Fixed turbo codes are
> supported directly, whereas custom and standardized LDPC codes
> are supported through the ability to specify the parity check
> matrix through an AXI4-Lite bus or using the optional programmable
> (PL)-based support logic. For the further information see
> https://www.xilinx.com/support/documentation/ip_documentation/
> sd_fec/v1_1/pg256-sdfec-integrated-block.pdf
> 
> This driver is a platform device driver which supports SDFEC16
> (16nm) IP. SD-FEC driver supports LDPC decoding and encoding and
> Turbo code decoding. LDPC codes can be specified on
> a codeword-by-codeword basis, also a custom LDPC code can be used.
> 
> The SD-FEC driver exposes a char device interface and supports
> file operations: open(), close(), poll() and ioctl(). The driver
> allows only one usage of the device, open() limits the number of
> driver instances. The driver also utilize Common Clock Framework
> (CCF).
> 
> The control and monitoring is supported over ioctl system call.
> The features supported by ioctl():
> - enable or disable data pipes to/from device
> - configure the FEC algorithm parameters
> - set the order of data
> - provide a control of a SDFEC bypass option
> - activates/deactivates SD-FEC
> - collect and provide statistical data
> - enable/disable interrupt mode

Is there any userspace tool that talks to this device using these custom
ioctls yet?

Doing a one-off ioctl api is always a risky thing, you are pretty much
just creating brand new system calls for one piece of hardware.

Anyway, I took the first 3 patches here because they looked sane.  and
stopped when I ran into the ioctl problem...

thanks,

greg k-h
