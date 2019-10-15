Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FB3C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4B12083B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571167595;
	bh=5/1f+CZP9I4ojMUsdsrnltQ04fuafyAOnyVZnUzu5ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ge0lXTXrFdkLYNdWlUTn4A2jVq0JpWcEbfL07UTdY5cxRim4VxXkEZc2RdsribJUf
	 P4m+eAvLdH90NcCLPZnHN/KsE3wRxGghkZ/0UMBWbsYek0yThyfP83AtRurARyeOdt
	 Iuh0VRo90y8aXiQ4CqUxIZhl7GFLPt8pXQW6piBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbfJOT0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:26:33 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38542 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730550AbfJOT0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:26:32 -0400
Received: by mail-oi1-f196.google.com with SMTP id m16so17869846oic.5;
        Tue, 15 Oct 2019 12:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5iiAtGxSrTdQp0QGKq/f7302iXtdKwjl0hjxQ3NkrD4=;
        b=EynyRgJzI+0+jLAEKEHb5caDIoBIuZE/ZpH5in0iv5GZgOyAPZTr2GILVE7oTg5uNa
         wT/HcHVIkGpLn1kma1r/FYyzG5UR5OTFXjQcivOcKQ+OPmpGoHRYHLIZIxferJY2n/4s
         Sy4LRJiX5KvghRWWZrXCsoCvQtnVRIMTNdUDk3Nreeqw5+5GlBvprqF/nua//dDLU0WY
         6W0oSY/cw9bifpW6Q45sJHFoIYkKzSPFsDdrR/tKStUm0djAOtUtK7r+/zlOcMjE1wCB
         CbNvyIlPODYKmMzEpXDXyjOC/hmIGx5q9e0M8OFudZszQGliyMKsku0/f0+wjfWbMOgO
         qfXA==
X-Gm-Message-State: APjAAAVZ12IYlSCxT1lz7PaYxO7d5jadGgkbLA5UANjQBDNd/tg0PtMD
        mYoywnBxUyfRv31mLVNWyLS+xOk=
X-Google-Smtp-Source: APXvYqw58v3zVqOimrVk1o2jEAKMnN+uiNnsHPtWXeHnlXi8YNPQ9rDOhWl9vJKQ34wRh1IL0tYZ8A==
X-Received: by 2002:a05:6808:1:: with SMTP id u1mr132396oic.137.1571167590519;
        Tue, 15 Oct 2019 12:26:30 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 109sm6977628otc.52.2019.10.15.12.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 12:26:29 -0700 (PDT)
Date:   Tue, 15 Oct 2019 14:26:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: gpu: samsung-rotator: Fix indentation
Message-ID: <20191015192629.GA3241@bogus>
References: <20191004151414.8458-1-krzk@kernel.org>
 <20191004151414.8458-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004151414.8458-2-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Oct 2019 17:14:13 +0200, Krzysztof Kozlowski wrote:
> Array elements under 'items' should be indented.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/gpu/samsung-rotator.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
