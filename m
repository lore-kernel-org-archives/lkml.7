Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526A4C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2672521582
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="jF/qD4Bk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfLQMhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:37:41 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42858 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbfLQMhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:37:40 -0500
Received: by mail-pl1-f193.google.com with SMTP id p9so1809587plk.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 04:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MRudvmKhJDWYtzneDuCIws5zDLnO7yoUHBs3dAUugWc=;
        b=jF/qD4BknEFRCtTNqmrtKXztOwg8qDq5/1np9XgRXSq/6WBXUR3hZLMz5Ag/uGmzxv
         baxZHfit28ov6PRGnkNNgThDdFE7MHeypi7bLi4FNYh2CYlU83KVj3RGN/HCGwzm3noc
         /7SEarI0b9E7r5BoWrXihFoBkSGYFmQzrltwz0Gx3BA7NdXIs5Kzn5JtR+sWbBTf75EL
         LRRm2fB7wWk7qRVGPjPQ6HXPo39rH8fpaDC2jhhozINJnqT//0qpKgntXM+zZSPP/WT/
         g/+2XLHmvhe+u7VVsy52blYmo2B/Nqfz5Rd+wmFkoo132R0ZU1wPzaKn/qPj7k/MJpBJ
         z4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MRudvmKhJDWYtzneDuCIws5zDLnO7yoUHBs3dAUugWc=;
        b=UZOe+HNpMnH/jMR48hLwXKImGqNxid56VGtrAG6TC+A/P+ejKKxBzehsNfsHIvzazo
         FcYXeHzWdTfBCparp1BoL/M8LHHkCm9SToIpm52GjjphE7HD7NyhulBstQtdGzrBO89w
         tolXdYbkgm2DOkmTWtntwFqlmgPeV089Sa1KJZCb4coywif9SkjZncGmr9tpvR01PbBv
         IFnVa488qJu/0vcl1QkPxuarfwsDGL+gIYG6KZekO3dLsFcU9D1NO9PD5jIJxvJ9lg9m
         7LvdXCZIwGyxHVi7IiIhZnnGpbCgC+DdiKjYl2a6eq0ReY5/wXoHqKJm8oyKbL2vYtXY
         /k7w==
X-Gm-Message-State: APjAAAWZHm0760xH84go6yfrLSmuC9M2GyX9DJ28L8BYlQa7tXZq1vq4
        nUz647BKG4xnjvAIx1xatazQM0rO+AE=
X-Google-Smtp-Source: APXvYqwhUF3RlGnGikHc4pNISjJk5YxydwinKeNP1wBXzeE9lF9vDsz5YnzP44Qkb9ZLo7Y+iTOjwA==
X-Received: by 2002:a17:90a:17e3:: with SMTP id q90mr5601351pja.139.1576586260124;
        Tue, 17 Dec 2019 04:37:40 -0800 (PST)
Received: from debian ([122.174.84.27])
        by smtp.gmail.com with ESMTPSA id k5sm3258658pju.5.2019.12.17.04.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 04:37:39 -0800 (PST)
Date:   Tue, 17 Dec 2019 18:07:32 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        jeffrin@rajagiritech.edu.in
Subject: Re: [PATCH 5.4 000/177] 5.4.4-stable review
Message-ID: <20191217123732.GA3492@debian>
References: <20191216174811.158424118@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 06:47:36PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.4 release.
> There are 177 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 Dec 2019 17:41:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,

No new errors from "dmesg -l err" on a typical kernel configuration on my laptop.

--
software engineer
rajagiri school of engineering and technology
