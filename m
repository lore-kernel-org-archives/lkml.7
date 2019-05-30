Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50053C28CC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29529257B7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 11:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zs+87dXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfE3LED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 07:04:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47007 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfE3LEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 07:04:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id y11so3709113pfm.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 04:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S/cb0m9xHhDHoKqKMiFimQZjtq/GGyzkBYH+5P+CN/0=;
        b=zs+87dXY2uJHWUUk2UltFW9vWu7zXdUEpIxMKXcJPx8VZByqt6q5b8MmoQqAiPBIs0
         rbhatuc4l5So1hpFoZOObOs+vi3UzRzxLYi8EZ98U+3THxPaAGcpEGyfNVZSJL4LPKHJ
         KusupP2XA6wpIcYHn2evj4cWgrFh2GDjPpQNPwNn2cjECO2MkLAMRWej5ICmCRiowIGh
         VrSlwUfeUy0Fi4/oBaS5iHv9Mt5jgI1duviHzObo/RhV8t/0U1OWEno2LskN1A3wWthg
         ZfL8/Ic/lST3aXrc4TJ0MEPLD/L6TtCmHJHEydra4VrBEeC9CpaPSkQfsxvUXv81Crme
         Dwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S/cb0m9xHhDHoKqKMiFimQZjtq/GGyzkBYH+5P+CN/0=;
        b=S6p63aY9u43TTeV2Jpf85Q9ummwoAF0zzdM2SmkAOT3A47Axs5+nixOSw2hJXWRsmV
         lPcY7o52coWXgSIZA3mp2mruvBG/yqGsZBoqxh/EEZ/xGMMfJT35LF+KXToAmvnL/yKA
         rSaYIB+FjJlbGDNq66FcHaUH6XJImMVqMheVixc0jiZWcp3uCyTjBdlWpX9RrTcO4QZk
         867UJDEJv8tpTILORfRuiwOxfD3ExTVbJQhN6aBjkfxieTBwS/tRLYLmifZTAO8Tx1/h
         dgadqpKEfLY/VUlmdG10fnZQGV8Rdcpf4TLSq/Pwf+AQnZHngWNvTtsrNPHwgVuZqPtP
         eBnw==
X-Gm-Message-State: APjAAAX0DDopoa6pqxaunrFrGd/g0knbabYGZtEUtNCowcqIx+QSyirp
        facYJ7ZpskvvrmH5wwvMTDSxwA==
X-Google-Smtp-Source: APXvYqz+vXGWZcBEZJYVx+rFv5sqTUAoCg0qb5bq3U1UYR5WpxnO0dE7UdJWmxFtnX3tHhlwh568aA==
X-Received: by 2002:a62:e10f:: with SMTP id q15mr3069680pfh.56.1559214241664;
        Thu, 30 May 2019 04:04:01 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id r44sm2250083pjb.13.2019.05.30.04.03.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 04:03:58 -0700 (PDT)
Date:   Thu, 30 May 2019 16:33:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com,
        catalin.marinas@arm.com, daniel.lezcano@linaro.org,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/3] thermal: cpu_cooling: Make the power-related code
 depend on IPA
Message-ID: <20190530110356.vet2exwowdbm4umq@vireshk-i7>
References: <20190530092038.12020-1-quentin.perret@arm.com>
 <20190530092038.12020-3-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530092038.12020-3-quentin.perret@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-05-19, 10:20, Quentin Perret wrote:
> The core CPU cooling infrastructure has power-related functions
> that have only one client: IPA. Since there can be no user of those
> functions if IPA is not compiled in, make sure to guard them with
> checks on CONFIG_THERMAL_GOV_POWER_ALLOCATOR to not waste space
> unnecessarily.
> 
> Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> ---
>  drivers/thermal/cpu_cooling.c | 214 +++++++++++++++++-----------------
>  1 file changed, 104 insertions(+), 110 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
