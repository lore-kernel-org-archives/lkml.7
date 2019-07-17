Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB292C76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 04:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C78208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 04:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IiereG+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfGQE1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 00:27:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38198 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfGQE1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 00:27:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id az7so11241678plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 21:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WCoUs4Hb3/orTt0/DRrzcBNTaD0Ae5/zpkSi1tZIxVE=;
        b=IiereG+0BCAa0XdwaQHy24zNuCtVxyNA8YYg1B/rOL7rToEYoFyLQ6dmh7K8T5iP65
         KM2xMoG+2xMnWcf9Pjz19BorYKLoMK3P3X7Mudx5mDh1p2XVN0WvSl2r9sjpF2jMox6e
         iSCKvrYrDQ1hxiYdXRJwOg7j883Kq0s2OwoT0QbBOL0j+lMEHlPqV6R3BebAqoPQy+Ch
         MJdr5XaxXbNwzpX0AfyWf8OCAS2qK+kyrVZHdEMu9QJV0MXwfB6BIJ4VGA/04sGGt7Cf
         1NNXOmO12/XdJoYR7mIFBlDVaqN8oAZ7wKwOdQ5qHijwffZYkLpJ+ysqq54Bft2WMwfQ
         9OqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WCoUs4Hb3/orTt0/DRrzcBNTaD0Ae5/zpkSi1tZIxVE=;
        b=nIRCr2JML7PwFu6w37DArlsuDHB65XYfxIXISutIZUVie7LQpC/SZLS6gnyXVwJ+gG
         2njkkSQwzhal6dsGLYMO0T5KIOZnHly520pP6tOETb5ux/bvAevup9hS+sqQEqxVi+GA
         OXz3xUxSSh9kiGkAtSVFAIFwKT6eBuQwGbRutlB/8mcYx/RdPKwzrEa5G4CLoCAlOD+G
         WWkbL2Nb0Fvb4ZmcvCLAzNrbBS8t7JPfukhKe2z4vNZZqPoTa+tnhXQ29iqC7iQzjiz7
         xZueAKq0IU3rWxnmr0ZPeL0tUhhHHKZAbvB/mm5sdY6R8wrR01744H3WT12hZm0qzPdy
         QxnA==
X-Gm-Message-State: APjAAAVXFLqlx28B94Fa/EQJw7SPTNAOdqr87saiaKKvBdK9nb++m8Pi
        uTcZgSm0/8QpX33C7HHsg3rAiQ==
X-Google-Smtp-Source: APXvYqzn00yoFOY6V0VVSZoXn809wajh7dZLsAzML9/Buf6OjvFE8aIcmdRSdethJ0XKQGYosUCTQg==
X-Received: by 2002:a17:902:2de4:: with SMTP id p91mr9764548plb.28.1563337620108;
        Tue, 16 Jul 2019 21:27:00 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id c26sm21187405pfr.172.2019.07.16.21.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 21:26:58 -0700 (PDT)
Date:   Wed, 17 Jul 2019 09:56:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     rjw@rjwysocki.net, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v7] cpufreq/pasemi: fix an use-after-free in
 pas_cpufreq_cpu_init()
Message-ID: <20190717042655.jmiblv5mhg55s7la@vireshk-i7>
References: <1563335704-25562-1-git-send-email-wen.yang99@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563335704-25562-1-git-send-email-wen.yang99@zte.com.cn>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-07-19, 11:55, Wen Yang wrote:
> The cpu variable is still being used in the of_get_property() call
> after the of_node_put() call, which may result in use-after-free.
> 
> Fixes: a9acc26b75f6 ("cpufreq/pasemi: fix possible object reference leak")
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> v7: adapt to commit ("cpufreq: Make cpufreq_generic_init() return void")
> v6: keep the blank line and fix warning: label 'out_unmap_sdcpwr' defined but not used.
> v5: put together the code to get, use, and release cpu device_node.
> v4: restore the blank line.
> v3: fix a leaked reference.
> v2: clean up the code according to the advice of viresh.
> 
>  drivers/cpufreq/pasemi-cpufreq.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
