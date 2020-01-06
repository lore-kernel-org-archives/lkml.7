Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3915EC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012E9206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eL75pyah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgAFWno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:43:44 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:46095 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgAFWnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 17:43:43 -0500
Received: by mail-vk1-f195.google.com with SMTP id u6so12922374vkn.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 14:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TR0dAeXGfCCFkxJD34tOpB63AtNq67/wZLn1sgE74zk=;
        b=eL75pyahAHEuX3ngDs7I3eNS+ac9tWxkPj73XAmr0aLMHAm7DokL7cftGGGdU+mJr8
         W4UPw/aWX6QLjlvEQmMCf4/yezgaqrxEw97e/m2sTE7nYv76t6Lbwa/BdJnbc3XZyjdl
         iXXshyIY5TSz/6e+cN+SojeHi8SiSJfq8oZMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TR0dAeXGfCCFkxJD34tOpB63AtNq67/wZLn1sgE74zk=;
        b=gHhNPPdzjs64na9CwzNIU7e6wUIMmAxIncm/X/kshAKbI99Gi6wq1z9g+zxVf9WKf1
         WNzSe+cPqgS8NNNitrMB5wB5RHmyie3AftJKAiXVrjeznt4vcEwAmQp8koWow4FGnoQx
         OtUqDPWLCKyoKLro8Q9qRgT2GZUEwCvCFmtBVLZgrWYr0DLgnbIqXOJ17wIghxiGGyPh
         MR+t328gUy/B4eJDA9D95MEnJo0osSGY9HxScgGIS44OddBS7kLRePwojn+sDAo3iEAi
         8F2NPAXa7wVniWo84NVnlJKjUL0Wuf1anX1mGbi4LNvreW89LbSsusrBUIX9QBQuUFYk
         KSow==
X-Gm-Message-State: APjAAAVKODuzplhHCoLJSiWWQyBj79v62Hj96qRuPqYN0f8RO6r8sTZM
        8ZPMcSxJ921+zCrJR9H9mK+9GQRM2NE=
X-Google-Smtp-Source: APXvYqyAJYlq3NCwA+cRQyq1kq8sKxz8rMtDUsyXTxRt08PpCB3iVP+b12CKWtHyHIsVw6UA0bUYng==
X-Received: by 2002:a1f:5fc7:: with SMTP id t190mr59835822vkb.52.1578350622568;
        Mon, 06 Jan 2020 14:43:42 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id f22sm17565485vso.8.2020.01.06.14.43.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 14:43:41 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id g15so32709250vsf.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 14:43:40 -0800 (PST)
X-Received: by 2002:a67:8704:: with SMTP id j4mr55185151vsd.106.1578350620195;
 Mon, 06 Jan 2020 14:43:40 -0800 (PST)
MIME-Version: 1.0
References: <20191217164702.v2.9.Ib59207b66db377380d13748752d6fce5596462c5@changeid>
 <201912212109.ehZOyrlG%lkp@intel.com>
In-Reply-To: <201912212109.ehZOyrlG%lkp@intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 Jan 2020 14:43:28 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Ui=ZbzdyV6SjLvrL-zj6e+upog_wZMG4seOsdgZpF6tg@mail.gmail.com>
Message-ID: <CAD=FV=Ui=ZbzdyV6SjLvrL-zj6e+upog_wZMG4seOsdgZpF6tg@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] drm/bridge: ti-sn65dsi86: Avoid invalid rates
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Clark <robdclark@chromium.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Robot,

On Sat, Dec 21, 2019 at 5:57 AM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Douglas,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.5-rc2 next-20191220]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Douglas-Anderson/drm-bridge-ti-sn65dsi86-Improve-support-for-AUO-B116XAK01-other-DP/20191221-083448
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 7e0165b2f1a912a06e381e91f0f4e495f4ac3736
> config: sh-allmodconfig (attached as .config)
> compiler: sh4-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=sh
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings
>
> All warnings (new ones prefixed by >>):
>
>    drivers/gpu/drm/bridge/ti-sn65dsi86.c: In function 'ti_sn_bridge_enable':
> >> drivers/gpu/drm/bridge/ti-sn65dsi86.c:543:18: warning: 'rate_valid' may be used uninitialized in this function [-Wmaybe-uninitialized]
>        if (rate_valid[i])
>            ~~~~~~~~~~^~~

I love your report!  Interestingly I had already noticed this problem
myself and v3 of the patch fixes the issue.  See:

https://lore.kernel.org/r/20191218143416.v3.9.Ib59207b66db377380d13748752d6fce5596462c5@changeid


If the maintainer of the robot is reading this, something to improve
about your robot is that it could have noticed v3 of the patch (which
was posted several days before your report) and skipped analyzing v2
of the patch.  I'm currently using Change-Ids embedded in my
Message-Id to help automation relate one version of my patches to the
next.  Specifically you compare the Message-Id of v2 and v3 of this
patch:

20191217164702.v2.9.Ib59207b66db377380d13748752d6fce5596462c5@changeid
20191218143416.v3.9.Ib59207b66db377380d13748752d6fce5596462c5@changeid

Since the last section before the "@changeid" remained constant it
could be assumed that this patch replaced the v2.  I know there's not
too much usage of this technique yet, but if only more tools supported
it then maybe more people would use it.


-Doug
