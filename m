Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDEEC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 08:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BB2214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 08:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="hTdYUuX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfLLIF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 03:05:27 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:44517 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbfLLIF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 03:05:26 -0500
Received: by mail-pj1-f68.google.com with SMTP id w5so680200pjh.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 00:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fp5LYGJKEkfg5yRhHzvHzf1OfDrIgPebJ2E+jZMHJ24=;
        b=hTdYUuX/LFg7Pd3ilOvSYz4/ctywOUxqVSTtzhmLSq780UIf98CB3GtH7Uwu3bnbvh
         DITwUpWZIs0dn/iUvBgQBpCaL64gO92pHN0XqOeyR9dJsic2Rq8t9qMnPzHPWyX0Mxp+
         s/kD0cxw6ZazoIexIu/KZ9cozucV2BUUhG+01SqZrrpte46ijpJvLGK34Re47P9lQQzw
         QIHUNEVGMJ7/XO7ZlWvS9a4R2E6sCFylFiUV/HyCyyIni4Nb4edEXTqWdkslx7lxvdAT
         ZEjJI3iVhdmuAfbERpo3BvtwcBywWWHqI4qRDgan0odwXbfVYlSZWsFCDdH0vfxTj7r+
         EjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fp5LYGJKEkfg5yRhHzvHzf1OfDrIgPebJ2E+jZMHJ24=;
        b=RP4YcFLDUu0Frz3Y7mZacOozmdK8LQy5zvyGnizvXpIrPXyeBHjzH7dhobNKnPh5E5
         Ol7eAbbGEuMMmiphFjJZlO4LbWECyT/oLHQ8o41mcYgxZg4PELmoeNa62lL2kpoBPOE6
         duDK99Hc1iwm78J/RDT6tUR96+IN3ArdmrwBvUU3EcreEa7L8AJID/Lz3cvyTY4TEBvE
         2HG0fSzxzcwzGg3069EfKKO0bGdX60Thi54EwknfxqnRRJO/chKYsrbIXGS98Ich3Bsr
         wQjPze/s9IaYIA5wnSzwtDpnTuCbEZqh+RZ6yIHd1nzcdUscppSPyiuKEkwxIF2ZYeq3
         okAg==
X-Gm-Message-State: APjAAAX2715qO42deEKrMinOjoH2xIySOiOhN3PiRRr/DWfqXJZH/jHN
        BHqHwdEymMRf/9N/awQEBNXAkg==
X-Google-Smtp-Source: APXvYqzgtaUqbQwoRjMvL+XzEm1CG7mK1gKpaRv8+pqOZ54pcrwGWB4YlSELs5ekSKZbvnw0qJXgQw==
X-Received: by 2002:a17:902:7797:: with SMTP id o23mr8079385pll.149.1576137925667;
        Thu, 12 Dec 2019 00:05:25 -0800 (PST)
Received: from debian ([122.174.90.102])
        by smtp.gmail.com with ESMTPSA id 83sm5739611pgh.12.2019.12.12.00.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 00:05:24 -0800 (PST)
Date:   Thu, 12 Dec 2019 13:35:18 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        jeffrin@rajagiritech.edu.in
Subject: Re: [PATCH 5.3 000/105] 5.3.16-stable review
Message-ID: <20191212080518.GA2657@debian>
References: <20191211150221.153659747@linuxfoundation.org>
 <20191212065214.GA3747@debian>
 <20191212074124.GA1368279@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212074124.GA1368279@kroah.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 08:41:24AM +0100, Greg Kroah-Hartman wrote:
> Are these things new to this release, or have they always been there?
Normally these are not new things. it has been there.

--
software engineer
rajagiri school of engineering and technology


