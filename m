Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932F9C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 07:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658FA20882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 07:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cxP+eNFJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405453AbfIWHx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 03:53:58 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39828 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405191AbfIWHx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 03:53:58 -0400
Received: by mail-lf1-f65.google.com with SMTP id 72so9333696lfh.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 00:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+GerYcmYMO5YvdQkT9Zn07Af1kbLUNX6Y/+zHLXd0M=;
        b=cxP+eNFJeT5F7TXm7atEyHSr+rSnR0aDK+1Ma2XO3DcJMuXnJi3Kyiblt4jzyxaAgY
         iQsQQx61Vyx07Lf5+MXyG+KFgsme4snyfnEmCQcMe6HPIfWd1uAwyGlhQ9wFzheHpHNF
         9kBUomEAJ5cIgxpxx1dW7u1pc9ClpQl3q48Le6vpIYMFMuvxLCzJ9UUc0sWP0F9f1HQS
         TijYSh1rchb3JIi7BvctqmmwmS/dLORk3PROROTTZxiAaALC/4/x0XRW89hvN6N2MxvF
         eqS/h+VXoB4MKNPUtUypd2drjogttxVHJBNGuV9bZzXzqWEQL2I92tvi58htdPtonp6S
         CU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+GerYcmYMO5YvdQkT9Zn07Af1kbLUNX6Y/+zHLXd0M=;
        b=lRegeoco/ILglqLKqzRo3rQK4jSxlSu220zWAfR52QCRONh6q4RYpEpHTlmhaZjy6b
         bG+tCub9bWDmGPHsICW2sSOdJZsAnOXRjP6oPff/vM+8MVd3JnxaUsG9wCUFGzhtksOz
         ofW6FHBiAWpXuBhEi0xgSeTMJGSnhAkq1TqykcuKoy1NSgxFpB/HPWv8YEGy+NLniJKI
         jBP2d5gGg5ZHrBjx1wvjzpXLWnhUoN9yNrqGDUx/YvHk0UbUgH1m22g4mG+B899gStGW
         Q4OVDLzsmVP62v2nyZpqKRjEqM+lm9hqTFwxndpGTpihH3GJhnx3TRNno5yfeg2A4H22
         Poqw==
X-Gm-Message-State: APjAAAVllOtHfP2E1HFCUZyLDfgu2qYgf49ihlPd8gBXBioFi32gDXSU
        ewiL75GFNXKONWfE7SyKeE68va0eYr6/FvFXwM9Ql17YoNY=
X-Google-Smtp-Source: APXvYqygvtnIx3QdOPmtm3Dh6aqMWmYMQVt8wtC93BSYUtfHNLQsNjV49z9+Q2sxHmdCkSPAzmVRPbM40h0JA4wnEV0=
X-Received: by 2002:ac2:5148:: with SMTP id q8mr15155737lfd.84.1569225236069;
 Mon, 23 Sep 2019 00:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <63395d0c73f0bb1cf7c2f52545137fd4014f84ba.1568864712.git.baolin.wang@linaro.org>
 <20190921144922.GB13091@xsang-OptiPlex-9020>
In-Reply-To: <20190921144922.GB13091@xsang-OptiPlex-9020>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 23 Sep 2019 15:53:44 +0800
Message-ID: <CAMz4kuJONoMYAmQrKukxxpDbYDQQ8G7SYaL4svk8A6ewr2sYEA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mmc: Add MMC software queue support
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 21 Sep 2019 at 22:43, kbuild test robot <lkp@intel.com> wrote:
>
> Hi Baolin,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3 next-20190918]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Baolin-Wang/mmc-Add-MMC-software-queue-support/20190919-140107
> config: i386-allmodconfig (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-13) 7.4.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
> :::::: branch date: 7 hours ago
> :::::: commit date: 7 hours ago
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    ld: drivers/mmc/host/sqhci.o: in function `sqhci_finalize_request':
> >> (.text+0x644): undefined reference to `mmc_cqe_request_done'

OK. I will fix this issue in the next version and wait for a while to
see if there are any new comments for this patch set. Thanks.

-- 
Baolin Wang
Best Regards
