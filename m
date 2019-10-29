Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C321FCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BCF20874
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+YX88go"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388163AbfJ2NFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:05:41 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38428 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfJ2NFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:05:41 -0400
Received: by mail-oi1-f195.google.com with SMTP id v186so8846125oie.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 06:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I1m3xu+m9D6gNt192ldAysUnXZ1pnKI/Ej70V8nnp/Q=;
        b=Z+YX88goKKBun8hGKQzGum6fxwq27ys1g6YH8mzsIOFHjZeyo187uDWpv9vwW/WtQY
         IhmQsiwUHlb15K2hPLJuKkupAkfHS7Onbgi/YlW90rAKiooUkKIeAzm1mdgBj3LrQibk
         dL1h9sf9joqZ5kU6XHo3civXlReFlcQgLzizNYxvdbylsl+TMjCzZZgRGxLv0xyNqmqX
         1roCCPyB7/4zGEUdoTCCLX+L+wHqj5ARSlp+bNRvA1ULMzPFAheyhB3fDZqo1IQVM2Rv
         KZJ1V99zSEykVE1LQGtq+xYUEztrxqnjxSD+vJKenwf/UDB5b9cl1MYzcek5AI/MIHo9
         LzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I1m3xu+m9D6gNt192ldAysUnXZ1pnKI/Ej70V8nnp/Q=;
        b=BV/UIiYL5YkuaVD4tJCfkOCiWkSdgvheX2zQqqXU2SDAwato4XBTZks0qs/VSw3X5D
         eMwad2hR1PwyO5WcdKKskRtkslwK3NaK8BcU/hfGgGZP9o/O97z99xH3mATrEFsmwRE0
         9HA+NlKTgpODjhcUtHRLVvEnrtE2vlSwMaRSShfm0exI2mrjz+/EXgKNMK/rvM6qPOcs
         8XDeB9dpNTRiUdWvRXpPk4dP1AeUMVj33qUfs70vnsXrL3qJxDySysKaRTdWD4GPTn9E
         82MH4qLSCKE7UhxjS82f7PnM+GGOm9774Foij0nBx3wIUztGo5jhi8uFzFK22c2Zn7u2
         kZDA==
X-Gm-Message-State: APjAAAW61pfgC7dGaZ9cbKrxltrxKKVFvIZlIriQGKbEnPx3R5s22Vwu
        rBiQCREgUSkaGT0tiQ+t5QKaKXWRvupSVLALM1w=
X-Google-Smtp-Source: APXvYqzcuXK39zeqZTtDeXlSdcOoUxbBCJz+mD+QEuH872R+9IM1iojFTcgFg1Pi9wN5zc2183cyT1KJYO/hUnpAdu0=
X-Received: by 2002:aca:90f:: with SMTP id 15mr3812140oij.92.1572354340215;
 Tue, 29 Oct 2019 06:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <1570515056-23589-1-git-send-email-hariprasad.kelam@gmail.com>
 <CAGngYiX0zoAQB=SEoXfoMm9u_JzHu3eLErj4zmTYtSAoDwkp6Q@mail.gmail.com>
 <CAGngYiXxagQMiHA-pZupTPHfyFz4kU=QOrvM28L_jSV1VGw=jQ@mail.gmail.com> <20191029080336.GA493801@kroah.com>
In-Reply-To: <20191029080336.GA493801@kroah.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 29 Oct 2019 09:05:28 -0400
Message-ID: <CAGngYiWDUbnLCDMM4JM-Jn3GNBvQsbrD5NfNmL59q-3DVeD3uQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fieldbus: make use of devm_platform_ioremap_resource
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 4:03 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This has been in my tree already for a while, can you verify it is all
> ok?
>

All good. I see you took Cristiane's version, not hariprasad's or YueHaibing's.
As long as one version lands, all is well :)
