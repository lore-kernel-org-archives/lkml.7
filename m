Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3198C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67F320663
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqfWBwrm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732529AbfDQSwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:52:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42259 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbfDQSwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:52:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id p6so12406358pgh.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 11:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HJHPz+R+CU544kFQAxOjPvxjaUk0WljUZxgaPbvIzcc=;
        b=YqfWBwrmfbl5Hv+1kfO451IuZw6K2fopkKRxOjVMmlqLtvfCD+8P8ulQ5lZgK/1Yuo
         wotciWLK1N9YFaKqnCC7KhDsWaBYCcT1dWVmNfqTTBO+DZ/5zjovCURXwfjLc4pQbepd
         VYPgFROhVk0Kz2SB9pI7EgoAvlIvb4aJVn2gBesvQmz74RGyw98dVBk0ZR4it8OA+gFO
         1vAu6X2c1JHJk0vVLXC27yg0uqDAWYDzdVGAfYoi6j8YgTrYpToOSc/dvRAfaZhyVRNC
         HlTYWRVSM1S292BTrmgfIvsUpIXINuwXvCLc9+m4MBwzQa93AZ+/J9BjehizbkejOG45
         tAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HJHPz+R+CU544kFQAxOjPvxjaUk0WljUZxgaPbvIzcc=;
        b=eRYJv7hcc2EixQvFWiZCfHM2osy+pDvrMFBzXLZswWOduvbnSwwzyUXy2Qu4izpmwJ
         DElw/hsVpGI0Sp8xrbkNYtMVVRsB5aHrpQIWnGQru6tIylfuapUeIEXULH/dB5sOVzQ0
         Pd0Trbxp04VRcbDBS4hu08LgYm0GuEE0tlzrxELU35fghvoCwaa1FF0NPhCm2sVLzzDT
         uoXGxUslVDjqbDadgDYrT6bRlPfN8wCV0r/dSndc5IpaRzSv48vEg8admGYzZaAhnSbv
         M52ypBJDqDUh1I8jwRCctCWZwb240E89wqBgiufmMh5fiCrEuWmDrFAge+X70Y0hYnz5
         tg5A==
X-Gm-Message-State: APjAAAXxp4QNBhcrTUEoHjURtBdaOb3Y838ToczlenVDBSFwR7s7Up8N
        B1ojU+EMoDTlJ9Ey4aX9bQlG/WzUqeI=
X-Google-Smtp-Source: APXvYqykeKm2o2jK/pzbLZZWY60wLb9avMmElfMMhZG0aMKJkE8U0atALpGy9m1VS/GCrsA8DTYNug==
X-Received: by 2002:a63:2158:: with SMTP id s24mr38059731pgm.156.1555527159561;
        Wed, 17 Apr 2019 11:52:39 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id g5sm42888832pfo.53.2019.04.17.11.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 11:52:39 -0700 (PDT)
Date:   Wed, 17 Apr 2019 11:52:36 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
Message-ID: <20190417185236.GC5073@Asurada-Nvidia.nvidia.com>
References: <cover.1555491598.git.shengjiu.wang@nxp.com>
 <1eaeb882bdd69108c8ce897398c5c36ece6d49c5.1555491598.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eaeb882bdd69108c8ce897398c5c36ece6d49c5.1555491598.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shengjiu,

This looks better. Just a couple of more small comments inline.

On Wed, Apr 17, 2019 at 09:06:18AM +0000, S.j. Wang wrote:

> +static int fsl_asrc_sel_proc(int inrate, int outrate, int *pre_proc,
> +			     int *post_proc)

Just a nit: it looks better by grouping them two-two.

static int fsl_asrc_sel_proc(int inrate, int outrate,
			     int *pre_proc, int *post_proc)

> +	/* Condition for selection of post-processing */
> +	post_proc_cond2 = (inrate * 15 > outrate * 16 && outrate < 56000) ||
> +		(inrate > 56000 && outrate < 56000);

Could align the indentation:
	post_proc_cond2 = (inrate * 15 > outrate * 16 && outrate < 56000) ||
			  (inrate > 56000 && outrate < 56000);

Here:
> +	/* Does not support cases: Tsout > 8.125 * Tsin */
> +	if (inrate * 8 > 65 * outrate)
> +		return -EINVAL;
And here:
> +	ret = fsl_asrc_sel_proc(inrate, outrate, &pre_proc, &post_proc);
> +	if (ret) {
> +		pair_err("No supported pre-processing options\n");
> +		return ret;
> +	}

Instead of a general message, I was thinking of a more specific
one by telling users that the ratio between the two rates isn't
supported -- something similar to what I suggested previously:

	pair_err("Does not support %d (input) > 8.125 * %d (output)\n",
		 outrate, inrate);

Thanks
Nicolin
