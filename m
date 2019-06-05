Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA6DC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A138020866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F1D/jvTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfFEGb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 02:31:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34479 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfFEGb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:31:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so992781wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 23:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LYO7MZjMjAOwuDjHwHbiHY3lR1loAWbw3IgSWOarNtM=;
        b=F1D/jvTOeMHzbjUZYhcZIgu1OyEAhnj2spdsQPZ7gfv5le5MkJOnPIA/ukHiyyHRzW
         oAyAoO77XpE3IM7sLavxYRIMyhuxcEfR40F6KV+rS72mNbPdIOLMriDkH9MpAy3GbLZp
         D8938DAs/4j9Fed3vOBEXXniiQoU1aI6k49Iynmsf31HFvBw1bkSQgS9ZT/qZtfStkh+
         AdaAkqHYykCegTvpNG4gTMrlH52Uc792rwsSk7winJTxDMrKWXGMJG7ZXjWiTBcm1VhO
         6md8TsG5LOom/yaMhrktQuHqHKc6E9XRVbE4pdUqV70k9BAGPbxIbT8JR/j7lcNA/0Rf
         spRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LYO7MZjMjAOwuDjHwHbiHY3lR1loAWbw3IgSWOarNtM=;
        b=Xbwx5yIXUiddCVUMcF4EkSk49ImNd3v3AkYte++pXdvRVBoa186JgnMwMIG/R2lFo+
         SUDzF/u28TYtjL5pdBlvRqRcqoHIZ+At0hWD3PQacM9Ns1hiz3dZSD9Hu6YJonVUzqnY
         huWyh6bqVJrfReDfe+39uM4xCcMQrxp8XDTzGIXLlGMQHFrA/UlFeyJdQbawLlk4IbSR
         cTuBryRQt8xzC1M4gqStBW+DyMPC+l88VIE6cVl30J+BFUZlWcatJaEDm/ZLpQkiTEvx
         mLEi5HKH3rNu6k+ki5Zy2Z1Tl/Ai3h6VYrZCXGz0cNrR/dq29BFRSp973D0gsBeprKWh
         o7wg==
X-Gm-Message-State: APjAAAXqKYiSYNlZ5E1VKGvvfJGg9SAnxm17tcNZrqBKXLiGA08Ilebz
        NqYbtIfSkl1+9nTkWu8l/Zi4+w==
X-Google-Smtp-Source: APXvYqxcHPukmA+z8kbMll6EBCZARAaqtDMDqH950r9rqNsTur5E47T+wxXQKZlJVBBbeKYnlqJW3A==
X-Received: by 2002:a1c:4956:: with SMTP id w83mr8848452wma.67.1559716286692;
        Tue, 04 Jun 2019 23:31:26 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id t6sm12178782wmb.29.2019.06.04.23.31.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 23:31:26 -0700 (PDT)
Date:   Wed, 5 Jun 2019 07:31:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Robert Hancock <hancock@sedsystems.ca>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: core: Set fwnode for created devices
Message-ID: <20190605063125.GG4797@dell>
References: <1559687743-31879-1-git-send-email-hancock@sedsystems.ca>
 <1559687743-31879-3-git-send-email-hancock@sedsystems.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1559687743-31879-3-git-send-email-hancock@sedsystems.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Jun 2019, Robert Hancock wrote:

> The logic for setting the of_node on devices created by mfd did not set
> the fwnode pointer to match, which caused fwnode-based APIs to
> malfunction on these devices since the fwnode pointer was null. Fix
> this.
> 
> Signed-off-by: Robert Hancock <hancock@sedsystems.ca>
> ---
>  drivers/mfd/mfd-core.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
