Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534A5C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 06:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2502020866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 06:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkSG7RZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfFNGsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 02:48:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41591 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfFNGsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 02:48:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so815611pff.8;
        Thu, 13 Jun 2019 23:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H092MI60P2U9NZrqbDHdXedYcja7hdVNXwteHt6bh58=;
        b=nkSG7RZhjcE0C6JYpK64ofYbTr6sCe/LLP68kVQlQi9+AwbXbdsygNM1rzYBre3W+k
         FpkrqUIsF6y/Uvm3KTSWfgYOa9Wq4Ffjzp5acPhpvnHmUITTR4yJ8iOmPkf4urgcD5/4
         2LRQF8trUyysxPEyxm1xhYGE+GSSFYeZqloet4wTrkENo5kDhKjdyfSa1x41P5GE7HTi
         7cL8ube5Yo8ZzAfpd5bLEmU5iscZYO+cOY/KI/zZpmD57SoEvVsU4t1c+NsvFI2PtlU9
         hgc0GHhtspF7BUs3eYQag1GH5QYlxLNdzW0ioDG2YN0hk7FlnaYNqiNTKSgo9gq1R6P6
         NVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H092MI60P2U9NZrqbDHdXedYcja7hdVNXwteHt6bh58=;
        b=O3LPuN8FNhx5MEQNsgr3CydE8+YrJo30X86PyhMVDWV7sbWBvUWtM/RrGuc5hOn2uu
         F9H/VCVVMJuBmpD7gkiAp/hkuO+sD+5/2CgWtOHG1+U2/VxxUN7u/HpPw67b9YqGS4B4
         ugiyWNYX9dpqAzryf4G72z5u1jnBF0qdmdOHHBOwvx6VNJnc2I+4kbQCHzWKkEInQreL
         X/mwK7AlswYEqLWSBLIJKBiA9yNQZxpgHi4VcZNZTydu9V81Beq9UCJ8pUhEeoIxZeRG
         bbUgVe3v3aurN2DdtCVoBD7wM3bLSGHCJOWtDcCxQMOnI9xou3PZAH743oIaehgIFi1Z
         24hg==
X-Gm-Message-State: APjAAAXHsAsKktZP+DLRSKDugAIby3pEMgKZ7YQx9eOC788g/i08zgp3
        FzV6fCN2agReSbv+/G7gAtzcxGwLxFGO9ydpznA=
X-Google-Smtp-Source: APXvYqwTy0ziuttPL016M2x6Wxfcjm9lsVHGzUmgrAf3rcFj+T3/flj4H9A0ILZnwKJ3B5XVZc0gwCY1aYNf1Iqqbg4=
X-Received: by 2002:a17:90b:d8b:: with SMTP id bg11mr9469564pjb.30.1560494895390;
 Thu, 13 Jun 2019 23:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190612121258.19535-1-gregkh@linuxfoundation.org>
In-Reply-To: <20190612121258.19535-1-gregkh@linuxfoundation.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 14 Jun 2019 09:48:04 +0300
Message-ID: <CAHp75VeQy9o6tHtqKEE3o9ijBE4c11cWcc00+RqCj+P1FOky1w@mail.gmail.com>
Subject: Re: [PATCH 1/8] platform: x86: acer-wmi: no need to check return
 value of debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "Lee, Chun-Yi" <jlee@suse.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 3:13 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
>
> Also, because there is no need to save the file dentry, remove the
> variable that was saving it and just recursively delete the whole
> directory.
>

Through which tree you want to proceed this?

> Cc: "Lee, Chun-Yi" <jlee@suse.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: platform-driver-x86@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/platform/x86/acer-wmi.c | 29 +++++------------------------
>  1 file changed, 5 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 521b526cd467..f8f0e98b1f0b 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -259,7 +259,6 @@ struct acer_data {
>
>  struct acer_debug {
>         struct dentry *root;
> -       struct dentry *devices;
>         u32 wmid_devices;
>  };
>
> @@ -2148,29 +2147,15 @@ static struct platform_device *acer_platform_device;
>
>  static void remove_debugfs(void)
>  {
> -       debugfs_remove(interface->debug.devices);
> -       debugfs_remove(interface->debug.root);
> +       debugfs_remove_recursive(interface->debug.root);
>  }
>
> -static int __init create_debugfs(void)
> +static void __init create_debugfs(void)
>  {
>         interface->debug.root = debugfs_create_dir("acer-wmi", NULL);
> -       if (!interface->debug.root) {
> -               pr_err("Failed to create debugfs directory");
> -               return -ENOMEM;
> -       }
>
> -       interface->debug.devices = debugfs_create_u32("devices", S_IRUGO,
> -                                       interface->debug.root,
> -                                       &interface->debug.wmid_devices);
> -       if (!interface->debug.devices)
> -               goto error_debugfs;
> -
> -       return 0;
> -
> -error_debugfs:
> -       remove_debugfs();
> -       return -ENOMEM;
> +       debugfs_create_u32("devices", S_IRUGO, interface->debug.root,
> +                          &interface->debug.wmid_devices);
>  }
>
>  static int __init acer_wmi_init(void)
> @@ -2300,9 +2285,7 @@ static int __init acer_wmi_init(void)
>
>         if (wmi_has_guid(WMID_GUID2)) {
>                 interface->debug.wmid_devices = get_wmid_devices();
> -               err = create_debugfs();
> -               if (err)
> -                       goto error_create_debugfs;
> +               create_debugfs();
>         }
>
>         /* Override any initial settings with values from the commandline */
> @@ -2310,8 +2293,6 @@ static int __init acer_wmi_init(void)
>
>         return 0;
>
> -error_create_debugfs:
> -       platform_device_del(acer_platform_device);
>  error_device_add:
>         platform_device_put(acer_platform_device);
>  error_device_alloc:
> --
> 2.22.0
>


-- 
With Best Regards,
Andy Shevchenko
