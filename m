Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EE6C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEADE217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fhvmSvtH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391999AbfFKSne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:43:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37095 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391882AbfFKSnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:43:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so7149378pfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 11:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zchpM67OXnfoWoxAC4Uy2i/2DkaootIrbRMuOkvr7bI=;
        b=fhvmSvtHXqcPo4428w5b3B+FdloDpCCqQ8UbkfVHMcDm6L5bseytzG2WhcYL9Y8pI9
         Yq/VVvksYWT5z0wHjWq9wE2TiHNWx4/ZGyAc2ggTCaGhiz8d+2ILZEHts/uJ/r36ZOez
         1N9YblqYStfKQn4D+WTfI4wd5JkaTCyWPhJKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zchpM67OXnfoWoxAC4Uy2i/2DkaootIrbRMuOkvr7bI=;
        b=NBoBXVzUAVwuUONNpOSjNxOettT+VJGyFf3jdD5KVxHPL0wCbMbg1kZeFGhr5dM01/
         KAkS0qIDs0ALCnzdD2T8ZMnZsdGSDxjLUQQ3+XNvE+OMeWMYUcv5QclpcklVM9/tmOp+
         YtARnqsUDP/K2pyzEapUOdzRwg/Q3LGpMTgkhQvRe/SQ3fuoWgHhVXZl9FLOV7kL0DVr
         6xNdiRV5E4l+wm5d+f1LUVYWyUGqavfeoQfMK0gehRqGdcdAePVSSNxPTza1E6gKv61t
         MBEzV99jUtdTodlgqzmvjx0n1t2BRR7n0JEPIt5KfWJPveCAS3xaJszHMGWvdnZXKQfO
         rMDA==
X-Gm-Message-State: APjAAAVuU2uF1UaqcnfdzFfHTND96yM6730cWegfaoV299YO0LbfwMho
        d4idI6xOCWnrXnG51i6YEnDwqPFEacU=
X-Google-Smtp-Source: APXvYqzOIDER20DXqpZHcGg8NxyyOCBjPzfJYScOvKC9sAHp+ybkyffQvCFyci6kchpLc0ter9lFSQ==
X-Received: by 2002:a65:56c5:: with SMTP id w5mr21211756pgs.434.1560278612370;
        Tue, 11 Jun 2019 11:43:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 25sm15055282pfp.76.2019.06.11.11.43.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Jun 2019 11:43:31 -0700 (PDT)
Date:   Tue, 11 Jun 2019 11:43:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eeprom: idt_89hpesx: remove unneeded csr_file variable
Message-ID: <201906111143.2A7FDD2B77@keescook>
References: <20190611181700.GA18599@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611181700.GA18599@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 08:17:00PM +0200, Greg Kroah-Hartman wrote:
> The csr_file variable was only ever set, never read.  So remove it from
> struct idt_89hpesx_dev as it is pointless to keep around.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Colin Ian King <colin.king@canonical.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/misc/eeprom/idt_89hpesx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
> index 8a4659518c33..81c70e5bc168 100644
> --- a/drivers/misc/eeprom/idt_89hpesx.c
> +++ b/drivers/misc/eeprom/idt_89hpesx.c
> @@ -115,7 +115,6 @@ static struct dentry *csr_dbgdir;
>   * @client:	i2c client used to perform IO operations
>   *
>   * @ee_file:	EEPROM read/write sysfs-file
> - * @csr_file:	CSR read/write debugfs-node
>   */
>  struct idt_smb_seq;
>  struct idt_89hpesx_dev {
> @@ -137,7 +136,6 @@ struct idt_89hpesx_dev {
>  
>  	struct bin_attribute *ee_file;
>  	struct dentry *csr_dir;
> -	struct dentry *csr_file;
>  };
>  
>  /*
> @@ -1378,8 +1376,8 @@ static void idt_create_dbgfs_files(struct idt_89hpesx_dev *pdev)
>  	pdev->csr_dir = debugfs_create_dir(fname, csr_dbgdir);
>  
>  	/* Create Debugfs file for CSR read/write operations */
> -	pdev->csr_file = debugfs_create_file(cli->name, 0600,
> -		pdev->csr_dir, pdev, &csr_dbgfs_ops);
> +	debugfs_create_file(cli->name, 0600, pdev->csr_dir, pdev,
> +			    &csr_dbgfs_ops);
>  }
>  
>  /*
> -- 
> 2.22.0
> 

-- 
Kees Cook
