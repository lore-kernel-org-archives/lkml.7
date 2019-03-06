Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9F7C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB29206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xqismq3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbfCFJ4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:56:35 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34687 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfCFJ4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:56:34 -0500
Received: by mail-lj1-f195.google.com with SMTP id l5so10315340lje.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 01:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yEgciwo74r6L4X4QmqakPxxm+3jaaTZZ7kRHGY9cfkY=;
        b=Xqismq3M/3qd2q2EUQWoh7lfLWHeHWwGek+X3MxfChEmF+8nU33my4UlHUDn+ASct+
         HQYFGcn+MiDbMLdabxo2jBj+lgEoCvbv/MSysSUhDKoWMWp7eEEFiL9WJJGhcNNm4EVA
         UPKuFAV+6I5K0g2hTEAXltIxJ7hzIysMPbSo6BTYPc9Hm53HlStjb6T/l6fqPecjwiQw
         7EtUQB0y/W2Jewk0EsItYGykw/q9X3TT2Ei612DpDgYGmg7VfFbJaXW94n7ury2YyGwh
         ifDzIvsTnWB14M2n5u8VvinWebcEEci3T3B5yopHhLn2tY8aemP+c7trIQ5yX3aN098x
         XF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yEgciwo74r6L4X4QmqakPxxm+3jaaTZZ7kRHGY9cfkY=;
        b=sx85qx9RBqYuo8tNvU8fnZ6fFdhfErA/PggwNcC8GcYmtjrS1vUOu4LTRhoY0b6i3Y
         ihrj45IFTeXORT0pi2OruA6yz3el1RYdM3P89vYoBz9R/iwNIzq9C7lfRkflFwIsQ7TA
         DliEMcba4ESOy6RbJGQIMQOTDQs/y5Qi+4OHQrsG53XUFhozeB4CpiY4fBbtvRjVWbUe
         aIUEdIUMifhoBRWGe4PjD9aPJ78zzQ7AAMQJR3ZR05YYwKX2FS6NsBSJX1SqMvxpwNUw
         LggGwfBjfTEtwwA079AIGTI/1ehuzhKxSsl9wvl+0pKa0cyNp9Y+ZRjE+EKJmrvTMMdf
         QCGA==
X-Gm-Message-State: APjAAAX5ka/sSf7kLWZxktGo66tXUDv+9E5X0hIjoKYYHJbSmsyFAsWV
        e0TmOBlqxc+IxLmXYS3quw0U3tGNgAXy37O0em0QSzM7
X-Google-Smtp-Source: APXvYqx4IKWDa9aqgKWKw2x50pzvvxMwXQ/w0d7pMwnSwULOXilXkCyNBhsKdHILwXk1h0EpxbCmIjtE9mKorwMZNrg=
X-Received: by 2002:a2e:780a:: with SMTP id t10mr1656075ljc.19.1551866192846;
 Wed, 06 Mar 2019 01:56:32 -0800 (PST)
MIME-Version: 1.0
References: <20190301184816.784-1-mans@mansr.com> <20190301184816.784-3-mans@mansr.com>
In-Reply-To: <20190301184816.784-3-mans@mansr.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 6 Mar 2019 10:56:21 +0100
Message-ID: <CANiq72nFOhrjN0nfBQc28dDyY0XPwWrJwWSkXv0yxGb-B2M-JQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] auxdisplay: charlcd: make backlight initial state configurable
To:     Mans Rullgard <mans@mansr.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 7:48 PM Mans Rullgard <mans@mansr.com> wrote:
>
> +#ifdef CONFIG_CHARLCD_BL_ON
> +#define LCD_INIT_BL "\x1b[L+"
> +#elif defined (CONFIG_CHARLCD_BL_FLASH)

Style nitpick: no space after "elif defined". Do you mind if I change
it before sending it to linux-next? Otherwise, looks fine to me.
Thanks!

CC'ing Willy in case he wants to take a look for charlcd.c

Cheers,
Miguel
