Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347CBC17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 04:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A8772086A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 04:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P7TReUjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfKKEy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 23:54:29 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34237 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfKKEy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 23:54:28 -0500
Received: by mail-pg1-f194.google.com with SMTP id z188so2732887pgb.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 20:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S45RXA4zGV7gDprsye+JFjRLdDRo3WVxz530wyGpJP8=;
        b=P7TReUjlHc9dF8PHNzJzV9vA9J8emcI7MGU4VBkJS7ZpTDGkeE1abyae1I+gowgS2Y
         slZNVa09fIkCEtv11NJmVWpFcnWqkh2j3yldAGM7qJSOeEpqMfUMKnU1SWvLXa57PYHz
         fJrjCuosK6+4HxrQL8Wom/RlDRRCS/yIsV34SqA2Z2ysJobEILnAC4YtEM3ws4bT9dgd
         rNd8hiqhQyD6sfNsBofoc3mA1y4lzwQAq4bd/rfkgU+xK6f1xfVIgc0hcsJIApXYuQp6
         RQ2ixHkFKrYhAX63PLoNUPFHutLEU1eQsDvS26piKSeLrF4ZEfRLWMdx1w9CVUVE2Zp8
         3Kzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S45RXA4zGV7gDprsye+JFjRLdDRo3WVxz530wyGpJP8=;
        b=fDz4QL/FoItAQsU/TjnXEJI7CuqJ9Hvv3HiILsmt39fsV+JWW5R8SpRxT4/hfFi0oF
         FA0kBKs3hFgpn+5kuQSBkPHxLLgOmVl2oVwhmGYpXdj/Gx98oiSbMdlwMxwOVIptDe/5
         vZ1cp1ugoDBj/d6d5J/zqFW7wYpm1rfbMa05pFge5fQnNrcSMnhAicBBoAN22puK96HY
         WPfC1bLtDwqdN8tCQg6m6afZKIMTSn5WFuAQvr9N1h14Q2qnYdRXf/Xnrz1qExAODhm1
         Lp7mnxiBRHj8UIH21wEmJ4epDRjMsMlRzpydw6GsJOV+I4Z36whq9BPL8g510wvQsp77
         hUHg==
X-Gm-Message-State: APjAAAVTiYxuSBi2fym6bEa1UhDPrniHGtKzWciFgBlhSDCOjbt/QGBf
        IOwdO01neqkk0epFDE5yzrTuGg==
X-Google-Smtp-Source: APXvYqykMoJHUhOeCov71Fd/M57CoIspV1B+HZ07HZOay4M0s/x3pAt0wUtbrCmSDBSVEO31b3ZV9w==
X-Received: by 2002:a63:4104:: with SMTP id o4mr26140789pga.169.1573448067775;
        Sun, 10 Nov 2019 20:54:27 -0800 (PST)
Received: from localhost ([122.171.110.253])
        by smtp.gmail.com with ESMTPSA id 21sm18386478pfa.170.2019.11.10.20.54.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 20:54:27 -0800 (PST)
Date:   Mon, 11 Nov 2019 10:24:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] interconnect changes for 5.5
Message-ID: <20191111045423.rnhmv7uzhabgtebq@vireshk-i7>
References: <5123bf54-5d62-fc5c-8838-17bc34487d83@linaro.org>
 <20191107142111.GB109902@kroah.com>
 <0cb5a6a6-399f-99e3-dc41-50114eea4025@linaro.org>
 <20191108103917.GB683302@kroah.com>
 <CAOCOHw4d0q3uGTAh_UrNWr+Wi6ObDKUFn7M_zkD8cFTkNFEUDA@mail.gmail.com>
 <20191109084820.GC1289838@kroah.com>
 <CAOCOHw4AFz2Rj3sLTrboA0pBOkL_5MbitJnFHgBYaVBbWyYATw@mail.gmail.com>
 <20191110101647.GA1441986@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191110101647.GA1441986@kroah.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-11-19, 11:16, Greg Kroah-Hartman wrote:
> Ah, now I get it.  Yeah, that sucks.  We need a "shortcut" in Kconfig to
> express that type of dependancy.

So we are going to merge this patch for now ?

@Bjorn, thanks for replying while I was away :)

-- 
viresh
