Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCCAC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 00:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766C52077B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 00:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t/WZD0xW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfD0AUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 20:20:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38734 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbfD0AUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 20:20:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so2463172pfo.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 17:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T0jupFcF9hnJ5smEbqb8Uiz7NwwaG9r63Ny4hvX0g9A=;
        b=t/WZD0xWD4+qUwydinbxwpGTTZYKtmcQXMy+jVmll8VF7BiQzgxJipQJ+lgTVFVTZM
         QkIsgxanZ3IHVmprDg/XSLSPKJdXk/qm4l/MC7JDlj4GmYhliUuYibtHVLYYuKz+JKwm
         t3SZN0gEXwCh3wsqSS28M5OlAT+ui45cscRRAxQX50eFamkLbY7A45IpWJTtH9/4L8uZ
         HanjK8g0pfk2CR0vw6y5Bs/9kTM2M7siGv47V89UoG3QpIqfbtof0/QuA/pIgsIIEvEu
         M/UZF1NmYHxgD0M7u4ontGMDZ6lh6PLk4xV465NRajJEIw21S4dNDSLsu4nuPX7LjKMg
         cDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T0jupFcF9hnJ5smEbqb8Uiz7NwwaG9r63Ny4hvX0g9A=;
        b=Vpt0j6MyF7duzVoY42mhw6qXKA7yNDF1mVdzhE5TVg1zHxilLbGbshnMXy6n2lrRfv
         Wl612MmUNWweI2Ct3/EdHbLzTrbPGb+HnU2Vyv6wC/FpRESk6Y3K7tJH3u84Iinypgok
         mAIyfHsp4FYsaBxXqd++7d9VXzE0IoJoZZiAG7qy2bCw8dBjXLg8ZoCl05QZowES8luU
         Bp0nI5rqxBbPMlCOJOLBm1he8z8X8zb8USp/8aHCkjv9t7VY35+nc629i4jfRcR39Ce6
         tYfVJ9PZUuv2BRNKJ6OIXkJ0m+q/5eQEfxyzonj05HVbgOvBZNQUVGHSGnxJQmw7VpAE
         oGxg==
X-Gm-Message-State: APjAAAU6VajGRm90T/v+3G8ICYHsH6QRa3eE7jzHpviBYNaSWQ4J4Xv9
        Sk1NdJT4FHh7C5DE0u/ZYJwBow==
X-Google-Smtp-Source: APXvYqw2gLFtFNX39U/qRmokrO6vKW8rT5xiEM3Tlhb6+pACWd/nZ65bcBAT8wEHIpzApDIShepOaQ==
X-Received: by 2002:aa7:8083:: with SMTP id v3mr51379417pff.135.1556324442308;
        Fri, 26 Apr 2019 17:20:42 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li990-117.members.linode.com. [45.33.40.117])
        by smtp.gmail.com with ESMTPSA id n3sm39239298pfa.99.2019.04.26.17.20.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 17:20:40 -0700 (PDT)
Date:   Sat, 27 Apr 2019 08:20:34 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/4] CoreSight: Support static funnel with DT binding
 consolidation
Message-ID: <20190427002034.GA6454@leoy-ThinkPad-X240s>
References: <20190412102738.12679-1-leo.yan@linaro.org>
 <CANLsYkyFXEiYh78uhhQRiqAOvv_u+oq5GS3z3-Lbj6RHm7x+sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkyFXEiYh78uhhQRiqAOvv_u+oq5GS3z3-Lbj6RHm7x+sQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 10:26:24AM -0600, Mathieu Poirier wrote:

[...]

> > Leo Yan (4):
> >   dt-bindings: arm: coresight: Add new compatible for static replicator
> >   coresight: replicator: Add new device id for static replicator
> >   dt-bindings: arm: coresight: Unify funnel DT binding
> >   coresight: funnel: Support static funnel
> >
> >  .../devicetree/bindings/arm/coresight.txt     |  60 +++++++--
> >  .../hwtracing/coresight/coresight-funnel.c    | 116 ++++++++++++++----
> >  .../coresight/coresight-replicator.c          |   6 +-
> >  3 files changed, 147 insertions(+), 35 deletions(-)
> 
> I have applied this set.

Thanks, Mathieu.  Also thanks Rob and you for clarification DT binding.
