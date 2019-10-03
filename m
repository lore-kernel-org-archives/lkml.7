Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2F3C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D062086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="Hi1MkI/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732634AbfJCS1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 14:27:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34745 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbfJCS1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 14:27:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id a11so3847921wrx.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 11:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fi4XGjAW8IL22UQ2E3MLgTRkUEhWQPz4pB1hOvF/+fA=;
        b=Hi1MkI/qpCxDbo6JZhKQmKaxIfwr4T4/k99ZbBFtrHb3q4zw4ByDCYUdD64t29C+gj
         jVQ2d7m6uw7VArrSuymO7GOFOw0xAjsY1rOrejvNUM/CWj5UQkatSjG1q/5u8wGFu44X
         adzpD3zXTL4dmCzurjzLoCdmCYYyAlYC9Nnh28F6IWKNhnFhLA/FeCYphMw3rixYFew0
         Zd+7JUBPLll2xu2/2sVF2JxGdc3dQdcK5N+5sIFIFY29oE9lBrj8yuNFrneVgttifo9J
         rD/bOUSj1RMwnG0WRsbbYtMqFD8WoJ5ODZLwcMNPWz9rAl1uw5hW7ef8uqkisLu7P5pb
         O9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fi4XGjAW8IL22UQ2E3MLgTRkUEhWQPz4pB1hOvF/+fA=;
        b=TD3DinxBkAP43v4vGPWBE7quHmo6NxpPQ7d95EQR3RCMNpEe5j1tvR7Dr3MGttC6ae
         XgGxJDOrd183gV52/8WhhzypGEdiW6/6YzufLnZsl+quQWZPQGYl5IRtkErnxuTugJQh
         da0kRebDXQ+BRDsNna4cNarYEwMrvB7ALY/2A+ExRewObNxgvVnkFjTgvFGebFkGjkt7
         Pp5tsOvVMxTuiqKa/ASKOkHrQBfmaXyuthxHXdFDqgxYMmmvIcqw3I88GPDRYOwGSGbU
         jMXK4qhx0RRdGN4Vo/bbz/3JvR/BtFUuWqcCmccT7rxSfm0zdVzO99RUxTPYXPtiizEg
         NsRA==
X-Gm-Message-State: APjAAAV+1jaFtCbm5GikDMdVpc1moSH5PS5Ll9Zcih88KdXX93FXltf8
        Gzv5X8E0RYV7TO0UUVy4nf0Imcp/aEgBTt1Mq5zXaw==
X-Google-Smtp-Source: APXvYqxbFaYgQESHFT0ejIDrfC9cSb6nt3hGDE7e+F1jf57qtk9/E/O4Le3nxo8YcgqHg6K6YkTwO5gXuwhpzDsp1ZQ=
X-Received: by 2002:adf:fe8b:: with SMTP id l11mr4115663wrr.23.1570127268783;
 Thu, 03 Oct 2019 11:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190301192017.39770-1-dianders@chromium.org>
In-Reply-To: <20190301192017.39770-1-dianders@chromium.org>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 3 Oct 2019 11:27:37 -0700
Message-ID: <CAJ+vNU0Ma5nG9_ThLO4cdO+=ivf7rmXiHZonF0HY0xx6X3R6Hw@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/arm-smmu: Break insecure users by disabling
 bypass by default
To:     Douglas Anderson <dianders@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>,
        linux-arm-msm@vger.kernel.org, evgreen@chromium.org,
        tfiga@chromium.org, Rob Clark <robdclark@gmail.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 11:21 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> If you're bisecting why your peripherals stopped working, it's
> probably this CL.  Specifically if you see this in your dmesg:
>   Unexpected global fault, this could be serious
> ...then it's almost certainly this CL.
>
> Running your IOMMU-enabled peripherals with the IOMMU in bypass mode
> is insecure and effectively disables the protection they provide.
> There are few reasons to allow unmatched stream bypass, and even fewer
> good ones.
>
> This patch starts the transition over to make it much harder to run
> your system insecurely.  Expected steps:
>
> 1. By default disable bypass (so anyone insecure will notice) but make
>    it easy for someone to re-enable bypass with just a KConfig change.
>    That's this patch.
>
> 2. After people have had a little time to come to grips with the fact
>    that they need to set their IOMMUs properly and have had time to
>    dig into how to do this, the KConfig will be eliminated and bypass
>    will simply be disabled.  Folks who are truly upset and still
>    haven't fixed their system can either figure out how to add
>    'arm-smmu.disable_bypass=n' to their command line or revert the
>    patch in their own private kernel.  Of course these folks will be
>    less secure.
>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Hi Doug / Robin,

I ran into this breaking things on OcteonTx boards based on CN80XX
CPU. The IOMMU configuration is a bit beyond me and I'm hoping you can
offer some advice. The IOMMU here is cavium,smmu-v2 as defined in
https://github.com/Gateworks/dts-newport/blob/master/cn81xx-linux.dtsi

Booting with 'arm-smmu.disable_bypass=n' does indeed work around the
breakage as the commit suggests.

Any suggestions for a proper fix?

Best Regards,

Tim
