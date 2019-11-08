Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09A5FC6195
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CCB20679
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="OGeRhNwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfKHQFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:05:09 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:33839 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfKHQFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:05:09 -0500
Received: by mail-il1-f194.google.com with SMTP id p6so5585638ilp.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 08:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WWhxxwtXBsYr3ujNQbOniWk+oJ9McNvg7ht/PhD1bwA=;
        b=OGeRhNwUh5ZORqAH7nioyjRY3n4m1e0tf7rrXmZWM/nkvzRr+Jz78odb6aMdX1AfNN
         Gj0OXw+m5mb4FIsAEQ+hGtoBqv5rLgdhs/nG8KK8+8iDA5oofV8DmgMds9VPfp+IAYXJ
         jRi/aBENaspw3XTZrzU6IXgDDs4peaARaEpbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WWhxxwtXBsYr3ujNQbOniWk+oJ9McNvg7ht/PhD1bwA=;
        b=jgFQZTZHMtCYLEeXW9lxIIerzHCWhoYdtH2LweSihM5Hjn2sXuGXiSftpP/AdjXU6D
         nqf8eiGpGfZsLjVOaB3nlAes83VMBMsB7JkDvehAkKkLgxdu33aplKuYwVAIXRqXGOZj
         L+f3KLSCdSgF4Uq9p6P4NG1jhBfXZ3+37zUO6t9j8qMyKieNKZeqfwXkHDg3/MrVlT1V
         RIaFAI0/7DoJroWPRtgqSFFcjjF/glOXvPXtpf1UZboU2buCEYU8PHwC2WOx5TPQ3P6Y
         S6ynE5opR5tvWMYz+BS3TbeVehMZWljydFLrC4WeMz3RnOf7FFeRkoJ/yckJLtfH0xAn
         B/aA==
X-Gm-Message-State: APjAAAW9100POXR9raXowX96xTAP9IBhR79AThiIbAs5kL7jK0Zq6+ZL
        324U6/ADpUKRgJKyzdwYZVDiIpMe8qg9t4tMj3cy1A==
X-Google-Smtp-Source: APXvYqyMR9OW7SeX51o9tfRFIg3JQm5oVrpif96xXuOURB6DQd71NN/ekFza/Eww6hYPI147Lbj3qHHvKAelLBLe7fE=
X-Received: by 2002:a92:a189:: with SMTP id b9mr14223728ill.259.1573229106630;
 Fri, 08 Nov 2019 08:05:06 -0800 (PST)
MIME-Version: 1.0
References: <1571990538-6133-1-git-send-email-teawaterz@linux.alibaba.com>
In-Reply-To: <1571990538-6133-1-git-send-email-teawaterz@linux.alibaba.com>
From:   Dan Streetman <ddstreet@ieee.org>
Date:   Fri, 8 Nov 2019 11:04:29 -0500
Message-ID: <CALZtONCQ1YqpAXfZS6jemHuKpBXhLz440EcxSoWZbxrH0kyLHg@mail.gmail.com>
Subject: Re: [PATCH] zswap: Add shrink_enabled that can disable swap shrink to
 increase store performance
To:     Hui Zhu <teawaterz@linux.alibaba.com>
Cc:     Seth Jennings <sjenning@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 4:02 AM Hui Zhu <teawaterz@linux.alibaba.com> wrote:
>
> zswap will try to shrink pool when zswap is full.
> This commit add shrink_enabled that can disable swap shrink to increase
> store performance.  User can disable swap shrink if care about the store
> performance.

I don't understand - if zswap is full it can't store any more pages
without shrinking the current pool.  This commit will just force all
pages to swap when zswap is full.  This has nothing to do with 'store
performance'.

I think it would be much better to remove any user option for this and
implement some hysteresis; store pages normally until the zpool is
full, then reject all pages going to that pool until there is some %
free, at which point allow pages to be stored into the pool again.
That will prevent (or at least reduce) the constant performance hit
when a zpool fills up, and just fallback to normal swapping to disk
until the zpool has some amount of free space again.

>
> For example in a VM with 1 CPU 1G memory 4G swap:
> echo lz4 > /sys/module/zswap/parameters/compressor
> echo z3fold > /sys/module/zswap/parameters/zpool
> echo 0 > /sys/module/zswap/parameters/same_filled_pages_enabled
> echo 1 > /sys/module/zswap/parameters/enabled
> usemem -a -n 1 $((4000 * 1024 * 1024))
> 4718592000 bytes / 114937822 usecs = 40091 KB/s
> 101700 usecs to free memory
> echo 0 > /sys/module/zswap/parameters/shrink_enabled
> usemem -a -n 1 $((4000 * 1024 * 1024))
> 4718592000 bytes / 8837320 usecs = 521425 KB/s
> 129577 usecs to free memory
>
> The store speed increased when zswap shrink disabled.
>
> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
> ---
>  mm/zswap.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 46a3223..731e3d1e 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -114,6 +114,10 @@ static bool zswap_same_filled_pages_enabled = true;
>  module_param_named(same_filled_pages_enabled, zswap_same_filled_pages_enabled,
>                    bool, 0644);
>
> +/* Enable/disable zswap shrink (enabled by default) */
> +static bool zswap_shrink_enabled = true;
> +module_param_named(shrink_enabled, zswap_shrink_enabled, bool, 0644);
> +
>  /*********************************
>  * data structures
>  **********************************/
> @@ -947,6 +951,9 @@ static int zswap_shrink(void)
>         struct zswap_pool *pool;
>         int ret;
>
> +       if (!zswap_shrink_enabled)
> +               return -EPERM;
> +
>         pool = zswap_pool_last_get();
>         if (!pool)
>                 return -ENOENT;
> --
> 2.7.4
>
