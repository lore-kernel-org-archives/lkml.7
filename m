Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CE4C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E03214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kn07xZZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388963AbfIPPPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:15:38 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38067 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfIPPPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 11:15:37 -0400
Received: by mail-oi1-f196.google.com with SMTP id 7so60186oip.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 08:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=myU5/TC8EM0o03fkgYztHIvhCCZ3n2MmrOaOleMEGcA=;
        b=Kn07xZZNH8LhKSWctdaltI81HMhS1HytLccqyQ3Yaw7hN3M01YoZBZrXG8xAjz2nX4
         2MY4xfjSVwq9U2LKNZqm96npY8ZQaSTj6vQOFlVwzxv2QuMtxe4x8HWU0qoXzfRgKvIp
         trRh8UrXdren7ITIZWvRLdhZZMnwmCR2PV/bpuX5tvYKTT+32gfXtl3MYM9OcrHliWKQ
         kcg5D1EEcLxLuSjLq0XFepTA0qWt5YsWTrghI771EWdJPPiRKOaR2pFxMSgjAXQJ19GN
         Xz1byM+4awfK2AdRk1ah6M8xE+KanR7caW8wYgn8mfSw35EZaiLm2lq0SCKXmglCHK/B
         wkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=myU5/TC8EM0o03fkgYztHIvhCCZ3n2MmrOaOleMEGcA=;
        b=mdxUck0xRdGkgx5bURCgy/DRbTMSRTIZ2EdHZL60b37TZQJDP9eEIUUS4ekrXxoRsP
         W01kODG4ou7HTs/4YicW35JMoKnNA/3U0wDPc/E0+h8yAYaiOc4DtAHVdbP2FZacUV2D
         d62AcSeglCIN3qsTEuVlpOUQ/xYFNM4ndAuQ+CbtOfRhJRGFjx1fDm2OWmw5oixz/dU0
         VjW8r+TzawKGW8hiFa5gN3YV7gtX2T+jOa5lvWX3rwEqrYgfpdCSQ94AvzQyeVLGrvz0
         1+UO9xq1Tn3lLAXIRyBli/siuw/v9+8W5MAfGwFftkbIBvdiYTuZpJ7BK8HG4CkhsDZo
         DAxA==
X-Gm-Message-State: APjAAAXSZJqKwcgKZHkIKfCgUryUbsINU6zjm+F5hk4gKrKHykk4p0X2
        uE3VfVPPET+CPPZkxoS3EEqwmBFBObiNvVQuQPk=
X-Google-Smtp-Source: APXvYqxv0WB7yHn0EYqv/F75KfuLWbRubTIglyprLwvBnqwa7v1kd9h+n3uI3ynbbt0c4wWZPM3b0EN4o6BFmNCQzMg=
X-Received: by 2002:aca:4f8f:: with SMTP id d137mr61864oib.33.1568646936752;
 Mon, 16 Sep 2019 08:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190915170809.10702-6-lpf.vector@gmail.com> <201909161257.ykb3lopd%lkp@intel.com>
In-Reply-To: <201909161257.ykb3lopd%lkp@intel.com>
From:   Pengfei Li <lpf.vector@gmail.com>
Date:   Mon, 16 Sep 2019 23:15:25 +0800
Message-ID: <CAD7_sbG1_E1ZTRWHb21GaYcjRsr9e6CPSxXRauTOc4sLpCTeDA@mail.gmail.com>
Subject: Re: [RESEND v4 5/7] mm, slab_common: Make kmalloc_caches[] start at
 size KMALLOC_MIN_SIZE
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christopher Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 12:54 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Pengfei,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on linus/master]
> [cannot apply to v5.3 next-20190915]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Pengfei-Li/mm-slab-Make-kmalloc_info-contain-all-types-of-names/20190916-065820
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
>         make ARCH=x86_64 allmodconfig
>         make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
>
> >> mm/slab_common.c:1121:34: sparse: sparse: symbol 'all_kmalloc_info' was not declared. Should it be static?

Thanks. I will fix it in v5.

>
> Please review and possibly fold the followup patch.
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
