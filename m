Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E059C2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 11:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA48820409
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 11:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="prJhyB6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfLaLdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 06:33:45 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36580 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfLaLdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 06:33:45 -0500
Received: by mail-pg1-f196.google.com with SMTP id k3so19448738pgc.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 03:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vT5dBaJiwzxpEHvp7zKJaSnGeHGYjZq7+yzqZJHM94Y=;
        b=prJhyB6uVNCOKLpi+JAG+XgnvuPtmJ+n+tv57IddOyIjZ7S3dLcVXXlJgMvHgV2Pwd
         wjmKvUeXGPsmVjJPTqIVdImW/9l+LvcAsZMhUmtzWQhMBF437ZUMjJPlGczTPVt0YTpi
         qUgVEDAFpF/YfzTH5euC0M0mSezKPNOzVNt0Axa5db8FMBiB2tw/n5/c4prCoVRdqXx0
         gD036xEemY+F8fLnnrTvP5wlb7OaYKFaMd2/6dzFB+8alexYibxzUyRvFEi5i5cYgZZS
         /TCmZzaD2uj/GkOYGD2lqkt5Y4CY2QU9fwfg+/oFk1bZTetrUSrxAqMRCYtT0VWQ0T0v
         y3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vT5dBaJiwzxpEHvp7zKJaSnGeHGYjZq7+yzqZJHM94Y=;
        b=tc/zo6JWcNA3M60ZifRnQ/moxEdYG4S8r7kzAhUU9nk9zxD5m+tuw1Jre6BAYNCLXU
         p493aAVscsvzYhdRNRpn/KH3MVwaW1EJYBNoNIAQShns6GwYJ1/cAlvvLShi5swvV13R
         nS8h9ufXI3GthWFZesNFcMjpClHFVPetFMKjJlrPUGmk3rSeyObeqfyyElnvhfwrDQSD
         xjyyCJRRYsTwKGMxRelFKMcRDsyBDr5hBdToShXFKydBH43OmmLdrrP7yNTZ1LqpnuKe
         BNYTCprSLaaJzFDj+L0TUckYSZgkyZV66fS0w4TeMuagEDDiF1pcU9IYbcZVXHrOVQZB
         Zohw==
X-Gm-Message-State: APjAAAWWW/0xckrsEQ3VWl25rAiMr3k/halexQ0UcM4bTe7klTYpdyVk
        MrJSHIwAK/IrLcCYyeX7SXhJ0w==
X-Google-Smtp-Source: APXvYqxmkIym5DGEdRsYPSAKxmedCSqXsKvVY1rzp2ePuMjKUIR4m77CB8VoPlgmC3MdOcmU2oYFCA==
X-Received: by 2002:aa7:9474:: with SMTP id t20mr75308382pfq.241.1577792024342;
        Tue, 31 Dec 2019 03:33:44 -0800 (PST)
Received: from debian ([27.57.18.230])
        by smtp.gmail.com with ESMTPSA id b15sm52706468pft.58.2019.12.31.03.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 03:33:43 -0800 (PST)
Date:   Tue, 31 Dec 2019 17:03:36 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        jeffrin@rajagiritech.edu.in
Subject: Re: [PATCH 5.4 000/434] 5.4.7-stable review
Message-ID: <20191231113336.GA3016@debian>
References: <20191229172702.393141737@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2019 at 06:20:53PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.7 release.
> There are 434 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 31 Dec 2019 17:25:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
>

i have compiled 5.4.7-rc2+ related and "dmesg -l err" has no new errors.
"dmesg -l warn" all clean

--
software engineer
rajagiri school of engineering and technology

