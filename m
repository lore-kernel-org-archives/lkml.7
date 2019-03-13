Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25777C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB54A2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe5iYqgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfCMUg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:36:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44851 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfCMUg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:36:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id h34so2317741pgh.11;
        Wed, 13 Mar 2019 13:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2hYYdu+bQsJnRoW33r5yvy7HqBkrRf1vj09eO7p3UwU=;
        b=Pe5iYqgM+FILC0cI6I0yHv5YzpeSU6D//82dfFHb/+hTQyYsWKAnI1R6uYLpazpf67
         pQzW4y+DO+xrA3RvR3k+ggZYdpkubFiCJMmdKD9l6qgvV4PhVAwYE7LPJs6V55mlU+ov
         o6nOaX2TjeR813hCZaMPhntWD8rlP1DyShkspCg3vZihGs37b0s3apKjmLemSwxJPFFR
         /FVjZd2Qtb7zJfNjwL6ja6hzng13jRFGgVocm73iwwWLXwNfolZEcGKIgHGdS/6oyR5P
         IsSKhzHZAXKdPGrx9WlkJu6p2l2vfLY2RtwiWcwlAxJO6P3T8utFc64sOZwTfc7X8s5T
         ndOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2hYYdu+bQsJnRoW33r5yvy7HqBkrRf1vj09eO7p3UwU=;
        b=PMS3xerMLvj45uH32EzVAO5/R1PW8Rb4gzNyL+xt0I5fScF+R+PQ+NT+x9eQX/H/v4
         OQhqUFmbp95qGvjp4O/TUKq51/nUZnUWzDqaRw5i7BD2J//wgXBffRmhOQGb451KWEvC
         FSYA62j4k+dPKNy8CnwxpqG2Aq3W1ufvDF1qZikYuGmoKpbxFHCH9/oXdPMB8ngRnd8B
         vKGhd+KO2AhnBxsRcDNB4Q1TsqrYSY4WaeaDqJX5mFlS0h584hhXYxm9viqnvqluXp9c
         TqE8+CtyaIEF/JpHFKrvquFlkl9Ch4OZMKUmLWHAlcW1kK9KB4oKyn1AZ2WFcvk0pIg3
         AWIg==
X-Gm-Message-State: APjAAAWhwftdEx/8gUMrbWgYXNme/rv/sx9I1A8E2eLok5LSPVBxioJ6
        wLs1aZbDwkQUvAFYljaFjqc=
X-Google-Smtp-Source: APXvYqwqb1h51dgo0FKu/Zqh/RTZcrKoUykUTv3UREw+xVB2k4o0Rt82M+4sf2OGch8p88u5EDbaPA==
X-Received: by 2002:a65:60c1:: with SMTP id r1mr28382662pgv.137.1552509387085;
        Wed, 13 Mar 2019 13:36:27 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l7sm45842258pfj.162.2019.03.13.13.36.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 13:36:26 -0700 (PDT)
Date:   Wed, 13 Mar 2019 13:36:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.0 00/25] 5.0.2-stable review
Message-ID: <20190313203625.GE26634@roeck-us.net>
References: <20190312170403.643852550@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312170403.643852550@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 10:08:38AM -0700, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.0.2 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 14 17:03:43 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 345 pass: 345 fail: 0

Guenter
