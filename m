Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56A2C33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C862081E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578349008;
	bh=fu2DqfrbuFaGWXKt9NCaBaBO2DiLlEmXWK2BMRTlfzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v1tixk3UYkFf0yoTUpMef/gRGAyIk0ggKpsHhph949RSFVbaYfUqEtDw64uKLNOVI
	 JodidWFPFHEsF/dOTCX3q8BYrWx2qnDF8rzhYwUNLvJVI525kjZMqCFb+RKxw7oLsc
	 7qSUGNgZ+Rf4ijKxcIFq5S0iDOlxHjAPtQ8yU94U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgAFWQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:16:47 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44428 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgAFWQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 17:16:47 -0500
Received: by mail-oi1-f196.google.com with SMTP id d62so16958524oia.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 14:16:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JawZyvCEqxbxDbUWcz/6qCJtFgFJJZ6Kq0F51D4TyLs=;
        b=mZDL2yTTysuYoC6Bmy/rr9p2LPG1LTqOTs9qNK24Xh9tdI/RE/50xsW7X/Y0esNRfu
         7uBbFGwPV0zteEy3zBV7m+6yCymwjU1SRcvC9JmGZXfxp81Q7hePjvZg9KVOgNZeSn5q
         K/3tcROJbMTzCKyGx3ch1fzuX3svmKPB2LEwXcqUjntsrhYyBu7u6aB29vFnrdGcSAoK
         1nta+DORjx8Cbgk8laRsC4rp5OvZMAGCLeAQqnIbsRI2YwcNHEj7J/kug3RpIv34ygKm
         uH+sGggPJMcW6xd9ufN4ASK4uL7mBOdmHlPD7MKvWSRl7UctFJ+LjN/C/vCzI4wZHnK1
         W69A==
X-Gm-Message-State: APjAAAUTQj67GWvtPvfJ41gsrPD3qInnb+4IS5W/96OVIBlAervvhWl1
        E5bhJu857PDifjEuwO/ecKw4ywE=
X-Google-Smtp-Source: APXvYqwzvjdf+sExDDOivVxMCHvWad7LVYYYwhCgGI5rGvE8hNnzzBm3v2Ya4xXFs0fxLz4ICk0ssQ==
X-Received: by 2002:a05:6808:4c7:: with SMTP id a7mr6480768oie.83.1578349006126;
        Mon, 06 Jan 2020 14:16:46 -0800 (PST)
Received: from rob-hp-laptop (ip-70-5-121-225.ftwttx.spcsdns.net. [70.5.121.225])
        by smtp.gmail.com with ESMTPSA id z17sm19539720otk.3.2020.01.06.14.16.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 14:16:45 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22043f
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 06 Jan 2020 16:16:43 -0600
Date:   Mon, 6 Jan 2020 16:16:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kamil Debski <kamil@wypas.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 01/20] dt-bindings: Rename Exynos to lowercase
Message-ID: <20200106221643.GA31683@bogus>
References: <20200104152107.11407-1-krzk@kernel.org>
 <20200104152107.11407-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200104152107.11407-2-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  4 Jan 2020 16:20:48 +0100, Krzysztof Kozlowski wrote:
> Fix up inconsistent usage of upper and lowercase letters in "Exynos"
> name.
> 
> "EXYNOS" is not an abbreviation but a regular trademarked name.
> Therefore it should be written with lowercase letters starting with
> capital letter.
> 
> The lowercase "Exynos" name is promoted by its manufacturer Samsung
> Electronics Co., Ltd., in advertisement materials and on website.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. New patch
> ---
>  .../devicetree/bindings/media/exynos-jpeg-codec.txt         | 2 +-
>  Documentation/devicetree/bindings/media/exynos5-gsc.txt     | 2 +-
>  Documentation/devicetree/bindings/media/samsung-fimc.txt    | 2 +-
>  .../devicetree/bindings/media/samsung-mipi-csis.txt         | 2 +-
>  Documentation/devicetree/bindings/phy/samsung-phy.txt       | 6 +++---
>  5 files changed, 7 insertions(+), 7 deletions(-)
> 

Applied, thanks.

Rob
