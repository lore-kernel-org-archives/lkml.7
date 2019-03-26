Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA71C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A102070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgMrT2JV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732277AbfCZRsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:48:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43517 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731940AbfCZRsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:48:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id z9so2308586pgu.10;
        Tue, 26 Mar 2019 10:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hiHpwcnZN0gMMNWYHFFaH+VeNFbN7ISATTVVlVcE4RE=;
        b=rgMrT2JV1UnCj6YvmolnNrqD1xWFsHc4iyRl/5eOyBHImfh04gMdr/OPz47qoBNxck
         Pdvf+KpcR3f/34zQbVKBVh8r4GNAOWkhwRhCciCqTGBaL9IuAY/KAhZZhq5tmbqBc0vV
         IQGVj8Gt+3TZ/lfoJ4QgwysB0DMgxO649bwhdGSjNbHFkcpC8MFmCXRXl/3AFvO/AhFr
         d4udWpQPCf7BrEtw832w444CfhOkBcN9E/D52Uz/zzWqqgcbtczsbdXgMx306egE2glH
         7R6qlKQPCpefhy31LoXssf+0Gs08Nx9EonQ35LD5fQa0FFem4AMyk/9lCsZyT315CiUZ
         N01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hiHpwcnZN0gMMNWYHFFaH+VeNFbN7ISATTVVlVcE4RE=;
        b=I5SXR6osewEL++eFCO/3IIUa5f9mbVz3oyWG+Xqi68z3IogjgeLd0UW7YeDa8Cjfjo
         HfllUCD/1qNUUvM7XcRrlzWGAPn0OxkzAxvoQmzhnFZxMZaOhfHUQ0yHxg5k8T8uMLHL
         oHpj+/AO07DtEC7vV61gkvQgKJLymr0Q+JQu+2Np68JzrzLrgJu4QpvzXEbfRTF5c5IW
         TaTHHRdb0/AyQe3Y3+VuCt2e7mK13yagF/NPUiOZ5ZOPczgXqiIz+wIhvm6gwJRKvbZQ
         s2kweVOvLV0YjYCmDDBbZKgAb4GTAupx8Lo3SdYSRC+Jf2xg6MQgsYz3wOkLqCj6Xa95
         MP0A==
X-Gm-Message-State: APjAAAXjeBEy6yRWxn5rr6CRhIGmQyKJlLjktaBYU/WD5efjlHIwQF9J
        0ZNPFaj4bMNB9WM8nyowiezocL56
X-Google-Smtp-Source: APXvYqzd8MYaCFIhbuROvov3RCVae6RRXrjQ+fw689OV1sH8nu1JXAx9PBSHpqhR6hC8qmKqhyJboQ==
X-Received: by 2002:a63:9246:: with SMTP id s6mr30440364pgn.316.1553622492379;
        Tue, 26 Mar 2019 10:48:12 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 138sm40838067pfz.18.2019.03.26.10.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 10:48:11 -0700 (PDT)
Date:   Tue, 26 Mar 2019 10:48:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/30] 4.9.166-stable review
Message-ID: <20190326174810.GA9916@roeck-us.net>
References: <20190326042607.558087893@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326042607.558087893@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 03:29:39PM +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.166 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 28 04:25:51 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 316 pass: 316 fail: 0

Guenter
