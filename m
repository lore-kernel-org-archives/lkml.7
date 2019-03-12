Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7E8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8982A2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552351129;
	bh=u1T9h5MtYqiDCiXeeGOncO72SRQji8BZkHgV5c5HfiI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=neWCXytideL0nbayBe4YI71o3xiRHlMZdT/NdrhtmwOPoDup2H/2gF0bvUsRIU/AM
	 INTwN9LYznpjSil0zW6b8DslT3OdUweWyE5rRDgqvbt6/MNQ8TNlfwJKER5y7vmRS7
	 kZs+w9Y9p4xIo/b+8z4IgySfZXsPvE4RuUB7jd0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfCLAir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 20:38:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38886 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfCLAir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 20:38:47 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B20C2CB7;
        Tue, 12 Mar 2019 00:38:46 +0000 (UTC)
Date:   Mon, 11 Mar 2019 17:38:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drop -Wdeclaration-after-statement
Message-Id: <20190311173845.53c2e4e4d2257a3701fa2033@linux-foundation.org>
In-Reply-To: <20190310133535.GA20473@avx2>
References: <20190310133535.GA20473@avx2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Mar 2019 16:35:35 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Newly added static_assert() is formally a declaration, which will give
> a warning if used in the middle of the function.
> 
> ...
>
> --- a/Makefile
> +++ b/Makefile
> @@ -792,9 +792,6 @@ endif
>  # arch Makefile may override CC so keep this after arch Makefile is included
>  NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
>  
> -# warn about C99 declaration after statement
> -KBUILD_CFLAGS += -Wdeclaration-after-statement
> -
>  # Variable Length Arrays (VLAs) should not be used anywhere in the kernel
>  KBUILD_CFLAGS += $(call cc-option,-Wvla)

I do wish your changelogs were more elaborate :(

So the proposal is to disable -Wdeclaration-after-statement in all
cases for all time because static_assert() doesn't work correctly?

Surely there's something we can do to squish the static_assert() issue
while retaining -Wdeclaration-after-statement?  Perhaps by making
static_assert() a nop if -Wdeclaration-after-statement is in use. 
Perhaps simply by putting { } around the static_assert()?
