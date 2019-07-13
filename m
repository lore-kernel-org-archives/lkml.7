Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AD9C742A7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 13:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509E020838
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 13:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ma5ZI12l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfGMNrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 09:47:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35273 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfGMNrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 09:47:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id s27so5778519pgl.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 06:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MHQBlqOJyDDBTOKEayCnxnSR5munfqfFU78suNbldEE=;
        b=ma5ZI12lrynFaFq1wLNZC05ShF9C4Nts9tZIFj8OvXtp8WeNkuxldGyQbBwe0GZd1P
         zuNCYWgikc/cQdadbV4+8Gh6puzyackdUOLErtBHBKeRhZ/X+Xrkspn1twK72wyjxg8O
         9yj5y5CHmXySPbd7mvQayFRQYwG1cjMgCXOVAeCjKVrd23sgt08AuQe2a2M7Iv4XxmHH
         qjZ5ZCBgY7nG+15syDrBGfMy0AQ+p66nbl3DRUPM45C41TLAch0kIKaaCYu5Sz6Mvxto
         12xZ83WzEh3uZp1tAI14k8cJgGS6Xn7N2cwmoxbWRFoJSpxa8Bwz+UaqZYbht9Tod5gr
         fMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MHQBlqOJyDDBTOKEayCnxnSR5munfqfFU78suNbldEE=;
        b=UUrAotKm5ZlhIS33YhrEsv6LvoNSFNBOHGAPd78gUrD3Z1HLxsDkP27pkM2pJwc4jS
         MGs4cjWYAJ1Uq76YfwUPTir5P9D9Q6176A2qlQHQYGz6qT788I3mz3OHOSQjO6uf/R2N
         b7Dzo2a3F+xaSnzjJxK6YIf1jqN+njvu1jouYfv2z3BDdU6pYhm5UxDUs8oiZoiVWIg0
         zRHqx54xG25CjmpZHH5si+m8UmGsA3b06l6aMH0vlTRZmmfiNO9NplQMd7NNM8+ur21N
         MdU/6A6iskCYzfU91UbIk7UyOskxi5O/SCkKbjYm30v+x+7zTwA6yIKeUdxmqyJC7hmv
         Ftfw==
X-Gm-Message-State: APjAAAURq4STHSlz178dC0H/DjgmBnzboWBzYp1cQ0NUlw4dN2m5CwOr
        dmH6lubIzh+LSMxPM0fN8B4=
X-Google-Smtp-Source: APXvYqx4idiwBlGEcHoYCRhzdK6VMDt71COUdgiJS35nV5ptO3rXo807rxCRKPLRa5tJHgbse51/kA==
X-Received: by 2002:a65:5cca:: with SMTP id b10mr17317538pgt.365.1563025665379;
        Sat, 13 Jul 2019 06:47:45 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id cx22sm9934041pjb.25.2019.07.13.06.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jul 2019 06:47:44 -0700 (PDT)
Date:   Sat, 13 Jul 2019 19:16:34 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Joe Perches <joe@perches.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Gen Zhang <blackgod016574@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound: soc: codecs: wcd9335: fix "conversion to bool not
 needed here"
Message-ID: <20190713134633.GA9749@hari-Inspiron-1545>
References: <20190711174906.GA10867@hari-Inspiron-1545>
 <eeeb09518c8967ffd48606c3d1222553752e895d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeeb09518c8967ffd48606c3d1222553752e895d.camel@perches.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 03:00:00PM -0700, Joe Perches wrote:
> On Thu, 2019-07-11 at 23:19 +0530, Hariprasad Kelam wrote:
> > Fix below issue reported by coccicheck
> > sound/soc/codecs/wcd9335.c:3991:25-30: WARNING: conversion to bool not
> > needed here
> > 
> > Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> > ---
> >  sound/soc/codecs/wcd9335.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> > 
> > diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
> > index 1bbbe42..85a8d10 100644
> > --- a/sound/soc/codecs/wcd9335.c
> > +++ b/sound/soc/codecs/wcd9335.c
> > @@ -3988,12 +3988,7 @@ static irqreturn_t wcd9335_slimbus_irq(int irq, void *data)
> >  		regmap_read(wcd->if_regmap,
> >  				WCD9335_SLIM_PGD_PORT_INT_RX_SOURCE0 + j, &val);
> >  		if (val) {
> > -			if (!tx)
> > -				reg = WCD9335_SLIM_PGD_PORT_INT_EN0 +
> > -					(port_id / 8);
> > -			else
> > -				reg = WCD9335_SLIM_PGD_PORT_INT_TX_EN0 +
> > -					(port_id / 8);
> > +			reg = WCD9335_SLIM_PGD_PORT_INT_TX_EN0 + (port_id / 8);
> >  			regmap_read(
> >  				wcd->if_regmap, reg, &int_val);
> >  			/*
> 
> This change makes no sense and doesn't match the commit message.
> 
> Please ignore this patch. 
> Both statments in if/else loop looked
> similar to me but they are different.
