Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A55CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9EB2089C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CSj+yl85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409627AbfJRIDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:03:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34537 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391356AbfJRIDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:03:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id b128so3392196pfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 01:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sErwmlR/ZtxUuqXk1qiWYIssOCsSgFu0QKb72b9MW9M=;
        b=CSj+yl85ckEYIGtjBkkucgoP9XJVBKMX9yMZWZxVCKaNA7uoVJ6dj7s+46L1Ppkxwl
         aWAVJHR6FLkgCVnM/bQOJ/ivhDUC29Y3nKd8yG8OYE8QHj9lf2sZd9FUo1RF29ojz6Df
         AYIkW1rcciAGsMfrCOA9UnhcQ2yGfC84ajT6MeUnzyxzY8cEyO3WqdQU0ih1PnnEub7a
         ldIVFc8w+9Ud8eVjOsN5Mzm9c7kIx0DB1diB45ranZ54YXnVHv5srfQvK8h4p60pHpvk
         SsK4OgILURKpEwpxs1fkRFEChcEs+e3hRg+vu3Fwp3ylfVwC55yMsZqS1tdAtK/6VDVG
         n7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sErwmlR/ZtxUuqXk1qiWYIssOCsSgFu0QKb72b9MW9M=;
        b=P7OLyCgY0lJE8+VGFTSjBjTojiv2KSuKWy2XJOSsubXyqGGXhcsG4A02aYI/o8bqGy
         U/rldFyomWi2l9IwPTKgj0bOn45xevwq9khzl0VxwUqRlBm1vT5vo9BI1PYgU5gp29tx
         VGv1aAkBzvCjQn+INsiA6ks8OuWlXhQHy20WmEBexW6v+bBr5MPmpFnayqbYvq4R7Sjb
         tlax/l76uak8Iw8liTS4TurHxfIyHSaC8et45Dv8ZefvINgIlw7IDHCowm3PMA8LnVw0
         A9vftw8qITRE4CB6WoPNZDndB/KP2lX4H9rO5p7IwtgEAtquAGQTEOYdyqxpscAUtGut
         xskQ==
X-Gm-Message-State: APjAAAWk5YCuMFFaVj1S/5UXqLTXELKiTLjBHmIg3THihK4TOXTnPARi
        jK9axfyMLbK29zSDKO+6OQlHHg==
X-Google-Smtp-Source: APXvYqyl3gwdARfErU5RAKLJFb5sS5B/4NXYBWlelgfub0M3DMR/M662GiCUQj/xU8IwTdo0BkbRJQ==
X-Received: by 2002:a62:6411:: with SMTP id y17mr5243257pfb.158.1571385821315;
        Fri, 18 Oct 2019 01:03:41 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id w65sm5450872pfb.106.2019.10.18.01.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 01:03:40 -0700 (PDT)
Date:   Fri, 18 Oct 2019 13:33:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: flush any pending policy update work scheduled
 before freeing
Message-ID: <20191018080338.vbgnrt3i6epkrx3u@vireshk-i7>
References: <20191017163503.30791-1-sudeep.holla@arm.com>
 <CAJZ5v0gTpK0cJhsWGVvs-=Sbgcia0jz2j5QNYRL+1wOz=2xkJQ@mail.gmail.com>
 <CAJZ5v0h0ioEZqLuaW1jz_8jRuGYZLQS3fbpv9ctyV9ucXb1WiA@mail.gmail.com>
 <20191018055533.GC31836@e107533-lin.cambridge.arm.com>
 <20191018060247.g5asfuh3kncoj7kl@vireshk-i7>
 <CAJZ5v0h0vY9OBYg-_pR-hu_TJkE0odf5Nnd8qnJc17+8NQo=7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h0vY9OBYg-_pR-hu_TJkE0odf5Nnd8qnJc17+8NQo=7w@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-19, 09:32, Rafael J. Wysocki wrote:
> Well, the policy is going away, so the governor has been stopped for
> it already.  Even if the limit is updated, it will not be used anyway,
> so why bother with updating it?

The hardware will be programmed to run on that frequency before the
policy exits, so I will say it will be used and the constraint will be
satisfied. And so I had that view.

-- 
viresh
