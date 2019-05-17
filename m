Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B878AC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 20:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AAA32082E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 20:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZzaaWOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbfEQUyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 16:54:54 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45336 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfEQUyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 16:54:54 -0400
Received: by mail-lf1-f65.google.com with SMTP id n22so6217273lfe.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 13:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JJRrTg5PzvuYeQUxZIzf7uCsLJxZe+UcmxFB9vCHOUc=;
        b=KZzaaWOkFfEqz35NjpvGePpuO7+LVzWdEqZmzLhKQO9og3mXF4tnhShX+9Vf1N8sWJ
         O5ReuNy3rFfJ47YB0SrozVrxKyFfX5SwCFQkuEFjh+cGFMxg0RHJ6ZnhjvVlcfrynrep
         900IrYhQhndSjxAgLk75cMMwQzC7Xe3e6yRrjhan44/OhrqGu1+4V7OX61MKakh2BiIP
         +nvYoar0+0UlBc0ycZc17RtY8PqhV/X6gf13TG8TcX4DkHEGQWeDrJlBM9MCZIzk8cRU
         09OBhTbYNvlXyGufA+xlRLT79mwlBzEygo0TNm80aZTd2JXGYYK2m6cL8fCtKgHONDJk
         GXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JJRrTg5PzvuYeQUxZIzf7uCsLJxZe+UcmxFB9vCHOUc=;
        b=RwnFmWe84e+vxLMi+JoC4Sh0Mnk6etO+EtaG/UmDMErOrGDwTHk53lNCCbbavs9Fby
         IHMihF2t/gb5Vhun8tpJmUD3HD8dlX834WjgVh8/m0+IFT8S+89kaSo5tJ3nNBjSoSZG
         fTRyqX0SZ+zkq6cdjsylDFqVgiUJTEa+7qywafMgfPxDaW4BH6mZ3/vTlc1WUeTrsiwV
         rBEZJ4bRVWgS8oTNn/7hQh/T4ST20mABnjj57qzIJlQCRnJ8rF1Y9cf5q6KkUfevxyZF
         MUW5WQFxWAhgDYFEt6hrXtWRpxuh5xgsTCWun4ikTobFX/yWOauFL2hGMSqVcjce8Od1
         0KXQ==
X-Gm-Message-State: APjAAAXC0P6Z4Ao36bJ5kA+Nd8Bnuloghv4ztD86q/tFL2QXxqISuMd0
        yoFusmVXKuexF2brSHN2hNdpAfUGuzmbH3e6FSw=
X-Google-Smtp-Source: APXvYqwPBcFBIBzB3B6o5rAKCa91HrqFkcRRTB6ksPmYAS/d80jXS4ecwAsfH7oVcs0Xu38JKV0VJEvETxckIH848fw=
X-Received: by 2002:a19:2d1a:: with SMTP id k26mr29727689lfj.104.1558126492487;
 Fri, 17 May 2019 13:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190517092502.GA22779@gmail.com>
In-Reply-To: <20190517092502.GA22779@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 17 May 2019 22:54:41 +0200
Message-ID: <CANiq72=GeQYK=j+WEa0NLVLK8O0mwoV+H+=1LjyBXVCq=8-JPA@mail.gmail.com>
Subject: Re: [PATCH] tracing: silence GCC 9 array bounds warning
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 11:25 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
>     ./include/linux/string.h:344:9: warning: '__builtin_memset' offset
>     [8505, 8560] from the object at 'iter' is out of the bounds of

By the way, I noticed these offsets of the new warning seem to be off
by 1, reported here:

    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=90525

Cheers,
Miguel
