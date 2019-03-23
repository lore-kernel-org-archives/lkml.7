Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D0AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 06:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC39218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 06:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553321262;
	bh=i+W3s/Dy8mXwWlJKLQIHuN7xinXExHtZzDfjr9uQjps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EwvXTjdTDYb8PMTkwgCZ9lgxyPNpagmagwzNrVBE4+CVJQ6B8uVzr7oLNx34Iu8RD
	 JdkRfS+bda/1bmcw0Df08HUGu10f4pkiXODiPJVGUz4GP98rxYIA8Bx9+ptqPdpbhO
	 XwZz15F+SdVCH7lKZH/RJBT4bzZcl4pXxawatH7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfCWGHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 02:07:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfCWGHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 02:07:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8990218E2;
        Sat, 23 Mar 2019 06:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553321260;
        bh=i+W3s/Dy8mXwWlJKLQIHuN7xinXExHtZzDfjr9uQjps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U6VcT9VOS9y2LHjNIRAtdZ13ydR/E/Kbp3mf7gJJZGsX+6qhejJd3I6+X1y5EJD07
         0RDjJNzuXcj0ydF6+P9BMPPlf+UfCE13p3J33NU/PRUAibht2nP2C7ScKP7qLmXSTm
         UXksTU9GBc7MyJrAaK5sCKsfRYwubI1zvWDSNsKg=
Date:   Sat, 23 Mar 2019 07:07:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kimberly Brown <kimbrownkd@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kobject: Add support for default attribute groups to
 kobj_type
Message-ID: <20190323060737.GA28563@kroah.com>
References: <20190322201440.GA30814@ubu-Virtual-Machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190322201440.GA30814@ubu-Virtual-Machine>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 04:14:40PM -0400, Kimberly Brown wrote:
> kobj_type currently uses a list of individual attributes to store
> default attributes. Attribute groups are more flexible than a list of
> attributes because groups provide support for attribute visibility. So,
> add support for default attribute groups to kobj_type.
> 
> In future patches, the existing uses of kobj_type’s attribute list will
> be converted to attribute groups. When that is complete, kobj_type’s
> attribute list, “default_attrs”, will be removed.
> 
> Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
> ---
>  include/linux/kobject.h |  3 ++-
>  lib/kobject.c           | 14 ++++++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)

Yes!  Thanks for doing this.

But how did you test it?  Did you convert any kobj_type structures to
the attribute group and see that all was the same?  Ideally I'd like to
take this patch with at least one subsystem that uses the change,
otherwise this looks like unused code in the kernel.

thanks,

greg k-h
