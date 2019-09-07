Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2563C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 20:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED2821835
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 20:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLvcUd52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391614AbfIGUYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 16:24:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33058 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfIGUYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 16:24:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so6725178pfl.0;
        Sat, 07 Sep 2019 13:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kSwXjXzZYKJiCqywH51dxpo2qwU9GV6iT5gLa0TXjcw=;
        b=RLvcUd52lld4E+8udQ1d806EtK4KC7v/TKuhinRSgzE3aRETZCt2Gq4C35mRt0DHhI
         3a38H9fkszjh52jqcN7Sf9eNmLFIV5gIgGHa28FjiPrM0EX1Y8fttthqtUrLC59XTuCh
         WKk+ZzHgzL0d05FkMU8Ha0r8lFt5BjYy7FXJ72HfZ23mI4AHlw5WKVfIG2iouipgiUAY
         mNCoRsilN7ixpWv+DrOENtYFR8Z3Jmw2ujry6Z7C89SkBXr2M2TUI5ClToGRC5LROBnG
         1iEItEAmCc5fl9pYRy2Kp4TrelFSEE2mZ6QN/6WLoUbhk5Of41erqjuDxvHpDr4xcvtN
         kOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kSwXjXzZYKJiCqywH51dxpo2qwU9GV6iT5gLa0TXjcw=;
        b=BQ+IHwjDA7nYMtPcwA/X6v/oyuI/3UOP4d/CgkxVKkrripZ+ojin0yn2nqu0ndx/ul
         dY5zhuR1c/06boHsgpqGbBuqDlrNLrDIUxvCnlzm/cu8nhsaLy7HJi+umHvW35VDSAoa
         ADcqQ6csWtSE2xEebqToDF4QtQtpsa3TBASDJRUgX1Gprw2ck3CcAv8KrOYlJ0CwMG+j
         LF3KW+7IyTeDzXfcNf76Ma0RT3LUINFOffCK3ZYKK+juQgdmLVhY7ib+w0Pf++vfjffX
         MA2UoU1AozsBCom8Qeo8t7geYNxScJUfexDT3dPLrZblDyXYgUOvF97cFzBilOrkXQcA
         YkTQ==
X-Gm-Message-State: APjAAAV1wOa4VE+XAV3agSQU28k4Lr+hjJ9JVl/yDpIF1yEui1lts2XS
        FhxX0jklbEZPXz+inU2OSwkqkpX05RKrEJdBXy5zBNRh
X-Google-Smtp-Source: APXvYqy7iVRX8NOM2h1P14zFXDH9B6tkp/Hu+ZIT9lRPjZPyaNK0MS3qTgc/lr78H/XX/OQCAU785UiqT1I6AInkvmM=
X-Received: by 2002:a62:c141:: with SMTP id i62mr18689338pfg.64.1567887845980;
 Sat, 07 Sep 2019 13:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <a68114afb134b8633905f5a25ae7c4e6799ce8f1.camel@perches.com>
In-Reply-To: <a68114afb134b8633905f5a25ae7c4e6799ce8f1.camel@perches.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 7 Sep 2019 23:23:53 +0300
Message-ID: <CAHp75Vc=hSTWzSDToijXJGWxiHA1JOA2e8R0YYmETQ+tTfVhYw@mail.gmail.com>
Subject: Re: [PATCH] docs: printk-formats: Stop encouraging use of unnecessary
 %h[xudi] and %hh[xudi]
To:     Joe Perches <joe@perches.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Louis Taylor <louis@kragniz.eu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 7, 2019 at 9:15 PM Joe Perches <joe@perches.com> wrote:
>
> Standard integer promotion is already done and %hx and %hhx is useless
> so do not encourage the use of %hh[xudi] or %h[xudi].
>
> As Linus said in:
> Link: https://lore.kernel.org/lkml/CAHk-=wgoxnmsj8GEVFJSvTwdnWm8wVJthefNk2n6+4TC=20e0Q@mail.gmail.com/
>
> It's a pointless warning, making for more complex code, and
> making people remember esoteric printf format details that have no
> reason for existing.
>
> The "h" and "hh" things should never be used. The only reason for them
> being used if if you have an "int", but you want to print it out as a
> "char" (and honestly, that is a really bad reason, you'd be better off
> just using a proper cast to make the code more obvious).
>
> So if what you have a "char" (or unsigned char) you should always just
> print it out as an "int", knowing that the compiler already did the
> proper type conversion.

> -               char                    %hhd or %hhx
> -               short int               %hd or %hx
> +               char                    %d or %x
> +               short int               %d or %x

> +               s8                      %d or %x
> +               s16                     %d or %x

This is incorrect. Integral promotions promotes also sign, which will
produce too many f:s.

-- 
With Best Regards,
Andy Shevchenko
