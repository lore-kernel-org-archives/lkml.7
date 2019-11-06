Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F20C47E49
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 04:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FE42067B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 04:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573013772;
	bh=fmGAlQwZXlQwLpcFHzgo8W4Alpqb/uFeQsy1ha5K4+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FF1sB3SCesFEOIYGtk1wB6joCIh7Zq12kJd3sxen8qKlyF/v4WEB08aZjj0dOMKw6
	 b3CLhjzaciM603qKJwwlzpAjqF35lRs/+O6hizt8LpvZvG3Mq5MrXjzSzBggtM8w9d
	 3IuqxCCLbCDAgPOmL3zQ2DOaR3sy/ZU+FLoMVBQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbfKFEQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 23:16:11 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46615 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfKFEQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 23:16:11 -0500
Received: by mail-oi1-f196.google.com with SMTP id n14so4028178oie.13;
        Tue, 05 Nov 2019 20:16:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YyIz8f1e9UfiTAitqdpO0gSzcZ8qqT+hCle9bN35WzI=;
        b=B1NNwIIzFkTYFMJZl1shJ8EV63Xt/qewjuRSU+NKoXu78rS5+qo6GX2fCfPFrVGtTi
         EGmAo09tjrgBkcrj5I1FcxhCbLEHmtdTAnHCaF2ICRRcxm/Kq5DjikUV7CJFJmeYSTO8
         um/xPaDInyvcIfT5Nu4NaZtNtKSeKj742aKQvsQgtz1fa4W3Xhrk461rtm18raha3dVk
         aBpvUHL5fATZNFF0+wrCEF+R+YlUO0GPiipUpTOncPyhVmTryAJD1FmZ7Kbgp4srtDTG
         KfyE0xD0FANBHvEAR+AAsJlejfVmO89XimGHoWvpgb1Ir6Wh0GKKv6cw11KNG5jjAr8z
         X0rw==
X-Gm-Message-State: APjAAAUP9lR/QBFIbD7M8eF7hK3CoDHMkvXlrRYhKf7nFpOneq4d7cso
        aX+PzG9yy9LqoTfk6dcYCw==
X-Google-Smtp-Source: APXvYqx3I4HQVzBQc3zq/SLJYwhrOMbaEj1Kj7im68FUhkqovz+Jg6Aj3wFPbiVOYEEOavsrH0Th0A==
X-Received: by 2002:aca:6207:: with SMTP id w7mr407049oib.87.1573013770143;
        Tue, 05 Nov 2019 20:16:10 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 103sm3515081otn.63.2019.11.05.20.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 20:16:09 -0800 (PST)
Date:   Tue, 5 Nov 2019 22:16:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     mark.rutland@arm.com, alexandre.torgue@st.com,
        fabrice.gasnier@st.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, lee.jones@linaro.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: counter: Convert stm32 counter bindings
 to json-schema
Message-ID: <20191106041608.GA24747@bogus>
References: <20191031123040.26316-1-benjamin.gaignard@st.com>
 <20191031123040.26316-2-benjamin.gaignard@st.com>
 <20191106041023.GB5294@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106041023.GB5294@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 10:10:23PM -0600, Rob Herring wrote:
> On Thu, Oct 31, 2019 at 01:30:37PM +0100, Benjamin Gaignard wrote:
> > Convert the STM32 counter binding to DT schema format using json-schema
> 
> Probably this should all be 1 file instead.

Also, checkpatch reports trailing whitespace in several of your patches.

Rob
