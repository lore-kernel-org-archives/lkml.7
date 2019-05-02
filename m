Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516F7C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199432085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K1azEk9F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfEBH4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 03:56:45 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42244 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbfEBH4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:56:45 -0400
Received: by mail-qt1-f194.google.com with SMTP id p20so1416673qtc.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 00:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oRQNrBl3LbUWqyjxjhcKLS8Zdkaq+AHCYKUjrU7AoLE=;
        b=K1azEk9FUZTF8l2OPl9v0vSzvaDSDakovrJzRcwbtRPQ1Ki/rEsvk6No2vUF4HY1+J
         GOXHNzqdPU489+RSuELiGvWh09jiS0XtJErSFv0tSB+JV30b3XP21kZbXLPo62tuy8z3
         wXmBOqchvpNA6BfRQ/EbaK+Bmh9YPtfYK+Un0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oRQNrBl3LbUWqyjxjhcKLS8Zdkaq+AHCYKUjrU7AoLE=;
        b=UpUAPf/upSvWNRuXQ1aAPzmjhoc95l759p/NPkGXnhs6k7cY2N9wL6JkhVcSWtPLMJ
         y0Y1ID7A7Ji0GUWYmMBYri2nFsjookzAwtOUHjNHmfaT6/cwSpNmo8jBd9mNxniikHxs
         qLwkCLMcrj8S0ZT4QV9nr5R2RwbAzErN2UeX0SDHvd34BD5AiQ33gKvLzK4rbmj2/E4S
         bHpjp9hmgVxx2+zctpsqStfwTr0qROTmtpMzxD9uqVyLsNdHgiSP5uxoNN+y3muheQU+
         L5vaYzS2ykt944Netz3cr6oJa4+MRKbeosOp/7l50OR5plbWH3wilNkKro5b2n6vIVZf
         p4mQ==
X-Gm-Message-State: APjAAAX4CPfoU/3FjqbshfUQIGT4P7LuCPepiILx8cerG0X8mvl2BMIR
        IBXg/qZ1F0DNIkxha3FcdHhYtXLXafNv56jzOvgBNQ==
X-Google-Smtp-Source: APXvYqwM6qmZs9QMprvFC8eT7hNgb431bDfnqEf3Whh9ByrBUw3+WOxYgsMMm0S/s1eXLuhWM/HhUi2jlX8+QcMgJeE=
X-Received: by 2002:ac8:362e:: with SMTP id m43mr1985816qtb.339.1556783804389;
 Thu, 02 May 2019 00:56:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190418075016.252988-1-pihsun@chromium.org>
In-Reply-To: <20190418075016.252988-1-pihsun@chromium.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 2 May 2019 15:56:33 +0800
Message-ID: <CANMq1KCwcVawg6L1hTKXBgBi66EKdHQrvxr_chR9Kv1ifFREnA@mail.gmail.com>
Subject: Re: [PATCH] wireless: Use offsetof instead of custom macro.
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 3:50 PM Pi-Hsun Shih <pihsun@chromium.org> wrote:
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

The warning from clang is spurious, but in another case, we felt that
the cleanup was worth it, nevertheless
(https://lore.kernel.org/patchwork/patch/1050040/).

Reviewed-By: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  include/uapi/linux/wireless.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/wireless.h b/include/uapi/linux/wireless.h
> index 86eca3208b6b..f259cca5cc2b 100644
> --- a/include/uapi/linux/wireless.h
> +++ b/include/uapi/linux/wireless.h
> @@ -1090,8 +1090,7 @@ struct iw_event {
>  /* iw_point events are special. First, the payload (extra data) come at
>   * the end of the event, so they are bigger than IW_EV_POINT_LEN. Second,
>   * we omit the pointer, so start at an offset. */
> -#define IW_EV_POINT_OFF (((char *) &(((struct iw_point *) NULL)->length)) - \
> -                         (char *) NULL)
> +#define IW_EV_POINT_OFF offsetof(struct iw_point, length)
>  #define IW_EV_POINT_LEN        (IW_EV_LCP_LEN + sizeof(struct iw_point) - \
>                          IW_EV_POINT_OFF)
>
> --
> 2.21.0.392.gf8f6787159e-goog
>
