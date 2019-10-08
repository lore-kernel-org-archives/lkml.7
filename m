Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6C3C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45EA20873
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 22:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U+XLcNgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfJHWU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 18:20:57 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34886 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJHWU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 18:20:57 -0400
Received: by mail-io1-f68.google.com with SMTP id q10so579809iop.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 15:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3cGhRmXoX7em9EGDCBwQCuo/Mdk5iXwJzsobY+LVqP8=;
        b=U+XLcNgxdPpA0k77YJ8teB2psbrpM6F+e1/FlxKJlocg8hoBUlS7cM7Kb97GD2vnlo
         SSa2gc//2n8lrx+nRGUFCmg7YUSHVTQofxccijZJjuBQaGG9YsB9SjTxbyI2Y1baUwBz
         Ij82NUAvuLWtLt3GU0AlbOym7w4xx5ShwJhI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3cGhRmXoX7em9EGDCBwQCuo/Mdk5iXwJzsobY+LVqP8=;
        b=gt0Da0acsWMrM6De8wkh8Y5o3oUBNTKnCsMg0EAZzxCVI3in/bYAkEMiLxi0tSTnVy
         Apu4NAT1Rr+vC+UhNHjlDpikM8r7i/EgT2O+cT9PyGsviZYG7KOw3aQhXbToB9spwgy8
         r0Cj7arJ+91v/Er7Aa2CEycEhcuxKWiXzkEjQObH66bqLMIkmHHy3X041qvu9T9ITl5d
         CWOtRnWH2vLwiqgTwhe7wA33hU+oVEI5saZXLWckWB8KsvMlyww6mpQ2WxXBbcF0m6PW
         RJaEihhsnH5AX3Gm0xjbiZv7RwdSowVMAwVcakRfQXHQ05Cz0C8QWO4fBkcvTQVpt8m+
         QtKQ==
X-Gm-Message-State: APjAAAXfuxCNVzHU86tfU+L+S9EVqVm1vJ9olcAUK+vKlgautp3WKSsf
        Am/LXByGpXDJTLBP/EbCj2aAdCxGGTM=
X-Google-Smtp-Source: APXvYqxVDW60CWGs7axFHnWX4cYNFEo4/J+d2AVFodMOtgx8X5qbJ7Y+r5p0nmfufd72cABd5VZ2Lg==
X-Received: by 2002:a6b:7d0b:: with SMTP id c11mr448286ioq.222.1570573255783;
        Tue, 08 Oct 2019 15:20:55 -0700 (PDT)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id i18sm224114ilc.34.2019.10.08.15.20.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 15:20:55 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id v2so464250iob.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 15:20:55 -0700 (PDT)
X-Received: by 2002:a6b:8a:: with SMTP id 132mr515861ioa.168.1570573254743;
 Tue, 08 Oct 2019 15:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191008132043.7966-1-daniel.thompson@linaro.org> <20191008132043.7966-3-daniel.thompson@linaro.org>
In-Reply-To: <20191008132043.7966-3-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 8 Oct 2019 15:20:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WmznUNO15Bk3hjN9k4irfVM1wAHpo4B8hG5jrnYA_D5g@mail.gmail.com>
Message-ID: <CAD=FV=WmznUNO15Bk3hjN9k4irfVM1wAHpo4B8hG5jrnYA_D5g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] kdb: Simplify code to fetch characters from console
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

On Tue, Oct 8, 2019 at 6:21 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently kdb_read_get_key() contains complex control flow that, on
> close inspection, turns out to be unnecessary. In particular:
>
> 1. It is impossible to enter the branch conditioned on (escape_delay == 1)
>    except when the loop enters with (escape_delay == 2) allowing us to
>    combine the branches.
>
> 2. Most of the code conditioned on (escape_delay == 2) simply modifies
>    local data and then breaks out of the loop causing the function to
>    return escape_data[0].
>
> 3. Based on #2 there is not actually any need to ever explicitly set
>    escape_delay to 2 because we it is much simpler to directly return
>    escape_data[0] instead.
>
> 4. escape_data[0] is, for all but one exit path, known to be '\e'.
>
> Simplify the code based on these observations.
>
> There is a subtle (and harmless) change of behaviour resulting from this
> simplification: instead of letting the escape timeout after ~1998
> milliseconds we now timeout after ~2000 milliseconds
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/kdb/kdb_io.c | 38 ++++++++++++++------------------------
>  1 file changed, 14 insertions(+), 24 deletions(-)

Looks great.  My only comment is that since this was the 2nd patch in
the series I spent a whole bunch of time deducing all these same
things when reviewing the first patch.  :-P

Reviewed-by: Douglas Anderson <dianders@chromium.org>
