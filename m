Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6C4C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71EB22070B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lHOPAntl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfHSQvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 12:51:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40453 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbfHSQvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 12:51:13 -0400
Received: by mail-pl1-f194.google.com with SMTP id h3so1232156pls.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 09:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PF9Fz7eLOn3KOSJvwuGfd7kZcP+Q82SJirXg7MMKVTc=;
        b=lHOPAntlcr7DvNNnqvGon8PsmC5KmwzxdXbVCIgrhXAtUPzFHwLR9e4ryWdu1nuSuk
         Ehdt/HQ565j7tizRT6Sk1evJ+r63wY5/uqERuNIBq7QSjdswgd8o9TlmUxV2sdkzTM6e
         FKyUhTMwIM0WiojP3BvTlMSmkshvlivGl1p0HdIAq30G3r6AH0HjcXoU8VgRqnnQ0pRj
         SqLM1uvtl61cfFjNTQUe32kc+gBKyyxdYi4luXvShhmmAtzDlRqCI7EE51g38oJtoMDf
         0AjjxTRurHFWz9s+7bWl02zAqVcKU56b+6UDVJi8MTf2bAp97Z0w/OfFjF2Qtrv0KA+j
         WlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PF9Fz7eLOn3KOSJvwuGfd7kZcP+Q82SJirXg7MMKVTc=;
        b=nn9XsTIPdBRbksFXbQkWpEMe/p0nSG4N4Sd7yLeA+azfcKCBI/tKs2OsIg7z886pkz
         q5RDVeT3u+gbRPp4dIrEGpuazCnZ/NoIfE2JjQ8NDzGCOum/CjNUQIqsSPmMSJl5WgH7
         /a0xpmN8CY44caXTop3xYcj9PDkNsmNSyV0SqhjCThLrr0GVGTYUlvBK1DeHlXz2Uhtp
         OulKBXDaUFfAlBAnByo/TeIcWv5wDj7LxPznYKO1A7odNB5MsU/08/tj1SBcNZ7FCSOV
         qRQ/epg6uuSqQHO+IXn6O9GeyW6gw9mChocdJJQBuvxzokIxcEfXLOI/TY+uzEfa4h96
         r6IQ==
X-Gm-Message-State: APjAAAXrZ4AanqISO1L9UG+lF9P8ffQApP1r+zZ/rbzz7769Ewz3tBNy
        dvH+oCnA843hleoWhaRbU+ZnPQ==
X-Google-Smtp-Source: APXvYqy+GZvqO80ibtH+ku91D+7Ug4tpguKdLphDT0NoWOq2CKeFFjM/+4q4NMDcCteJLySS1DmZEg==
X-Received: by 2002:a17:902:141:: with SMTP id 59mr24103307plb.324.1566233472771;
        Mon, 19 Aug 2019 09:51:12 -0700 (PDT)
Received: from tuxbook-pro (pat_11.qualcomm.com. [192.35.156.11])
        by smtp.gmail.com with ESMTPSA id i11sm22052392pfk.34.2019.08.19.09.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 09:51:11 -0700 (PDT)
Date:   Mon, 19 Aug 2019 09:52:55 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Jordan Crouse <jcrouse@codeaurora.org>,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-clk@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH v2] drivers: qcom: Add BCM vote macro to header
Message-ID: <20190819165255.GA26807@tuxbook-pro>
References: <1565037226-1684-1-git-send-email-jcrouse@codeaurora.org>
 <20190807234232.27AA720880@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807234232.27AA720880@mail.kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07 Aug 16:42 PDT 2019, Stephen Boyd wrote:

> Quoting Jordan Crouse (2019-08-05 13:33:46)
> > The macro to generate a Bus Controller Manager (BCM) TCS command is used
> > by the interconnect driver but might also be interesting to other
> > drivers that need to construct TCS commands for sub processors so move
> > it out of the sdm845 specific file and into the header.
> > 
> > Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> > ---
> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> 
> Unless this is supposed to be applied by me?
> 
> BTW, I wonder why we need an rpm clk driver much at all nowadays, except
> maybe for the XO clk state. The big user, from what I can tell, is the
> interconnect driver and we don't use any of the features of the clk
> framework besides the API to set a frequency. Maybe it would be better
> to just push push the bus frequency logic into interconnect code, then
> XO clk is the only thing we need to keep, and it can be a simple on/off
> thing.
> 

There's been a number of cases where we'll need to enable the buffered
XOs, but perhaps these are handled by other subsystems these days(?)

If so the one case that remains would be the operation of explicitly
holding CXO enabled during operations such as booting the remoteprocs.

Regards,
Bjorn
