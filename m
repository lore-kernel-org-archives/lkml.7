Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681BAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B37C218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553875421;
	bh=W+HXGrAES+ZJDDVxoEddDBGUJ6+zVGbOGNoiX2apnNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pQEh57DExqnyxtsqw0I4RWuJ4to1MDXE361kq+B5W8X0rxNWPkFIB8/++rEKsgLQ7
	 8urko8ngNjLh2asEI6BzgsGMpncoS72AfO3phFUCm4sxcY5AAijgwUc4IWIevxM2vm
	 /E5I7W86Tn6Kznn5Mbodkez5ZMtgCX8lzwTlZu6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbfC2QDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:03:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728902AbfC2QDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:03:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FCA82070B;
        Fri, 29 Mar 2019 16:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553875419;
        bh=W+HXGrAES+ZJDDVxoEddDBGUJ6+zVGbOGNoiX2apnNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TFRmUCQjVfIhq/NxnDGPSW7w9Q9p2lcf9o73cGnVlTMn1UTWw0OW8AmW9YwjI4hHo
         XMnLyk+8VTzOfpb/iDp85fjnEwtpOAxWI2MerhPp1bjIu7CofrN5rKASR0V4gANEB8
         LqxRU+rnpMrOemTh7yv+G2dTUTUe4T3gex+Kj0kY=
Date:   Fri, 29 Mar 2019 17:03:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zeng Tao <prime.zeng@hisilicon.com>
Cc:     labbott@redhat.com, sumit.semwal@linaro.org,
        devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH] staging: android: ion: refactory ion_alloc for kernel
 driver use
Message-ID: <20190329160336.GB5906@kroah.com>
References: <1553884816-37850-1-git-send-email-prime.zeng@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553884816-37850-1-git-send-email-prime.zeng@hisilicon.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 02:40:16AM +0800, Zeng Tao wrote:
> There are two reasons for this patch:
> 1. There are some potential requirements for ion_alloc in kernel space,
> some media drivers need to allocate media buffers from ion instead of
> buddy or dma framework, this is more convient and clean very for media
> drivers. And In that case, ion is the only media buffer provider, it's
> more easier to maintain.

As this really is just DMA, what is wrong with the existing dma
framework that makes it hard to use?  You have seen all of the changes
recently to it, right?

thanks,

greg k-h
