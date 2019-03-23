Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D05AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 00:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA4220811
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 00:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Yxqvn/6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfCWAOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 20:14:21 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:45285 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfCWAOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 20:14:21 -0400
Received: by mail-pf1-f176.google.com with SMTP id e24so1706078pfi.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 17:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=oRMHjnvQs0ikWTEqlDADpNMzEZP3KRcRf9TO7CZKyEs=;
        b=Yxqvn/6+4SCsd6WkN+lGG59xW7aZOpkYX1YuHaGKhLeZuEIKxLFJVRgf6uVOT5kAil
         ncbpZdxV+xkrxuqSr0LkwJKq7XtvkNhUkUoO0RWTKAxN5OUccZIip7XsO4hyUbfgFqNs
         6hxkU7YGflCHKcH+u0Ily+no05jYivfZ1lC9Fs0LLuIqh3yE4HxN6j22TMP+LEyT8pJN
         G/aK7kmXh9vjPqpTYWTBG/ZEjzssJPX71rZA4ZolGe4iuIsnKWXBaeZPowjVe/+VQuWU
         xMWjqxEni2y+QmityXy9oOk4hvft1IiGyLrW5m0c2GmKe9VuZ6Y1xHcGmOXBS/So+SG2
         5+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=oRMHjnvQs0ikWTEqlDADpNMzEZP3KRcRf9TO7CZKyEs=;
        b=TqqpFrdTnXzSjJEej6IUXDTl0uq8apS7T3hCur6MMoNqsRZjVPzq83RuJqUZQggKdj
         BAlUETrThS+kVLEwLdbKeDhQ9y50i2SjyC3aks47MxWJB7n0TNPE/hptgazAO+Or+7Qi
         fWVdoXKtlqWCgp+qmpu9/Jic4gKi4loVjKzUBS7exRSUCE6XC8Zz8RXh+zwYXr7M/cUL
         88wyBxUQFoWFJCIij/ss42g5A5P+N1IihOnnr3PhZclUklfXCmdFbTK3wcHT+2Dr2Tb9
         vZbshW40AqAR649zQwNhXap5v8txOhkOSHCMeJEEy7lZtXjc1+paaDiqtTuJDjon8lTs
         isTw==
X-Gm-Message-State: APjAAAWXw6hEmRDSJoGwVVmVLkADnw5FQfxUCxoLaTA7Dwfv980uwfAw
        IoLz6Lua1FyfePB58haBrop5r/YzqMk=
X-Google-Smtp-Source: APXvYqyak8xPelQDLqlHqvekkoCy2XND4zLRnaILDRz/YPlQfTg/6qXBYGty14l7M2Jt44qSMKOP1g==
X-Received: by 2002:aa7:918b:: with SMTP id x11mr12392871pfa.228.1553300059868;
        Fri, 22 Mar 2019 17:14:19 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:314c:c810:897b:a1d4])
        by smtp.googlemail.com with ESMTPSA id u86sm9168634pfj.69.2019.03.22.17.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 17:14:18 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] arm64: dts: g12a: Add boards peripherals
In-Reply-To: <20190318100458.5619-1-narmstrong@baylibre.com>
References: <20190318100458.5619-1-narmstrong@baylibre.com>
Date:   Fri, 22 Mar 2019 17:14:18 -0700
Message-ID: <7hh8buzbtx.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Following [1], add regulators, bluetooth, UART and ADC keys on :
> - meson-g12a-x96-max
> - meson-g12a-u200
> - meson-g12a-sei510
>
> Changes since v1:
> - Collected martin's reviewed-bys
> - Added missing regulators in commit logs
> - fixed x96 dc_in regulator
> - fixed includes overall
> - removed dwc2 enable floowing disabled remove in [1]

I queud patches 1-5/11 for v5.2 (branch: v5.2/dt64).  The others have
some dependencies, or you mentioned you'll do a v3.

Kevin
