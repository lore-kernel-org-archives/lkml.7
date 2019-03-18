Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4274C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5BA2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dE9C1kNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfCRUil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:38:41 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:44203 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbfCRUik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:38:40 -0400
Received: by mail-vk1-f193.google.com with SMTP id q189so4111572vkq.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 13:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xFsMmX/k0i1rBGaGSCpX1BTyFqBPFztwdG/wsbG1D2M=;
        b=dE9C1kNEFUMCBqguAAFAp4qeOodfL1P1AzX66kHRB8TW9+ML51qhd5t+mpf8CHFo7J
         Aa23FWwlvQbh7onhMray0Xw4EXgGGcM0vjrAr+g6cRhgWgF0/ZZjlDJft5iH9vMUSp1G
         cloxRLwPBjpDBGzmuEINAMr3TccbD35vtMMH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xFsMmX/k0i1rBGaGSCpX1BTyFqBPFztwdG/wsbG1D2M=;
        b=Ep/CcUG4dYfAA7g7yY81qkcQALqwvI5IWf84M231djb62qfumUSrGeM0h3RmlPRtJU
         1ZiVwFSMSF0f+MrZA6tzq1OTTBVO88RujvYJxMS21UtlTG4M93axAYwhsc5/FCVA1bpr
         krO2YRpgNOocBHRgcgMqm2laPcbHMN5JRGvgZ7TSat1BNnO69AVnIjrNlZ/OG3ksPpYI
         UN/eK+ouVU+saVZWZ+eltMrWyhUdmOhtPzjHqa+NzCjQEdYOSW5QTjY5nxNyeEQkPy4Q
         rxp8yUGSDreNiD7+dWUZNQQfLWPrT0/axreawFZB7kxKYW7dnmxO7A5nd3pFpK1ud6Wc
         ZryQ==
X-Gm-Message-State: APjAAAWPgEO0gzQe/AWSjuHKcYeQt+m2fT+vfK54UOVXUIlvHVmcfZSU
        avyhAS/EnUUJq2V+4yiyn3sJNtk0wBI=
X-Google-Smtp-Source: APXvYqywSN/Cdq95EbPCHa9d3wfxiVl4ANSXWsHeIJRHfIBuTebzeKz1/bdIFyaa+iDfMMyQpG7aMw==
X-Received: by 2002:a1f:ad10:: with SMTP id w16mr9905139vke.49.1552941519570;
        Mon, 18 Mar 2019 13:38:39 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id k202sm3347533vke.50.2019.03.18.13.38.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 13:38:38 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id i207so1833513vsd.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 13:38:38 -0700 (PDT)
X-Received: by 2002:a67:bc01:: with SMTP id t1mr3234954vsn.149.1552941517745;
 Mon, 18 Mar 2019 13:38:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190116184623.77136-1-dianders@chromium.org> <20190116184623.77136-2-dianders@chromium.org>
In-Reply-To: <20190116184623.77136-2-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 18 Mar 2019 13:38:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UaaHtXEut=zZBOvdsS-14Emmnyos84ONup8FkBexzcMQ@mail.gmail.com>
Message-ID: <CAD=FV=UaaHtXEut=zZBOvdsS-14Emmnyos84ONup8FkBexzcMQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/msm: Cleanup A6XX opp-level reading
To:     Rob Clark <robdclark@gmail.com>,
        Jordan Crouse <jcrouse@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Kristian H . Kristensen" <hoegsberg@chromium.org>,
        Colin Ian King <colin.king@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        David Airlie <airlied@linux.ie>,
        freedreno <freedreno@lists.freedesktop.org>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 16, 2019 at 10:46 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> The patch ("OPP: Add support for parsing the 'opp-level' property")
> adds an API enabling a cleaner way to read the opp-level.  Let's use
> the new API.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> Obviously this can't land until we have a tree that contains the patch
> adding the API.  I believe that means we'll want to target this patch
> for 5.2.  Luckily it's fine to wait since this patch has no functional
> changes--it's all cleanup.
>
> Changes in v2:
> - Split into two patches to facilitate landing.
>
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)

FWIW I think this patch is ready to land any time.  That commit
5b93ac542301 ("OPP: Add support for parsing the 'opp-level' property")
is now in linux/master.


-Doug
