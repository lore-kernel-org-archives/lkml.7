Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF11C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39557216B7
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAuvXa0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732761AbfHFODv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:03:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35900 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfHFODv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:03:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so88117948wrs.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 07:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wzq+p0eJtG7jZmjcp0d0DzrnblGaqYlr4Ws+kyqhj58=;
        b=BAuvXa0eF4zMO6GKu4f1j22IN5GzcxSbI1guPiwAvB1N3Z/E5WzMH6q9eISheTlTc3
         2yXPskE2Qzff9l48mRqV6eXCDk0uVCZICiL5bZWedjumXmF3xsh8e/PojyBsX++U0gCh
         4GTZvlN92rJkl36tM8IbgY4fvjGZZRIqzgjXsdpg8tgw0calahgP86oyg8VFT85fjbvK
         22MH5LMTWKiSOq06XOI4LVRMRqSkY+jCBwOY1wITXTL1fizGO2rEgaxG/8vueVuIB93M
         +56lKW/6kIpSPtGAx66H2O/vL9FJa++h5qebQS+xDNrYOC3S8L15bEnVW4rMh+lzJoTM
         XtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wzq+p0eJtG7jZmjcp0d0DzrnblGaqYlr4Ws+kyqhj58=;
        b=cFhzytaxtmyT4pHVW/QUaPRfWNPLowvhQriE5bmDlPp5R6xLdjV9q71/i8JDU/SiSj
         ifqXe0yUO9Y4UpEMU83HKrSNPM6el8TtvoKMj1cqUmZkpy9RjkKRGAzf05rlyW2aSxa/
         nutzH2gjJVjSF4HDxp5XKeCeKTuH0xcj1KZgugIgZsK4d7YjjqrHgzIcQJjFPsTPX5aJ
         wBr7IRgjfU+WjW/hm1uK+E3pjvU7pffDco4pkpaZMGCtvNqo1Zfd5lcrgVqA3SKJByD/
         lDE3ohFIYor/wwynUoLL1nYKSgdzFg9YD2ju2EasD90eEtzGeaXviI7qKw1fGpocKFJX
         Aoug==
X-Gm-Message-State: APjAAAWBqr/lASd1T+TC/nS9UbGlEvkBey1f0N01l/NNFhrBoISBdBpE
        qNLBd+grG+CtCunHZi+g80uYPR9Nr4xqHlncetA=
X-Google-Smtp-Source: APXvYqwOGQ7HlbmyoDQLAdlLJKJRQ1bfFrRaYx7B8v3wp930Mwl5WIS0fLGyOH5g9JNHWn+kueNPW+SC9OMB9w4zoV4=
X-Received: by 2002:adf:f94a:: with SMTP id q10mr4761229wrr.341.1565100228559;
 Tue, 06 Aug 2019 07:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190805172138.GA4534@hari-Inspiron-1545>
In-Reply-To: <20190805172138.GA4534@hari-Inspiron-1545>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 6 Aug 2019 10:03:36 -0400
Message-ID: <CADnq5_MniQgphMuAsYkvYT9QerSTRYLQQwM_yo9Qxg09Tx-ceA@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: amd: powerplay: Remove logically dead code
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 3:01 PM Hariprasad Kelam
<hariprasad.kelam@gmail.com> wrote:
>
> Result of pointer airthmentic is never null
>
> fix coverity defect:1451876
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index ee739c0..a3acd77 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -736,8 +736,6 @@ static int smu_v11_0_write_watermarks_table(struct smu_context *smu)
>         struct smu_table *table = NULL;
>
>         table = &smu_table->tables[SMU_TABLE_WATERMARKS];
> -       if (!table)
> -               return -EINVAL;
>
>         if (!table->cpu_addr)
>                 return -EINVAL;
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
