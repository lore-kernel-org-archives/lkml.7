Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82515C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446F021670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556618805;
	bh=+Ap5q0BssJykOfkulh2pmXM0tTcQ2jrRz2JM/v7brEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k5Dp/bbDpyI7ZDKV43B3TOwP+9vGTxbRDnfRHWWALgVi5FQ8861ktVNVGxldOrWKM
	 x0u6dLS5tEhl1DPHnc/W5NxDnHVduFiYq2Ej1Luh8722WGWOICjtnbtEsICfXWydhK
	 esHQDYpExYcwagBFGx5Dt2j3QJK770E/r2Yym7xE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfD3KGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 06:06:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfD3KGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 06:06:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CF782075E;
        Tue, 30 Apr 2019 10:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556618802;
        bh=+Ap5q0BssJykOfkulh2pmXM0tTcQ2jrRz2JM/v7brEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BUouH29r8bkCC2KymZtwoqwP03PvwSr0ZY0Rdpd65bEZJ8asT1IvaanZyWVdqKir4
         sWO2nqgKtXlUgPjih+OHD+1eopIT/SuYVI/q4U+usESQRnlkks5kxw+7ZwRX+ToJZE
         /0sj3Ocug1zBr7lqesb12LYUVKRrc9aPwYbbrRT0=
Date:   Tue, 30 Apr 2019 12:06:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marek Behun <marek.behun@nic.cz>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: sysfs attrs for HW ECDSA signature
Message-ID: <20190430100640.GA6691@kroah.com>
References: <20190429234752.171b4f2b@nic.cz>
 <20190430082728.GE8245@kroah.com>
 <20190430112319.6c4159f9@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430112319.6c4159f9@nic.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 11:23:19AM +0200, Marek Behun wrote:
> On Tue, 30 Apr 2019 10:27:28 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Mon, Apr 29, 2019 at 11:47:52PM +0200, Marek Behun wrote:
> > > Hi Greg and Tejun,
> > > 
> > > is it acceptable for a driver to expose sysfs attr files for ECDSA
> > > signature generation?  
> >
> > What is "ECDSA signature generation"?  Is it a crypto thing?  If so, why
> > not use the crypto api?  If not, what exactly is it?
> 
> Hi Greg,
> It is a crypto thing and it should be accessed via akcipher crypto API.
> But akcipher userspace crypto API is not implemented in kernel. See
> below.

Great, get the akcipher code merged then, that should solve your
problem.

> > > According to the one attr = one file principle, it would be better to
> > > have two files: ecdsa_msg_to_sign (write-only) and ecdsa_signature
> > > (read-only).
> > > Would this be acceptable in the kernel for this driver?  
> > 
> > Why not use the crypto api, and if that doesn't work, why not just a
> > char device to read/write?
> 
> Because the akcipher userspace crypto API is not merged and it probably
> will take a lot of time, if it ever will be merged. Till then I would
> like if this feature was supported on this one device somehow in
> mainline kernel. As soon as akcipher userspace crypto API is merged, I
> can rewrite the driver.

No, do not try to route-around the proper api being present and hack up
something on your own, that way lies madness and you will then have to
support two apis for the hardware if your char driver is accepted.

Just work on the akcipher code to get that cleaned up properly and
merged, along with your driver that uses it, and all should be fine.

good luck!

greg k-h
