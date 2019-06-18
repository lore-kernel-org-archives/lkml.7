Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB15C31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3942082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bNVvSbgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbfFRLeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 07:34:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40627 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729621AbfFRLeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 07:34:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so7489428pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 04:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xZHZFfBGAguz2tt/aDclYAU0MMkB/zuIOCSv36kPYTM=;
        b=bNVvSbgfHNdbARu+Qps70R8iY9LClJKO2ADtLd+/YN5r3gA2/gsGz3cjvm9Eb8Iw6w
         zDaXp+DYV6wrFRc+vzVGteYaDYzHNqgF36MUVedEJcFlHmNtxJAe2yQLtMYJm0QV5bSw
         j2AMk0Sc7aMdkGTJtpi/hCag2hkiJ4G0lZFdh3mAeNIiJnLJ/KS8/xpu2vxaSp1sne+U
         MCI9hxvVegVHuCtOQvABHO34gWp0O7zZpj2Sp9YyK5I2GIVSt6Pu0U3v8LwbDr1fJKFJ
         w3bgFUB3Qko3gm0HOwWsNNA2YakYdgk9A3MGGQ8Y13XIumiHX/ZH2VQA/LogSgvIdtRj
         8bDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xZHZFfBGAguz2tt/aDclYAU0MMkB/zuIOCSv36kPYTM=;
        b=p1f3WjeGveDlbzVH1/antmxbC6TjMZax7Dd4V/gkAFcBJVU2OBbaY5rLYJDBymN743
         ClWuKEaNO57ldEzo5cRokgth75lDg6C5eQzLmasqKqvXq1O8MmNt2ZF4Ew2ygNmDyluk
         lKurF8ID3i4qJU2iycKoeDb8Hbj/6IvZU6DeN3KthtHm5rRzUkYUkq9dL4mng+RGdZmx
         FGfPvgx209GUpCavz1+BbqmvUTn6QAkjYen077odf91hP3O0HsZ3mUDZEBwjf3mFtMFf
         N4w1enqzuHMlTwLI2EbZIvWH5JeBYCUMNrtkpuQkiA5iUYuIFtqZYH6Fm2R4zOUKxBcy
         PWhQ==
X-Gm-Message-State: APjAAAX81hFc4HCa8Ed/48qWU0fRW1OA5LE05S+HwtN7n8XALtrsXtAu
        hB5atwSduvioJaYKalqog05JJQ==
X-Google-Smtp-Source: APXvYqx9A8qcsDI8yw+Nf7x+9EFx7IT9gMXaWuX8lHS0a2qtKDYTHX/RNHxnvpEjdWFk/6vvTmn/3Q==
X-Received: by 2002:a63:3141:: with SMTP id x62mr2294788pgx.282.1560857644690;
        Tue, 18 Jun 2019 04:34:04 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id p68sm14234589pfb.80.2019.06.18.04.34.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 04:34:04 -0700 (PDT)
Date:   Tue, 18 Jun 2019 17:04:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qais.Yousef@arm.com, mka@chromium.org, juri.lelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 4/5] cpufreq: Register notifiers with the PM QoS
 framework
Message-ID: <20190618113401.ybs7k7k3oxkl2ql4@vireshk-i7>
References: <cover.1560163748.git.viresh.kumar@linaro.org>
 <a275fdd9325f1b2cba046c79930ad59653674455.1560163748.git.viresh.kumar@linaro.org>
 <1794396.RVx65QvVqq@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1794396.RVx65QvVqq@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-06-19, 01:37, Rafael J. Wysocki wrote:
> One more thing.
> 
> handle_update() is very similar to cpufreq_update_freq_work().
> 
> Why are both of them needed?

I probably did that because of locking required in cpufreq_update_freq_work()
but maybe I can do better. Lemme try and come back on it.

-- 
viresh
