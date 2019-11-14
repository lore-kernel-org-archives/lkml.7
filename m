Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F69C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 06:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA69B206D6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 06:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KaUsoDMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfKNGJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 01:09:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42826 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfKNGJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 01:09:47 -0500
Received: by mail-pl1-f195.google.com with SMTP id j12so2139081plt.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 22:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aw8y1jiGvDQuLoad9v02dXK5MRBBqE3yqRJRCShjhww=;
        b=KaUsoDMkOxGtKBYv81fJMUCgETapU2RakSt6h22VwS5B3+ecb9eOhYEJFqAU6u7coF
         4kb5d+Ozunov31XfwFnnoz+TFDqpuWPnyhQ5NOh2Kxs3JfccG8wE/SunSG1etjaVlV1j
         x/1wP6NZ6LKtUXjHzQk2koVYBye1heoA1pZPjPcvpxvmiu64B1nE5UxTeqGgLxt4eCj1
         b5ta7L4aWkW/vqmygbxb/Ku1N5239Ua6vJR8p2EBPEM0tey6KYECmV2MTpM4Cqsbs0sa
         dAksZhSCR9ZbieXb+/y6d2xsCKAW+Ajbo68p6PXoc9lTpPA/Ry4N8C/dfek+uf0i5NWs
         0RhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aw8y1jiGvDQuLoad9v02dXK5MRBBqE3yqRJRCShjhww=;
        b=mF0wsqR/JXKvg0maEiUffhmmz38AYqzcQNiT4qtVxvZfB7MOtZm6o454AaiqYpaUuJ
         LRNbcMYFgj4ueJN2W1TsnhxBSmTUHfH1/V1LlJLtO8SDtviHwDDbkcXmebuiabjhCqpM
         5uRbw9t7KldciaWT1iUKGxUaTS5peSXFCyKWn9cPkeRrFDLeJghkCfZ0bGfXBtn1gy81
         zMjyXqIQyTzUjioMOiidMvvhCFSHYIfSrV5aJnxgk/fFTg/k3rZN+clfaBll8K6bN/er
         XwkHNqzPSzkkrTmdT/QajnhIieNdYyEcZDcw+Aw31uajV81+wcpTPWJppRopyHgRwTVI
         R0lQ==
X-Gm-Message-State: APjAAAWifKnaB2ClBOhyKYtO/prn4qn+gptekz7q5Cg5XpSx8EdFhLoO
        Be1WqydwrkEWuuM+ZjaM8X9D
X-Google-Smtp-Source: APXvYqzVItSwZLHCuH1SFvN8lnszFgvIq8ecWeEhJ4mhuw9CcYH9GPraKqjzKFczcLQSD2Wgpor8iA==
X-Received: by 2002:a17:902:ab87:: with SMTP id f7mr8011816plr.78.1573711785394;
        Wed, 13 Nov 2019 22:09:45 -0800 (PST)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id w11sm4579443pgp.28.2019.11.13.22.09.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Nov 2019 22:09:44 -0800 (PST)
Date:   Thu, 14 Nov 2019 11:39:37 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com
Subject: Re: [PATCH v6 0/7] Add Bitmain BM1880 clock driver
Message-ID: <20191114060937.GD8459@mani>
References: <20191026110253.18426-1-manivannan.sadhasivam@linaro.org>
 <20191113222116.E5E9B206E3@mail.kernel.org>
 <20191114053404.GA8459@mani>
 <20191114055054.C280F206DA@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114055054.C280F206DA@mail.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 09:50:53PM -0800, Stephen Boyd wrote:
> Quoting Manivannan Sadhasivam (2019-11-13 21:34:04)
> > On Wed, Nov 13, 2019 at 02:21:15PM -0800, Stephen Boyd wrote:
> > > Quoting Manivannan Sadhasivam (2019-10-26 04:02:46)
> > > > Hello,
> > > > 
> > > > This patchset adds common clock driver for Bitmain BM1880 SoC clock
> > > > controller. The clock controller consists of gate, divider, mux
> > > > and pll clocks with different compositions. Hence, the driver uses
> > > > composite clock structure in place where multiple clocking units are
> > > > combined together.
> > > > 
> > > > This patchset also removes UART fixed clock and sources clocks from clock
> > > > controller for Sophon Edge board where the driver has been validated.
> > > > 
> > > 
> > > Are you waiting for review here? I see some kbuild reports so I assumed
> > > you would fix and resend.
> > 
> > I'll fix it but I was expecting some review from you so that I can send the
> > next revision incorporating all comments.
> > 
> 
> Ok. I'm glad I broke the silence then.
> 
> Can you please resend without any dts changes? Those don't go through
> clk tree. 

I'm the platform maintainer, so I'll take the dts changes via ARM SoC tree.

> I think otherwise the patches look OK, although I was hoping
> you could register clks by using the new way of specifying parents. Is
> that possible?
> 

Eventhough I'd like to do, my time is very constrained these days. So please
consider merging it as it is and as I promised, I'll switch to the new way of
specifying parents soon.

Thanks,
Mani

