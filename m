Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA4CC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825F32075A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ik5Anhpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgAFOxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 09:53:52 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39582 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgAFOxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 09:53:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id q10so27071155pfs.6;
        Mon, 06 Jan 2020 06:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7XaSQ/EximSmFGX8/V3EJ80TFSF4aq77AU2UpijSJZI=;
        b=Ik5AnhpvAImEgN0p68Hf/k9umrhsuqXm4qs4u1YkY6jd3OiUdRu9W1AWJ5x0/nw7FO
         0qu3x8xEPb/n6HoM5qFhztMzyR0T1k7hjFDX8l4lkfRqFaoG5SCnK4DOKDGA2eUmpzYb
         PlmW6sZk6qfLbaO8+8VVPoz1GrYrj967PNenLmYB1U70QsW7vB86h2NM6C953J8gYsG6
         mWyOAYo8eHHXfCwkDvSfQR5wVbR0Xhn7vy5QxTUM35CePfOWGKGmK3qW1NZss9LXbx36
         +gAsR7V7Dbj4eBNdtu7XYWkdZZegcEZ3ygCCYjiyV4PU8/Vf8tLJwGozZyVAuUdyDXlU
         7qeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7XaSQ/EximSmFGX8/V3EJ80TFSF4aq77AU2UpijSJZI=;
        b=Fbq6hAv0cvBDUrqN57dW+IW6QiOvobSfBV9ddDRXdhvPVZlIx0J+U4W5pTqhtiGNv1
         QjE/YmVpE6Xo/Zho8/nY/2OPJIcTstUK6YV2LnyMZZRMlIEC3qRGkSgtlNOX1DFIRBOD
         6CUKCZZcNjFhxTXyHxing7AiP76qei8GI0bSt4ZSoPqCvHyN85x72yaZImv1InHhb/nk
         WcPHHBUp6gtNAEzJuxe76E1tanfjbJCZnRZI4HDq6bC+GMKxlJc68gK2ZPOpM5CgwH0O
         iPOAOkHZRBU1kz1TUzUVcrQ32rhN6wzWWzbE1w/NiMz8mwGT7bH44ULG9d6eYvaenNsX
         lWtQ==
X-Gm-Message-State: APjAAAV8OL+LjK6GtzJvwZ4kqtjb2sMr/FVwU383I0FZmvolit+EFzyY
        3uzMG+OmMFEswfL0GU+cKjo=
X-Google-Smtp-Source: APXvYqw7X+6XPNP8y15lx7qSPoqnIH26+3MN77S1SiKjqMSEGFmpmGs8DCFCMg4IJCS/+hFNtusRHQ==
X-Received: by 2002:a63:358a:: with SMTP id c132mr4412983pga.286.1578322429849;
        Mon, 06 Jan 2020 06:53:49 -0800 (PST)
Received: from localhost (g52.222-224-164.ppp.wakwak.ne.jp. [222.224.164.52])
        by smtp.gmail.com with ESMTPSA id k21sm68949754pgt.22.2020.01.06.06.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 06:53:49 -0800 (PST)
Date:   Mon, 6 Jan 2020 23:53:47 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     Julia Lawall <Julia.Lawall@inria.fr>, kbuild-all@lists.01.org,
        Jonas Bonn <jonas@southpole.se>,
        kernel-janitors@vger.kernel.org,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] openrisc: use mmgrab
Message-ID: <20200106145347.GT24874@lianli.shorne-pla.net>
References: <1577634178-22530-5-git-send-email-Julia.Lawall@inria.fr>
 <201912301238.xfn6pKut%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201912301238.xfn6pKut%lkp@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 12:49:19PM +0800, kbuild test robot wrote:
> Hi Julia,
> 
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on vfio/next]
> [also build test ERROR on char-misc/char-misc-testing v5.5-rc3 next-20191220]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Julia-Lawall/use-mmgrab/20191230-011611
> base:   https://github.com/awilliam/linux-vfio.git next
> config: openrisc-simple_smp_defconfig (attached as .config)
> compiler: or1k-linux-gcc (GCC) 9.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=9.2.0 make.cross ARCH=openrisc 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arch/openrisc/kernel/smp.c: In function 'secondary_start_kernel':
> >> arch/openrisc/kernel/smp.c:116:2: error: implicit declaration of function 'mmgrab'; did you mean 'igrab'? [-Werror=implicit-function-declaration]
>      116 |  mmgrab(mm);
>          |  ^~~~~~
>          |  igrab
>    cc1: some warnings being treated as errors

Hi Julia,

It looks like this is just an include issue, do you want to revise the patch?

Once fixed, how do you plan to get this patch series merged?  I can add the
OpenRISC part to my queue or do you have a cleanups queue you can manage?

-Stafford

