Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D30AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6C8218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551378457;
	bh=TtxvfFBtf5+mYVXEEAGD1O+zdCvnZ0GId4GIiYTiFYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SxqLbbuko3B8PUdHy8HCbuPb+dbhLo07pkMNa+qczlb1VXuDXPTh/M6Xztj9POcoO
	 9gzCZE42XawQslJQLNdbVXKcH9ABBWhnYmxVanNa46s493OTf9WYkffV+KZIgKTaSU
	 AtvboWHTRm28dRxPgpxlCvARscpTQD8gF/+ffi80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733142AbfB1S1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:27:36 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46550 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731063AbfB1S1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:27:35 -0500
Received: by mail-ot1-f66.google.com with SMTP id c18so18519121otl.13;
        Thu, 28 Feb 2019 10:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xNovduMDo+bsSSdGYFMtjocQrj85X9mGKNQDCwYuzkg=;
        b=VFlS28DadXj3N/rwsRpBfQxAATYWci7cAjbjGS77kB8fLGhUYgm7ZWW2hQCcJ3gQ49
         7/cAbfYjU50ndyLoNdBdaeAbopLlnUooHLv3LpSGdfyptxylcsCwSasQOVseaSkqDRMc
         9eMQs6opdBj8PigpQAm8tjw0Paak9zD/7kMoYP71v4HsU6BNhcvEa/ook808x8enasM0
         cecx0u7VZM0aH1QmBOCapUv/F8qc5H7kXtCCDjSfirlqhoVIfTjxaUFIFMGSTJQpkZgJ
         NiU1MPmfGyNy+o9+G1c2aLlo6aJuqYGmNzTao0D8gARdU77THCrk5hxPzscGwr+4IkTJ
         rP6Q==
X-Gm-Message-State: APjAAAWilfh2MDPMoQ22DX07ap+WYVTDc3ooGIUURbIG/aQUor7wnAvx
        X8YOd1dH5/0WogbZHEMkvu7Wq+0=
X-Google-Smtp-Source: APXvYqyNztIquLFpPlpRDDOooGeKjMhiVzNnt8fny7bkcGDxJPnYOcFHdFPJEM4teymiA5fIbja7Hw==
X-Received: by 2002:a9d:32e5:: with SMTP id u92mr681650otb.208.1551378454720;
        Thu, 28 Feb 2019 10:27:34 -0800 (PST)
Received: from localhost (ip-184-203-129-180.hstntx.spcsdns.net. [184.203.129.180])
        by smtp.gmail.com with ESMTPSA id q8sm635449oih.6.2019.02.28.10.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 10:27:34 -0800 (PST)
Date:   Thu, 28 Feb 2019 12:27:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Maxime Jourdan <mjourdan@baylibre.com>
Subject: Re: [PATCH] dt-bindings: clock: axg-audio: unexpose controller inputs
Message-ID: <20190228182731.GA25353@bogus>
References: <20190213095835.17448-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213095835.17448-1-jbrunet@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 10:58:35 +0100, Jerome Brunet wrote:
> Remove the bindings ID of the clock input of the controller. These
> clocks are purely internal to the controller, exposing them was a
> mistake. Actually, these should not even be in the provider and have
> IDs to begin with.
> 
> Unexpose these IDs before:
>  * someone starts using them (even if there no valid reason to do so)
>  * the actual clocks are removed. The fact that they exist is just the
>    result of an ugly hack. This will be resolved in CCF when we can
>    reference DT directly in parent table.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/meson/axg-audio.h              | 20 ++++++++++++++++++++
>  include/dt-bindings/clock/axg-audio-clkc.h | 20 --------------------
>  2 files changed, 20 insertions(+), 20 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
