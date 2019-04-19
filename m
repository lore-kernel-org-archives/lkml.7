Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87236C282E2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453F120821
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qh92+1TI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfDSUQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:16:40 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34765 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfDSUQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:16:40 -0400
Received: by mail-pf1-f194.google.com with SMTP id b3so2995527pfd.1;
        Fri, 19 Apr 2019 13:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rhPXyDhk16T9cQpirgZvpFE8v4ScJlSdRM//7AKDErA=;
        b=Qh92+1TIIw0CbrXMWcRGYA3ITg8aRvpcQeolqGR4uEK4aZKGetLYqt2UWTfkSIwrdy
         z2hDbZrMoRrKIUNlC/lQBwx1Yd7kcX3cdmhwAlooiDXYFyD524dlM3hb3r4mgv2PK2yV
         WpJsQO+7scL55rl5AeoMYrtQzXx8h+3xxNBPmEx3r44PaTcLkK8PwK/1fN55/oDVtYc0
         uJtNrC4qJrBUzd7i+5oA5eMwI5uBN8IB+FsZzSz+Anw/+5Z/4FwgjAi7mgQE86XpinHs
         ar+Dx/fFixUkJ+8WwT2nH9UfTCQijErbdyWO74CxmmMvuDPznCrVvkj1KlnjMTsUf2lu
         pyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rhPXyDhk16T9cQpirgZvpFE8v4ScJlSdRM//7AKDErA=;
        b=ZzBuN7mUeYZ1qIJa9V2qCSa6+wNJ2hxfTPGHaj4gZdqlh8WUkPvuMHmlZgN61vnfeW
         N0ZgU6on5M8QupFS+CtikGDvR+t+tHL7z2haR7cEbMMUMCpojneqB3hCmbY0SScSBzQK
         i90mMlyj2Zyw4SZpMwjzu8kANNSHmKQSJOlm0Kzyxhe9A/iravTiRahpFn/y5fpM9r9P
         mJ5GJrxMFQJEVlwEWpDJWbjNlj/+if2+SnbN0iJvvA9UJiZdiWK4AK5XB0eNrgczX+P3
         Nd3elug7pVhuZiOH8fQT06QlHnEZHNaLAObjPDVtB5N5RI7nqJHz5m5qOkrc9W6pmf6Y
         Rh8g==
X-Gm-Message-State: APjAAAXwbz0XpIecJsWWggDoTI/91ZGt9jnaBjidxHih4YQxTbI8W7Cb
        y+AFuVlTenNPuTeVoRIVAH8=
X-Google-Smtp-Source: APXvYqyIujYBfrRFQBMtha5Z7QQcyrhNDwQXxuOqMk7rrzjD1SCTZrC1+AERxoQaFzNzfeYttEF0DQ==
X-Received: by 2002:a63:3dca:: with SMTP id k193mr5755119pga.146.1555704999510;
        Fri, 19 Apr 2019 13:16:39 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n82sm8772558pfi.63.2019.04.19.13.16.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 13:16:38 -0700 (PDT)
Date:   Fri, 19 Apr 2019 13:16:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/50] 4.9.170-stable review
Message-ID: <20190419201637.GA5347@roeck-us.net>
References: <20190418160422.455656724@linuxfoundation.org>
 <20190419193926.GA10320@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419193926.GA10320@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 12:39:26PM -0700, Guenter Roeck wrote:
> On Thu, Apr 18, 2019 at 07:57:11PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.9.170 release.
> > There are 50 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Apr 20 16:03:22 UTC 2019.
> > Anything received after that time might be too late.
> > 
> Build results:
> 	total: 172 pass: 170 fail: 2
> Failed builds: 
> 	i386:tools/perf 
> 	x86_64:tools/perf 

Caused by "tools include: Adopt linux/bits.h". That isn't really
a bug fix, and since it is the last commit in the perf directory
it isn't needed either. Reverting it fixes the problem.

Guenter
