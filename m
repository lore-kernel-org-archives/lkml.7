Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E207C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 17:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7932229A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 17:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563903319;
	bh=c7WbfEZO8l0xJnHGIJhz9LLf49HfIgCTSXIEG4NqnSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pUOBMKR6lci7Ih3A6Kgy672LnwCBGk4otF9pdlzwW8wYbE3AfbGFNTrv0zBDfHnBR
	 CZd6Nke7CV1Z66lJVJ5VFhugmL8mX/XkVgLsnjwYvnCtvcF71C/g7q9wBOtV1qCnhY
	 xFdBT5n6UmLlrZAq4/RvNz76TtGpDCoa6reGp40A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391123AbfGWRfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 13:35:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36145 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfGWRfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 13:35:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so35126243wme.1;
        Tue, 23 Jul 2019 10:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KMzb3lQV6/HQhyFJeMHm9RDfYopFx3+fyKqozQwxa7c=;
        b=FXkf+ad5WEsPsVuNEd/akwpuJKav1wHTStpjJYvBSXd8YPr+ZoULeKQARb8R5APOL+
         xAAdyN4nCWgcubQe7ZGgRVJODuiyX4wLtiHAixtjaUKZjVz8SRbuvx8z3ZlFxndAYSGc
         ZiGkHVHZC1w+JXLSPjCbAWn9TNzSJwqKmF+FMHb+7r+cLD8ENT2hv7bCejGwyv7HH4Me
         RxUN5cRkqqALd2O//S2T8AHs6PG2R/ThWFuW6YS6gA2Y2EVRLhDtpnDls94gx3A47l9O
         nDuewgQ5G4wwmeTYq9pIwgpilN1JclU8dXHobvx/21vTb9TaOdgmLMKEkZ6HbL0kv4ec
         Sp8A==
X-Gm-Message-State: APjAAAW/VuE5awNVPco24LeBip5jcZn+hhFwCRFulgtSrZcA6tAm0pul
        2ZkyIUBjzZF9/SleEhB5fLyqY1LC
X-Google-Smtp-Source: APXvYqwNRzEAQq/pFaRBFGVCDCI0KRPQ7Kg+0eycJPNDnuZpclNN2Fxt/Sfrz/Iq2t20plmQXSrtTQ==
X-Received: by 2002:a05:600c:212:: with SMTP id 18mr20452940wmi.88.1563903315440;
        Tue, 23 Jul 2019 10:35:15 -0700 (PDT)
Received: from kozik-lap ([194.230.155.239])
        by smtp.googlemail.com with ESMTPSA id c11sm75919141wrq.45.2019.07.23.10.35.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 10:35:14 -0700 (PDT)
Date:   Tue, 23 Jul 2019 19:35:12 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-i2c@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/14] mfd: max14577: convert to i2c_new_dummy_device
Message-ID: <20190723173512.GA6317@kozik-lap>
References: <20190722172623.4166-1-wsa+renesas@sang-engineering.com>
 <20190722172623.4166-7-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190722172623.4166-7-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 07:26:13PM +0200, Wolfram Sang wrote:
> Move from i2c_new_dummy() to i2c_new_dummy_device(), so we now get an
> ERRPTR which we use in error handling.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Generated with coccinelle. Build tested by me and buildbot. Not tested on HW.

I do not have the HW for testing anymore but looks good:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

