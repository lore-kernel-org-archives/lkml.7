Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D32C00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8977B227BF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578090571;
	bh=cagGhZOxCV0Mw3q8og/AhdWgRjglOTxAWlraDkYvhTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KZmqng6GjBUw9H1ug/QwHvzBgJmSPOIGPhgLqPZGvEAqlXiJu2oEsBawORh0vaMsK
	 qUOYqVOUbcIhiZaC+9DslzSE7uqhHAfER25GH5mEua66C8f6RxPF7wULPs55r2A6AA
	 ytqTAWE84hCza9zt6ICqCmzvfu8HnR1MjXUaX8kM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgACW3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 17:29:30 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45190 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbgACW3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 17:29:30 -0500
Received: by mail-io1-f68.google.com with SMTP id i11so42877456ioi.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 14:29:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TFDz39ekdeb/43sN0oag/MOWFARZHq5KPLmY9cO79x8=;
        b=PFoOgHFpfGir41QRr7Rm6vw3A1KVx9IimewxYWSgeO39dN2Wf5mS0V4jKy65kZN63U
         Fx43otHA+fx0KL+KKylua1isPHabMY8YkE9cHdHWyd+4unVh4otfe1+bYFk/lHZzvDBh
         ngGyJnWCLX02wOvp8dPGdH6lgeXupUF8F/8hDr2LzWEixVt+iwW4v6oGbXDjjitY4dMb
         E1AFt/Q/1D2dcGOCaIfX2Ss4/6YdHp8WFHWWKyIiaU0yhJg+xbsWeMmnEo5gBRCpD7+K
         chot+DwSC5Zw/tx7LYwsnC3Of+MnmOTCRtu/vL6vg+dokXdl+LN5uvtywuQqzOQYA2nc
         F1TA==
X-Gm-Message-State: APjAAAVu2NbYFYzNa+646WlkXCiAOdj6PtM5yxJjjEWmrbBvBKthe7rU
        qZYOsRl6rZWMhM+FLpieL2A86dk=
X-Google-Smtp-Source: APXvYqwBrOzybAw8Vpq4mKEAbY3YrJLKAxll/9SfsiaarG2u6jZcJtS7pRhC6YsJP1ZcDV2MeMdC8A==
X-Received: by 2002:a6b:ab81:: with SMTP id u123mr58668489ioe.214.1578090569262;
        Fri, 03 Jan 2020 14:29:29 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id e1sm21281129ill.47.2020.01.03.14.29.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 14:29:28 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219b7
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Fri, 03 Jan 2020 15:29:25 -0700
Date:   Fri, 3 Jan 2020 15:29:25 -0700
From:   Rob Herring <robh@kernel.org>
To:     Jian Hu <jian.hu@amlogic.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Chandle Zou <chandle.zou@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/5] dt-bindings: clock: meson: add A1 PLL clock
 controller bindings
Message-ID: <20200103222925.GA654@bogus>
References: <20191227094606.143637-1-jian.hu@amlogic.com>
 <20191227094606.143637-2-jian.hu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227094606.143637-2-jian.hu@amlogic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Dec 2019 17:46:02 +0800, Jian Hu wrote:
> Add the documentation to support Amlogic A1 PLL clock driver,
> and add A1 PLL clock controller bindings.
> 
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> ---
>  .../bindings/clock/amlogic,a1-pll-clkc.yaml   | 54 +++++++++++++++++++
>  include/dt-bindings/clock/a1-pll-clkc.h       | 16 ++++++
>  2 files changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/a1-pll-clkc.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
