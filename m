Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E45C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E29627413
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a09cCL26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfFCSl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 14:41:57 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36774 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFCSl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:41:56 -0400
Received: by mail-ua1-f65.google.com with SMTP id 94so6868877uam.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 11:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VsSotgwA1nxU4EAySnnvJ5ZgB7iMM3DB2x56bZwTUg8=;
        b=a09cCL26+bNOhQdoUo4x1wwzRc4g9+ZUKrcQIliCV1lVo86BnM7yonXBOHs3n8ThUp
         tBeLLscjAUtngd30ZkAshMl1RND5mQUFk5hVmajXhWgn0Q6ATNrv0OJKmvUbmJLKJjZp
         7PN3dXgD7aCNGHhYS/nSswGo8LZlcgEqVC4Fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VsSotgwA1nxU4EAySnnvJ5ZgB7iMM3DB2x56bZwTUg8=;
        b=M0PR7H5iLbznJBA39CpdssFIgyDtxIbubJ5OTrq5RS/EaJsNQaj+M1EGgOCa7hez0B
         QN1EWjIQrOPm/UTL7s6CzgKY5Dbmu1ZLaTRiGOog6ggBW08o7w8OjsmgnWreTk9XiYLH
         Oeepp50+fwXGB6qodkL/yWeCg2sWUfJKncI0alFceozPbkYaV3POE5PTrSmXscqwdZHy
         iSpPmVXG/xZ4goSoM0Hna5hgEm9w+e5qw1uwedEr/WukHLQ01WFZkCTXNPNC8iO7QUTm
         5hUREvLroIauLVdZkt1XF7NkzLbnu9oTSDubKM+mwKt/OX8EEi3pNjepX25JyHv4cXyS
         WD+g==
X-Gm-Message-State: APjAAAWqxZtWYH9k7OtHlPmaxJu1tgsaDeyq5G/NsCG6A+3/UnZqmCLK
        PFqKZIrilsaClnPt3ftCJOcSWOz6tVo=
X-Google-Smtp-Source: APXvYqx9VHQcUJRctke816d+PAA3Fx3azzqu0C0kPLEyC3aSYQVkvyd9oksLRPRwv8oPwfyI6tqnTw==
X-Received: by 2002:ab0:14cb:: with SMTP id f11mr13521877uae.24.1559587315790;
        Mon, 03 Jun 2019 11:41:55 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id j134sm4804029vka.4.2019.06.03.11.41.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:41:55 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id n2so3515260vso.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 11:41:55 -0700 (PDT)
X-Received: by 2002:a67:ec5a:: with SMTP id z26mr9662027vso.144.1559587314889;
 Mon, 03 Jun 2019 11:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190429204040.18725-1-dianders@chromium.org> <CAPDyKFp0fQ+3CS-DadE9rO-9Npzve-nztY9hRaMdX7Pw9sUZMw@mail.gmail.com>
 <CAD=FV=XMph_CE3pFZGP+5d0K2FgbPbheF1oX72TfZn_dpf8SQA@mail.gmail.com>
In-Reply-To: <CAD=FV=XMph_CE3pFZGP+5d0K2FgbPbheF1oX72TfZn_dpf8SQA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 3 Jun 2019 11:41:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U7_ek_z7UfaDn9My8UfZfpNom04OJHowoH-sNsGZQnxA@mail.gmail.com>
Message-ID: <CAD=FV=U7_ek_z7UfaDn9My8UfZfpNom04OJHowoH-sNsGZQnxA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: dw_mmc: Disable SDIO interrupts while suspended
 to fix suspend/resume
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Sonny Rao <sonnyrao@chromium.org>,
        Emil Renner Berthing <emil.renner.berthing@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        "# 4.0+" <stable@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ulf,

On Tue, May 28, 2019 at 3:49 PM Doug Anderson <dianders@chromium.org> wrote:
>
> > 1) As kind of stated above, did you consider a solution where the core
> > simply disables the SDIO IRQ in case it isn't enabled for system
> > wakeup? In this way all host drivers would benefit.
>
> I can give it a shot if you can give me a bunch of specific advice,
> but I only have access to a few devices doing anything with SDIO and
> they are all using Marvell or Broadcom on dw_mmc.
>
> In general I have no idea how SDIO wakeup (plumbed through the SD
> controller) would work.  As per below the only way I've seen it done
> is totally out-of-band.  ...and actually, I'm not sure I've actually
> ever seen even the out of band stuff truly work on a system myself.
> It's always been one of those "we should support wake on WiFi" but
> never made it all the way to implementation.  In any case, if there
> are examples of people plumbing wakeup through the SD controller I'd
> need to figure out how to not break them.  Just doing a solution for
> dw_mmc means I don't have to worry about this since dw_mmc definitely
> doesn't support SDIO wakeup.
>
> Maybe one way to get a more generic solution is if you had an idea for
> a patch that would work for many host controllers then you could post
> it and I could test to confirm that it's happy on dw_mmc?  ...similar
> to when you switched dw_mmc away from the old kthread-based SDIO
> stuff?

Unless you have time to help dig into all the possibilities here to
help understand how this should behave across all the different host
controllers / wakeup setups, maybe we could just land ${SUBJECT} patch
for now and when there is more clarity we can revisit?

Thanks!

-Doug
