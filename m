Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37189C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 04:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A92520872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 04:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eVZWpuNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404568AbfJQEKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 00:10:36 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:43760 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfJQEKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 00:10:36 -0400
Received: by mail-il1-f195.google.com with SMTP id t5so659652ilh.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 21:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WfD6ayjfYqzqP/LVh7w+bvnD4qYp9ltqa0DyJebxkC8=;
        b=eVZWpuNmW1LjNbZB427rwnRwJXN0K6rrcRk6OTdb3sr/zasrjkEs/A6KN26Cl4NOl3
         +Rh0iGrfl7+aOKNCCEMIh2A3m1oVJSUmRHxt8CczU8cOAzykww/p2p9sxc9HAvHHCShw
         QK5OCE7VBb+gc/OnQ/oiYModNGH7UBHpO0RGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WfD6ayjfYqzqP/LVh7w+bvnD4qYp9ltqa0DyJebxkC8=;
        b=Qo/6bfVP3UZmA2Pj4n2jywZNuGl2fhfMWanKCg5AueqGSDU+WkXXshDnck+Wuqcn0X
         mpCGH0oDEITDEGSd1C6hRgesm/HzHcwzTrLWVTbiC4Bf5TCHEbg712ADkow9hZu6RNDP
         DFONZVt/UimsoEwArowRvluLdvwF2fe8NyZYB0CCniEUQWkyu8Slcr7H7ec6PfvDwG9R
         j3wLcbw81UpH8cSvsUHsl2Gr9kFy38LLJ9Lk+abzhwvo9n35i4EyNc9voVPyS8J0l/f6
         fQMeOJy8lC1BpKCduBTJkmNG3ENDeZI5Mp7Xci/oXGGWuZt4hmTV/DcImU2WBEboKXSO
         xvQQ==
X-Gm-Message-State: APjAAAVAtLB6LNRNgo5Hd6EBjS8L7ZNvxuqPaF6JMozewAVBo9YjAQSP
        S8zdkH4j2RYsscsnfO6PElKHl1l4LN0=
X-Google-Smtp-Source: APXvYqyouU4NwYyuwRZ51tQQZkRgY/F9/pO02gWWdGbz3DbP66T3ByP1MbCXQ7FbbiD5BZZinF+bjg==
X-Received: by 2002:a92:5e4d:: with SMTP id s74mr1463106ilb.115.1571285435251;
        Wed, 16 Oct 2019 21:10:35 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id u25sm467967ill.4.2019.10.16.21.10.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2019 21:10:34 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id n26so1266051ioj.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 21:10:34 -0700 (PDT)
X-Received: by 2002:a5d:9952:: with SMTP id v18mr1049308ios.58.1571285433894;
 Wed, 16 Oct 2019 21:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191014154626.351-1-daniel.thompson@linaro.org> <20191014154626.351-4-daniel.thompson@linaro.org>
In-Reply-To: <20191014154626.351-4-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 16 Oct 2019 21:10:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W44zXesz8b8Z05_k7JjPW8D9z8fGT3GiGFSmSLw85zMQ@mail.gmail.com>
Message-ID: <CAD=FV=W44zXesz8b8Z05_k7JjPW8D9z8fGT3GiGFSmSLw85zMQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] kdb: Remove special case logic from kdb_read()
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 14, 2019 at 8:46 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> @@ -91,12 +92,17 @@ kdb_bt1(struct task_struct *p, unsigned long mask,
>         kdb_ps1(p);
>         kdb_show_stack(p, NULL);
>         if (btaprompt) {
> -               kdb_getstr(buffer, sizeof(buffer),
> -                          "Enter <q> to end, <cr> to continue:");
> -               if (buffer[0] == 'q') {
> -                       kdb_printf("\n");
> +               kdb_printf("Enter <q> to end, <cr> or <space> to continue:");
> +               ch = kdb_getchar();
> +               while (!strchr("\r\n q", ch))
> +                       ch = kdb_getchar();

nit: above 3 lines would be better with "do while", AKA:

do {
  ch = kdb_getchar();
} while (!strchr("\r\n q", ch));


> @@ -50,14 +50,14 @@ static int kgdb_transition_check(char *buffer)
>  }
>
>  /*
> - * kdb_read_handle_escape
> + * kdb_handle_escape

Optional nit: while you're touching this comment, you could make it
kerneldoc complaint.


> @@ -152,7 +158,7 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
>                                 return '\e';
>
>                         *ped++ = key;
> -                       key = kdb_read_handle_escape(escape_data,
> +                       key = kdb_handle_escape(escape_data,
>                                                      ped - escape_data);

nit: indentation no longer lines up for the "ped - escape_data" line.

Nothing here is terribly important, thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
