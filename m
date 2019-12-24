Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A2CC2D0D0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 05:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FCDB20718
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 05:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXcMGRKt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfLXF3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 00:29:51 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33585 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfLXF3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 00:29:50 -0500
Received: by mail-ot1-f65.google.com with SMTP id b18so3168882otp.0;
        Mon, 23 Dec 2019 21:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5mIHnK6BEXabOhDkyqQEsS+XZ4SjPH+Ikpu6wNoKfTY=;
        b=OXcMGRKt+jJv0xgFfQWCl/en/y7wiuoYYfovW6TgMPcdLXQVqP3tw5pvmFCEyhHwZP
         wNFcQtSUDSe6dQMP49m9xNBUFB/s9iIpiv6RKSFKfjSqWtMP2OO+VzWtmCATpb+QyjO9
         ZlC4vCaO07aKO/ajAkyUaVpRBFGhQ1QAIEEKyxXosQtMmBqm84ZoxrSU7gEsXjq/egWp
         8jzR13+nUBRG6h9dFV4BlBULrmjylMxNpj9Dk2WoSbBPiv1tM02umpcDg8nxuejqflYC
         1iZgvwkFxCKhHw1LU07KbJM+Eh2PoCcvRk549DxQS5m7c6NMVds8cQpXvgqjHT5hnTXd
         1SsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5mIHnK6BEXabOhDkyqQEsS+XZ4SjPH+Ikpu6wNoKfTY=;
        b=rPHMcOK09scCQqmMIbV1efI1jt4FVcO+DI9lQ5hTG3O5HTPVGXHhm9PuLiDIkWkmT4
         /n+NI8lddIOc1d3ELgUot8MQbUPuBE5eePpqgAtvrAal3O4pCyVNSVb42lt3DOYV9LnB
         k5uVx/FT4tH/DsrPcYn1V7YI8d9ls3v53FdRpls1ysrXV9GAyM9E+W6Q4ro7vOrKz9U6
         yfEsp1zFzgaEsYyYDwyWZl/yMWZwVlSCKRL+Awx5Ux/lxj+kxFk13D4re+3WHwUehgin
         14/mIlYo8ytNMZkOhUNERlY5fCHPm/NXx6nSuAXHMvOjPGAq2rXDwn0ZINJTfVOvwLAI
         8F5g==
X-Gm-Message-State: APjAAAUJetQzAirAc4RLwXTKkf0FGieJu9vReLDnzv9i3Fh80HdC1JKB
        Q5we2MyaabrOX9G8LRnLaI9Bkpx8
X-Google-Smtp-Source: APXvYqzBtDy5T8KNyDQtb9LOhaIsbpL690b19vPzf0dbocSBvDQ6VjIZQwUMHSj7KJKAuf5Z0AlrYw==
X-Received: by 2002:a05:6830:605:: with SMTP id w5mr34268557oti.79.1577165389758;
        Mon, 23 Dec 2019 21:29:49 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id p20sm8171116otr.71.2019.12.23.21.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Dec 2019 21:29:48 -0800 (PST)
Date:   Mon, 23 Dec 2019 22:29:47 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, yixin.zhu@linux.intel.com,
        qi-ming.wu@intel.com, rtanwar <rahul.tanwar@intel.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2 1/2] clk: intel: Add CGU clock driver for a new SoC
Message-ID: <20191224052947.GA54145@ubuntu-m2-xlarge-x86>
References: <cover.1576811332.git.rahul.tanwar@linux.intel.com>
 <ee8a8a0f0c882e22361895b2663870c8037c422f.1576811332.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee8a8a0f0c882e22361895b2663870c8037c422f.1576811332.git.rahul.tanwar@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 11:31:07AM +0800, Rahul Tanwar wrote:
> From: rtanwar <rahul.tanwar@intel.com>
> 
> Clock Generation Unit(CGU) is a new clock controller IP of a forthcoming
> Intel network processor SoC. It provides programming interfaces to control
> & configure all CPU & peripheral clocks. Add common clock framework based
> clock controller driver for CGU.
> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>

Hi Rahul,

The 0day bot reported this warning with clang with your patch, mind
taking a look at it since it seems like you will need to do a v2 based
on other comments?

It seems like the check either needs to be something different or the
check should just be removed.

Cheers,
Nathan

On Mon, Dec 23, 2019 at 04:48:54PM +0800, kbuild test robot wrote:
> CC: kbuild-all@lists.01.org
> In-Reply-To: <ee8a8a0f0c882e22361895b2663870c8037c422f.1576811332.git.rahul.tanwar@linux.intel.com>
> References: <ee8a8a0f0c882e22361895b2663870c8037c422f.1576811332.git.rahul.tanwar@linux.intel.com>
> TO: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> CC: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
> CC: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com, yixin.zhu@linux.intel.com, qi-ming.wu@intel.com, rtanwar <rahul.tanwar@intel.com>, Rahul Tanwar <rahul.tanwar@linux.intel.com>
> 
> Hi Rahul,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on clk/clk-next]
> [also build test WARNING on robh/for-next v5.5-rc3 next-20191220]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Rahul-Tanwar/clk-intel-Add-a-new-driver-for-a-new-clock-controller-IP/20191223-110300
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
> config: x86_64-allyesconfig (attached as .config)
> compiler: clang version 10.0.0 (git://gitmirror/llvm_project 891e25b02d760d0de18c7d46947913b3166047e7)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/clk/x86/clk-cgu.c:50:20: warning: address of array 'ctx->clk_data.hws' will always evaluate to 'true' [-Wpointer-bool-conversion]
>            if (ctx->clk_data.hws)
>            ~~  ~~~~~~~~~~~~~~^~~
>    1 warning generated.
> 
> vim +50 drivers/clk/x86/clk-cgu.c
> 
>     46	
>     47	void lgm_clk_add_lookup(struct lgm_clk_provider *ctx,
>     48				struct clk_hw *hw, unsigned int id)
>     49	{
>   > 50		if (ctx->clk_data.hws)
>     51			ctx->clk_data.hws[id] = hw;
>     52	}
>     53	
> 
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
