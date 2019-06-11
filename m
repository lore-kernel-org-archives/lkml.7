Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC73C31E46
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92DA21734
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D7fip/1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406982AbfFKXpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 19:45:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36196 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404979AbfFKXpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 19:45:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id r7so2540414pfl.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 16:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EE5fao1AUitHL11bqb8RzdJd171k3eMtm5FzLnxkzMU=;
        b=D7fip/1V+5bW+B8dWrY7plbTkotwRxUvYjzMcfs/yAIf4igp83VQrrPfKXjepLI22P
         E9k+82PdFR2nwcil8hYAmTIjZ6P6SEqn8wfklTSbnLRAhXcaJ2n20+R8erkT8PY7i6sI
         2+qdr/vOBxAQ2qk5YyJ+KWgnMgaojGDTXLC4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EE5fao1AUitHL11bqb8RzdJd171k3eMtm5FzLnxkzMU=;
        b=s0d3LeLdJ/MFxzjzYFafbniWrtAFNpJXeXTWFpjqv6c+2yVUNaQTT3AhBJw/2z2ctQ
         a2+yIx6wQvqzP55kW7PVyu0Y0QUk3ZivtizBCc5MXHlF10c2+AFO1rRRCcwPW5vxNOdU
         pp8WFnvRPUpFqHQ2UnsXL16PBqRgxQYILbkS4ET6rlCWmnYMtlen3H+35TH1eKNv6u1z
         emjtXXViunazsrZnJ1QdA58EZi8o7OFRKK+MpgWYNNXXWE5dvn1aya4whEbey4jaW0mq
         zwafkPgeDyV9getWx0y7D3AEDv+Y1iDvJkYSL56WVEHvjUY0ApTURgDpxILxnKwM6OQi
         9KnQ==
X-Gm-Message-State: APjAAAUAGkEuKfNPQ6Qyjkrsh8Loo9O+/Z0Snjtv0l/lpuA+GL5Rx1Dm
        AdR4NaHf8P2I7wF+Tq3HCkbN3Q==
X-Google-Smtp-Source: APXvYqxcqR3WSelpvX3tCqTRattGgRgcJ2IJb5b+N+ksFZzMMp3sg9U/czcW6OvmAOE7+XoNWsiLwQ==
X-Received: by 2002:a63:5c1a:: with SMTP id q26mr23389230pgb.260.1560296746374;
        Tue, 11 Jun 2019 16:45:46 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 16sm14711166pfo.65.2019.06.11.16.45.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 16:45:45 -0700 (PDT)
Date:   Tue, 11 Jun 2019 16:45:43 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/5] PM / QOS: Pass request type to
 dev_pm_qos_{add|remove}_notifier()
Message-ID: <20190611234543.GI137143@google.com>
References: <cover.1560163748.git.viresh.kumar@linaro.org>
 <c263629a53dba33f9e7190b82172a88cc79654d1.1560163748.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c263629a53dba33f9e7190b82172a88cc79654d1.1560163748.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 04:21:32PM +0530, Viresh Kumar wrote:
> In order to use the same set of routines to register notifiers for
> different request types, update the existing
> dev_pm_qos_{add|remove}_notifier() routines with an additional
> parameter: request-type.
> 
> For now, it only supports resume-latency request type.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/power/pm_qos_interface.txt | 10 ++++++----
>  drivers/base/power/domain.c              |  8 +++++---
>  drivers/base/power/qos.c                 | 14 ++++++++++++--
>  include/linux/pm_qos.h                   | 12 ++++++++----
>  4 files changed, 31 insertions(+), 13 deletions(-)

My QoS background is nil, but this looks reasonable to me:

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
