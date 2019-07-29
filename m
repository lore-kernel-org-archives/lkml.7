Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA68C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A0F2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="js95TmVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfG2TNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:13:05 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40050 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbfG2TNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:13:05 -0400
Received: by mail-io1-f65.google.com with SMTP id h6so35970878iom.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 12:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ZlNUIYJRHifCdPri9SMA8pO4Nh5Z8AKEbChCIx9WaU=;
        b=js95TmVG44zg68Pzp7YQvvDNE5S3by0hmMEXX6zqN7/Te/wLCBHdcZATz+X/0KKkfy
         KHllTVk9CjFbRXEqHs82Wg81F2s2bbPUircRnDfRoO8nhk/XHWKIk/kY4ksNMjs1zKSx
         /rggG30zNUznF/KeI6d1RnyVtMBH3431GNd5R0JzXkpxMprJGDQzCpHLa2xEI0nM3WJu
         vcVdUnjDNHzkotKwFOYTGPQPOGXWlQvLUgKs+QqYurlmQsBDPLao1dSg5+ycEyVLYDrc
         f2uKSKrhK9T8+Ts4v5+9idjX2rau67AkcgounOHOaJ6e/fjfOxu+Jtn9+7PQbXkO0tQu
         J6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ZlNUIYJRHifCdPri9SMA8pO4Nh5Z8AKEbChCIx9WaU=;
        b=IebM25oKb6R5H0sY4TdpvG4nQTLlMrbBmdfDOog+vvt19hoqJr62IqHzlTDXm4EqsB
         brXT1dxMyHN7pvPGs9kwGSRWN+lGwrgnSz9nhsR5arGjJjpla1cXT5w0Z3JihVVKq8Df
         09mAhKAQa89SPfcwah9845Jyx4VjrPvCEF8dssIFjh4PL+jm2PeCLodaKDXi6ba+5MWZ
         oPo+wENJS3pKbPqZnUfAGajbJwsfJHg5YvZFYwH6Q64UTqGOcsJvWOo5k2GeWd4KUCnT
         HekQvA797n8it8oIMMds1q8bPEJAzUouTULAUhrwhk1IEMqqPhoufqvAZqYfWzUz1NOb
         mESA==
X-Gm-Message-State: APjAAAXKJOwq7Fs2jnW0h14V6YECREiIBVf04JAuuK6KzF6DwSKC2Kjx
        AIhYfwjnNwzmruHkV7u/0X/XU359VgQPDIboh3E=
X-Google-Smtp-Source: APXvYqwIwmK0xElBjA/nOJ8hADi4zfz/MDtOHjzWdJYU1bnYuKVq4ePDvOZt5byXSLzOYtQ5TBRVwCNr5FZxsU2m2VM=
X-Received: by 2002:a5e:de0d:: with SMTP id e13mr3536780iok.144.1564427584481;
 Mon, 29 Jul 2019 12:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190729163355.4530-1-areber@redhat.com>
In-Reply-To: <20190729163355.4530-1-areber@redhat.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Date:   Mon, 29 Jul 2019 20:12:53 +0100
Message-ID: <CAJwJo6Z5qHThG5wECSn+jiS0iM3smuXA1OS96Gho1HL-gD=RKQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fork: extend clone3() to support CLONE_SET_TID
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2019 at 17:52, Adrian Reber <areber@redhat.com> wrote:
[..]
> --- a/include/uapi/linux/sched.h
> +++ b/include/uapi/linux/sched.h
> @@ -32,6 +32,7 @@
>  #define CLONE_NEWPID           0x20000000      /* New pid namespace */
>  #define CLONE_NEWNET           0x40000000      /* New network namespace */
>  #define CLONE_IO               0x80000000      /* Clone io context */
> +#define CLONE_SET_TID          0x100000000ULL  /* set if the desired TID is set in set_tid */
>
>  /*
>   * Arguments for the clone3 syscall
> @@ -45,6 +46,7 @@ struct clone_args {
>         __aligned_u64 stack;
>         __aligned_u64 stack_size;
>         __aligned_u64 tls;
> +       __aligned_u64 set_tid;
>  };
>

I don't see a change to
:    if (unlikely(size < sizeof(struct clone_args)))
:        return -EINVAL;

That seems backwards-incompatible, but I may miss some part..

-- 
             Dmitry
