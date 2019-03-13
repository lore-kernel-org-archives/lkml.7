Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FADC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31866213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nU9/LjVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfCMUfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:35:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43934 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbfCMUfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:35:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id l11so2321713pgq.10;
        Wed, 13 Mar 2019 13:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xGZc8fZyWf0nRylG1X1awWjyFMerbqwrnWMTdNshOak=;
        b=nU9/LjVc9xgm4BofU7Q9X5oNOEBNkP9mCjOArjwmejmwVsyYQNChsS/v/JbX03V2i9
         amIHe3aAb6v8WIuiIuW11TYZHxge3Nz58mvskb5yRY2P0Qu5AhDFw1FzprbbpBlyNZ9b
         TrEzx2cfxNA3+X5yW1rIVHw0EkLJ5/mppNCBxR16bqsLTNAnAx7V60ClPujorFlFMIhB
         K9UM83lWJCCrQs2+cNk452h+ynkFBGB9cNicOr4QYaRe1k+CEklbQaB3OtY1MthmHdiT
         DZ5DLDYKNEhgAPPyhQrHj0PryfzEJMDDmqBdpNkHv+eveIxvAE6RrYGTAFeWMz6ITix6
         mGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xGZc8fZyWf0nRylG1X1awWjyFMerbqwrnWMTdNshOak=;
        b=Ld+SBpMNwJ4WHYURZvqneqSereUP0nR5/M0MHgtsYHdUrk4KxaGcyMrF/3KLVm7uTs
         vvOiCEdyBIiaeRx/0Ym1j/t0F0V2sdpm1UNqecplr/BSQl0xg36Ti2p1Y+q8olxsLr/v
         F7FGDMYKSJL2KrZrbQ3Wr++wA/k42YjAbmM3kckqPr6d/DzmbfyHjl3nuUx8uthQwhVM
         PXyI19iga67rqu5RLkQn3+9+2jQdIY9OQh5dMfX0mTFCJRlHyT6wpI8t3Yry+QlUCwJb
         h6FXrhxUpUaOuUy9Y7CuJ4iX+XZ0jCuGzA3xfrAQda12n6rmlhsrTj5UUL18mD9psDBY
         DOzg==
X-Gm-Message-State: APjAAAVdpdLd2LvnNd2/27UG1oh6Go/WCATUsOv3Or/fntx5HEpTqdIy
        lG6jAnRtOz7KM70h4Qiz7pk=
X-Google-Smtp-Source: APXvYqyUSGTnJLCbuUGUxeb8NZYgplpj4fJFQJsq0rF8vnc6GvxPh+5iKW6w5g43XQlbJs3/rdd4tA==
X-Received: by 2002:aa7:8b93:: with SMTP id r19mr7693090pfd.163.1552509352968;
        Wed, 13 Mar 2019 13:35:52 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u13sm26946249pfa.169.2019.03.13.13.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 13:35:52 -0700 (PDT)
Date:   Wed, 13 Mar 2019 13:35:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.20 000/171] 4.20.16-stable review
Message-ID: <20190313203551.GD26634@roeck-us.net>
References: <20190312170347.868927101@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 10:06:20AM -0700, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.20.16 release.
> There are 171 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 14 17:02:23 UTC 2019.
> Anything received after that time might be too late.
> 
Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 345 pass: 345 fail: 0

Guenter
