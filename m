Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FB2C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48770206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHZqjeYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfECT60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 15:58:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32999 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfECT6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 15:58:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id z28so3404872pfk.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 12:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WB6WukALIt5LPSFOLetrqCfdn6458xhXun4VAeBfku8=;
        b=AHZqjeYBooF34dvlJEEYqeS5a/OwB/N3wk8oRUX3xMNSZkJpPj2xUUUhnfeja/ANyO
         tLcv8IyusQA50EJQjTWkpWqIyRR/dEIwxDFO38PsT9Yr/CGqyAmXM0zi/CYIKU/Tpdzs
         R4tXGXyS977mH72o1FZgcd3NrHQ4BhL4DfLfyNDG3TvWlrO7QMvI2+13BEABMzrV9zd3
         Wu4t6R2/qCSX4OIx24AO7VADifBn7OP2NwFxU7vTCga6cc0iM6EblGTAsERoUhKpvbSm
         0soVKjoHaKXoMJZbuEM6ie18l9NrzilF1wzJWAIFdQoBCxxpogrzCe6g3QHS4vuShJz1
         UlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WB6WukALIt5LPSFOLetrqCfdn6458xhXun4VAeBfku8=;
        b=hNAcK8+cpvjADVmEm3ad0UO5khW/gdYOK9msU7I2tds8WF91VeLB+eZ/ZdcjKUjkMI
         tZXJR4IFga4uwZMrRgu7hf6R4vnUXSjtEEIynLrgjHlbAonL06ovWsTVQfkWhTFgMbXR
         wfF/KgMMS9wkgpr45+gJ9D9Ygs1d5m9JdH7gQYGztwnbeifHUBcYE4qK6Ta865Oy2hW4
         omqBJs625/NX/Wi+Ho8DDUNiTN8RvII+SkaG2By43uxTMhKtkTgwg7f8SxICEcXJPCBO
         0+vkBYhtIy/bLt+kKUrLZhQ9wyeqLT+SBkKfTsYtoQwVBZaDgx5h7iMtI5clIXZ4Vmnt
         /Dpw==
X-Gm-Message-State: APjAAAW9hiOHnkfc2HQuDTlL1yJKdJznwybgcwwUusTWd4couwPttmqY
        Y/A4COr9GV0Z49pn8zFNLc8=
X-Google-Smtp-Source: APXvYqy7TK+EVMdOx5DGkjrJ0eA7+vRZ/pb3vRx0DHFz2qS0ZuFK5ZP5l67SdIG88fBWSJiRE/CyAg==
X-Received: by 2002:a63:d347:: with SMTP id u7mr13073160pgi.254.1556913503804;
        Fri, 03 May 2019 12:58:23 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id i15sm4868020pfr.8.2019.05.03.12.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 12:58:22 -0700 (PDT)
Date:   Fri, 3 May 2019 12:56:49 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH V4] ASoC: fsl_esai: Add pm runtime function
Message-ID: <20190503195648.GA30289@Asurada-Nvidia.nvidia.com>
References: <c4cf809a66b8c98de11e43f7e9fa2823cf3c5ba6.1556417687.git.shengjiu.wang@nxp.com>
 <20190502023945.GA19532@sirena.org.uk>
 <VE1PR04MB6479F3EED50613DF8F041713E3340@VE1PR04MB6479.eurprd04.prod.outlook.com>
 <20190503042731.GX14916@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503042731.GX14916@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, 
On Fri, May 03, 2019 at 01:27:31PM +0900, Mark Brown wrote:
> On Thu, May 02, 2019 at 09:13:58AM +0000, S.j. Wang wrote:
> 
> > I am checking, but I don't know why this patch failed in your side. I 
> > Tried to apply this patch on for-5.1, for 5.2,  for-linus  and for-next, all are
> > Successful.  The git is git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git.
> 
> > I can't reproduce your problem. Is there any my operation wrong?
> 
> The error message I got was:
> 
> Applying: ASoC: fsl_esai: Add pm runtime function
> error: patch failed: sound/soc/fsl/fsl_esai.c:9
> error: sound/soc/fsl/fsl_esai.c: patch does not apply
> Patch failed at 0001 ASoC: fsl_esai: Add pm runtime function
> 
> which is the header addition.  I can't spot any obvious issues visually
> looking at the patch, only thing I can think is some kind of whitespace
> damage somewhere.

I downloaded this v4 from patchwork and resubmitted a v5 for a
test. Would you please try to apply that one?

If my v5 works vs. having merge conflict at v4, maybe something
wrong with Git version of Shengjiu's? I compared my v5 and his
v4 using vimdiff, there is no much difference of whitespace.

Thanks
Nicolin
