Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9854C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16AA20835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556612854;
	bh=qpWhxfKdvK06OPgNuI0PmE1gknQDuPHSD6Ow6PnrCtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XJAE3iKhsRVD87GYx4dkFGNGQPcrDIAhOiX0+vRTe6iBPrfTrRr/sz9XBYdctXRsx
	 HtOhJs4mqj8pVLFssJbbk1Hfdb052zRTJY9Fvj27neONa9np6u+y+lJwYadZS85Ifg
	 7Mpk8Pf5FeXyKGsBh4drypUfAvmw1Hz+WVmjo82I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfD3I1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 04:27:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbfD3I1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 04:27:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 946472080C;
        Tue, 30 Apr 2019 08:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556612852;
        bh=qpWhxfKdvK06OPgNuI0PmE1gknQDuPHSD6Ow6PnrCtQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UCs9O3r1c1XINbUYUolN9sjlVVFUkTBPi/L2CvIGQfYsivM41zEEB+oBYCs/GKh8j
         i/zt3TpNVX8BTAzhHB1d8epMursSTZD9R0CNKr/fZpN9qe7NAKNR61/ITtegl3pFJd
         uQPQLeGsPQH5OiLPYDTTzWstOhtUYKQpSpkqWFVY=
Date:   Tue, 30 Apr 2019 10:27:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek Behun <marek.behun@nic.cz>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: sysfs attrs for HW ECDSA signature
Message-ID: <20190430082728.GE8245@kroah.com>
References: <20190429234752.171b4f2b@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429234752.171b4f2b@nic.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 11:47:52PM +0200, Marek Behun wrote:
> Hi Greg and Tejun,
> 
> is it acceptable for a driver to expose sysfs attr files for ECDSA
> signature generation?

What is "ECDSA signature generation"?  Is it a crypto thing?  If so, why
not use the crypto api?  If not, what exactly is it?

> The thing is that
>   1. AFAIK there isn't another API for userspace to do this.
>      There were attempts in 2015 to expose akcipher via netlink to
>      userspace, but the patchseries were not accepted.

Pointers to that patchset?  Why was it not accepted?

>   2. even if it was possible, that specific device for which I am
>      writing this driver does not provide the ability to set the
>      private key to sign with - the private key is just burned during
>      manufacturing and cannot be read, only signed with.

Why does this matter?

> The current version of my driver exposes do_sign file in
> /sys/firmware/turris_mox directory.
> 
> Userspace should write message to sign and then can read the signature
> from this do_sign file.

How big are messages and signatures?  Why does this have to be a sysfs
api?

> According to the one attr = one file principle, it would be better to
> have two files: ecdsa_msg_to_sign (write-only) and ecdsa_signature
> (read-only).
> Would this be acceptable in the kernel for this driver?

Why not use the crypto api, and if that doesn't work, why not just a
char device to read/write?

> I have also another question, if you would not mind:
> 
> This driver is dependant on a mailbox driver I have also written
> ("mailbox: Add support for Armada 37xx rWTM mailbox"), but I have not
> received any review for this driver from the mailbox subsystem
> maintainer, and I have already sent three versions (on 12/17/2018,
> 03/01/2019 and 03/15/2019).
> What should I do in this case?

Poke the maintainer again :)

thanks,

greg k-h
