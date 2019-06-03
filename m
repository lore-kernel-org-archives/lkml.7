Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965DDC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686F2272AE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="bEsneHSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfFCN3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:29:34 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42846 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfFCN3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:29:34 -0400
Received: by mail-qt1-f195.google.com with SMTP id s15so9268659qtk.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 06:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mZev96uN8n10EvmVIXtu7wkuFnMrbFGBNKk++AfTZ1E=;
        b=bEsneHSjj52GjgF8l8Dc2ToLi/EkgcaZmpYGfwkd8iqgakVeS0vHif1pKbYP6+gKSY
         ci2/zAAk6rqRWnZJuMlhMXvbWcLTrcC7HNxk4gahYTMl8/+Ym9xGS8ERPJVv0goMsep7
         iyu0h8/ch4w8JwxB1YZWIfsPb9mV5CG8m0uv0VmkAxyFw64bIxgYGyzcrjWvtCveRPPY
         zlmWzEb9vQmOo5A/Oc+w5h4vTIPZdKtp+/ZsSkCCTsGPAa82mmsg3MtDEsfS65YDOHcS
         IRxwJvUDOsGZ9hXQZTwk88dYyoVW+X1wlYM9F5F5nvaD+F5VS4dqr1fzHgdVMaizSwO1
         BG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mZev96uN8n10EvmVIXtu7wkuFnMrbFGBNKk++AfTZ1E=;
        b=Ty6kMPrWOaqMb8JNEZ5xqWQmiH16FaD3yeqbEemCuW+x8meKutVCXV9PWV2agI63rb
         tzz8XyrizkccZ8mRDnlvyUhvz9yf9Gb1tU/i8yhql6CiJhnbT5kmnPuboRljuFA52bhO
         U5bduF0qOhShGjYgF3hNX4a3eor4lgZWR20sK8YhNqSJWtFIVzqO4Uaxl/67YRk0W1XM
         8qhk/j1TypbhHTjg+xrDDbufYefSdcNKOCMTZLInGcUr9hZWCz/xBj7b7XR6E7HNoo7V
         qlHeHfGN6IcUMde/BjNHR0OtfmJlsEPc5ZsP2W9AhH2VbYtytIW1WrzSdzAulml24PCI
         vYow==
X-Gm-Message-State: APjAAAUKGHTVsIMhfD11LWXo4HUul1FxpsvXpSSpb0v68jCjqv9HUF9R
        AFKtTUm628lcQz3L5OX37FCgSQ==
X-Google-Smtp-Source: APXvYqye0Wu5YYJf2p5hR3aP5of+NBIqggqx412TOzc22Tu4TSfg9fOF7G4PVGU5gtTBViT3vCctxQ==
X-Received: by 2002:a0c:bf4a:: with SMTP id b10mr21132334qvj.120.1559568572920;
        Mon, 03 Jun 2019 06:29:32 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y29sm9931599qkj.8.2019.06.03.06.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 06:29:32 -0700 (PDT)
Message-ID: <1559568571.6132.42.camel@lca.pw>
Subject: Re: [PATCH] iommu: replace single-char identifiers in macros
From:   Qian Cai <cai@lca.pw>
To:     Robin Murphy <robin.murphy@arm.com>, jroedel@suse.de
Cc:     akpm@linux-foundation.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 03 Jun 2019 09:29:31 -0400
In-Reply-To: <fe5e8da4-38d2-c663-c2e2-70e6d4f7640f@arm.com>
References: <1559566783-13627-1-git-send-email-cai@lca.pw>
         <fe5e8da4-38d2-c663-c2e2-70e6d4f7640f@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-03 at 14:07 +0100, Robin Murphy wrote:
> On 03/06/2019 13:59, Qian Cai wrote:
> > There are a few macros in IOMMU have single-char identifiers make the
> > code hard to read and debug. Replace them with meaningful names.
> > 
> > Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> >   include/linux/dmar.h | 14 ++++++++------
> >   1 file changed, 8 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/linux/dmar.h b/include/linux/dmar.h
> > index f8af1d770520..eb634912f475 100644
> > --- a/include/linux/dmar.h
> > +++ b/include/linux/dmar.h
> > @@ -104,12 +104,14 @@ static inline bool dmar_rcu_check(void)
> >   
> >   #define	dmar_rcu_dereference(p)	rcu_dereference_check((p),
> > dmar_rcu_check())
> >   
> > -#define	for_each_dev_scope(a, c, p, d)	\
> > -	for ((p) = 0; ((d) = (p) < (c) ? dmar_rcu_dereference((a)[(p)].dev)
> > : \
> > -			NULL, (p) < (c)); (p)++)
> > -
> > -#define	for_each_active_dev_scope(a, c, p, d)	\
> > -	for_each_dev_scope((a), (c), (p), (d))	if (!(d)) { continue;
> > } else
> > +#define for_each_dev_scope(devs, cnt, i, tmp)				
> > \
> > +	for ((i) = 0; ((tmp) = (i) < (cnt) ?				
> > \
> 
> Given that "tmp" actually appears to be some sort of device cursor, I'm 
> not sure that that naming really achieves the stated goal of clarity :/

"tmp" is used in the callers everywhere though, although I suppose something
like "tmp_dev" can be used if you prefer.
