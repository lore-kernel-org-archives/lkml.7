Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C62C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10DC206E0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575919656;
	bh=bzcNyjdSa+ztOIW0Oxj5CIgYIGKH0CN4fPLCygHsqNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KePAlxZTihtNjfGnWN0u8NDRynhCQ79Y3nFg8dGSjVNcDpLULIcmxeFFWmvmvYDFJ
	 GPMXKvm56xwqlzK/jyge5SWXLD41aTKNOohmk1yczKshx2E9TOWQhF4w+mC3s9xVfY
	 ute07wZx5LINzNpf5HJ0GEbYqLYu+pYuOuHe7yN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfLIT1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:27:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbfLIT1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 14:27:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1911B205ED;
        Mon,  9 Dec 2019 19:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575919653;
        bh=bzcNyjdSa+ztOIW0Oxj5CIgYIGKH0CN4fPLCygHsqNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HKU1PVYVil4JQoKV10k3yQs0bBRNzeGyu1QwXWueJeK8H/YRJgG3B+AWAZmdJZIz0
         1ZIQ8lTY0CVEyBJxejWba5JnO6ooo7XfgkHAJapfqkiUWLnRR/OotfsemDcB7CkKYh
         EhXpqerBQVAHk269bNP1y7LMF7SjsVscCLf7/Yl0=
Date:   Mon, 9 Dec 2019 20:27:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        kernel test robot <lkp@intel.com>, kernel-team@android.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] of/platform: Unconditionally pause/resume sync state
 during kernel init
Message-ID: <20191209192730.GA1693284@kroah.com>
References: <20191209192221.143379-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209192221.143379-1-saravanak@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 11:22:21AM -0800, Saravana Kannan wrote:
> Commit 5e6669387e22 ("of/platform: Pause/resume sync state during init
> and of_platform_populate()") paused/resumed sync state during init only
> if Linux had parsed and populated a devicetree.
> 
> However, the check for that (of_have_populated_dt()) can change after
> of_platform_default_populate_init() executes.  One example of this is
> when devicetree unittests are enabled.  This causes an unmatched
> pause/resume of sync state. To avoid this, just unconditionally
> pause/resume sync state during init.
> 
> Fixes: 5e6669387e22 ("of/platform: Pause/resume sync state during init and of_platform_populate()")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Reviewed-by: Frank Rowand <frowand.list@gmail.com>
> ---
>  drivers/of/platform.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)


What changed from v1?

Always put that below the --- line.

v3 please?

thanks,

greg k-h
