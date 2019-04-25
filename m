Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39CEC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3271206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kv+leOxm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbfDYVkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:40:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44087 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfDYVkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:40:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id y13so553159pfm.11;
        Thu, 25 Apr 2019 14:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7Szp2R/NMaewfJcmh9oR2JQwWkonJsV0nLpXsNKuO0Y=;
        b=kv+leOxmZ4Y9vXsZoONspmfT6TUw3wH2FYoiY2gU9wNq9zP7SGCCA54RTvnW4DoUAR
         EAIhQLSI1ZlKVD6BwY/U4KLJfFbT1UKcC0pKWf9bke9eu/moq2Advr3L1u7KTci7aAB2
         0ChBhX9LhVY9BNu/CJurNUVQzLbvobHhK7jliDdTuXDVhA8jv33PHhJVE6cF3cTFzJaK
         wg2B41mqQAotFL40L75QalvPRSjEE7hoEuqQPc9IZXzlUF6/i2v5iHipYgrBzxR5v7D0
         nP9ED5LPTBFD7IV4JZbP7ueE4arhuoVTacPxUx62zNbVVTGLgSHl2rtwKI3Pdxy6MV5N
         vc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Szp2R/NMaewfJcmh9oR2JQwWkonJsV0nLpXsNKuO0Y=;
        b=HryDHgsodreW0zEMWFaEAfAt2pqbXeEYMQVzGADnM0kXtgPNRTVRPKIuErFiK6llJY
         zdkVp2NmEbtB00vsMK7yR1oN6en60MQ/uHcsIP3egsMYCWst28vQx7XLt6iNk7IIedYP
         E9kPb3YnMVWHbckdbOTk8FilzHx83T3dwATQzoy1inMZ581XG059TGCE5XbqNK8Qk4aT
         jVJN25MTGMqXP6xE2yU1CKh0SOCG/1syg4L9UjsZ8raFMHUV5JzvKMh0wIlXX2MqqsLs
         UTDyRH66+FVzXjKUtyLR1oietFVf1NpmXhOIfnmEGQg5RBuaPcNI2QR6jZQIhBhylMHq
         kSoQ==
X-Gm-Message-State: APjAAAU35mUNWR6BWqNKue3pNgMUpXGcEOD2V6yELUQsnPrYE97QDfOl
        ds9m1upa70ip8Mity0nOP6FU64UL
X-Google-Smtp-Source: APXvYqwHfpSyz4gZ2VZyPfcyt/jYkndSM9xJbovlXOZpDPuYDDa3gXq2x9E3+yAABNYvPC8rTfnZRA==
X-Received: by 2002:a63:de11:: with SMTP id f17mr29892644pgg.94.1556228441273;
        Thu, 25 Apr 2019 14:40:41 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n26sm42286853pfi.165.2019.04.25.14.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 14:40:40 -0700 (PDT)
Date:   Thu, 25 Apr 2019 14:40:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/44] 4.9.171-stable review
Message-ID: <20190425214039.GB10073@roeck-us.net>
References: <20190424170839.924291114@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424170839.924291114@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 07:09:38PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.171 release.
> There are 44 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri 26 Apr 2019 05:07:31 PM UTC.
> Anything received after that time might be too late.
> 
For v4.9.170-47-gde1fb2f4bad0:

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 320 pass: 320 fail: 0

Guenter
