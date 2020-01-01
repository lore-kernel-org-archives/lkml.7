Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0B9C2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 13:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7DB2072C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 13:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hzrg9gIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgAAN13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 08:27:29 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37463 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgAAN12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 08:27:28 -0500
Received: by mail-io1-f65.google.com with SMTP id k24so5781131ioc.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 05:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pGOzii5pjqcqWkUrkDhE9mT1sdWAp5pPuwdqfoXWtAI=;
        b=Hzrg9gIkl2MahbihUjuszDAby0q4kQ/O2c2kSYG9+R6rZEzdwTTysSRk9LkcNZdNG5
         x1CcJhNMLvQozSgxxWyv7l45t161c+ogAG12Zh/lqXxdtLLKvU6Eazcp1fCv7lkuj1Co
         EOxM3PZkgnhrDNDYO7+YsG9iT1DPoxUggey6BflzOuL9Iy1XVsHLZe1T3VgskNsla679
         j3k0rdrB1BSsoeKXHHgoYQ0GI8jfGSv3HySKDzcgLdKvxVniigEy6qyln1obN8FF0Atz
         dlTqPmufz5ZD1NbnwW9jN/nGVhwAcSKVPG/zuHs7CnZKYQ6kPE1NXcASAdAKxKd5PndN
         LsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pGOzii5pjqcqWkUrkDhE9mT1sdWAp5pPuwdqfoXWtAI=;
        b=jlsD3IJZir0SD6QisGpk2W8pphVmWxiDa+ZdF7MlCzN6h3yVdGpT7kxEd0asIUyPVD
         go3Fj38l8uTAfq3WcI9aQTwm4Sg5RNmXdNMY69nGCz4uboHR+jwpfqZNbK1asWhd10GZ
         7RfpI65eUabT5hdUvWB5lpe0CEBjW8b7qMdvGhqJMkUlIe28keoCyUxcfLClHODe4aMy
         Yf7g/45X/nCnMBvhxF0UCg4dQD5nv3XnZ90rmlCfGZIc3GGBo4ze3tiA27RkPcI0Pmfs
         rvkyVpysrbHteBIAnRCHqAL3zIM5N9kKz62Jpu6gMQPjK6S3J5H9KfT/DLq89WsiKX4I
         elAQ==
X-Gm-Message-State: APjAAAWrsfLyJWCzJerSvpm5+gvxDUY9ngXLFHmVXIbOvNpoHCidd8YP
        /o2lYjwjxyC4F9hdrnJL5hOxMjS40LdtIjIFdUc=
X-Google-Smtp-Source: APXvYqwg47twzkebdo7/rRsHK+uNTOXKMXFhUZXxxBct3KF9NuPa9ySUV/0S3U2qc9GRBfY1FMdlGi7Ea9kIIk4kO2o=
X-Received: by 2002:a02:780f:: with SMTP id p15mr60464329jac.91.1577885248116;
 Wed, 01 Jan 2020 05:27:28 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac0:9191:0:0:0:0:0 with HTTP; Wed, 1 Jan 2020 05:27:27 -0800 (PST)
In-Reply-To: <20200101104313.GA666771@light.dominikbrodowski.net>
References: <20191231150226.GA523748@light.dominikbrodowski.net>
 <20200101003017.GA116793@rani.riverdale.lan> <20200101104313.GA666771@light.dominikbrodowski.net>
From:   youling 257 <youling257@gmail.com>
Date:   Wed, 1 Jan 2020 21:27:27 +0800
Message-ID: <CAOzgRdZ0eBNKAP_T8r=MF35WUtUMn07-14OwA+AXACyY=r5hqA@mail.gmail.com>
Subject: Re: [PATCH] early init: open /dev/console with O_LARGEFILE
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, test this patch still no help, has system/bin/sh warning.

2020-01-01 18:43 GMT+08:00, Dominik Brodowski <linux@dominikbrodowski.net>:
> @youling 257: could you test the attached patch, please?
>
> Thanks,
> 	Dominik
>
> On Tue, Dec 31, 2019 at 07:30:19PM -0500, Arvind Sankar wrote:
>> On Tue, Dec 31, 2019 at 04:02:26PM +0100, Dominik Brodowski wrote:
>> > If force_o_largefile() is true, /dev/console used to be opened
>> > with O_LARGEFILE. Retain that behaviour.
>> >
>>
>> One other thing that used to happen is fsnotify_open() -- I don't know
>> how that might affect this, but it seems like the only thing left that's
>> different.
>
> Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
>
> diff --git a/init/main.c b/init/main.c
> index d12777775cb0..3f4163046200 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -94,6 +94,7 @@
>  #include <linux/jump_label.h>
>  #include <linux/mem_encrypt.h>
>  #include <linux/file.h>
> +#include <linux/fsnotify.h>
>
>  #include <asm/io.h>
>  #include <asm/bugs.h>
> @@ -1166,6 +1167,7 @@ void console_on_rootfs(void)
>  			  O_RDWR | (force_o_largefile() ? O_LARGEFILE : 0), 0);
>  	if (IS_ERR(file))
>  		goto err_out;
> +	fsnotify_open(file);
>
>  	/* create stdin/stdout/stderr, this should never fail */
>  	for (i = 0; i < 3; i++) {
>
