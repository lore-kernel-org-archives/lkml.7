Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86178C2D0BF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 04:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C46E206F4
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 04:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHrxReNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfLHExP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 23:53:15 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:45623 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfLHExP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 23:53:15 -0500
Received: by mail-pj1-f68.google.com with SMTP id r11so4423047pjp.12;
        Sat, 07 Dec 2019 20:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E9ObJMfjT0tXvG01HRa+Y+qrax7TnR6L9lEKiXNgVEc=;
        b=WHrxReNoTRnt9IzEtnJRf0sIwWAZ6uNEbjjtniGJ0Mx+ON9+1ALC5blJi9w/V6jsbD
         2QyPbR3cUUmSSzWkcUwbQ1Dq4ymPThWVnDeEMIyiXbfqwTO3gkacGOg1Q2Q+LwsTYIXm
         ywbHC3ldUcqoHmAAo1VMVaFU2LO4VyeAT4sgSkOG7mEXw19NFmtcfmLaMLixL/8XeNjk
         TQYMmCq60kuwAf112g7nXBrtbdoaPT4SHudncTwjY9doN74Pie0OEbGSHO+Cho5orfkI
         2bnz356MhskgqJaG2felN02rsMcljFGBwTMAOyGDZVcINrjkD8Vx9eDk1qi7NuTqNkLr
         oqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E9ObJMfjT0tXvG01HRa+Y+qrax7TnR6L9lEKiXNgVEc=;
        b=nWGbKojypa/HLK1eQSzzY9qxUFkZo4a1237bx+GvTAiiU03EBBTokpLJsnAsqA66Q6
         EbTpLYsFvJl4ooARU+45f4yDI/VrZREmwM4lcujT5HANHuBbAaG4ENQzsoj532iEtNXF
         Hy5MZUW5C/DEV3HST7l8IR63V757YQk18vzO9Co/r991MghWAGjNzo9gCZMiFRPX8pwa
         oiEsohgTUs2ZFeJiisjD4l5KyD0EtdGTlIXfw6PS/AkE2wVsgAXUe/rufyLz1Q0zDt94
         SnEOzG624boYDz5Mt07VvNtbAW8uH46XXXt6DiACCWe7aSA4CGu6HQtxhwF20HihRPzn
         YwdQ==
X-Gm-Message-State: APjAAAWYtooUgszwX9Zm4ih0ZSoY3CihlmO35cU25SxPxUycgToQBZjw
        2Wl9azRc94wr/GMf9FIFKoo=
X-Google-Smtp-Source: APXvYqybuauwkdXtS8uLiRxSU8cLQDVv+P3QEKwXwFXqM86PJVC/wpRoOM2WT5jXkO6Jnhy6PgnC4Q==
X-Received: by 2002:a17:902:1:: with SMTP id 1mr23114881pla.108.1575780794490;
        Sat, 07 Dec 2019 20:53:14 -0800 (PST)
Received: from [10.231.110.95] ([125.29.25.186])
        by smtp.gmail.com with ESMTPSA id u65sm21938790pfb.35.2019.12.07.20.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2019 20:53:14 -0800 (PST)
Subject: Re: [PATCH v1] of/platform: Unconditionally pause/resume sync state
 during kernel init
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel test robot <lkp@intel.com>, kernel-team@android.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191207010307.56529-1-saravanak@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <e6e9aa38-1a77-03e4-f245-58bcfd60ffa2@gmail.com>
Date:   Sat, 7 Dec 2019 22:53:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191207010307.56529-1-saravanak@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/19 7:03 PM, Saravana Kannan wrote:
> Commit 5e6669387e22 ("of/platform: Pause/resume sync state during init
> and of_platform_populate()") paused/resumed sync state during init only
> if Linux had parsed and populated a devicetree.
> 

I _think_ (but I have not actually checked the code) that enabling unittests
is not the only way that of_root can be changed from NULL (thus changing
the value returned by of_have_populated_dt()).  I _think_ that applying
an overlay on top of an empty devicetree will have the same result.  So
I would change the following paragraph:

> However, the check for that (of_have_populated_dt()) can change between
> initcall levels when device tree unittests are enabled. This causes an
> unmatched pause/resume of sync state. To avoid this, just
> unconditionally pause/resume sync state during init.

to something like:

However, the check for that (of_have_populated_dt()) can change
after of_platform_default_populate_init() executes.  One example
of this is when devicetree unittests are enabled.  This causes an
nmatched pause/resume of sync state. To avoid this, just
unconditionally pause/resume sync state during init.

> 
> Fixes: 5e6669387e22 ("of/platform: Pause/resume sync state during init and of_platform_populate()")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/platform.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index d93891a05f60..3371e4a06248 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -518,10 +518,11 @@ static int __init of_platform_default_populate_init(void)
>  {
>  	struct device_node *node;
>  
> +	device_links_supplier_sync_state_pause();
> +
>  	if (!of_have_populated_dt())
>  		return -ENODEV;
>  
> -	device_links_supplier_sync_state_pause();
>  	/*
>  	 * Handle certain compatibles explicitly, since we don't want to create
>  	 * platform_devices for every node in /reserved-memory with a
> @@ -545,8 +546,7 @@ arch_initcall_sync(of_platform_default_populate_init);
>  
>  static int __init of_platform_sync_state_init(void)
>  {
> -	if (of_have_populated_dt())
> -		device_links_supplier_sync_state_resume();
> +	device_links_supplier_sync_state_resume();
>  	return 0;
>  }
>  late_initcall_sync(of_platform_sync_state_init);
> 

Reviewed-by: Frank Rowand <frowand.list@gmail.com>
