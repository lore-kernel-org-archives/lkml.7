Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66B5C606CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97AF62064B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CVOcYgSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404823AbfGHUBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 16:01:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46777 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404790AbfGHUBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 16:01:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id i8so8194700pgm.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 13:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+rS3r5/o5WlglKViT05ZfPqB6A1XK/bfTpeSIbtHg0Q=;
        b=CVOcYgSEvh1Iyt/5ekj6VuLbZ/qdh9vrCDeeWY5d34h1vdMhsbs3BCYEHu95y6UvMM
         7Z70VYRicybfXnwBIUHXnFSffN53pGjH4NJdHVy3khRhRSkh/u4e774D/T/dn4OLilrg
         YeZsbuL8rp3AIbIebFwZJBZ9IiJXCa+vbIkNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+rS3r5/o5WlglKViT05ZfPqB6A1XK/bfTpeSIbtHg0Q=;
        b=PkAWihdiyLqTT3LAAkaP4mMm4rJB1TXM1HDc+4dRJrV+9/QAikjOYg1gnCIYjHd0f6
         0ps+OyeSpKCWhf+Akggf2ERRfgXFHaCgax/LXcq3AtXljiyS6Td2mpcV2XKim8xDXO6B
         ixZ63GtLNEqRb6Zo8hxavsPZFRlbIhaY7ndV61Bi7eICqiqy8Ib08j3ZK6H1hoTq5EnL
         9Vm/OjpNaVJUZ9cIu9gmb/F0BnNGdm2fnDxMW3P3PsNxq79ctCBNDq+SJd2nvNNM5B04
         lfkIhi3YizqedhxA2yaC8udA6O60YJblsT7bKO+gqs4rihUM6QpC9pzF6HE4e550qyyN
         A8gg==
X-Gm-Message-State: APjAAAWAbRlTG8XuWVJoeL86TqEnyi2gi8kXwzzqQnA2j+IzX9UwZLuD
        Cxi8VQ/srV75VK8qcfEpVOtq/g==
X-Google-Smtp-Source: APXvYqxsXmL8H3YlaNJHrM80DDPyuqBUBVzPdrdzzDi2u7Tph0fpyS7VUV+Z2JjPq13R9E7qjd5tfA==
X-Received: by 2002:a63:b904:: with SMTP id z4mr25368975pge.388.1562616098656;
        Mon, 08 Jul 2019 13:01:38 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id l124sm24507761pgl.54.2019.07.08.13.01.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 13:01:38 -0700 (PDT)
Date:   Mon, 8 Jul 2019 13:01:36 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v3 1/7] dt-bindings: net: Add bindings for Realtek PHYs
Message-ID: <20190708200136.GM250418@google.com>
References: <20190708192459.187984-1-mka@chromium.org>
 <20190708192459.187984-2-mka@chromium.org>
 <20190708194615.GH9027@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190708194615.GH9027@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 09:46:15PM +0200, Andrew Lunn wrote:
> On Mon, Jul 08, 2019 at 12:24:53PM -0700, Matthias Kaehlcke wrote:
> > Add the 'realtek,eee-led-mode-disable' property to disable EEE
> > LED mode on Realtek PHYs that support it.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > TODO: adapt PHY core to deal with optional compatible strings
> 
> Yes. Does this even work at the moment? I would expect
> of_mdiobus_child_is_phy() to return false, indicating the device is
> not actually a PHY.

Indeed, it currently doesn't work atm. I found that removing the check
for dev->of_node in of_mdiobus_link_mdiodev() helps, but I imagine
doing (only) this might have undesired side-effects.
