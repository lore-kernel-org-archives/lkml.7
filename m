Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9459EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651E8218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="guQEGIIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfCUIXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:23:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38092 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUIXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:23:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id g12so5551610wrm.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 01:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2AZAZ/E+DHoG7j0qdAoHZSyLZjtvV30VMLHXfo3frEQ=;
        b=guQEGIItSu4X03yXJEgFzMPy9s/uEBVs3xhFA0k4vL49wfXmrACu3aAmXO1tCDsXP/
         AGRH4e+ZjzLan0B1kbQqlRtyt+3lD6sj8VWZmAqrZvwk6Y5pMMea82MrSkGdP+m4mkxg
         TaZIC3Yy5eE7MYhbrM4jonvsy+wA0nC1YSvMMfUddBLDWAeVNrNtv+vUICLLIniFDd//
         6y8yaFj6UMBKdW/bu4fnChh+Rg/atRNTaHC+BZe9INSS9SluiP/fLCnqNZoT/b0ShbzQ
         xB81FvSeADPN3T3Td322f/3aqIGcG0oOcAcsu/sZBwJ/bVNT+mkVwZQ62DFiMbEtHnty
         8Hqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2AZAZ/E+DHoG7j0qdAoHZSyLZjtvV30VMLHXfo3frEQ=;
        b=nEJMBURrfV5md29ubcNmv8eK2lkqpZDwbRHuH0QxEo2UkM04RWG1c8x5ChlGgL41WL
         wu3pVnl1xuZ8bvQPv5QMI4OvrQp5FkUIXhRVK00uzICKWzd8WF5m3zVORpl7yveHenhJ
         rUL4iE7A/4rQ6von9o2GfXjUGLD2FlqS0fBtUp/BFdcdhN4Uc6OuFjZu0SipPAsG4b1z
         s3nulaZyEfgoKltvKcXhVi0tHOmgkOvYdqYtK7ptMXIU4YDidMghMhcRHi4Fv7EezNhn
         hOvR/U43lKuluKDqlHcl5VzN+dzX4X+RzABQevj7C0VPhW/F/HJ1W/cZgDyrhRyiWC48
         PSag==
X-Gm-Message-State: APjAAAXlxTRKVTzttRnKk1Apaa0f8lBobJN4w+ifunImKNJnYsIuxYkx
        ZjNvIUowK6QacmptsrderhwF0A==
X-Google-Smtp-Source: APXvYqxsp2KPuNiVCdTnFe2wbSq12+VxwhCGE9DRBMhDqYBcCYNyMClTcDzOMXSBB0aC5OEBXhfsgg==
X-Received: by 2002:a5d:624a:: with SMTP id m10mr1611289wrv.18.1553156620839;
        Thu, 21 Mar 2019 01:23:40 -0700 (PDT)
Received: from dell ([2.27.167.37])
        by smtp.gmail.com with ESMTPSA id 3sm5548919wrk.68.2019.03.21.01.23.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 01:23:40 -0700 (PDT)
Date:   Thu, 21 Mar 2019 08:23:38 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazzisaccount@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com, Robin Gong <yibin.gong@nxp.com>,
        Elven Wang <elven.wang@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Angus Ainslie <angus.ainslie@puri.sm>
Subject: Re: [PATCH v3 1/3] devicetree: bindings: bd718x7: document HW state
 related ROHM specific properties
Message-ID: <20190321082338.GT4731@dell>
References: <cover.1550135853.git.matti.vaittinen@fi.rohmeurope.com>
 <6ed4238fb083f52de0f5f013647b2334bad8ebe4.1550135853.git.matti.vaittinen@fi.rohmeurope.com>
 <20190320130259.GN4731@dell>
 <20190320141701.GA6208@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190320141701.GA6208@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019, Matti Vaittinen wrote:

> Hello Lee, All
> 
> On Wed, Mar 20, 2019 at 01:02:59PM +0000, Lee Jones wrote:
> > On Thu, 14 Feb 2019, Matti Vaittinen wrote:
> > 
> > > Add ROHM BD71837 / BD71847 specific device tree bindings for
> > > controlling the PMIC shutdown/reset states and voltages for
> > > different HW states. The PMIC was designed to be used with NXP
> > > i.MX8 SoC and it supports SNVS low power state which seems to
> > > be typical for NXP i.MX SoCs. However, when SNVS is used we must
> > > not allow SW to control enabling/disabling those regulators which
> > > are crucial for system to boot as there is a HW limitation which
> > > causes SW controlled regulators to be kept shut down after SNVS
> > > reset.
> > > 
> > > Allow setting the SNVS to be used as reset target state and allow
> > > marking those regulators which are critical for boot.
> > > 
> > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > ---
> > >  .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  | 17 ++++++++++
> > >  .../bindings/regulator/rohm,bd71837-regulator.txt  | 38 ++++++++++++++++++++++
> > >  2 files changed, 55 insertions(+)
> > 
> > Needs a DT Ack.
> 
> I think this was already applied to regulator tree by Mark:
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git/commit/?h=for-next&id=f43d1b388f9be4aa47ed42c33659243a675c5c76
> Does it go in via his tree or do we need to apply it in Lee's tree too?

Why don't I see an email from Mark?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
