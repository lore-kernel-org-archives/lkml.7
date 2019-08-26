Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E75C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C98220828
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IK4bcaUH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732224AbfHZPPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:15:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46229 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728732AbfHZPPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:15:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id z1so15696650wru.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 08:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QMc8BlFNPwhPMkitaQqYoQoxo4FLyEe7KvlKmz3CRSU=;
        b=IK4bcaUHJxVr5f3+1q9aB477uA6/aGYXg37x+81Y2Ak4Z8NyC7YCHsbt6yXQmMRud5
         i4zPn0V+BRuBq86WtDn8g+Nvs5B+H1wZtQDFornWtxRuA31nQoT1DOrnv/drN8BFcsrk
         FJoOjzqrHy//7LYX7NIAs3k8sOf0efOfawx/9mEy/CwbSfKSFFHIeGw93iKJcxVme968
         COPsmMb+yLY8CD3R/L9DErB31NsaryHOwpsQdq1+0ZpUxSNGLp4w2WO9aHSHVgkte3Wo
         LrqsEcJF9vLUcY7Mm+T5E8Lfc0B6iFC6+HrF+aAl+rNhFwcfarXz3JDzGZxpna9ZKkWd
         okAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QMc8BlFNPwhPMkitaQqYoQoxo4FLyEe7KvlKmz3CRSU=;
        b=TMguOMr6hTMqym2lRTgktRrFylbdn0NQufESPKiHKSW91AWyD1FvkyGlvWow3GUkid
         rW8952Oapy1GjFoIgcjBU5L3HMPSz8bN8M/yxkyUIp++4wSW8WU6IsuwNHwZdfJ4RI+X
         rc1l3r19NiUcNOoCAporFjTnIjUWqtI1GGzIupHmr8YMi/odeZnoguFhvJnUYQfae+ok
         EzaqvvW4hHfpcRstbrfIizxTHQm5xHLWD18Kn4fnOEjeFy+iKj291/SlQM7TnL29N33R
         t+zOuMmqoXf7U0EUZkd4SjlDBgM3aC7i/tDLOlbtuIM4t90pUQ+pf2JjU3Rv2ambLDIC
         devQ==
X-Gm-Message-State: APjAAAWjxJsu4rVE+0t7nlAXZ1NGNaQWzrgPXcV+Y07Ai6hxJV9eSqEZ
        Zoa/3Fffn0vek7Y3QoBUt4E=
X-Google-Smtp-Source: APXvYqx50jWkW+jSQ4r//xNkXNJqtoB1M5J0Csu13FzO88J5ru1KMzVr7A6FyWGpl9iGrChq1LngwQ==
X-Received: by 2002:a5d:4205:: with SMTP id n5mr22982928wrq.52.1566832530322;
        Mon, 26 Aug 2019 08:15:30 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id s64sm25344990wmf.16.2019.08.26.08.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 08:15:29 -0700 (PDT)
Date:   Mon, 26 Aug 2019 08:15:28 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ilie Halip <ilie.halip@gmail.com>
Cc:     clang-built-linux@googlegroups.com,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: imx-weim: remove __init from 2 functions
Message-ID: <20190826151528.GA91444@archlinux-threadripper>
References: <20190826095828.8948-1-ilie.halip@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826095828.8948-1-ilie.halip@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 12:58:28PM +0300, Ilie Halip wrote:
> A previous commit removed __init from weim_probe(), but this attribute is
> still present for other functions called from it. Thus, these warnings
> are triggered:
>     WARNING: Section mismatch in reference from the function weim_probe() to the function .init.text:imx_weim_gpr_setup()
>     WARNING: Section mismatch in reference from the function weim_probe() to the function .init.text:weim_timing_setup()
> 
> Remove the __init attribute from these functions as well, since they
> don't seem to be used anywhere else.
> 
> Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: clang-built-linux@googlegroups.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
