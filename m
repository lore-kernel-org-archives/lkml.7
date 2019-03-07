Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLACK
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74993C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D0920684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LE0lGsVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfCGMlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:41:52 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46196 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCGMlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:41:51 -0500
Received: by mail-pf1-f195.google.com with SMTP id g6so11330170pfh.13;
        Thu, 07 Mar 2019 04:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=olFkU/65HkxK00mHeSLg/d5LulsvqoasTALPzlb52B0=;
        b=LE0lGsVUCQlACRPDbLZjChQ1hY28J2yERJwkhs+owTG8n/oWWIqfYeELOf4hYdUATK
         Vxc5rWl6oLdMpEaGWOqmPgOJLVqXZiiugqbQLyfjW4xFwH4lphaT3sljQPQ1hMwyrbnX
         OCnxOJBnJ+0WkHZGWD8ELBywv1s6A4nuo21Gje1JBCOWFkDTUSh9+muwZtHXjEwl+/FV
         S8q4/s1Fyu+WlXsnsTZIdETUw/0eRTY6HxoK3bl3aUqTwLLERvXilSbvNeH/5XYJsprU
         q+l5TswVKeAx3urGPhjZNBgZ/OU1eDRbvxZqT702uHqFpXGQre6MXO25CsHFmvaZoSII
         x0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=olFkU/65HkxK00mHeSLg/d5LulsvqoasTALPzlb52B0=;
        b=hS+0TmbKqMp+e5rY0jbj7vXHbOC1yliqpOUrTJNn6RakJAcGiLC+BLZfJnCMH+godQ
         2FHJi9+SsLYLdcjoK8oYVYxTCRCXmSJDd/xTK9hxFTRj9GOTH66zMD5Nm2LR16YYknQ7
         gMNIhzaXB0eSWtG6dYA13UNVT0Pd9n5XXrDcioEp2QAGGvmaQ+cSW+1XDgG2dwExRZqa
         b4m7HiKKtHCFkTGLOFS1Z3Y4Yhj6Xt4WQ5VINOsF1LDlDMyCJwlXNANpmp+gVtx8CjKz
         zdRNjgygXMEQn9Qk/xSHW0M0TZu4CScFAMlxf9iraJ5CQyhdb++ON7M3YcKFd2Riclv4
         Ebyg==
X-Gm-Message-State: APjAAAWSEFJNSURABtm92gxtmtEDH/eejVjUC55+LZS5xSQ1mFOFH76L
        i6p4oRmVC8bakNOKUBL08tteVL84VMzMLPSy/yc=
X-Google-Smtp-Source: APXvYqySOQowoUQ+uHdArMzDO/e2I0CouEZ6Q2niLPdGaOnM7Bfk0xWmW136DP/DcG5ggo3sI+a7na4Y6IYlYem2DhM=
X-Received: by 2002:aa7:8c97:: with SMTP id p23mr12885105pfd.229.1551962510877;
 Thu, 07 Mar 2019 04:41:50 -0800 (PST)
MIME-Version: 1.0
References: <20190307080820.9723-1-jiaxun.yang@flygoat.com>
 <20190307112041.GC13633@kroah.com> <c84c9553-e31b-a175-59a3-aeb35afd0854@flygoat.com>
In-Reply-To: <c84c9553-e31b-a175-59a3-aeb35afd0854@flygoat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 Mar 2019 14:41:39 +0200
Message-ID: <CAHp75VfCfmqZyBs+8Mr9sh2C_y+XanA0C_NA2uhDJD3yQDh6dQ@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: disable bluetooth for some machines
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 2:30 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
> > On Thu, Mar 07, 2019 at 04:08:20PM +0800, Jiaxun Yang wrote:
> >> Some AMD based ThinkPads have a firmware bug that calling
> >> "GBDC" will cause bluetooth on Intel wireless cards blocked.
> >>
> >> Probe these models by DMI match and disable bluetooth subdriver
> >> if specified Intel wireless card exist.

> Thanks for remind.
>
> Should I resend this patch in correct way?

It still needs a bit of work, and as I told you, we are now during an
opened merge window.

-- 
With Best Regards,
Andy Shevchenko
