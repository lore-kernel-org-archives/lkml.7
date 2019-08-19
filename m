Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AB2C3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1DD622CEA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="st33qIY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfHSQtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 12:49:13 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35855 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfHSQtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 12:49:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id f19so826320plr.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 09:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JfNQ1P5D1q5FjOjoMZsxiAYKvHd+lD5nnopxEzzzvMc=;
        b=st33qIY1DLlZc5OvsEzD7D1yWQ6hmvX+dVih9ZV5bdrQXdJmL/lUIoWwzRIUHzf9v7
         gm9s3iQNDchMgOfFPmebeTLO/NRHeFwsXaaLO1Chj0qjhcxJrvcowr/Wx4jIrvVuWVcW
         ZYU/qrzgTGSERPHcs79EDmrXD2fBK1k8Snsudj3aaO/leTo2L09hqCYIqQ4+saj+8By2
         V5OGMPTdJhn+apEajZvjx+Oh2uU2OIOaQFZUjXSCiyMA0q9w/sxBhRlW9OIivxNGWWiW
         W5Ly/o55dTV6UBs86QCDaZxG7ZFQOapqS2HNC4DEz1pzI20uFnMj464hnN7iq3+kt6Vc
         KIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JfNQ1P5D1q5FjOjoMZsxiAYKvHd+lD5nnopxEzzzvMc=;
        b=XXd83tQ2fW7SgtTuldvhCks/KoD8qgwbLo42ZerRN5i8SDQTKu1vwPv8Vup+okbU+d
         g7ox65NHi3iNUfGAxv7VCQHWv9Y+6QbAku0UQfjW4ySC42G/NY8xQhvg3Rrohp/744ms
         b+4n/jY82Sum4p1RUmUrDWoNkx1qMLK800HvkcNy/XpZd55AhadHh+XZc3n0TyIAHkd9
         6P0Yzn1fd4u3LYE8EDp8YcsTBg81YehyGY0P6sGSee15a6zC3zOpXMc/ZY9BQoKdkF+Y
         4oNMN3dwHmiWRxs7mhTESKGlzqhLmMFWTRWT808i0N90Hijy4Poh/n/xRMNPqvQBlGvW
         rrxA==
X-Gm-Message-State: APjAAAWEndvubADSf76LTMaYaaG53EKsTW/OgP1pMRgIS8RJhAFICjNy
        ukMc2VNkgqQXM6ocONLSUGcx+A==
X-Google-Smtp-Source: APXvYqwsgMZ2k5xp/8T99zAMciVVeb0hTMubBeJKxyPqVgwJxwc1NAU5VwwX26QtDrUgiabgaf1rsA==
X-Received: by 2002:a17:902:8f81:: with SMTP id z1mr23101913plo.290.1566233351811;
        Mon, 19 Aug 2019 09:49:11 -0700 (PDT)
Received: from tuxbook-pro (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id i9sm15901499pgg.38.2019.08.19.09.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 09:49:11 -0700 (PDT)
Date:   Mon, 19 Aug 2019 09:50:55 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2] drivers: qcom: Add BCM vote macro to header
Message-ID: <20190819165055.GZ26807@tuxbook-pro>
References: <1565037226-1684-1-git-send-email-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565037226-1684-1-git-send-email-jcrouse@codeaurora.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 05 Aug 13:33 PDT 2019, Jordan Crouse wrote:

> The macro to generate a Bus Controller Manager (BCM) TCS command is used
> by the interconnect driver but might also be interesting to other
> drivers that need to construct TCS commands for sub processors so move
> it out of the sdm845 specific file and into the header.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>

(Discussed with Georgi, he will pick the patch)

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
