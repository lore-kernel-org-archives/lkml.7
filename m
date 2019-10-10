Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C1DC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11C92067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="2D1Tqf6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388363AbfJJNmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:42:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38565 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387791AbfJJNmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:42:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id 3so6854566wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 06:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BFnPJ9CbG5m+x0gh6lci0Tzu5Dr4+uLZpxV5Yx2Lp/I=;
        b=2D1Tqf6UFvfY0GQ9zEYDEh2Aun4e/M6ytMMzlnE2j/5GfOvQb2EdFXTY8hL3tUFiK4
         IKvpLWImL7VIt4bWNW6tdtZjUjstnN9Sw4k+8qSkxy1hm7hP3wzyM9tXrNoehAr2pBfI
         /pph7Ltzs7VJpXiH5PgtBZQg6RphycW5hmd6eemxlXSu9/bL+7iUvP0l/8E2smERE16U
         c5a5JCC+dn3i1Kuzymw+jIQ/dEaazHKRi+sULEFpIKz+2f2qySvzK8MEQTuoEX/m8FmZ
         zndroZ+Qn1ckVlUP4Av//2uOc97O8bKY+D/nzac0m21tJ0UcjUJJbsX0H8QvCCFL0QQv
         4HKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BFnPJ9CbG5m+x0gh6lci0Tzu5Dr4+uLZpxV5Yx2Lp/I=;
        b=HPn8ZEt1nij63b/Wm+mc+ZhI18Uv1n8EvaumVwBN2wXOAc6B8M5Jno/T7X1ODTy+7F
         Dzwcw8ECNZg1cXsJRUP0eHvAatORH3ha1qT4d2eBYWS3kBD1/gEfVPaRzcCh2aCY1t48
         UfHDp0lhX9dm7Wpi27Ouen84dflzv0T9ulwfHi+y4FQTn/JzayGE37U+jc+9RefhKVka
         1NXt9oqt4XlYtzs+dxz6qgztcLzFp0BmEb5PlZgm9VFD1B4EgNVjtYUCN3tyUSDnoDH+
         MbcX0aKM7o6m2UZZCkUl8wGmTrptPU2xJ5BBIWkkRbjapOCbr1KaxCU+qq1eF5hJ6cos
         YEoQ==
X-Gm-Message-State: APjAAAUcqz4j2xp0uJqZYjzRtJ2u+PU6KmV6ehhWjbGCjdBBTkCjRK9b
        z6yfCEunELA15eO7DT4xFGUubg==
X-Google-Smtp-Source: APXvYqzi+PrehgDRm3UXJf+By4vMypNQE6kgp+vy7T5Pq1WqICHZIHsTblx+rCZ98uH3ZCqj4MEFdQ==
X-Received: by 2002:a05:600c:2185:: with SMTP id e5mr7960137wme.78.1570714924491;
        Thu, 10 Oct 2019 06:42:04 -0700 (PDT)
Received: from localhost ([85.163.43.78])
        by smtp.gmail.com with ESMTPSA id u1sm4930948wmc.38.2019.10.10.06.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 06:42:03 -0700 (PDT)
Date:   Thu, 10 Oct 2019 15:42:03 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 05/17] ethtool: helper functions for netlink
 interface
Message-ID: <20191010134203.GA22798@nanopsycho>
References: <cover.1570654310.git.mkubecek@suse.cz>
 <061af34c9f34205ed18a126cef9ebe1534de8bc7.1570654310.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <061af34c9f34205ed18a126cef9ebe1534de8bc7.1570654310.git.mkubecek@suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Oct 09, 2019 at 10:59:15PM CEST, mkubecek@suse.cz wrote:

[...]


>+/**
>+ * ethnl_parse_header() - parse request header
>+ * @req_info:    structure to put results into
>+ * @header:      nest attribute with request header
>+ * @net:         request netns
>+ * @extack:      netlink extack for error reporting
>+ * @policy:      netlink attribute policy to validate header; use
>+ *               @dflt_header_policy (all attributes allowed) if null
>+ * @require_dev: fail if no device identiified in header

s/identiified/identified/

