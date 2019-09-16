Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3B5C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4117420830
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvhydDp4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388959AbfIPPPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:15:00 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39904 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388422AbfIPPO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 11:14:59 -0400
Received: by mail-ot1-f65.google.com with SMTP id s22so164031otr.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 08:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z0/EWWbquuGe/alMAK52FBBiIV0cXbrcVPiI5d8H2kA=;
        b=DvhydDp4Gjrd2G6qJDzXD3XOWPCqDoxP5i3/PlSHgjgZkqOp4Cq/KgGwBARdDjCLWx
         1vNisHSk+S/wNrHX1fPZdjE3ZeWyfw7tmjf4Y/pCQ+/OWmD9fRYdbjkXRaS+l4H2vG7W
         PTFVopNTicepzUYPPTIAEaorvSxghBiJfbawugVL+uEQSFgLmJzVm/Veo/Ge0t9Z9CbR
         CypWoStT2qoLYKHBQnhSdwjJwHnlftPy4aX1MSfhOZ6ns8MFwThDcaWvgqKxb/tQ7110
         V+AAEUL7n7VeLaaj79dxtLu9rit/ZO7BopCSLX6hcj/sKNcLeqYSKdrDjAzvqs1FXZmD
         Ao5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z0/EWWbquuGe/alMAK52FBBiIV0cXbrcVPiI5d8H2kA=;
        b=US0YRHh1qJ2km/WYCbdYizzwmJ5N6FJj+34ePdIn88YBbWLY44EuysqzcTyltW2hau
         cjAVoVloGiIW4wOi9T1yx6mPlo/bSMiVmrpsQaCH1l/iwT7D1FdtVZl1LnN6YG8+BDu5
         LW+hqLGOaWRUZjhzVmQo0Xjp4XVqXaHgXHgcwMvhRPy8JsE2xwYRBZ16W5sak0vxnbzN
         9LN9I1VtRQwltf9Vkm8dVaZbjWwhmoM2ZA1XNnEfO99Sy09LOBwpROFWXFsrY6KZUrqK
         Rq+28hKpNKxf3b+hW0ARt6gRL7soMDYBywkVkcHQdQmNV3TvmBMtunPFf69aEMxOS+Ca
         4thA==
X-Gm-Message-State: APjAAAULI8bfY8VQZLCQvWu+ai1dUqfC7VzaWrF6WGohHSWaMVt+Bzyx
        Gd8G2Cum/nPx5qbpUqLIxsxH2DxSMH6Nci694sM=
X-Google-Smtp-Source: APXvYqwr0f3KzajSDi9qsg3JLAmYbbkUZ9nL5Oyt5K3lTAXjPs/yGAzctYEPjVsS/U7zeSmEUm2j+YejcAmEqIAh7/c=
X-Received: by 2002:a9d:1ec:: with SMTP id e99mr44878419ote.173.1568646897425;
 Mon, 16 Sep 2019 08:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190915170809.10702-6-lpf.vector@gmail.com> <201909160919.Qa2fDQjj%lkp@intel.com>
In-Reply-To: <201909160919.Qa2fDQjj%lkp@intel.com>
From:   Pengfei Li <lpf.vector@gmail.com>
Date:   Mon, 16 Sep 2019 23:14:46 +0800
Message-ID: <CAD7_sbG3UcizVKMemaxOnpxDQKARSEJo340c8zPHkX4R+KdW9Q@mail.gmail.com>
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

On Mon, Sep 16, 2019 at 9:46 AM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Pengfei,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3 next-20190904]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Pengfei-Li/mm-slab-Make-kmalloc_info-contain-all-types-of-names/20190916-065820
> config: parisc-allmodconfig (attached as .config)
> compiler: hppa-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=parisc
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> mm/slab_common.c:1144:34: error: 'KMALLOC_INFO_START_IDX' undeclared here (not in a function); did you mean 'VMALLOC_START'?
>     kmalloc_info = &all_kmalloc_info[KMALLOC_INFO_START_IDX];
>                                      ^~~~~~~~~~~~~~~~~~~~~~
>                                      VMALLOC_START
>
> vim +1144 mm/slab_common.c
>
>   1142
>   1143  const struct kmalloc_info_struct * const __initconst
> > 1144  kmalloc_info = &all_kmalloc_info[KMALLOC_INFO_START_IDX];
>   1145
>

Thanks.

This error is caused by I was mistakenly placed KMALLOC_INFO_SHIFT_LOW
and KMALLOC_INFO_START_IDX in the wrong place. (ARCH=sh is the same)

I will fix it in v5.

> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
