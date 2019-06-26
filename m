Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B0DC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63ED421670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 17:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RITarLgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfFZRfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 13:35:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46952 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfFZRfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 13:35:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id 81so1704322pfy.13;
        Wed, 26 Jun 2019 10:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+fxDVnTTuhSR5z+Ysh8XFIy+I0e6r/dC96Y+BNXbBxY=;
        b=RITarLgPOjvPDpxBVBKBO5Qv06uP9/z27lsnMBsV4xg0nWX5yTi+Pqx5dGNFtkZkpV
         isuqxftRPm+MB+jxCwND+t93qBttG74hcPUNdkBFVZFZK7wo0sOekSD1VxwgEBw0bTmg
         OXMfXVv0qU45EJAooW6dVrF1qi3QoCs8gBM/qr1TJK0iR5VfZzruKxx47mYjriRUhQUn
         e3UP42aZFpVyqwtpUh/QWLxnf5I0odKL09GTqy93AtN98d9u/DAcQEQPfRxCsHFy+smg
         B3tTuouoezT0u21sL8sHvQdGpqAsJBsGc76gZFw94V+1pLaPTVmxlDATYSwhS03F47Xx
         SfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+fxDVnTTuhSR5z+Ysh8XFIy+I0e6r/dC96Y+BNXbBxY=;
        b=sGXShh168m8apZj/wnBvhv6IzBCfuBR1dHwpHRvTm9GgaPWWwJmCThdyVAKrhB82Tg
         hTKwwSDE3MLqGsaEscdHB8976UWZN3863j7fka2wP8PhAIFmR40spTpjtku2yClEBvNm
         RG6UBm0/oBwbF1KnjPVCCmaGyrMn0j2adqgqkCk99RwJPtpOuFp1CfUMB9c4NP8l18qE
         ReimjHA4YhmDJm5Iakn5zk2YwYcvbFhEh9DIPWtKlJU7mmc+dsnZGAUpehW0V+cvvUFT
         UKEl35IvBr3WmFuYCJS/1Vs5+3Me3YGJKgTj9NNNRcJ+7yjtb5lz3rmtuu6un09XwRUj
         L9Rg==
X-Gm-Message-State: APjAAAWsPRXXvqNEXzBQqnPDhHFSbQgLOzx89j+qBybpnJ6BYhfjRZ6j
        ZFQIn94jx+PSEs4B82QVgeE=
X-Google-Smtp-Source: APXvYqwuYu/ApwFxA2dbvbqkSN8S9Eo6YqrEOEnApB2SAylzCWpRRl1SwGVlZ+idrNnKuc5veRQxrw==
X-Received: by 2002:a63:1723:: with SMTP id x35mr3985134pgl.233.1561570553732;
        Wed, 26 Jun 2019 10:35:53 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y11sm20307207pfb.119.2019.06.26.10.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 10:35:52 -0700 (PDT)
Date:   Wed, 26 Jun 2019 10:35:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 0/1] 4.4.184-stable review
Message-ID: <20190626173551.GA2530@roeck-us.net>
References: <20190626083604.894288021@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626083604.894288021@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 04:45:04PM +0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.184 release.
> There are 1 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri 28 Jun 2019 08:35:42 AM UTC.
> Anything received after that time might be too late.
> 

Build results:
	total: 170 pass: 170 fail: 0
Qemu test results:
	total: 307 pass: 307 fail: 0

Guenter
