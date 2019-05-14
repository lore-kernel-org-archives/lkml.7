Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0B9C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 05:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D343B208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 05:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gekg/Ime"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfENFjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 01:39:53 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34185 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfENFjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 01:39:53 -0400
Received: by mail-qt1-f193.google.com with SMTP id h1so9808550qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 22:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LX0XaYHmt6JczsEsNVrSRTTBxFWPZ8BYZiJCI1WPlfs=;
        b=Gekg/ImeDsjdwbPk3/9Rec4Nz+REdcTbuknK61Hxcqut8GFddxQb8OhftCzpwpFmzx
         SLqT9+k7QiUXSoifO0lm/QfE2jSK94dfcZgdaAM9mYzow8Ie+evrF/C4+bhC+QxdEK+g
         RtwGV6qJSY3Det823v7PxQf3yt31hBY7GSxVt7ziPaoS7hNoQ4+9+4XCPMNSeBcJXXhS
         WDqCHNsD9juiWMQFGLajowPD8rNgf6+EJNzXcblGHVU1BK3vjalBgcWebTmxMus4WD7U
         w9PPt6y39A+fAGPB9imEHReWkn+8GrmuSIghIZ/UlQLw1/PDuyKZO+WVg4EeUF+GUF3O
         1aVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LX0XaYHmt6JczsEsNVrSRTTBxFWPZ8BYZiJCI1WPlfs=;
        b=nJD/P3ojeaIDX4bDDPqFzUfxIyn/hjiFZxwTdeBajKw8NILgWh20DlkxLXD6YXUQXV
         dtWIqBaTRrqK4npmPCp7aOqVP1XlamHM3167UBWTYOwS07MLNcNBIxPBgPzej83Us8WB
         IHWwj6gtTT1ekE3eFullbQkn8MdIkpbdhj1eSQgtDuGycwWBXu6c5mKXj/gatgJt3cXH
         clSarQolG35cX0uhBFTaQgi4z24LyUCCJmSBan23oQWr6sqwm0aztWUk3FrK0sipZOpS
         ktyGcBFSRSiz2SUDLW0iTHCUAVEl383V2Gj1PsyfC7yUu3BguA5jbf1CxVYZUrVi6rYv
         Nujw==
X-Gm-Message-State: APjAAAWpHepPSSVErHmNJ8kregOoaHAwh0aRcAnF88fzXVAp4CzEzUOh
        daH5YrMTC+gWcWOMZtb5QO1ZjNhu3cilve2fM68=
X-Google-Smtp-Source: APXvYqxoQmjPOX4z5nn8aA71WQnVuMX6mmygZa/Jn16QvBTxak3EDI/Irrk3FF8KmKluSoI68DkTq3eLvSlzUS57szg=
X-Received: by 2002:a0c:ee28:: with SMTP id l8mr26055818qvs.67.1557812392608;
 Mon, 13 May 2019 22:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180529205048.39694-1-jaegeuk@kernel.org>
In-Reply-To: <20180529205048.39694-1-jaegeuk@kernel.org>
From:   Ju Hyung Park <qkrwngud825@gmail.com>
Date:   Tue, 14 May 2019 14:39:41 +0900
Message-ID: <CAD14+f154_t1-TbbSDb9xV_ikDAWfF+8H7aOSK4VF8UmqWRDAQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: issue discard commands proactively in
 high fs utilization
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 5:51 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> In the high utilization like over 80%, we don't expect huge # of large discard
> commands, but do many small pending discards which affects FTL GCs a lot.
> Let's issue them in that case.
>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 6e40e536dae0..8c1f7a6bf178 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -915,6 +915,38 @@ static void __check_sit_bitmap(struct f2fs_sb_info *sbi,
> +                       dpolicy->max_interval = DEF_MIN_DISCARD_ISSUE_TIME;

Isn't this way too aggressive?

Discard thread will wake up on 50ms interval just because the user has
used 80% of space.
60,000ms vs 50ms is too much of a stark difference.

I feel something like 10 seconds(10,000ms) could be a much more
reasonable choice than this.

Thanks.
