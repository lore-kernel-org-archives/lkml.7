Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A19C4321B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B034206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1IY2m5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbfDYTiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:38:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36461 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbfDYTiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:38:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id z5so422470pfn.3;
        Thu, 25 Apr 2019 12:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CRsGik+GGi5aV/wsOZrmTp6oiWgYzqvLkF22RjIdT6E=;
        b=N1IY2m5ax8RJF93LxaCEFy2VPelbpqSMZ3KTCmdcyvbpDH6vZWJBhf6nkws/j1lz2l
         5ty7MoX1OwuirNoOrP7wq2m/Vb9ITKSQaju8SD2CbqzXkmRSQ0bKNOU7axFdi3ciHPzz
         gyLyrrTKfLFAvQIH8CLHm9L/f8L5AXdLtKUg8BquHe2iUy5Qhyt0kx5BliftmFN73618
         CwsPMDvKlkt3E5Oddv4XnOOu1AgsocthE5wOVzqWbfQi7YOrZNk3HPU6oMROPgiQu8DW
         lEyPbz9CpD9l7B8OfdKYR0wuOPYDkWiYXHXEKnaKkAH4glIku0cQ1qtoVixxA/Ys/TZz
         NJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CRsGik+GGi5aV/wsOZrmTp6oiWgYzqvLkF22RjIdT6E=;
        b=Uac+ctcA2VH6gxpM3LfKwjwvQWLsspfMM0FyMen0iAOCBK5MUp5CacIa2Ti1ymiY83
         pJyyq9ru4fZTQmTwdiSvmjCak7pCto90nmz1JPksAKQFXyboPzblCPahLBY4ETyzdKRV
         ZKMix+x7g0tvVa40X4CdrdWE4itINSMe+Su1QylyZrDTv+68Jz5LnuA28z5UBqECcuYL
         ViTPL2t+8LOeex5KqL8QyL7QFBD18BOfRZnh6LEB5Wzzgp7fnTjUCeVNj3yP9i+Q7Wxc
         l2x7hm7I4FFLuVhkvSmABCxE3f+Y+DHnzZSeRUHbLI9xBogdgYqt/VQRrQlGtQV7Ca39
         DwUQ==
X-Gm-Message-State: APjAAAVNViH2RtZOIqQUTpnX2WBGZFDGGxCkl7EL2o/GSddHYIQA89uK
        QoRW5TqHDUUphTEcFH2qrAUGAeGP
X-Google-Smtp-Source: APXvYqyinCB6hVfgRbGhgKE7CprBDr16aRrrG+UK/MURrZ2clYFOiob4bFE35Nx84biRUKOTNk8Y9Q==
X-Received: by 2002:a62:b411:: with SMTP id h17mr7052591pfn.61.1556221094546;
        Thu, 25 Apr 2019 12:38:14 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x5sm36490553pfi.91.2019.04.25.12.38.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:38:14 -0700 (PDT)
Date:   Thu, 25 Apr 2019 12:38:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/70] 4.14.114-stable review
Message-ID: <20190425193813.GD13462@roeck-us.net>
References: <20190424170906.751869122@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424170906.751869122@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 07:09:20PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.114 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri 26 Apr 2019 05:07:32 PM UTC.
> Anything received after that time might be too late.
> 

For v4.14.113-73-g7c2e346:

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 333 pass: 333 fail: 0

Guenter
