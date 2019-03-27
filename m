Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A85CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9BE206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="OztnVT2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbfC0PTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:19:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38192 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbfC0PTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:19:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id w15so485545wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 08:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KfLJanVXY61YCRElFkvD71/SNEcxjUcKSDSk5dFs59U=;
        b=OztnVT2xUXH9FFESgl0ILMsPGYpE17ANt4aqqF8OlSDwlmoxy4eNDwBkPmpfWuLVRX
         kQ0ez2yM1xbh30UvQirmL17zl3OC0O8kn7L69kopf0jRNFpv2jMJ4UCBP0ZHVVpiBDAg
         lK3byJ2763t43ll4uw0i/qEJcm8zkJNQTff8rBgha9uhd/eq3gbCG9RKzbdk4B5OYY33
         2dTd/xMrFdYiA0pieCLnSne5sbTqzq/iKTfYrStH/U5e3QiR1e9QOfg2nP4iGb2gTydG
         sqby7kBPyxIywoUBxBaw2HxUwnYMX60fxInFtOf2WZ1IEfKh7rbQiOctu9Y+/iJTA8rB
         QyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KfLJanVXY61YCRElFkvD71/SNEcxjUcKSDSk5dFs59U=;
        b=iyWNOc6EWve5LKAD9NYwLSAIUmh1BZKencGE5ycBg/jBH/KCUrtI3cw8P4UXdstQm8
         5y4KDHO7qAoUKryv/Z6XF605QjJxuak/pn3MBEh+eyG/Md2qeFqPaaia13jkwWsxiwm9
         ikQiSDqtuD9xvAAcLsByNG7xINOVkAOgJ8bk2uKwHalcGzQLiC+fCrpZTuQzqvNwxq7a
         tgk8k8AtqakmE4PeG9eQwe7osE8B/LBn5/ttVa8oBIEIHkvp2u43sgcMxmpw1SXMZ6Ft
         6SoyfvpKoed0i10dkJS51VMgi+eeanv52aX/avK7x+IRkA40XCSfSAsFTSF6L9J6Q6Dg
         +R9A==
X-Gm-Message-State: APjAAAUfYeLFOq2GeLYTPBlqgEY6nZYqlwDN4O4V+hcnIe24qEBqkGeB
        uPrS3a5L+SQQWhMaC1Ul+/moFg==
X-Google-Smtp-Source: APXvYqxT77TkQ+TimdJwqZuutiVNWK6/+rHDsyNFm/kbrB+Vmc7ugs3HObg6zhZSgDIgNrjB4caAyw==
X-Received: by 2002:a1c:1a46:: with SMTP id a67mr12108594wma.21.1553699972880;
        Wed, 27 Mar 2019 08:19:32 -0700 (PDT)
Received: from localhost (ip-94-113-223-73.net.upcbroadband.cz. [94.113.223.73])
        by smtp.gmail.com with ESMTPSA id a82sm418800wmf.11.2019.03.27.08.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 08:19:32 -0700 (PDT)
Date:   Wed, 27 Mar 2019 16:19:31 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 00/22] ethtool netlink interface, part 1
Message-ID: <20190327151931.GD14297@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <20190327130928.GC14297@nanopsycho>
 <20190327142806.GT26076@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327142806.GT26076@unicorn.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Mar 27, 2019 at 03:28:06PM CET, mkubecek@suse.cz wrote:
>On Wed, Mar 27, 2019 at 02:09:28PM +0100, Jiri Pirko wrote:
>> Could you please perhaps split the patchset so it contains max ~15 patches?
>
>Would 1-17 still be acceptable? The thing is that patch 16 is the first
>where some "normal" notification (i.e. not EVENT one) is sent and
>patch 17 is the first implementation of a request modifying data.
>I believe having at least one example of both querying and setting data
>would help the review discussion.
>
>Or perhaps I could leave GET_INFO related patches (at least second and
>third) for later.

I think 17 is okay. Please split if possible.

>
>Michal
