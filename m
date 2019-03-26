Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A97CC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2040B2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 01:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553564212;
	bh=G7TroPGUBZ4lxnxjfl7vSKgrP6/IbBc13sFf2iEQ0Q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AaDYJ5tsKZsLACO/PFuFmErHB1UygHXnWGYZ9Q45TsaF+acw/frGVBwKSkieVqd9l
	 YtXbwm1SkqJu/TDCQ5JogMWCTiNa9WuwhlnsYnScdIK/Nh8xbI6AZAjhRpLbpLFlw6
	 IEXyXJLz5ymFpoR13/RGWuc6xiRFHwHhBm1tFa8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbfCZBgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 21:36:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbfCZBgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 21:36:50 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ED6A2075D;
        Tue, 26 Mar 2019 01:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553564209;
        bh=G7TroPGUBZ4lxnxjfl7vSKgrP6/IbBc13sFf2iEQ0Q0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VVn6dhgNXtGtrbudSyU8NcFw4e1wUcozMEOxPZmd5uSWSw6mnNw16UCjXSpnpNCuI
         QJs5hk1iQ9I3zjGDOTDQhyTv2uTCgssdwPI/jagekijBW+VRO07VevrTSCd66Yz7wZ
         2g3YC8zk3llE8/t/bQoIQzQ0l803ZUkpNroKwehY=
Date:   Tue, 26 Mar 2019 10:36:42 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Suwan Kim <suwan.kim027@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BACKPORT 4.4.y 25/25] USB: core: only clean up what we allocated
Message-ID: <20190326013642.GE21198@kroah.com>
References: <20190322154425.3852517-1-arnd@arndb.de>
 <20190322154425.3852517-26-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322154425.3852517-26-arnd@arndb.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 04:44:16PM +0100, Arnd Bergmann wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> When cleaning up the configurations, make sure we only free the number
> of configurations and interfaces that we could have allocated.
> 
> Reported-by: Andrey Konovalov <andreyknvl@google.com>
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> (cherry picked from commit 32fd87b3bbf5f7a045546401dfe2894dbbf4d8c3)
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/usb/core/config.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Also added to 4.14.y and 4.9.y
