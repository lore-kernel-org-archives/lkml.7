Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE708C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80746217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdwZ/pUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbfHHSED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 14:04:03 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33172 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbfHHSED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:04:03 -0400
Received: by mail-lf1-f66.google.com with SMTP id x3so67628037lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 11:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cUT1jn+mhet4enel6UW9FMleWsJ0B0RrS3ZSVN0Siaw=;
        b=qdwZ/pUi0gV3cRmJGekHjmIpDrjItjtcbMuwCUN+weS5dC3bpYKJL+E0p9fw1l6c/Q
         aKNRLBli+Sgz1FcLJRIZhRlUxuTVjn8l8K5uKI/jRFSRGkzywnolWVwKvwvzinFBMumf
         1OKB54FJalFs9V++4+7djePhBzdpgZ/gCWkO6FmwNXK14a4DEh6hEAyDoqtrJjA8n7/O
         dfH5Ad29dd1w5QqjOzzNaO7rZdsxkJ1D6RF4MHfI70obvDRrDTriHIuEMhOENaWvzFgI
         ChOPEQ8klZepZ1bjS4d05Z77UG4YqvqwLK/pJg/ixTGNzjKX5/oEjs+10Ls0a1ZtYlUm
         Eb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cUT1jn+mhet4enel6UW9FMleWsJ0B0RrS3ZSVN0Siaw=;
        b=qVJqDtRMNpn9fGUJSeEIrOF0ZbrZyK8e446EgDcw09aF42AxErRjARjgzTW8h0JKFr
         nlgO9kocDWMBr6/coHAFhbl8rg1rwj7ElGYCaDBdPklCdg8H/+971Fs8I5uASRx5pyq1
         ADXprAnqINbjuVxkOIJ1cV+5QrLWXibxGlw1o1uvRZG6yVi967obMz7xfwa2y0OkSCMS
         tENFuzTYQgKavA4iRBd9s8bRDQZ7N2Dio6L3zWO1Ybfks8FvahaUct0fjUn9DoB84Skn
         779X3qRBiBjAo6mM3Yuo1CfnGRlKtvRV2UcVDyeLjMBAu+UEBMFLx/leR8v7dtacvoto
         qn2g==
X-Gm-Message-State: APjAAAUAALneMCT8VDxTzzdOlDpyO4LvUaU2OaBV1uLsNEvh5+GLm34Z
        Do8acH+tRTVjC7ooI2tPfzFPUx4xTr3mqKegUFxFjg==
X-Google-Smtp-Source: APXvYqxAIuwx5MjBPJx/FB8Ydh95G4+dIv7a8HnRJhPFkh+dt5/ztZaEc523GDkPtGJJokQgibfjr2/m8q5oCypkT5w=
X-Received: by 2002:a05:6512:484:: with SMTP id v4mr10597105lfq.66.1565287441050;
 Thu, 08 Aug 2019 11:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190806071445.13705-1-yamada.masahiro@socionext.com> <20190806071445.13705-2-yamada.masahiro@socionext.com>
In-Reply-To: <20190806071445.13705-2-yamada.masahiro@socionext.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 8 Aug 2019 20:03:49 +0200
Message-ID: <CANiq72mb5OT63s2qUvEOQCbrva6a-rdkJp9nmG9tL7NAuhzfxg@mail.gmail.com>
Subject: Re: [PATCH 2/2] auxdisplay: charlcd: add include guard to charlcd.h
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 9:15 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Add a header include guard just in case.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Picked it up, thanks!

Cheers,
Miguel
