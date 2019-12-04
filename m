Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA54C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A70A2077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QmoH0Uex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfLDRCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:02:43 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34930 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbfLDRCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:02:42 -0500
Received: by mail-pj1-f66.google.com with SMTP id w23so72661pjd.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 09:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eu3IyJHMQvuKhJZsYp2g7JJil3jVEh0AYfjqL0o1IiE=;
        b=QmoH0UexrWMCC1IIRTlz1PwJWQ6h2dxtiUk7KvO3NzCeEmPQZo3S3GKwDDa6xuwAso
         ZamUti0ojZ3jtqWW1PT1k+GCtau2iCzY1JRJUI0N8JxzE1f+lOz6PBNx/rzMdlcinqBu
         1FTP8v36bHZVo/GlZYEGqdFxUWCYxHdxSBbOLJd/LUD/6raGJRBjaqyKOaUD5jl4EJJ/
         LcOJkKnLuCMX9N2XsR2bssttYgqtw8euGbU2mPp3gb7dtbXQoKEwXT2/WxxVMFAVyV+Z
         eipg2msnalCwO17Uhru4JhR0Q+VWryVf0Dh0SAwjZ4ITsQPp8csF1Co1ivCPwxes6CcB
         qn/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eu3IyJHMQvuKhJZsYp2g7JJil3jVEh0AYfjqL0o1IiE=;
        b=p899SyXhZhdcql8Z8kYj5CpfsTFiREHUR8JNNCG9OB5UOHe10QgaIdYam71M5/DS9L
         uchvtoYlKWk2Dm81etOcC2u9jbob/NWoCcAKDp3ugI6i+Oa7GXWumicCNgw4ypUXHZ6u
         iadhNpChCbI4CTNWcsTe2Oqg+Pw5xROFXj/kjhJGfYTC1QQAnEhoajbGhKv+/sk5uxCl
         ist3G+tE4XRHuF8zMOpY4sBuXgJMHfD1MDV9f7X+Mmu48VdmjR9EA05d4+Int/fuisZm
         e/wfqRwQj302udR6vVvmzh4AbkcWx88AzZ3DqNyFWfwtOVBhywAW014jxkgaevx8otzw
         u/3w==
X-Gm-Message-State: APjAAAV4NSxgeDnSXA0vuelgbacupesBDr/yx11MPKktMcuX6hS/qAVL
        aV44th3mHYpF2rzGA3UO0lEoZB5QKTgNhaQUAmOeaA==
X-Google-Smtp-Source: APXvYqzrNQd3LocGGri7/gY6Hv0QqlU+RA0bb+qoQL4Gk6NCjiROT8Lilv2qq9FysgmHO6jzOSBR6S18uymGHTubEZg=
X-Received: by 2002:a17:90a:1f4b:: with SMTP id y11mr4270989pjy.123.1575478961561;
 Wed, 04 Dec 2019 09:02:41 -0800 (PST)
MIME-Version: 1.0
References: <20191204081307.138765-1-pihsun@chromium.org>
In-Reply-To: <20191204081307.138765-1-pihsun@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 4 Dec 2019 09:02:30 -0800
Message-ID: <CAKwvOdnLxXeGYfEL+fgVts3cW71gMsP42mysQYtKse_STUErzQ@mail.gmail.com>
Subject: Re: [PATCH v2] wireless: Use offsetof instead of custom macro.
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CLANG/LLVM BUILD SUPPORT" 
        <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 12:13 AM Pi-Hsun Shih <pihsun@chromium.org> wrote:
>
> Use offsetof to calculate offset of a field to take advantage of
> compiler built-in version when possible, and avoid UBSAN warning when
> compiling with Clang:
>
> ==================================================================
> UBSAN: Undefined behaviour in net/wireless/wext-core.c:525:14
> member access within null pointer of type 'struct iw_point'
> CPU: 3 PID: 165 Comm: kworker/u16:3 Tainted: G S      W         4.19.23 #43
> Workqueue: cfg80211 __cfg80211_scan_done [cfg80211]
> Call trace:
>  dump_backtrace+0x0/0x194
>  show_stack+0x20/0x2c
>  __dump_stack+0x20/0x28
>  dump_stack+0x70/0x94
>  ubsan_epilogue+0x14/0x44
>  ubsan_type_mismatch_common+0xf4/0xfc
>  __ubsan_handle_type_mismatch_v1+0x34/0x54
>  wireless_send_event+0x3cc/0x470
>  ___cfg80211_scan_done+0x13c/0x220 [cfg80211]
>  __cfg80211_scan_done+0x28/0x34 [cfg80211]
>  process_one_work+0x170/0x35c
>  worker_thread+0x254/0x380
>  kthread+0x13c/0x158
>  ret_from_fork+0x10/0x18
> ===================================================================
>
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> ---
>
> Change since v1:
>  * Add #include <stddef.h>

Thanks for following up on the feedback.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> ---
>  include/uapi/linux/wireless.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/wireless.h b/include/uapi/linux/wireless.h
> index 86eca3208b6b..a2c006a364e0 100644
> --- a/include/uapi/linux/wireless.h
> +++ b/include/uapi/linux/wireless.h
> @@ -74,6 +74,8 @@
>  #include <linux/socket.h>              /* for "struct sockaddr" et al  */
>  #include <linux/if.h>                  /* for IFNAMSIZ and co... */
>
> +#include <stddef.h>                     /* for offsetof */
> +
>  /***************************** VERSION *****************************/
>  /*
>   * This constant is used to know the availability of the wireless
> @@ -1090,8 +1092,7 @@ struct iw_event {
>  /* iw_point events are special. First, the payload (extra data) come at
>   * the end of the event, so they are bigger than IW_EV_POINT_LEN. Second,
>   * we omit the pointer, so start at an offset. */
> -#define IW_EV_POINT_OFF (((char *) &(((struct iw_point *) NULL)->length)) - \
> -                         (char *) NULL)
> +#define IW_EV_POINT_OFF offsetof(struct iw_point, length)
>  #define IW_EV_POINT_LEN        (IW_EV_LCP_LEN + sizeof(struct iw_point) - \
>                          IW_EV_POINT_OFF)
>
>
> base-commit: c5db92909beddadddb705b92d3388ea50b01e1a2
> --
> 2.24.0.393.g34dc348eaf-goog
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20191204081307.138765-1-pihsun%40chromium.org.



-- 
Thanks,
~Nick Desaulniers
