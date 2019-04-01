Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A386C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E9D20840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p357myAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfDANuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:50:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32966 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfDANuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 09:50:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id q1so12166606wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 06:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T2HrON9gNkjopnRgI336nLxC7mUalHxJOqW4qIGg/fs=;
        b=p357myAyE47YoZpxKaHehfHBjWNKYaJHNnaBSEfsG9rwsNxa5L6/Ym7aTytc4mvDKs
         m2UR5vKAVq/qz6g5Damc3sMYKCtdLPaJBcRqYHXXXHEVjas2zVDVj761fbi42o4RbvnE
         5U32rUfiFikYCwvEbOVaO6bBNLvLSzLEoC4NTi7SfaumNg7vlikC1GOTxQC2diu5NHO+
         oO16W2DrF6fRttkihCboSE1gAgo1Y/yYDm8CgDVZ6p5RDLcET9XueRD4O0U8Zrsht1Bb
         dB9kVNDio5cWaMI9oJ1mNpZokbwhyU3+6mecW3j2KdyfZf9ZS8JGgMpUnzuC5lUcX49C
         22yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T2HrON9gNkjopnRgI336nLxC7mUalHxJOqW4qIGg/fs=;
        b=rwOIIcjaqPVwOgLVhjJw3SzJ/7oyqjLe0+okrKHbqQUOpjVx2Z2M7uYZavNC4Jnj2a
         dDYjv/zb3uGtKJleln3S2LaQUT6syo9seJDYkKIGiHaLVWTiJKJc4RHR3o1Dki1oMkeq
         vQTYNEcvG9M8qL2AeU1VGo4YT9RfNdiymCGVqEa1C6maSQruiqHAV9/SwDSKVBTA4wKH
         V+0tWMxH+SJzz8ydXg/UeNsjFC+PRBYDucJCqX6qWZWMmWJxcXchtWisQ86FuVoMgp4+
         L/u1do+rLhHHhfbh0UMWCFZBl0h1XHBYdCE2hHqlvD7VaeMDGRActHidqTnXZ/G7tqfG
         TESg==
X-Gm-Message-State: APjAAAUVvvTdLKg9jQQeQB/IR8TmXU/5c3vf9mFoIHSQ57wR8VagcqUw
        BepO67glhsCZGA8VenJoVK6uxlJUKog5KHiJi7k0
X-Google-Smtp-Source: APXvYqxZgx0x98zjazjwFyAIPpZVrGSE70lXXRLRHGu8xIOW3L0aq1gQlpDGyI926rjwM/6Atf3p8QhIuQTRaZqAa68=
X-Received: by 2002:a5d:4d42:: with SMTP id a2mr44020297wru.130.1554126641986;
 Mon, 01 Apr 2019 06:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190325183652.252175-1-helgaas@kernel.org>
In-Reply-To: <20190325183652.252175-1-helgaas@kernel.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 1 Apr 2019 08:50:30 -0500
Message-ID: <CAErSpo6_VMJ8nP9sA2xZffsMXdG3bKKv8WL0skyTTbuLe4WtJQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: isch: Remove unnecessary acpi.h include
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mukesh Ojha <mojha@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 1:37 PM <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> 54fb4a05af0a ("i2c: Check for ACPI resource conflicts") included
> <linux/acpi.h> so we could use acpi_check_region().  fd46a0064af1 ("i2c:
> convert i2c-isch to platform_device") removed the use of
> acpi_check_region() but not the include.
>
> Remove the now-unnecessary include of <linux/acpi.h>.  No functional change
> intended.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Added

    Fixes: fd46a0064af1 ("i2c: convert i2c-isch to platform_device")
    Reviewed-by: Jean Delvare <jdelvare@suse.de>
    Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

on my local branch.

Jean, would you like me to repost this with the updates?  I assume you
will merge this (just based on get_maintainer.pl)?

> ---
>  drivers/i2c/busses/i2c-isch.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-isch.c b/drivers/i2c/busses/i2c-isch.c
> index 5c754bf659e2..f64c1d72f73f 100644
> --- a/drivers/i2c/busses/i2c-isch.c
> +++ b/drivers/i2c/busses/i2c-isch.c
> @@ -30,7 +30,6 @@
>  #include <linux/ioport.h>
>  #include <linux/i2c.h>
>  #include <linux/io.h>
> -#include <linux/acpi.h>
>
>  /* SCH SMBus address offsets */
>  #define SMBHSTCNT      (0 + sch_smba)
> --
> 2.21.0.392.gf8f6787159e-goog
>
