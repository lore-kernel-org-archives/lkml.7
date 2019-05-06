Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68CCC04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EAC20830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ALeaEk9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfEFJwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:52:09 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38793 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfEFJwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:52:08 -0400
Received: by mail-vs1-f65.google.com with SMTP id v141so7746860vsc.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 02:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DmsBhkWlYc1uTNw6jjpjWWASyR4UniOiR+IT6QHntHo=;
        b=ALeaEk9CIsi5/SHzgOkGrfo3YVdBP/hnx+rPsqMosbUzT0agIR+DCcF41mPVsIH2m/
         nEmge4VayE35vHVB6PNtNuDQN9TRFVwRnRnuuSlW/BhtKVXvA/t6YtvumSt6wVfDxGOl
         cAAVFBlC4/zDsCReQgHVykBYp3NFUxpFGlMUWxIl7tZVSo+g5l0AfZwpksDtUapreSoT
         pUSQXqkSuV+/usHSUlKtOCsB2eOKJZfn6/0mzeRcyhTHgQdal6D0WSRKAmzxIf+FBdaJ
         yxw2gNdbFGmBz7NxMKMxH/Zw3GLVlX0u3IR7vssLk1nTTI1tJTtRL2VdNeWAXSx9HEwW
         oLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DmsBhkWlYc1uTNw6jjpjWWASyR4UniOiR+IT6QHntHo=;
        b=AStf5ObXWndKqx2xHsHtW5780xY0ju8vHQXmmS1l09GdFK9bO0y5JBzIrCaTEo6DMZ
         fITUyYiAwFqVfY+Cv328VgS3x0OEL/KgM/VpHF2VHUZnNFi8UqydV3V+SBitfcsKfm2K
         BEmsQNRS/2D1sbEVuoXsMdetVenC4hYoVnFVBW79HKGRvaBPm/zVJGfYEZsbDRisORDA
         7IsLOkMGKSfFYSs8yz97o4AWeL0ik86kSD867vkS3duO7uaKODtmIH2AoSkF9q2nlvPN
         PjGijremqaaJTXffwnbnOqiwCvNURWUKd4kzZNvNrzz+ThT2/zew+4y0sUaYoOep/0uY
         JftQ==
X-Gm-Message-State: APjAAAX1vfk868hgiLVNRgNgTKOJSIHhdLMoYffyXaRXPvQ8J56J1MCx
        k2MZfAMWEcogKVB1mR9R9XphMcx9EAscjqudcR9IQQ==
X-Google-Smtp-Source: APXvYqxF66GwjuWRom41i00LWsDcol9d1DnTeSM0hRqjZ8HvNnzE/hNVgU2a1XSbP9yYHmTqxELfJd0bOHoSwsErZRI=
X-Received: by 2002:a67:b44d:: with SMTP id c13mr12757692vsm.165.1557136326923;
 Mon, 06 May 2019 02:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <155696540998.8632.5242582397805128125.stgit@noble.brown>
In-Reply-To: <155696540998.8632.5242582397805128125.stgit@noble.brown>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 May 2019 11:51:30 +0200
Message-ID: <CAPDyKFp9aQNsqkUnznPUaDDZf8Oa95MRKmb35Y-PuMbSJPfZug@mail.gmail.com>
Subject: Re: [PATCH 0/4] mtk-sd enhancement to support MT7621 - V2
To:     NeilBrown <neil@brown.name>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        thirtythreeforty@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 May 2019 at 12:25, NeilBrown <neil@brown.name> wrote:
>
> The MT7621 MIPS-based SOC contains an sdhci unit that is
> much the same as the units supported by mtk-sd.c.
>
> These patches enhance the driver so that I can use it on my MT7621
> board (gnubee.org).
>
> This series have been revised based on feedback from Chaotian.

Applied for next, thanks!

Kind regards
Uffe


>
> Thanks,
> NeilBrown
>
> ---
>
> NeilBrown (4):
>       mmc: mtk-sd: don't hard-code interrupt trigger type
>       mmc: mtk-sd: add support for config found in mt7620 family SOCs.
>       mmc: mtk-sd: enable internal card-detect logic.
>       mmc: mtk-sd: select REGULATOR
>
>
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt |    1
>  drivers/mmc/host/Kconfig                         |    1
>  drivers/mmc/host/mtk-sd.c                        |   78 +++++++++++++++++++++-
>  3 files changed, 75 insertions(+), 5 deletions(-)
>
> --
> Signature
>
