Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0369C28D18
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7D8206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fsssAC2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbfFEQbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:31:49 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:38117 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfFEQbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:31:49 -0400
Received: by mail-yw1-f68.google.com with SMTP id r128so4649476ywe.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 09:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y1OYtud6ynRddkkX+/uoFR8oepImmq49z7SkEsX+oO8=;
        b=fsssAC2jxc6N9VdT89cO2W5eloOCThusSzDuCWrmX8rL3p6SjRfShWT9Ro4szdGWzg
         /OwLlE2zuZq1k+E8NKL6Xu/Yc3B7S/ZovUxRpqbTsCHZMOXnmF0hs/zz2rhKakBnZLfC
         WxRN7X8xH5uToK3wDHNPnz1yMhJO9l9jPaHQxME5Hqv5eEaBJCkkjhdrboGh8/CUCNm0
         2W34/DSB6kwzLbcW2AZIaxX8tiZzKXecdR3H9p8CJGlR6wsHg/fnJ0rJFoxBzBmjc5od
         5u3Xyb8WSMOKFxSX+mkDCMW7LSojKD32zNQwJHPpEcsoz//DqbhhpWOo7EN8uXo3Fc5s
         GYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y1OYtud6ynRddkkX+/uoFR8oepImmq49z7SkEsX+oO8=;
        b=eUId4A5bNi+Xu80p1x9xac2xlpFE2Vu2wgZ3WUmEQdhfDeu7Mj/CseH9y9XP2WSsk0
         awTxhqWNAc/97oUWwQn5EiUcPgfYrGYfp4massGU3zkIkeJ5DJk0aH+elhV9FSgjgwK5
         68jLXL7twvArZNla2DaUae8vKBj4FDXoW4eh4qhpO83QOYqeJ7yiruz/2nifpVQT+5t5
         jjT/+Zme0obi52FpUfNw9hD8NXIbaUZghLN5c0w+VgbQRQcU4X9D6KVXlXEsClwMmS+T
         AYrktgCO/1LPGii96z4duyruXD0dtPpBmnU26WKUZx5hNCb5mdXVLi9urzy4N/BaoPBh
         6NCw==
X-Gm-Message-State: APjAAAV+yNmR2fgYcbyWVT/XKd1Z9w9RrYH1G1T1vG12/9bwnRMSa6zr
        GqNNOiOQkQ7LsTCsIEdyGWibvOgWucSZ+PtacmNA6w==
X-Google-Smtp-Source: APXvYqwxp/w9I6RVMYzDSCXTuAeWq+uS/Kgz+ePstY0WG1Azd+0j00estnaPcFznlN81K3EH8wYJ8SzOBLDgFkoIAME=
X-Received: by 2002:a81:4e94:: with SMTP id c142mr7970493ywb.398.1559752308314;
 Wed, 05 Jun 2019 09:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190605100630.13293-1-teawaterz@linux.alibaba.com>
In-Reply-To: <20190605100630.13293-1-teawaterz@linux.alibaba.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 5 Jun 2019 09:31:37 -0700
Message-ID: <CALvZod7w+HaG3NKdeTsk93HjJ=sQ=6wQAYAfi9y5F34-9w6V3Q@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] zpool: Add malloc_support_movable to zpool_driver
To:     Hui Zhu <teawaterz@linux.alibaba.com>,
        Vitaly Wool <vitalywool@gmail.com>
Cc:     Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com,
        Seth Jennings <sjenning@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 5, 2019 at 3:06 AM Hui Zhu <teawaterz@linux.alibaba.com> wrote:
>
> As a zpool_driver, zsmalloc can allocate movable memory because it
> support migate pages.
> But zbud and z3fold cannot allocate movable memory.
>

Cc: Vitaly

It seems like z3fold does support page migration but z3fold's malloc
is rejecting __GFP_HIGHMEM. Vitaly, is there a reason to keep
rejecting __GFP_HIGHMEM after 1f862989b04a ("mm/z3fold.c: support page
migration").

thanks,
Shakeel
