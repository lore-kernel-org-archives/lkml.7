Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B898DC28EBD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 02:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E8A20820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 02:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fawIqtj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbfFJCeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 22:34:04 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46220 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730278AbfFJCeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 22:34:04 -0400
Received: by mail-ed1-f66.google.com with SMTP id h10so12124744edi.13
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 19:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=afKgTHmsyagHLmYfWGsSLRAHwZWSCleIZNkXxK90uPY=;
        b=fawIqtj7htmk9JLOUC28S3iKNbxX4HMtjGN+MuVQUAVuCjMhYUz6VWwQ727OC2TTt4
         W5z42Nj1T8lmxR/j7JX2G/xkWIznAEh54U6SciR/Py1AiQQ97VIHcIfNhg7M+zqeL7gK
         izRcmPWT4FC06S8MN1aWWe825DOKTmxJM7433UVz2/MiCaj8Sz4LpRPzK7PDdPsyVETN
         QR4AJ6dqdo+Lu1gSRb3uPqLcByPZNMcPQHqBtKIumdmVs7248ruDEZxzggK8rE72NPxk
         oCxocsJ0+FYyrkeVnrDf1c2D/DC+TFx/SVnL9hSuiS3a/m0iWaGSv3k+BBZlFXVajXAB
         JwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=afKgTHmsyagHLmYfWGsSLRAHwZWSCleIZNkXxK90uPY=;
        b=dmia+S/jMn+xZqT2D2ylUbLZooAjZqBa7ybPOMKVNsu2xQYALfshN2aHZqRevx+i1C
         TQt67e+WulgciQc9j5S5Np2tLcmtj7QXVYdzAlm6CA/mFtjovuJVrfLmDUPJHvviWGp/
         ABEuRmp/wMWab9pEWY8GjrMShjDZ3rkDYbWRLJAlIWoBa61SQqITk4TBIbf3yU7msrYj
         2nWJ3itbwmPYXYD8iILrEoGwfs3vo+4L5jI+/RIbg3Zlb7yel5Y1uq0RyL1h/jLOWT/V
         4quFB72HLhJqHEkJ9VOCbrJTJkGNaH44W/TYz7R2nNxOIw+Zv4e7pdWuQqp+vq2Rpdw/
         69sw==
X-Gm-Message-State: APjAAAWfssKVxwfXCPqAIV1S67OJ8m8IySlF/eYdqyWq3FdMLdKNyuk6
        294YXDyxXhZlSJqeQyIofHFkeqdp0nTiP+z46wFNXQ==
X-Google-Smtp-Source: APXvYqyZ4zJSQrjpclg/tB88jotg/Lr0qMzgyhbyLXcOThxD7RIRBMYssHeHhkPCoz1e8x5WG9KYWcH5HQbN/vEAUJ0=
X-Received: by 2002:a50:ec1a:: with SMTP id g26mr71250547edr.174.1560134042811;
 Sun, 09 Jun 2019 19:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190605111412.3461-1-zhang.chunyan@linaro.org> <20190606010857.GF29739@sasha-vm>
In-Reply-To: <20190606010857.GF29739@sasha-vm>
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
Date:   Mon, 10 Jun 2019 10:33:51 +0800
Message-ID: <CAG2=9p_6Rk4oUu0hWKdzHNxRg=Hsboz=vYwsmfagmuCHzEKMOg@mail.gmail.com>
Subject: Re: [BACKPORT 4.4.y] PM / sleep: prohibit devices probing during suspend/hibernation
To:     Sasha Levin <sashal@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.Strashko@ti.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jun 2019 at 09:08, Sasha Levin <sashal@kernel.org> wrote:
>
> On Wed, Jun 05, 2019 at 07:14:12PM +0800, Chunyan Zhang wrote:
> >From: "Strashko, Grygorii" <grygorii.strashko@ti.com>
> >
> >[ Upstream commit 013c074f8642d8e815ad670601f8e27155a74b57 ]
> >
> >It is unsafe [1] if probing of devices will happen during suspend or
> >hibernation and system behavior will be unpredictable in this case.
> >So, let's prohibit device's probing in dpm_prepare() and defer their
> >probing instead. The normal behavior will be restored in
> >dpm_complete().
> >
> >This patch introduces new DD core APIs:
> > device_block_probing()
> >   It will disable probing of devices and defer their probes instead.
> > device_unblock_probing()
> >   It will restore normal behavior and trigger re-probing of deferred
> >   devices.
> >
> >[1] https://lkml.org/lkml/2015/9/11/554
> >
> >Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> >Acked-by: Pavel Machek <pavel@ucw.cz>
> >Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>
> This patch had to be fixed a few times (see 015bb5e134 and 9a2a5a638f8),
> we can't just take it as is.
>
> It might be just simpler to move to a newer kernel at this point.

Thanks for the information and suggestion!

Chunyan

>
> --
> Thanks,
> Sasha
