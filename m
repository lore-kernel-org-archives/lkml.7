Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9E5C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA76215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u50eCZjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgAFHoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 02:44:15 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:49413 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgAFHoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 02:44:15 -0500
Received: by mail-pf1-f202.google.com with SMTP id b188so15886703pfg.16
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 23:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gI0FCMXHiSbsnb1eu8hlDnR6/QaINgzrZx2HuBKeepA=;
        b=u50eCZjAfyNSmGTU5lKfBEkJSpC+iZuIR+FVISiRPPu8sFucUw/1jx30OWa4ZfNmMS
         vdmqZbyWwWCECAISxmCXgGOQahG621Bj+Dr5ByEpNWZSXquZJ4FS7wZPCUqxi8201jGN
         IymYpIHpl2bHnK8XKg89XPQM7hUwXE4y9bZAFlZt1LJ8wxkMpPwUkhU/y5rx4/To047F
         1iesw2UaaXIEVY3PtG41dEqo5NLX3m92jr0PZgQ0gbn3qNm5wQ3iGTxanjpUCVqKwEk7
         ym+f9xc8WG7DTDDFwHum7gQdVT+bovuByKM4WP6wydJz4g042Gj0NjPwQ2BOESwKDtBV
         hCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gI0FCMXHiSbsnb1eu8hlDnR6/QaINgzrZx2HuBKeepA=;
        b=OVV946uptHSMl1YXnPiKYOqZ0d7sIuHgnZYW83ybWnB/S3tOsWBpRleQRExAmvogyP
         7DvBYH7Yui3j2YpeEr1uIQ5TDSODsE1CZk3+sX71y39ZFqE4McqqRugC/FV8H1kzVINv
         sezR96eqo9JhYVfmMl7zSC4myB/NSwR1v27r+TpOjlm6iJs57DV3v4lDioVvMHxZUk0Q
         DLp8cvT13v8uM5MVlwxPg/iq2RmXGVfbA95FsMyhvx/OWKcT+UkkJOeFMAeZwOsbRoSo
         SNEsdYpZNFtbDsq/IQVxj/m96YFjPkxoCVTcNG7kwK4ybXLcslM+yiO2bTE8Fvv0hCk6
         f/uA==
X-Gm-Message-State: APjAAAWhKISf5h0Ow0URJfMbSGx3dHCtfgo5iw9v3Kz0M3fCMmqsS5gy
        tz/bLaScdcH1c3eKRePKSd7yOQ0zMOne
X-Google-Smtp-Source: APXvYqwkWw+sFDxH5xbEISI8YBEtzCgATQOsHtMEF+FFeOSjZgHpvvo17s2DeM1Kv6gqC3zlc0ccK9N7vmrs
X-Received: by 2002:a63:1945:: with SMTP id 5mr112181928pgz.310.1578296654450;
 Sun, 05 Jan 2020 23:44:14 -0800 (PST)
Date:   Sun, 05 Jan 2020 23:44:12 -0800
In-Reply-To: <20200104150238.19834-6-masahiroy@kernel.org>
Message-Id: <xr93d0bx6ncj.fsf@gthelen.svl.corp.google.com>
Mime-Version: 1.0
References: <20200104150238.19834-1-masahiroy@kernel.org> <20200104150238.19834-6-masahiroy@kernel.org>
Subject: Re: [PATCH v2 05/13] initramfs: remove redundant dependency on BLK_DEV_INITRD
From:   Greg Thelen <gthelen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <masahiroy@kernel.org> wrote:

> init/Kconfig includes usr/Kconfig inside the "if BLK_DEV_INITRD" ...
> "endif" block:
>
>     if BLK_DEV_INITRD
>
>     source "usr/Kconfig"
>
>     endif
>
> Hence, all the defines in usr/Kconfig depend on BLK_DEV_INITRD.
>
> Remove the redundant "depends on BLK_DEV_INITRD".
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Greg Thelen <gthelen@google.com>


> ---
>
> Changes in v2: None
>
>  usr/Kconfig | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/usr/Kconfig b/usr/Kconfig
> index a6b68503d177..72f50a21c051 100644
> --- a/usr/Kconfig
> +++ b/usr/Kconfig
> @@ -54,7 +54,6 @@ config INITRAMFS_ROOT_GID
>  
>  config RD_GZIP
>  	bool "Support initial ramdisk/ramfs compressed using gzip"
> -	depends on BLK_DEV_INITRD
>  	default y
>  	select DECOMPRESS_GZIP
>  	help
> @@ -64,7 +63,6 @@ config RD_GZIP
>  config RD_BZIP2
>  	bool "Support initial ramdisk/ramfs compressed using bzip2"
>  	default y
> -	depends on BLK_DEV_INITRD
>  	select DECOMPRESS_BZIP2
>  	help
>  	  Support loading of a bzip2 encoded initial ramdisk or cpio buffer
> @@ -73,7 +71,6 @@ config RD_BZIP2
>  config RD_LZMA
>  	bool "Support initial ramdisk/ramfs compressed using LZMA"
>  	default y
> -	depends on BLK_DEV_INITRD
>  	select DECOMPRESS_LZMA
>  	help
>  	  Support loading of a LZMA encoded initial ramdisk or cpio buffer
> @@ -81,7 +78,6 @@ config RD_LZMA
>  
>  config RD_XZ
>  	bool "Support initial ramdisk/ramfs compressed using XZ"
> -	depends on BLK_DEV_INITRD
>  	default y
>  	select DECOMPRESS_XZ
>  	help
> @@ -91,7 +87,6 @@ config RD_XZ
>  config RD_LZO
>  	bool "Support initial ramdisk/ramfs compressed using LZO"
>  	default y
> -	depends on BLK_DEV_INITRD
>  	select DECOMPRESS_LZO
>  	help
>  	  Support loading of a LZO encoded initial ramdisk or cpio buffer
> @@ -100,7 +95,6 @@ config RD_LZO
>  config RD_LZ4
>  	bool "Support initial ramdisk/ramfs compressed using LZ4"
>  	default y
> -	depends on BLK_DEV_INITRD
>  	select DECOMPRESS_LZ4
>  	help
>  	  Support loading of a LZ4 encoded initial ramdisk or cpio buffer
