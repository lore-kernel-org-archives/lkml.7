Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F2BC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4539820693
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 13:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567948717;
	bh=p6ViJo0+CiEMG/cqTINO2SFUlUYVi3ntsgDEGW0lad8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e0A3B062t8NgoA3bmgWo5utlyA7/z8/yXqNaz1N2w3mxg/eD1VIy7KLPZReyOX1Wi
	 GPjH2quQ7PIPHY+iCqt+4Ej4v0ti91FLwwF+PruruvLVztQI+qDsAAbezznkXWsY5Z
	 GfnXzoqBaL/wXYpZQyznejloI3kyahxfV7kTAHCM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfIHNSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 09:18:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727864AbfIHNSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 09:18:36 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABD8F20693;
        Sun,  8 Sep 2019 13:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567948714;
        bh=p6ViJo0+CiEMG/cqTINO2SFUlUYVi3ntsgDEGW0lad8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=egCtlfemTWIVvzur5VBMFnU7DsBZQbi+YMNXvFDIbeIFodvkWX8XGhIAa8Y7N8rLf
         V+jjKRvuxUJRUcgFQ4BpfL8M2kLKVnutBV9gBBOYnJkMA1O6WHLGG+qcZ6XSxkQ7Ew
         MPEdx01OULQC8iWzKsOS4DXr/nJ5X90QzSh3KvaM=
Date:   Sun, 8 Sep 2019 14:18:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH 1/5] leds: remove PAGE_SIZE limit of
 /sys/class/leds/<led>/trigger
Message-ID: <20190908131826.GA10679@kroah.com>
References: <1567946472-10075-1-git-send-email-akinobu.mita@gmail.com>
 <1567946472-10075-2-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567946472-10075-2-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2019 at 09:41:08PM +0900, Akinobu Mita wrote:
> Reading /sys/class/leds/<led>/trigger returns all available LED triggers.
> However, the size of this file is limited to PAGE_SIZE because of the
> limitation for sysfs attribute.
> 
> Enabling LED CPU trigger on systems with thousands of CPUs easily hits
> PAGE_SIZE limit, and makes it impossible to see all available LED triggers
> and which trigger is currently activated.
> 
> This converts /sys/class/leds/<led>/trigger to bin attribute and removes
> the PAGE_SIZE limitation.

Can you also put the "this really is not a good idea" type wording here
in the changelog text as well?  Just want to try to make it explicitly
clear that this should never be copied by anyone else.

thanks,

greg k-h
