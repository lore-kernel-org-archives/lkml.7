Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B598DC33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894BD206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 09:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578389312;
	bh=3av3o+vC/vXC6oh+TQ7c+u0WMkeu1eoqIgNTIIZ8n9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d9Ju0oARUdRAlwK2izk+p3UVfKXpbCg3355J/B8l8bnFBnanZ2eseqiSVgGVoQ6T5
	 Yj4KFTJb0XRn/0zzJtvF/aMam79ZCTV9DEanbIvGlOBwlCW8QTzuytg/sYipEJDw9Y
	 tPOwcBaUtf2Tl4XbKe4EbeKEeiu+uiFT37Qoy7AU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgAGJ2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:28:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:56176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgAGJ2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 04:28:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 116C320656;
        Tue,  7 Jan 2020 09:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578389310;
        bh=3av3o+vC/vXC6oh+TQ7c+u0WMkeu1eoqIgNTIIZ8n9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JPabrsknAjdJFKlBlhOK1aD5Uj1XZ3Ir0YPv2aVh5S/poZyyQ+xBezCYhiYZqWw6p
         PTYHGALXbN1f9H59xWVEiLyWfVUdE/vkmKFkk4o688m042XuQrnv8ulzaXYnZIsbuO
         4UO3rr0KVmD7GQWZ+9XNJl9DW2nDwxq9GDnAKz/I=
Date:   Tue, 7 Jan 2020 10:28:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Kim, David" <david.kim@ncipher.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Magee, Tim" <tim.magee@ncipher.com>
Subject: Re: [PATCH v2] drivers: misc: Add support for nCipher HSM devices
Message-ID: <20200107092827.GB1021817@kroah.com>
References: <20191220154738.31448-1-david.kim@ncipher.com>
 <20191220213036.GA27120@kroah.com>
 <46e2f36d770c462db487d0e918ad2b0b@exukdagfar01.INTERNAL.ROOT.TES>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46e2f36d770c462db487d0e918ad2b0b@exukdagfar01.INTERNAL.ROOT.TES>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 08:50:50AM +0000, Kim, David wrote:
> 
> > >
> > > This is the driver for nCipher’s Solo and Solo XC hardware security modules.
> > > These modules implement a proprietary command set (the ’nCore API’) to
> > > perform cryptographic operations - key generation, signature, and so
> > > on. HSM commands and their replies are passed in a serialised binary
> > > format over the PCIe bus via a shared memory region. Multiple commands
> > > may be in-flight at any one time - command processing is
> > > multi-threaded and asynchronous. A write operation may, therefore,
> > > deliver multiple commands, and multiple replies may be retrieved in one
> > read operation.
> > 
> > If this is "just" a crypto accelerator, why isn't this driver using the existing in-
> > kernel hardware crypto api?  What is lacking from it that you need here?
> 
> Hi Greg,
> 
> A cryptographic accelerator uses key material which is stored on, and managed by, the host machine. Hardware security modules, such as nCipher’s Solo products, retain key material (i.e. secrets) within the secure boundary of the device, and implement various forms of access control to restrict use of that key material.
> 
> nCipher's product range started, in the early 1990s, as cryptographic accelerators.  The series of hardware security modules served by this driver still does do cryptography but their main function is the generation, management and use of keys within a secure boundary.
> 
> The driver doesn't do any cryptography. It provides the link between the userspace software and the HSM's firmware. Cryptography is done within the HSM's secure boundary.

So this should tie into the correct crypto/key apis that the kernel has
and not create a brand new user/kernel api, right?

Please work with the crypto kernel developers to get this right, I can't
take this until they agree that this code and api is correct.

thanks,

greg k-h
