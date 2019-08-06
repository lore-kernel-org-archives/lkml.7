Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7443C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE242070D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 16:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsothXNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387460AbfHFQAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 12:00:52 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:39876 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbfHFQAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 12:00:52 -0400
Received: by mail-vs1-f54.google.com with SMTP id u3so58610389vsh.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 09:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ofg0wwZbH25QHjePp6RCyJhG7hAM5t6Xh6/enRreYVU=;
        b=XsothXNCfxB4CdRbKEmSVpbQ3VvuB27vn1KH1Bfd+0Vr9qb7WfjDfShAgdOLk7bXul
         p4vA4RBRJB+2jQvcAlzk0y7QzJSZWCT7ds/LbzysuSLyB2CYA6p/ktJLrAHTjpD/tczD
         60ykxwMCzVtjWP3+dnTXVQH6ECbkEU3iMFH6vPTwZ04AO8l4xFgeBAsI0Yvoq32c4HhU
         +fC5zQYiTLmRI7Ut2CuflX9LgrvrH02XDvW/A5zg/wnFRL9KkHMOkuW4X8KRGqv8G5EQ
         GQgS6s7scGa7CBAu7bYnZgFgqhtYEXft8ibSqpdFcuUxuC5fc969W2HTq5VO13IZ+u2L
         ntvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=ofg0wwZbH25QHjePp6RCyJhG7hAM5t6Xh6/enRreYVU=;
        b=oS9amCtPUgXLr+rBqAKtvJO9ctNQCcuBEM1EzgAiqqC7ykEnlYsm7cJztjXXTr3FNU
         OpuADFYWknwN/QjWf8Tx9RIUPdYkjhOn5uUhWXh2KkbQztc74jYwvVDwAjDS9LX6fjKK
         hTbt4JerbbaIz4JFCE9uxTdlSAC641R9NcOnI18aetXN4E0gqVhCDIhQCr9Z3B6pngny
         djIAaffUHZoU2iJlQTNzlVYAIZB0Ux423F6Apyd29qBBYf51+OYhlPCV5EJxYcd//tGF
         IdGFv08/Tby5ejT+h2fNtzhPmih8XMPPliFByrTKPS2zrST3vVsZGAXJ/aAV79Ksvv2B
         3Rrw==
X-Gm-Message-State: APjAAAXDxGvsLG9iWnwS21GYU9p2t0+R6iyeK+oxCMlUDjA3ITSIVSaM
        cPjLzxz/nXmJs3iU0+sSrXPfzxyuNl/0UPa63WXWHA==
X-Google-Smtp-Source: APXvYqxinkbL3p9W/9/duvU9g6pcCAFH3j4YdjfgOWY6vroylFU+tGG/ZsSuXIwSDN+UZY89Jb2Ng4lk+p2eNC7L6PM=
X-Received: by 2002:a67:e886:: with SMTP id x6mr2847851vsn.216.1565107250600;
 Tue, 06 Aug 2019 09:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAJrp0nBcm-++zejsjuM-q4=0eKzXOOUMUNjnTzfmt6FgDiiy1Q@mail.gmail.com>
In-Reply-To: <CAJrp0nBcm-++zejsjuM-q4=0eKzXOOUMUNjnTzfmt6FgDiiy1Q@mail.gmail.com>
From:   Fang Zhou <timchou.hit@gmail.com>
Date:   Tue, 6 Aug 2019 12:00:39 -0400
Message-ID: <CAJrp0nA8AVC4wBn5_84LOtNeBTC2g8vFoMXHzruYXrePzXy+1g@mail.gmail.com>
Subject: Re: Overhead of ring buffer in Ftrace
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any ideas or suggestions?

Best,
Tim

On Fri, Aug 2, 2019 at 1:41 AM Fang Zhou <timchou.hit@gmail.com> wrote:
>
> Hi all,
>
> I=E2=80=99m currently using Ftrace with tracepoints to trace several even=
ts in
> kernel. But I found the tracing overhead is a little high.
>
> I found the major overhead comes from
> =E2=80=9Clocal_dec(&cpu_buffer->committing);=E2=80=9D in rb_end_commit() =
function.
> local_dec() will invoke atomic_long_dec(), which finally performs
> LOCK_PREFIX plus "DECQ" on this variable.
>
> I'm a little confused. cpu_buffer is a per-cpu buffer. Therefore, I
> cannot come up with a scenario that two core runs INC or DEC on the
> same per-cpu value at the same time.
> So, why do we use such heavy-overhead operation here? Can we just
> simply use "DECQ" without LOCK_PREFIX?
>
> Thanks,
> Tim
