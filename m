Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880FFCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD1F20882
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JKTVSLuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfJURBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 13:01:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:45243 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfJURBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 13:01:48 -0400
Received: by mail-io1-f68.google.com with SMTP id c25so16753459iot.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 10:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y5hH+T0qVG92b2pjQ4AGR2b9Tlv1rtQ6rkilTn0xjxo=;
        b=JKTVSLuHreGlK+DNaNPXgQFU0MjZAlChAWNGTb49EArjloGdlj7S8IJ6yzHT5E49dN
         IxXGQOucKaaEtVznUcwZsLZbqnqbdocCACK35ndCwhr+xU2A21HKdBFo0FkyvxH+c4Wc
         ShyHrwYGag5kIluIoGhTUSVvb4jcks7TMbQvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y5hH+T0qVG92b2pjQ4AGR2b9Tlv1rtQ6rkilTn0xjxo=;
        b=QoVkz+yZn0oVozmM1s4DmAo0zmEKd9FjeQ7+KC2ITRX5VkIdE6FMP/5By96ki4xkTK
         plrySopfXEesOdhjwZ5vc6lpuLok2ZwzO4GO9UHatBJlHVi0fOGHVfQlNwtfRNbdPJpC
         8L6QxnF2Qpop5StAGwJEWHkl5/hJBDOFMD8YOErLXt8+fgZfhWRdy3LyoZ/NJE3UoHeM
         TuSNC5tJH09bjf9Xh1G4m+n+YtuJ9U6PmZQ/Y1TUB9NIKf6J2Kwx+qOaN71+5TFPt2xD
         SqTNRecxso7vOOZzh5+7dbBrkzaxI5daCYWXQOiKmiQU9B+hDAbOyYWXeOr4MCYpHZLA
         PD+w==
X-Gm-Message-State: APjAAAVfSY4XS/ZNXHtTF8W32s8wkpaYj8D+PAGQXL1+YAVX/fPFT95X
        l7ILBhbuxO5tyDfcf5l8uP93R5J5OwE=
X-Google-Smtp-Source: APXvYqw1KiSJgwSR5gWuxe/Dt2irE5j5i4vo5bkJqGcfklvRlaqrhBTIKwf+KyJe5er6+qVrJqsqug==
X-Received: by 2002:a05:6602:119:: with SMTP id s25mr22859924iot.111.1571677307000;
        Mon, 21 Oct 2019 10:01:47 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id l21sm5088152iok.87.2019.10.21.10.01.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 10:01:46 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id 1so5463730iou.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 10:01:46 -0700 (PDT)
X-Received: by 2002:a02:b691:: with SMTP id i17mr23172933jam.132.1571677305848;
 Mon, 21 Oct 2019 10:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191021101057.23861-1-daniel.thompson@linaro.org>
In-Reply-To: <20191021101057.23861-1-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 21 Oct 2019 10:01:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X9ESYnfWJLR1gsLwswBsTkbEh1-C7ki3=3AgFzUKkn3g@mail.gmail.com>
Message-ID: <CAD=FV=X9ESYnfWJLR1gsLwswBsTkbEh1-C7ki3=3AgFzUKkn3g@mail.gmail.com>
Subject: Re: [PATCH v2] kdb: Avoid array subscript warnings on non-SMP builds
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 21, 2019 at 3:11 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Recent versions of gcc (reported on gcc-7.4) issue array subscript
> warnings for builds where SMP is not enabled.
>
> kernel/debug/debug_core.c: In function 'kdb_dump_stack_on_cpu':
> kernel/debug/debug_core.c:452:17: warning: array subscript is outside array
> +bounds [-Warray-bounds]
>      if (!(kgdb_info[cpu].exception_state & DCPU_IS_SLAVE)) {
>            ~~~~~~~~~^~~~~
>    kernel/debug/debug_core.c:469:33: warning: array subscript is outside array
> +bounds [-Warray-bounds]
>      kgdb_info[cpu].exception_state |= DCPU_WANT_BT;
>    kernel/debug/debug_core.c:470:18: warning: array subscript is outside array
> +bounds [-Warray-bounds]
>      while (kgdb_info[cpu].exception_state & DCPU_WANT_BT)
>
> There is no bug here but there is scope to improve the code
> generation for non-SMP systems (whilst also silencing the warning).
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: 2277b492582d ("kdb: Fix stack crawling on 'running' CPUs that aren't the master")
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>
> Notes:
>     Changes in v2:
>
>      - Moved the IS_ENABLED(CONFIG_SMP) test to the first (slightly easier
>        to read the code, improves code generation a little)
>      - Sent out as a proper patch e-mail ;-)
>
>  kernel/debug/debug_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 70e86b4b4932..2b7c9b67931d 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -444,7 +444,7 @@ int dbg_remove_all_break(void)
>  #ifdef CONFIG_KGDB_KDB
>  void kdb_dump_stack_on_cpu(int cpu)
>  {
> -       if (cpu == raw_smp_processor_id()) {
> +       if (cpu == raw_smp_processor_id() || !IS_ENABLED(CONFIG_SMP)) {

At first I thought maybe your code would be less efficient than:

  if (!IS_ENABLED(CONFIG_SMP) || cpu == raw_smp_processor_id())

...since the compiler would be still be required to "call"
raw_smp_processor_id() in the non-SMP case.  ...but then I realized
that seems to be a macro in the non-SMP case and just resolves to 0.
...so while the compiler would still be "required" to execute the
first part of the if test, it should be able to realize that it's a
no-op.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

-Doug




>                 dump_stack();
>                 return;
>         }
> --
> 2.21.0
>
