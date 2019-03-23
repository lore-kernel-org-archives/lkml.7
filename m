Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61585C10F05
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 04:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D99F218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 04:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QX/utyXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfCWErs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 00:47:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35557 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfCWErr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 00:47:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id t21so2861475pfe.2;
        Fri, 22 Mar 2019 21:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=st/EIykFNs9gY/UToqq0D79E7Jyfge3X1URy/Y3OEAc=;
        b=QX/utyXam3tHE5IBaluqUp5G+iko9yyNvXsxPTJsJ5L6aSyvUNEo7RDTDZxUzZLjjG
         bGvwoGDufkjxsRbiuDHDArSZWoupLoVtr86XB4DlbldoSU5UxrGvK7rG4HsRIwzUXEgZ
         feN+hjoEbnLM2OjNYN39nFWnHhetgmsLKkSBmGzjOnXxVPTkITZnEPlGI9U1aIyprUu3
         RirvbQKEJ+cuwCevV+p7Y12cvI2POSoIbC/Ua7IOl/aDM18zmXtXQRv9yhDlDda03JcX
         ix40NPnKbjx6kOTXP7sPMjGrgX2ei9vjEfRvA7aPmxTebzkrrm6/VwCnnWj8fGD3Vuq5
         HX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=st/EIykFNs9gY/UToqq0D79E7Jyfge3X1URy/Y3OEAc=;
        b=fEXMFt9Wzg+PCj/FnLmrVWH8F8S1Anz5Rfgo6/0PKEs4bodL1ldOd/Pa/UKxzaGY19
         7u3XznntPvSmKGNF/FQNKTsd+XsWuOs4UD9rAo+4hZRYHNLwSjIyOrUGlxumaiJ3v+dU
         thPSrCvHJOLrec1qDlDARylGLvwwFUUnOvP6ERyKWOXF5DN2iTifBRmJoLW0fElJ8Nlq
         YrEm2ZZzi2D6ZKxDJstKCE3znoKzO4urB46Ac4OEqh1nl2OC5QP8YVtG27HeYAjZKEzs
         qWCYsp7IpVYEUypI59ZB9FOc+x4nmYRcrdDuC8hyT/eWyanxCJRGnI9Fq2ETxLfzfIC3
         IvhA==
X-Gm-Message-State: APjAAAX/MxuJWFVciYgel1C8hTWsmR6wxv9cJNCGm2DyiP69RqqFaVhR
        QKBXaByrlVcZQg8I2lltg3DtryaP
X-Google-Smtp-Source: APXvYqzz33GHfOTrBY3tDPKeSEw8zuW4rDr1W2DX0zjA3mO9JkI7yF/ph9Cl0Ky7lcJZg0YNf0HzZw==
X-Received: by 2002:a63:441b:: with SMTP id r27mr12042778pga.36.1553316466901;
        Fri, 22 Mar 2019 21:47:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h4sm781862pfo.119.2019.03.22.21.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 21:47:46 -0700 (PDT)
Subject: Re: [PATCH 5.0 000/238] 5.0.4-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190322111258.383569278@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <fba31581-44a9-661c-5f65-9474c376e567@roeck-us.net>
Date:   Fri, 22 Mar 2019 21:47:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/19 4:13 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.0.4 release.
> There are 238 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 24 11:11:13 UTC 2019.
> Anything received after that time might be too late.
> 
Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 345 pass: 345 fail: 0

Guenter
