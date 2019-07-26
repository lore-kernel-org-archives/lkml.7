Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC68C76190
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4EE62166E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HynS/ASw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfGZIDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 04:03:36 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46525 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfGZIDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:03:35 -0400
Received: by mail-pl1-f195.google.com with SMTP id c2so24431706plz.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 01:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V6zPBev9xQgiBqMyHVwiFqQKL5cx+sR2tLt2bKc/lVQ=;
        b=HynS/ASw3Ys3ZyhOwYmGKzl1m1kwEE7nhm8gNvbojrDBb+rqjQ9hmTAP92o9YJlhz0
         aj+aQeSIN6AmLljyuVNRQm9hKkmsP3BfsnY6Wg4fJ57DD5Nh5FLPsSydLc1zd1/vIgQo
         ZoLDbBxJWLgD7RMdTjZPu0VwaQITz47QSC5Uv9xnyTa8hqqJ+GzW+WM7ommW+BeSRik+
         H5hOMdwjoCoEFOI3NUWqYKYbzmFdcqlISmkJ1ff28H/CiE4DUUrxP9EEktKHnuutBIwf
         r26wI9R4XxfMoyPcU29ZUU29FLjWh7Lw5LO+TDJIXbHjcdsQB/w8yS1yjatI9gyD0fdt
         i8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V6zPBev9xQgiBqMyHVwiFqQKL5cx+sR2tLt2bKc/lVQ=;
        b=Ub3rd68lkN2tMZ5Y1akuTzckTCqJ0XJpKdFvkAQJwVGHxz+h6lVQphftvUap4kgBzC
         0rIWiSP1NLseE2pedi2pxNKHcCSargSy8njXxJUvlv12r0GGyaOHoDL4laQv3QjR+D08
         1k3duxErFIZxeeCAaYClIrFumjFqsxsy0fFEWF3r5lmgYnCrIO6fYpRedArBwFInAxN+
         UakeNxC+39YUEjru+0eimNFgsz2Dj6DthYp8KiC5sIc87zNqzYmgNaYkkJC0z1/gp9P/
         LMyBKZi5SVnjJdWMWtwBIaoBYcT3XTsv/WVRpXF+C73cXDaUcfxh24nKzXTdNHzbzNbg
         J0zQ==
X-Gm-Message-State: APjAAAV8dS9oZ5q5r2p9XucNh4J4/F1WiRZunKZm5iFAcsxjdXXuOwhG
        llQrIWEznCCCVTov+Dhv5iaamQ==
X-Google-Smtp-Source: APXvYqwYoNk6LUyHsrgO48OvfBPvyGjR8jqkVPjQWqjKXtuBa5adbQy6aRQy3AbSY5sRUgiAxHwLFw==
X-Received: by 2002:a17:902:ff05:: with SMTP id f5mr92070283plj.116.1564128214872;
        Fri, 26 Jul 2019 01:03:34 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id q22sm47092154pgh.49.2019.07.26.01.03.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 01:03:33 -0700 (PDT)
Date:   Fri, 26 Jul 2019 13:33:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/14] opp: Add dev_pm_opp_find_level_exact()
Message-ID: <20190726080331.qzvi737nj4oflghz@vireshk-i7>
References: <20190725104144.22924-1-niklas.cassel@linaro.org>
 <20190725104144.22924-2-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725104144.22924-2-niklas.cassel@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-07-19, 12:41, Niklas Cassel wrote:
> When using performance states, there is usually not any opp-hz property
> specified, so the dev_pm_opp_find_freq_exact() function cannot be used.

Removed above two lines while applying.

> Since the performance states in the OPP table are unique, implement a
> dev_pm_opp_find_level_exact() in order to be able to fetch a specific OPP.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---
>  drivers/opp/core.c     | 48 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  8 +++++++
>  2 files changed, 56 insertions(+)

-- 
viresh
