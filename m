Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE99C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E9C2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="utvScWX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfCMRgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:36:50 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35931 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfCMRgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 13:36:48 -0400
Received: by mail-lj1-f194.google.com with SMTP id v10so2367336lji.3;
        Wed, 13 Mar 2019 10:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qyT4JqnDv45kX8u00+MtA049NdZhgi8I/1D4CMcZyYU=;
        b=utvScWX4HfoPwr0LRV95rJwlnuUc7SJzhcEe9ofzUhpo3/NMPsfyJbLDr2p7VnqCbw
         H3z9780OxzDLgtQvbDJfUUvKsC1YkBk9loS9QudSPzbc/2Od7ugCBhGl/XzhEZpavi37
         R14weSU3p7i0aRl/NH4Fw/8gruxnpECRjfd+6MkKERagVzR6ByuScsW0fx+TGstXz6sF
         ymo5vQAurAjG7iJPgzov1gFW3K0Bl3V7bHAb6yC1rAVZsFKm2VqjjK3Qzm46zKJ6uk8v
         7/HHm1gmu8XqAKueRXpV53qFzK8x6RzPbi58hOiRg/f4HPf4cAdWNR+lGcBjmg+1mld7
         QF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qyT4JqnDv45kX8u00+MtA049NdZhgi8I/1D4CMcZyYU=;
        b=ONqCE+7bFHtN59gPlHhHWiSfOm80dx0nRp9ONp8XpbkHkMk9V4kH1DFodhDu8P8BHY
         NP4ao47IyKxUPSqQ5Se+nzNaejiE8rXFjc1gAC53/MTNMtUtvZ5iRe9UwV3YIyqVPi+O
         pFbgF/VLQlEguHvwWeseJQJ3cNsuJBS/w8AjSC8MbOifv8k+mhBMJ5dgQvAvG3Es8+Fl
         CZB9cuD5G+khkuBcFORhubCitW5k3M1ueC/1GEEqRETUNQbIpx6jBqPyDNBfGr5DjPXu
         Slcod9oIrzz/5y6OGSgMSbFuAfd4do3Rf8ExMHLrcabNQLkI9lpTj2ytwrCghAVpP9s5
         ZrnA==
X-Gm-Message-State: APjAAAXxfr5WUMV1+ZZu6qj0D+FXgiqsH+0PrlkTIDN9WwPoGlber88p
        b+DRZEfX+/0nS5K9rOEmskNiJvzBVvYA2nD7BVY7dMdH
X-Google-Smtp-Source: APXvYqzyfZihJ8L5iIeZULEB0LZHMANS2SlwAQ/u/HJTP7FfEuizYtZDQ8MGItjUA7A9egLK+CtGM97bDvLi9OPCC40=
X-Received: by 2002:a2e:9a8b:: with SMTP id p11mr24036517lji.66.1552498606384;
 Wed, 13 Mar 2019 10:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <20181205195050.4759-21-robh@kernel.org> <1552497686.2453.49.camel@pengutronix.de>
In-Reply-To: <1552497686.2453.49.camel@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 13 Mar 2019 14:36:35 -0300
Message-ID: <CAOMZO5CwxZv=kAiqZ7YE2eRV1tTA13xbz1czUXOiScBoBfk75A@mail.gmail.com>
Subject: Re: [PATCH] regulator: Use of_node_name_eq for node name comparisons
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

On Wed, Mar 13, 2019 at 2:22 PM Lucas Stach <l.stach@pengutronix.de> wrote:

> Unfortunately this change causes a regression on systems with MC13xxx
> regulators. The desc.name field is filled with an uppercase name of the
> regulator, while the existing DTs (as far as I know) all use lowercase
> node names, so the matching in the function above doesn't work anymore.
>
> Any opinions about how to proceed here?

Does this patch fix the problem?
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20190306&id=ec520911ecc7eaf01a
