Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49933C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F5F208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HA4KA6zk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbfFYNXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:23:08 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:38013 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbfFYNXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:23:07 -0400
Received: by mail-vs1-f53.google.com with SMTP id k9so10878104vso.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 06:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XeB/3xDQrxxJuVXFQuMuJo5SBnSx0zSjynbT8yHXjaw=;
        b=HA4KA6zkysUzhZVkwFh4OrxP/8T3QPuOgjRD3vYHXG832tEUmSoTTS7BnO0sHK99ja
         kqvusqbmQ7LQiIPAV5SPR8rzIGQzaNyZ78LptqlRxpdXnsoWCbq6H4D57Yp84Dis7PZy
         4xHpT7f5PH0MXqGj4VR/n8p10ggV0pK7ZLFFLIZpXudnqfw8DH9sfhT6058yZewp1j9c
         tRNw0vTvMfORORGaZpwa9vPNCChsM6LEreYd2duZ18A/n1E6xLBlrCQ3oeIwja9yauqB
         sG0p0KznNz/R8IkY5rS+s+ex7/frp+LvLmPL0s10LGaQguXEJE1dV9a9JuHD6O15BAzQ
         kugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XeB/3xDQrxxJuVXFQuMuJo5SBnSx0zSjynbT8yHXjaw=;
        b=aRozz0I8tytSW/t7VQvh2ku9jauMEiJiZCuOCGDfUCnqc0SN1IIqiE4N6EUij3m8Pd
         o60K9u3thTztZLhRzc11lRJSC8Ng6NwZpRsITLK2MBbUNAu8QiqPKuasA9gnMZhHE1r3
         TL1FRDAaEperWuo+vDsK/QiYwz0SHhFU6hA/Ghhs1kACoBwKKqJCRFRnnejN5v+6BlZe
         y6Fkoy88Wt9VP/RvBlw7eRHaGu2nU8NlJuS96zZy/8dHxioFjCu9Rd7t1lzkJ9mQjt6r
         8IDb9Ae2TUtBDDBAgqT/GIj3b1H45vlXNkViV+KI3frTA1Mv+ZnL+9YbCKgCEUKam0kN
         BjlQ==
X-Gm-Message-State: APjAAAVkIYVHZh4OMfIWJbHSsU7XJiPIP2BM8I8TIQ0oz6RA42E9PTv3
        /bf0vr+LUsF02McDEN6hwCCH405rLxHOU0MEMTs=
X-Google-Smtp-Source: APXvYqx40wlnI/l2eAlCn1M4FsahOIj+i3MEKX6XnIqju5PViEYX0OKmV1myRuSbh1hnW99Fcegyvb7X7mVHShwTTZY=
X-Received: by 2002:a05:6102:3c8:: with SMTP id n8mr164074vsq.135.1561468986495;
 Tue, 25 Jun 2019 06:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190624025604.30896-1-ying.huang@intel.com> <20190624140950.GF2947@suse.de>
In-Reply-To: <20190624140950.GF2947@suse.de>
From:   huang ying <huang.ying.caritas@gmail.com>
Date:   Tue, 25 Jun 2019 21:23:22 +0800
Message-ID: <CAC=cRTNYUxGUcSUvXa-g9hia49TgrjkzE-b06JbBtwSn2zWYsw@mail.gmail.com>
Subject: Re: [PATCH -mm] autonuma: Fix scan period updating
To:     Mel Gorman <mgorman@suse.de>
Cc:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, jhladky@redhat.com,
        lvenanci@redhat.com, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 10:25 PM Mel Gorman <mgorman@suse.de> wrote:
>
> On Mon, Jun 24, 2019 at 10:56:04AM +0800, Huang Ying wrote:
> > The autonuma scan period should be increased (scanning is slowed down)
> > if the majority of the page accesses are shared with other processes.
> > But in current code, the scan period will be decreased (scanning is
> > speeded up) in that situation.
> >
> > This patch fixes the code.  And this has been tested via tracing the
> > scan period changing and /proc/vmstat numa_pte_updates counter when
> > running a multi-threaded memory accessing program (most memory
> > areas are accessed by multiple threads).
> >
>
> The patch somewhat flips the logic on whether shared or private is
> considered and it's not immediately obvious why that was required. That
> aside, other than the impact on numa_pte_updates, what actual
> performance difference was measured and on on what workloads?

The original scanning period updating logic doesn't match the original
patch description and comments.  I think the original patch
description and comments make more sense.  So I fix the code logic to
make it match the original patch description and comments.

If my understanding to the original code logic and the original patch
description and comments were correct, do you think the original patch
description and comments are wrong so we need to fix the comments
instead?  Or you think we should prove whether the original patch
description and comments are correct?

Best Regards,
Huang, Ying
