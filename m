Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA7FC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505122067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570744309;
	bh=EfYl3DEKiMDTEd71Sf/gNrcgc3iPbO+kTX4RjvVd1p8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yO9AOJJaZG0kRcaUncXP27HwlzUF5sbqxrunCBAUsL5pU7NFoExAfJb/JwWi1uDUV
	 5jg3trFDIypCnEQahzDpFL1reuveUpsub/hyudOkXloktE04DRHQiDbMUE+bJ69ior
	 3quYTxXk4I4yfngea/guXENo/mu5TKZUFE+mj0W0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfJJVvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 17:51:48 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35855 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJVvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 17:51:47 -0400
Received: by mail-ot1-f67.google.com with SMTP id 67so6254070oto.3;
        Thu, 10 Oct 2019 14:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BsPwSU6X2gQyCit53YR9b2X6LOdSxAWOyZ/eXX+wmiM=;
        b=s4+67hOZqHoXoQJfJZZ63GCBSBsTweKg+dRP9lxkUlFoOBpILsrRQmwmZxy8PlakNX
         xq/RQ9oEi8QbebI+PbFWBNFqDb1+Ba9rs3e3gb7TtjGv5g314oHPF8n9lHyde7JCE0u+
         CDIKPZHaAJBmJbkSxf/7G8Qu4u2D5wBPI+jg8Vp//fcVBOn3TZ/GNr9gXO4rB1W8Fktn
         TARzcmMlfi9geugeoNVLRlmHC9heOqUBguG1xv3tlQ0JqZWj5CtZDwVHuLipQC5aAKG7
         cQONmtrjycsx99s8Xz3RqVfsvUPtgrlO+9NSlQEN6hFCCk2L6UeWQGVpaKaG3vmFnG6o
         8xvg==
X-Gm-Message-State: APjAAAUOR6PqmooBM97Exg9UORwxiYpXlWAZGGs3v2/+zLaj903JoWQO
        pTcXlr1kMCy1PhWxK6XipeYyPog=
X-Google-Smtp-Source: APXvYqyeeCI7SWt8DgFaTGCvI1pwHUIrAXSg4kf5ngWc9Hr2IhfYul0XKR9JMoYXpLjIpfiKIDNnZQ==
X-Received: by 2002:a05:6830:1e03:: with SMTP id s3mr403637otr.289.1570744306660;
        Thu, 10 Oct 2019 14:51:46 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f205sm2022658oib.11.2019.10.10.14.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 14:51:46 -0700 (PDT)
Date:   Thu, 10 Oct 2019 16:51:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2] ASoC: samsung: i2s: Document clocks macros
Message-ID: <20191010215145.GA24430@bogus>
References: <CGME20190926110226eucas1p24dbb1b39ffa3f607aa28c0c4d9ff6aba@eucas1p2.samsung.com>
 <20190926110219.6144-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926110219.6144-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2019 13:02:19 +0200, Marek Szyprowski wrote:
> From: Maciej Falkowski <m.falkowski@samsung.com>
> 
> Document clocks macros with their description
> from 'Documentation/devicetree/bindings/sound/samsung-i2s.txt'
> 
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> v2:
> - Added proper commit message and description
> - Moved comments to the right side
> 
> Best regards,
> Maciej Falkowski
> ---
>  include/dt-bindings/sound/samsung-i2s.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 

Applied, thanks.

Rob
