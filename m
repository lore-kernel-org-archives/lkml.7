Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76845CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E29E2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WpD0szc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfJ3Tu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 15:50:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45684 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfJ3TuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 15:50:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id c7so2312416pfo.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 12:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HQ9FlWq+UvdDEfKTzeyzDf/xB7q4VOki0EmDu2rneyI=;
        b=WpD0szc9Md9tY2/n0MEWZBMJUxjxDAsnN5nv6bFIaLE3Mfco+mnhKg/9Q3231acaPu
         JgrrSy8x2aEqZsWMcbT7a63vu8s7c+meiHWRXHNjjoCoeEJOMmjvXKC0U/rfoleoDLxv
         4ZSTicknUi/kduQca2gQQHhpq9n3Fz0KNstO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HQ9FlWq+UvdDEfKTzeyzDf/xB7q4VOki0EmDu2rneyI=;
        b=fd+vEdBD/HpZ/vwBkrZXe5xWrebu9zPW5n23i262UNkMuGpPXDYWqt1zDMf3vFZhlL
         skfkdk7TOM5XOJIqTUxoLnlpJ2gTd3eA4th5nrSmgqfn36sFZop+xLeXIBGtCkeYyGHV
         7HN7Ht5nXeiMvfWGsMJg5DZkLppRLU8Wtq4ynq94ZdeCzCGk9OKuDRUMYUsD14vDFHpk
         AXWXZgK72ECHoaiq75TltEpXKkGSxEamlcQx8q2hresWEtmVmE3fcOYPu833VtAZiAUv
         QFI/Zh0buV1ZZOlNRHCRPSXsUUWFkeyWbYuYOuk1YhlQLZQKZx914yeG8//O64DPE2aA
         jfBA==
X-Gm-Message-State: APjAAAWHb+XBo1tFSRppVepicwbFbBvd/JuqZwZig9RNoBcXSHWCyWyW
        l7j6JFGQxdUWFK7hhASj5H1++Q==
X-Google-Smtp-Source: APXvYqz/QWsyM/lJiIGheJ/+yIlYmhs+n/d7akVsIpvcixXB40xL1Dd1YxIGf/82aICZka66QdEzTQ==
X-Received: by 2002:a17:90a:77c6:: with SMTP id e6mr1213558pjs.93.1572465023464;
        Wed, 30 Oct 2019 12:50:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id k32sm2965175pje.10.2019.10.30.12.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2019 12:50:22 -0700 (PDT)
Date:   Wed, 30 Oct 2019 12:50:21 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maulik Shah <mkshah@codeaurora.org>
Subject: Re: [PATCH v3 11/11] arm64: dts: qcom: sc7180: Add pdc interrupt
 controller
Message-ID: <20191030195021.GC27773@google.com>
References: <20191023090219.15603-1-rnayak@codeaurora.org>
 <20191023090219.15603-12-rnayak@codeaurora.org>
 <5db86de0.1c69fb81.9e27d.0f47@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5db86de0.1c69fb81.9e27d.0f47@mx.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 09:50:40AM -0700, Stephen Boyd wrote:
> Quoting Rajendra Nayak (2019-10-23 02:02:19)
> > From: Maulik Shah <mkshah@codeaurora.org>
> > 
> > Add pdc interrupt controller for sc7180
> > 
> > Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> > Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> > ---
> > v3:
> > Used the qcom,sdm845-pdc compatible for pdc node
> 
> Everything else isn't doing the weird old compatible thing. Why not just
> add the new compatible and update the driver? I guess I'll have to go
> read the history.

Marc Zyngier complained  on v2 about the churn from adding compatible
strings for identical components, and I kinda see his point.

I agree that using the 'sdm845' compatible string for sc7180 is odd too.
Maybe we should introduce SoC independent compatible strings for IP blocks
that are shared across multiple SoCs? If differentiation is needed SoC
specific strings can be added.


