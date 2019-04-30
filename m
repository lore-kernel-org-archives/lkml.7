Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6348FC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CAB2177B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 09:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="r+A4QEPv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfD3JYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 05:24:23 -0400
Received: from mail.nic.cz ([217.31.204.67]:40526 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfD3JYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 05:24:23 -0400
Received: from localhost (unknown [172.20.6.125])
        by mail.nic.cz (Postfix) with ESMTPS id 0887E604CA;
        Tue, 30 Apr 2019 11:23:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1556616260; bh=qndt+RdDJTdMmo4kMJYNIBsyzaZbZnZzTcgCBJFC1/0=;
        h=Date:From:To;
        b=r+A4QEPvZLnp4dsI4u+FkG0VS+5M6mgH1DKBCYx+w5iSUL1X21OPtRvtXulg83ghh
         BC7r8aEGrdeTAzJrLft1cIM0NrPPwmASNG9DYiVpJLo0PCs/N2Nw70ldLnkzZ8EKwR
         cbcIIqH9Q+5DmptMaJusWBd42O72q1+bam0j6gVo=
Date:   Tue, 30 Apr 2019 11:23:19 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: sysfs attrs for HW ECDSA signature
Message-ID: <20190430112319.6c4159f9@nic.cz>
In-Reply-To: <20190430082728.GE8245@kroah.com>
References: <20190429234752.171b4f2b@nic.cz>
        <20190430082728.GE8245@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Apr 2019 10:27:28 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Mon, Apr 29, 2019 at 11:47:52PM +0200, Marek Behun wrote:
> > Hi Greg and Tejun,
> > 
> > is it acceptable for a driver to expose sysfs attr files for ECDSA
> > signature generation?  
>
> What is "ECDSA signature generation"?  Is it a crypto thing?  If so, why
> not use the crypto api?  If not, what exactly is it?

Hi Greg,
It is a crypto thing and it should be accessed via akcipher crypto API.
But akcipher userspace crypto API is not implemented in kernel. See
below.

> > The thing is that
> >   1. AFAIK there isn't another API for userspace to do this.
> >      There were attempts in 2015 to expose akcipher via netlink to
> >      userspace, but the patchseries were not accepted.  
> 
> Pointers to that patchset?  Why was it not accepted?

Here are the replies to the last attempt
https://marc.info/?t=150234726200004&r=1&w=2
This was back in 2017, apparently there were some problems and it was not
merged even after 8 versions.

> >   2. even if it was possible, that specific device for which I am
> >      writing this driver does not provide the ability to set the
> >      private key to sign with - the private key is just burned during
> >      manufacturing and cannot be read, only signed with.  
> 
> Why does this matter?

If it was implemented via akcipher, the user would be unable to set
private key, which is a method the akcipher implementation should
implement. But this probably is not that big a problem.

> > The current version of my driver exposes do_sign file in
> > /sys/firmware/turris_mox directory.
> > 
> > Userspace should write message to sign and then can read the signature
> > from this do_sign file.  
> 
> How big are messages and signatures?  Why does this have to be a sysfs
> api?

Messages are 521 bits, I rounded them to 68 bytes. The idea is that a
sha512 hash of the original message is to be signed.
Signatures are 136 bytes.

> > According to the one attr = one file principle, it would be better to
> > have two files: ecdsa_msg_to_sign (write-only) and ecdsa_signature
> > (read-only).
> > Would this be acceptable in the kernel for this driver?  
> 
> Why not use the crypto api, and if that doesn't work, why not just a
> char device to read/write?

Because the akcipher userspace crypto API is not merged and it probably
will take a lot of time, if it ever will be merged. Till then I would
like if this feature was supported on this one device somehow in
mainline kernel. As soon as akcipher userspace crypto API is merged, I
can rewrite the driver.

A char device to read/write would be possible. The sysfs API
seemed more strainthforward. Should I do the char device approach
instead?

> > I have also another question, if you would not mind:
> > 
> > This driver is dependant on a mailbox driver I have also written
> > ("mailbox: Add support for Armada 37xx rWTM mailbox"), but I have not
> > received any review for this driver from the mailbox subsystem
> > maintainer, and I have already sent three versions (on 12/17/2018,
> > 03/01/2019 and 03/15/2019).
> > What should I do in this case?  
> 
> Poke the maintainer again :)

I will,

Thanks.

Marek
