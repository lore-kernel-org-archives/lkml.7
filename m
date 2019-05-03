Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145A5C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 09:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2F7208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 09:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CmgJv+ov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfECJy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 05:54:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45253 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfECJy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 05:54:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id i21so2478480pgi.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 02:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C0o2C2dvxi0pLMdXrDdXumezhHQvfHIWUdutqFX4avo=;
        b=CmgJv+ovQfwvMZ8hYrU6a3KAmlaqUCKfjDSp83hy2eKiLdEJ4JPXjrBJqG14F9XqA/
         63eOwi3EkVjl+6D/641S48T8xo5/+soZmiSsx8FZG8MJNjuvkgpCckX5B7TdvVcx7LGV
         f+xOAwRPKBwwoRwKkqvQ+vDiOq7OhkELe3l6uvDfjSQDo1VC3gSVoa22s2Q2D7S0On1w
         wgP3TRWiWVyVbqssaGJTP4T2Q8KqSekqh+Buw9TLma8BXAJFkwYJBJaMHWjl+sVhdII1
         RtireCfFfJXDEh0wbQIcmVPQeuxSoPZwj1SU2QM9oQST4DJ1VMOWRQuzuNsvvBtrekmx
         8JJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C0o2C2dvxi0pLMdXrDdXumezhHQvfHIWUdutqFX4avo=;
        b=M+e60QEUYB/omD4D3uQKeMsVT4P4TGUW4SlnlreTuM62uOsWB70xMo9/zKPAiwtbKd
         UW0mOO5/w1IYfE+tvYV1BfBeoAVkAVYlFlrHPwTVzjK6xhQpexaPRQa3EJaFINA/+HTU
         cFfu+d1r5XeWAEu79EPs0KZbhXCYfkS3uKcOULG3PJz7Xv8KcXYuRPec7XW7bR6uAE1S
         yVNrDAZJsedvvrxI9JDA6329AwUSws+ljvRUN3v4GOsh4ms/QW8OleQGUX6FC/B8De4e
         tLPGDQKlL09kDZnUoPF+9A546bPHMwDe5duu//bBON9rzexFjS8cqGVT/BwM83bPBq89
         UpXw==
X-Gm-Message-State: APjAAAV/j17a2pGBInkkV1yMYaw7qXxJoHFwmRM4NsCRSXSxN9pupM4D
        cMQYjbMpen19wEzzn9F4d8uFBQ==
X-Google-Smtp-Source: APXvYqwvKwHE2OHYzzhBFYFV6Lf8kjUsbmnwDw43+ppDTskuURRW+KyLhklRJn7iA21MO0JSDONaUA==
X-Received: by 2002:aa7:9151:: with SMTP id 17mr9215458pfi.192.1556877265425;
        Fri, 03 May 2019 02:54:25 -0700 (PDT)
Received: from localhost ([171.61.121.242])
        by smtp.gmail.com with ESMTPSA id x4sm2353103pfm.19.2019.05.03.02.54.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 02:54:24 -0700 (PDT)
Date:   Fri, 3 May 2019 15:24:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com,
        catalin.marinas@arm.com, daniel.lezcano@linaro.org,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/3] Make IPA use PM_EM
Message-ID: <20190503095422.dw5ssdd6bz2wxaqn@vireshk-i7>
References: <20190503094409.3499-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503094409.3499-1-quentin.perret@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-05-19, 10:44, Quentin Perret wrote:
> Changes in v3:
> **************
>  - Changed warning message for unordered tables to something more
>    explicit (Viresh)
>  - Changes WARN() into a pr_err() for consistency

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
