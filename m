Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24A7ECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6C420663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 10:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rV8Qq1zT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbfJNKlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 06:41:17 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40703 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731461AbfJNKlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 06:41:16 -0400
Received: by mail-qk1-f196.google.com with SMTP id y144so15413154qkb.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 03:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/mDM4m3k7JTmmCNbrikY7f4R5yxUjjMcbeuuaXG2YC4=;
        b=rV8Qq1zTj/mqAQLscWN+hHRGrpBFQz7Ai/S3kljTyK03CLIDKNz06WjsMkRDVsYsx0
         RmVY8DA/49HQb7MYt5x9SFGsNGllrTYgA8Ovt2566vYlaypERUdHVWTBPNcITZVSoLmo
         BGGZvgkak+eoLS+ItIs2jU/vbtOhRpj+wNGDv8oBZJdDAJhqswAdYxHnPw9z+5TtnNqK
         WYHnSi4riwQnvt4Bk49k83Uzw02VE3C3tXXs928y+Z31zQLVLT6QFlyN4xyMpMJx3tXg
         zk1r/piFdMHJZHMmL3EqZg0iQhcTu7aeT0UUv+nGv2eBB4sH+J4WwMGr/gOSrEWl0zZv
         tI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/mDM4m3k7JTmmCNbrikY7f4R5yxUjjMcbeuuaXG2YC4=;
        b=axFb5MzcEM87ZQWJ9nxAta6f3myFyB54lv53PHbDIpML2PCSK1Sd8tQhmmHUW9pa2Y
         4cy10IfTSe10qfK69fJbysdnNx86Shre+xbZ2MlRSjSCPWixXrOfMAkiQMcLQNROH0lW
         PQI4/W3utXtsyR4IlzO+aWTQpFwBIRt3iYcXD5BIQDqasf/m4spt5IDW2io8k3PdraOF
         j4j1qOaOpLt3ooG2fjubT6pEN9GIa7FWUeVOxD3mDeoT662cTTBfFhyrnvWln3oSZBx1
         gVBYrf+QVexrzRghA9XOo62Hga2lloJclF3WZCZCxraIhoS4JvXNiGvfbDechuL6pULG
         bXdg==
X-Gm-Message-State: APjAAAX9ZpS/z/0PprdJCDxEdhvspWzweLSlK/KcSUCyso9gqKKqWjRb
        peNSf0LUaDBYs3qOF2CEfzcmIhHPmYak2HtUXylRkw==
X-Google-Smtp-Source: APXvYqwwwX+oLoGrnp0iO7Ph5lNAvWQm97LqjGAYSHmqnVtQ7XHdlMS8rQnbz4rzIgZfjST0xq01CRRxqEDpLybjQrI=
X-Received: by 2002:a37:4a87:: with SMTP id x129mr28464725qka.43.1571049675564;
 Mon, 14 Oct 2019 03:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191014103654.17982-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20191014103654.17982-1-walter-zh.wu@mediatek.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 14 Oct 2019 12:41:04 +0200
Message-ID: <CACT4Y+YOwMB6bguUwpcgDeaenErqG+CeuqcV-9GmB72C13Fn5A@mail.gmail.com>
Subject: Re: [PATCH 2/2] kasan: add test for invalid size in memmove
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 12:37 PM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> Test size is negative numbers in memmove in order to verify
> whether it correctly get KASAN report.
>
> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Thanks!

> ---
>  lib/test_kasan.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 49cc4d570a40..06942cf585cc 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -283,6 +283,23 @@ static noinline void __init kmalloc_oob_in_memset(void)
>         kfree(ptr);
>  }
>
> +static noinline void __init kmalloc_memmove_invalid_size(void)
> +{
> +       char *ptr;
> +       size_t size = 64;
> +
> +       pr_info("invalid size in memmove\n");
> +       ptr = kmalloc(size, GFP_KERNEL);
> +       if (!ptr) {
> +               pr_err("Allocation failed\n");
> +               return;
> +       }
> +
> +       memset((char *)ptr, 0, 64);
> +       memmove((char *)ptr, (char *)ptr + 4, -2);
> +       kfree(ptr);
> +}
> +
>  static noinline void __init kmalloc_uaf(void)
>  {
>         char *ptr;
> @@ -773,6 +790,7 @@ static int __init kmalloc_tests_init(void)
>         kmalloc_oob_memset_4();
>         kmalloc_oob_memset_8();
>         kmalloc_oob_memset_16();
> +       kmalloc_memmove_invalid_size();
>         kmalloc_uaf();
>         kmalloc_uaf_memset();
>         kmalloc_uaf2();
> --
> 2.18.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20191014103654.17982-1-walter-zh.wu%40mediatek.com.
