Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DFAC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D500B21019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557319517;
	bh=GZC2GHybzFWT6BL+dcet5iL9Wr3phDchdwhwLYNb3I0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vVQ+GZfdRDGdxcED6prmhO4sjvYVPidX1wo9gS3FO3oH8o6e+mxXkbJ7LpmzbovgQ
	 D5zE8+Bui86O0aCCceZsXJly8jLmscAc2VrP6ef9Q7cehLB00M5Wcx2RQJid1Y/9Fw
	 JHMgt/HiCbGTmq9I+IHjb7an7+HBb9F4ziM60yk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfEHMpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 08:45:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbfEHMpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 08:45:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A381120644;
        Wed,  8 May 2019 12:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557319516;
        bh=GZC2GHybzFWT6BL+dcet5iL9Wr3phDchdwhwLYNb3I0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SOFkRNvVzQx+mEnjRnDJTIGUil/CYsqaX86VporAgHRREEmau/9HbD5AM5iSIQ6vZ
         dJfTPHrTvJFTj1w5OkKXPyKtmiVprmldN8dDEYkc5zF1PeEF60yJrYO5tflHPMUnPv
         5MWM2qSDvFKnHQxnuJINiKQPJwvZJO+ZzQlJxkgA=
Date:   Wed, 8 May 2019 14:45:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     PanBian <bianpan2016@163.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] EDAC/sysfs: Fix memory leak when creating a csrow
 object
Message-ID: <20190508124513.GB8646@kroah.com>
References: <1555554438-103953-1-git-send-email-bianpan2016@163.com>
 <20190418172548.GL27160@zn.tnic>
 <20190419003536.GA57795@bianpan2016@163.com>
 <20190419004516.GC559@zn.tnic>
 <20190427214925.GE16338@kroah.com>
 <20190508110250.GD19015@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508110250.GD19015@zn.tnic>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 01:02:50PM +0200, Borislav Petkov wrote:
> >From 28e7f23939208bea639d6cd3d492cde3f65a7e4f Mon Sep 17 00:00:00 2001
> From: Pan Bian <bianpan2016@163.com>
> Date: Thu, 18 Apr 2019 10:27:18 +0800
> 
> In edac_create_csrow_object(), the reference to the object is not
> released when adding the device to the device hierarchy fails
> (device_add()). This may result in a memory leak.
> 
> Signed-off-by: Pan Bian <bianpan2016@163.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-edac <linux-edac@vger.kernel.org>
> Link: https://lkml.kernel.org/r/1555554438-103953-1-git-send-email-bianpan2016@163.com
> ---
>  drivers/edac/edac_mc_sysfs.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
