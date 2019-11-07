Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD1EC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 04:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A4A2077C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 04:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="If1p9UVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733197AbfKGEQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 23:16:57 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45274 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbfKGEQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 23:16:57 -0500
Received: by mail-vs1-f65.google.com with SMTP id l5so377269vsh.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 20:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LzF6jJl50QUKrzPAcp1BtDAHHTNuNTHTqpvlK0Y3t24=;
        b=If1p9UVVHbMT3OMrRjX6TZFEEaZIstvxpkIGc+J3eG+t7D9eaOQd+EJ9TUQR5C/SDf
         yj7ert6J1aSel7bNYUWjAQwAzESIRkq+ogInQv/yiqKAweakTEn811k3YMwfeOwOYKL7
         ZGWYtHxByLb/c9z1Vi/rBi0wJgfh1LUnYhR34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LzF6jJl50QUKrzPAcp1BtDAHHTNuNTHTqpvlK0Y3t24=;
        b=lI/BPNIR2fkKUPtS2V16Z3iouLIlUhmSAmjMyPs+6Ro/eMPUjLmgRWSlJOyheSuS3Q
         ZwIfCu/fMifxR6+ygkYTOupqr2mzPM48FWk0ZqxUc/XazZpHUmLLbGtzBbYbT/H9qVeR
         5t+2hfyzOils6rTHmGMznVShveEubkdGSzmODmduAHMWiwm6xo9hryEFXCGIdeIVFT8W
         ngrZ2zeS2U685Hi2kJG9id7sgx60eK4x8FScqBOwkw/Hp60WIvntkW8McDTcmeRaiMly
         oJwiEA0bgkyx2DQN8GzaNI+Y5JOwsOTZm7CmVLHV0ejGc/g6Wysnjhzx+a63nE9Owts/
         EebA==
X-Gm-Message-State: APjAAAUR428zezsqdRIWcR5/U0V3kC6ywHV2AUNkrFW7TTdiq2Rx4/Js
        NEtkUnhRejtDOAxksFRnOVh4cZG75LLiTkZqW1M7Ew==
X-Google-Smtp-Source: APXvYqyWoK9jREMyy8vyY43cMb0kasmyVW+I0hWsxZz0YGbqht5M4oAStGMyGw23UCirgUqEvwgbjD/YfpkA627rwok=
X-Received: by 2002:a67:edce:: with SMTP id e14mr1297463vsp.182.1573100216052;
 Wed, 06 Nov 2019 20:16:56 -0800 (PST)
MIME-Version: 1.0
References: <20191101054035.42101-1-ikjn@chromium.org> <87y2ws3lvh.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87y2ws3lvh.fsf@kamboji.qca.qualcomm.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Thu, 7 Nov 2019 12:16:45 +0800
Message-ID: <CAATdQgDhYWgHkujo9m1iUrhSu1Bt9A4C8eS82TD=W22_eaF80g@mail.gmail.com>
Subject: Re: [PATCH] ath10k: disable cpuidle during downloading firmware.
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 2:23 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Ikjoon Jang <ikjn@chromium.org> writes:
>
> > Downloading ath10k firmware needs a large number of IOs and
> > cpuidle's miss predictions make it worse. In the worst case,
> > resume time can be three times longer than the average on sdio.
> >
> > This patch disables cpuidle during firmware downloading by
> > applying PM_QOS_CPU_DMA_LATENCY in ath10k_download_fw().
> >
> > Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
>
> On what hardware and firmware versions did you test this? I'll add that
> to the commit log.
>
> https://wireless.wiki.kernel.org/en/users/drivers/ath10k/submittingpatches#guidelines

Thank you for sharing it.
It's QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00029
on ARMv8 multi cluster platform.

>
> --
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
