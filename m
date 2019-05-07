Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0B5C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5588C208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557259250;
	bh=sRvFneUonx8LWOIXyTRujXloYw1XXHSS4XcDi3ws2Xc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VQe4wTLUxiCb2jrKwP9jf+k7Jf6S1z436OSLmvcmVPICKCZjEmIu+8h6OLxyomYrJ
	 mnJiB2qp6ilss799HinEAPEvdRDvce4+iIGCYxgIykeRffTQGHpUUEOSf8UMqYrzHv
	 ENWHPEJZj3VJP+HiosNYC3bwonS2Pxr/YhJ2j6/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfEGUAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 16:00:49 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:39357 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfEGUAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 16:00:48 -0400
Received: by mail-lj1-f169.google.com with SMTP id q10so15463997ljc.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 13:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AhQwhnya1lWygBDHTyZELUjYoXrZkk+CaLqHSwtab4c=;
        b=Kzfmjw2pW4usOCMfxQJPbjeEqilKVI0LIcgtA3kJVJ4Tw96sTmBz9uiCgpLPOTX7xD
         j4I1H3U2sRyVayV2ZslkIpPQyUvnuFn+ALVfkFMVLcmpWfSf9pjRC5O2dyzbfK/ptt5P
         YNY442A4WUln5tqotbDtt/9LCbsuFtT0ligaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AhQwhnya1lWygBDHTyZELUjYoXrZkk+CaLqHSwtab4c=;
        b=aesFryR/8uh8fd0QPvG0muI27ZPsH3j+PojFAuVRAznj6a28Rb4B6dSVXrx2Ik3hhu
         NzYpDhpedLQ/TMr+KwtkVIueLkngzLiucRWfTRq6L+FlWxzbDE2JntmS5VJE1JoeyKQm
         OhhjjJKHQFOdUNwplS9DaSEhUuwPr5Qftno6FKi8WgMCjaQnu96GnrluiznxpeOio7gm
         NrUUSwFh8u6EL7rVBbA4apxdB/0WPcH12TXik8LKvyOZ7UJn7uRb0NZ4Q3UW/qgqOE65
         UYZjM4clvVjRzKl4U6adyB4NuBdpyZYDMIqpy+hOLq9UfrXQ7W87azbthBs5OLdWmFyj
         3pdA==
X-Gm-Message-State: APjAAAXyGtrPJFUspLw2m2+1yoYgPT3IcxPFV6j5S/mcRbacXa9F2YnK
        8cFIASvqmQytyhQlpfNeQ/+/2u8VHJk=
X-Google-Smtp-Source: APXvYqx41VLou0FM8hfni86oSEbgbKtkLpzzLkC1b/WlUMdRCcILrrGSMnWafaL/TKiCz/uUlghOBQ==
X-Received: by 2002:a2e:1508:: with SMTP id s8mr17990934ljd.87.1557259246450;
        Tue, 07 May 2019 13:00:46 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id n10sm3968719ljh.36.2019.05.07.13.00.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 13:00:45 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id w23so12762325lfc.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 13:00:45 -0700 (PDT)
X-Received: by 2002:a19:ec07:: with SMTP id b7mr11898917lfa.62.1557259245003;
 Tue, 07 May 2019 13:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190507063634.8389-1-ulf.hansson@linaro.org>
In-Reply-To: <20190507063634.8389-1-ulf.hansson@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 May 2019 13:00:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+d+dWT6g6DO5QgZkp_CAFJyXt7RPtXn59=c8bvdKtKA@mail.gmail.com>
Message-ID: <CAHk-=wh+d+dWT6g6DO5QgZkp_CAFJyXt7RPtXn59=c8bvdKtKA@mail.gmail.com>
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v5.2
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 11:36 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Here's the PR with MMC updates for v5.1. This time and onwards I will continue
> to include changes also for the MEMSTICK subsystem in the PR, please tell me if
> you prefer another setup.

I'll just consider it all "MMC", not worrying about the memory stick
part. I'm assuming it's not going to be all that active or noticeable
in the big picture anyway... Sending them together sounds fine to me.

Thanks,

                 Linus
