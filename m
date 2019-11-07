Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55232C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237FA21D7B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 08:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I14DfnkJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfKGIAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 03:00:39 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41372 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfKGIAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 03:00:38 -0500
Received: by mail-lj1-f195.google.com with SMTP id m9so1143561ljh.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 00:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MhaY0ugk8kwsxq3FKugkspL2MYGqh9zusrvzrZWI37A=;
        b=I14DfnkJr2s5xHB5Em9zNk3CnxEv+KsQd0RLv0S2M8Zbd+JBPrWQJLyDLI7UsFnUyU
         jewSW9KGU/5Mj9rdaNo/E2CyOlWqdkGPzV0FKD8pzXnXD3OmuC/TsBCYNhSg17P6FrJ5
         yO/9vByIOBxYr8lAEcOkeM/NE1hghWfDpsgq3uX5OL8n451FtpVVRIhZkjqCAZ7uX944
         lPTNCMOLpkf4y0CWt1TIVJuYzQfJ5LVPfLv4/nI9ZLCt88eZu1rYn+LQ/rUHDWf9xG3A
         PTkIKjTPMdR856l4uTDdUmyGArjXOYE5n9URj12P9bxKJYTmmXrwUZqQ+7tFtbtsxz5R
         tAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MhaY0ugk8kwsxq3FKugkspL2MYGqh9zusrvzrZWI37A=;
        b=Q6LowDMOPXSDuQWrJCMkzvZCb6pzRQIAPWS55wapRgDEqb4NNKg1tlIx9cLYAyTUmf
         pq+TSWLpiSNjodN2ntbR6E5c7lw3ul3P/QI6mstHCUsOp2pDz1WFmp5y0/fQKeW6I0oU
         JIbhjYuSGWAK3GEXaNBOUsYzQj6wUrfx7MRkR1y4HbVtoGQ209GxTwvb/mnWlnkoItf7
         yptNvtJS/OTjb7xpsciP80ozkLfn3BAW4YtGWNNw6Y4MwRb1eiToS5p8/7o+DdUCfMbO
         BwY9XnKxl7MbnP9yi7gKQBN1+ILuQPvRpGVk1cdBS2kAlA+mlXT4QhgMCEcS28xaOlBV
         hTnQ==
X-Gm-Message-State: APjAAAVJsY9ELaKXcAMHds9nRl1pu7rK2ezP4fIf08FSP1JMHyajorwb
        q9mVlGAtiSxIpnrJw+/D4Bs8fYj9I+aIsMI6r5PTuQ==
X-Google-Smtp-Source: APXvYqzRSNCULNUNJVqaJNgU2Aq5iaQhDKeZCxYwvKxqVktkZ0uhZzJPx1LEXl2tE4KbyibfhtzJ5OdCkeugYriABVE=
X-Received: by 2002:a2e:5c46:: with SMTP id q67mr1273474ljb.42.1573113636714;
 Thu, 07 Nov 2019 00:00:36 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYvm_QEq+9e+dni1Y+bJswr9bU5=shJcC+wKjjOyiPsXXQ@mail.gmail.com>
 <bfced8c8-c64f-982e-8797-d48b5ec65291@arm.com> <20191106161705.GA11849@sirena.co.uk>
In-Reply-To: <20191106161705.GA11849@sirena.co.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Nov 2019 09:00:25 +0100
Message-ID: <CACRpkdY5JObOobs7VW043QYGd_xufwnQDBJseKp+_QWv4kdzaQ@mail.gmail.com>
Subject: Re: Linux-next-20191106 : arm64: Internal error: Oops: 96000007
To:     Mark Brown <broonie@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, John Stultz <john.stultz@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 5:17 PM Mark Brown <broonie@kernel.org> wrote:
> On Wed, Nov 06, 2019 at 04:07:52PM +0000, Robin Murphy wrote:
>
> > FWIW this smells like a builtin driver had its of_device_id table marked
> > __init, leaving drv->of_match_table as a dangling pointer to freed memory by
> > this point.
>
> Indeed, in fact I sent a fix for this to Linus Walleij yesterday having
> seen the relevant build warning when testing -next.  Someone already
> reported that it fixed the boot issues.  Hopefully Linus will pick it up
> soon :/

Yeah picked it up and pushed out now. I wish I'd been quicker with
it but the patch spot activity has been high. (Bad signal-to-noise
ratio on the mailing lists.)

I wonder if it's worth to look at the static checkers like checkpatch
to warn for this?

There is always a bit of delicate balance between just fixing some
weird one-off problems and making sure they never happen again.

Yours,
Linus Walleij
