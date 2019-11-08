Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F080FFC6198
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71C520869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 21:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573247653;
	bh=1E2P2eaR5D6WMUT1+wIsyz3QIoOZz8hZxKKalhcbczw=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=v/2e/XEsUv7dRCz6zdhF1p/P8N+OEzgpTGEpFCAYuffmphuoE8/ldUy6GeKEw9qKf
	 s7fiiYVdaSdrQ1+9Z93lLVQmgiOFQdCW1btbsgGrZESr2tEW0uTRKympjK/5V8VxkJ
	 LTOW2jbeQZ9AF03Ot75MsbFANVwYDF52Y05ItCv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbfKHVOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:14:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:56286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732382AbfKHVOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 16:14:10 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0411720869;
        Fri,  8 Nov 2019 21:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573247650;
        bh=1E2P2eaR5D6WMUT1+wIsyz3QIoOZz8hZxKKalhcbczw=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=DVCgyzxiqBzEZbUqgcL/9xLt8kgLmS2d8qo10M/zc/qqUqVWE4FLM6G1VKk0HFDcD
         lsG7ddvHm09qdBdI6gUEYcheQjxOFagAYZVnUPBTfmFVq97FkNyhgwz+je/BX1ttlb
         0s8ni7iKvcqvuuI8fKYCrIK4hQx9MFv466YM7w6k=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJs_Fx6KCirGMtQxE=xA-A=bd5LeuYWviee0+KqO5OtGT9GKEw@mail.gmail.com>
References: <20191014102308.27441-1-tdas@codeaurora.org> <20191029175941.GA27773@google.com> <fa17b97d-bfc4-4e9c-78b5-c225e5b38946@codeaurora.org> <20191031174149.GD27773@google.com> <20191107210606.E536F21D79@mail.kernel.org> <CAJs_Fx60uEdGFjJXAjvVy5LLBXXmergRi8diWxhgGqde1wiXXQ@mail.gmail.com> <20191108063543.0262921882@mail.kernel.org> <CAJs_Fx5trp2B7uOMTFZNUsYoKrO1-MWsNECKp-hz+1qCOCeU8A@mail.gmail.com> <20191108184207.334DD21848@mail.kernel.org> <CAJs_Fx6KCirGMtQxE=xA-A=bd5LeuYWviee0+KqO5OtGT9GKEw@mail.gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Rob Clark <robdclark@chromium.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Taniya Das <tdas@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        robh@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH v4 5/5] clk: qcom: Add Global Clock controller (GCC) driver for SC7180
User-Agent: alot/0.8.1
Date:   Fri, 08 Nov 2019 13:14:09 -0800
Message-Id: <20191108211410.0411720869@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Clark (2019-11-08 11:40:53)
> On Fri, Nov 8, 2019 at 10:42 AM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > So the scenario is DT describes the clk
> >
> >  dpu_node {
> >      clocks =3D <&cc AHB_CLK>;
> >      clock-names =3D "iface";
> >  }
> >
> > but the &cc node has a driver that doesn't probe?
> >
> > I believe in this scenario we return -EPROBE_DEFER because we assume we
> > should wait for the clk driver to probe and provide the iface clk. See
> > of_clk_get_hw_from_clkspec() and how it looks through a list of clk
> > providers and tries to match the &cc phandle to some provider.
> >
> > Once the driver probes, the match will happen and we'll be able to look
> > up the clk in the provider with __of_clk_get_hw_from_provider(). If
> > the clk provider decides that there isn't a clk object, it will return
> > NULL and then eventually clk_hw_create_clk() will turn the NULL return
> > value into a NULL pointer to return from clk_get().
> >
>=20
> ok, that was the scenario I was worried about (since unclk'd register
> access tends to be insta-reboot and hard to debug)..  so I think it
> should be ok to make dpu just ignore NULL clks.
>=20
> From a quick look, I think something like the attached (untested).
> (Sorry, I'd just paste it inline but gmail somehow eats all the
> whitespace when I do that :-/)

Cool. Looks good to me.

