Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E35C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7151820652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PSUXYiY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfCGPyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:54:18 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:45305 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfCGPyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:54:16 -0500
Received: by mail-vk1-f194.google.com with SMTP id v187so3816683vkf.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 07:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ttDNNQa3Jjdi8Qly1cSVuh0On7PITP8LM32lOUx7u8=;
        b=PSUXYiY64e04WGQyUpztEZwJTC9rHyLrkYW3Ov9UwxtDvNyEYFBJ7VnfPgBMI2NSLF
         Nx7nUT7Dok3c7VGEDSIYCavS4khea5GbhE9K1Mfcb5FRxdNGHjqvJQ7O7iVL9iqzh1bR
         REgD047NLLjTLn1lVvldUCgWqGVCH7cZesY4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ttDNNQa3Jjdi8Qly1cSVuh0On7PITP8LM32lOUx7u8=;
        b=Z7kwJmgLwkpgp3OhLwoEwpEnnL+3Ab36ZC8WQafNjvWdvUDjb0IAaD6y4KQp1ngmLI
         qq7WIB0GIKirASrw5U3iE8E9/UkrXIYQqyUfpz0CzTKTedZY32I3ihmrah2cDiSvZxpR
         LtlWx5Aak8pTYK+Zi3saeC1RV5AZ3r3RjKdlbkqGG5vbBhub43GdRMr2+eL9WZBKo6uP
         1tGeX2gxwdDY3RFNLCu/2FygQhYsPtvr+fG06n04BY22uMdBiR1Np4Xy4zNiEislcRNA
         4pRvHpjPaF6osYljW9kHLefqSNvCr8JRJsIjZz7MstpLdPdgS/jcPHgPYikF1qCz56Je
         Gvzw==
X-Gm-Message-State: APjAAAUMTkzpcxt8Uc/A2PnlgB+eH1K2ZSfgqb/VJCHAZfwZDLbQyM3d
        c/Uu6uufZ7EjJ/6ZGLiIEEU47G6S6Ho=
X-Google-Smtp-Source: APXvYqyVxrMZMSsxQVx39xiDnH1ewE4OCcQFEfPYcwbDf0agJeD0AbGjOPzZRww5J4PUIBA1znaBNg==
X-Received: by 2002:a1f:154:: with SMTP id 81mr6608330vkb.90.1551974054580;
        Thu, 07 Mar 2019 07:54:14 -0800 (PST)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id l14sm2855630vke.54.2019.03.07.07.54.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 07:54:13 -0800 (PST)
Received: by mail-vs1-f51.google.com with SMTP id y19so4766050vsc.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 07:54:13 -0800 (PST)
X-Received: by 2002:a67:fa45:: with SMTP id j5mr7448594vsq.48.1551974052705;
 Thu, 07 Mar 2019 07:54:12 -0800 (PST)
MIME-Version: 1.0
References: <20190302094312.13363-1-oded.gabbay@gmail.com> <CAGXu5jLGCfP8Wv58swP_=w6-xNSOvOqZW9WUjSMaJQAXbYHnSQ@mail.gmail.com>
 <CAFCwf10bKhXsmmoQG4FP9FT6jq2dJYrMZOzk424HGbwLCp9MjA@mail.gmail.com>
In-Reply-To: <CAFCwf10bKhXsmmoQG4FP9FT6jq2dJYrMZOzk424HGbwLCp9MjA@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 7 Mar 2019 07:54:01 -0800
X-Gmail-Original-Message-ID: <CAGXu5jL-uLPvoiGQ_mxv4pihC0uUPRDR01s0O8LNs8ASyaYxkw@mail.gmail.com>
Message-ID: <CAGXu5jL-uLPvoiGQ_mxv4pihC0uUPRDR01s0O8LNs8ASyaYxkw@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: use %px instead of %p in error print
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 9:42 PM Oded Gabbay <oded.gabbay@gmail.com> wrote:
>
> On Thu, Mar 7, 2019 at 5:46 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Sat, Mar 2, 2019 at 1:43 AM Oded Gabbay <oded.gabbay@gmail.com> wrote:
> > >
> > > When parsing the address of an internal command buffer, the driver prints
> > > an error if the buffer's address is not in the range of the device's DRAM
> > > or SRAM memory address space.
> > >
> > > Use %px to print the real address that the user gave the driver and not a
> > > hashed value, so the user will get a clue regarding the origin of his
> > > error.
> > >
> > > Note that if the print occurs, the pointer that is printed is a
> > > user's virtual address and not some kind of physical address.
> >
> > Err, which virtual address space is this? If this is mapped into the
> > kernel's virtual address space, this should not be %px...
> No, it's not mapped to kernel in any way.
> It's supposed to be an address in the device's address space.
> As this is an error message, it's either a wrong address in the
> device's address space, or it's a user-space virtual address.

Okay, thanks! :)

-- 
Kees Cook
