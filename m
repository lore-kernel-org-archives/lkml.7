Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8034BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE5C206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SaLS9lct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbfDDLBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:01:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42181 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728724AbfDDLBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:01:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id r15so1181836pfn.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 04:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AiofSYcx2Wo0nGVEmWQRTw0epNH0tIJ/M9iCe1uC960=;
        b=SaLS9lctLc7dqP4kqVWJKhHVBodBsVopTwUk9XcgU7+rldRYFAbaKtW3Y/HIZyygr5
         MhkJrLcj+glmLOfuAbHcjn6WGtt6BhTAEihcjf4ilQQAJ6upPYRI6JG1YTaGRSS/jFC3
         Z66Bu2Y0/QD/UwzS/0vPRDcXKC5ThQJX1pPJw5eH86reTKkgojfIrmszQJnGxN/jYrHh
         5pg5vpfCVmhjs6sk/+zovbDuqPkWw3whFnVY+YGRU9C/53PdOXDnoFhKKsePSASS17oB
         3nEktYnGhh4geTgmphnyeu/5KqjuWrIv/ItqPfKzTLQvL56WBWX03BW2/SEkXnDaqJXn
         T4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AiofSYcx2Wo0nGVEmWQRTw0epNH0tIJ/M9iCe1uC960=;
        b=t8wmVvsN02FCEGGUyFC/Cq7WVsGjRHhULE/zMssik4Bz18W1Bl+RgRHnDlbG0lUPSu
         LetN4bZfbVGLwLd0mq+G40axrTRSEEcBWYPES3owkSROrp5zEMHQm8rB2kwhwiEFJ4zq
         p1t4nDvPK8EbI4m7IPUpnF1Y49doAoP2tbqxxa6qlcFAjCWY4BZjjkDJhnP1HUkAFg8B
         CkpRQIGHD/Ec/ShYQIhSqJf0zHH5JiFVVSK30tynZWk/aJg/QGSA8mX7sYHKvDNeEP0B
         e1AhXpMQEUHIqqb5628HlCpHGJYhbq1bS5v+QIFY9ikyUmnG4j7lLWrVdiehKf+49yph
         ifTg==
X-Gm-Message-State: APjAAAVs7Cesv4mO1lxLB9mVz08rL//iKjmnv+RxAdaYLjwrcNkQGExt
        vC9e0iaACMC5gYPILIN10ylf8T8TfTg=
X-Google-Smtp-Source: APXvYqzDddbxSPXq2c9RWYIvXMpfy4oGKzf3IIe9R+o6lUsYAE6yoPJoCMDAPqpux4hlv6wK+WaugQ==
X-Received: by 2002:a62:1ac3:: with SMTP id a186mr5245774pfa.48.1554375661031;
        Thu, 04 Apr 2019 04:01:01 -0700 (PDT)
Received: from [10.71.9.192] ([147.50.13.10])
        by smtp.googlemail.com with ESMTPSA id b63sm50718450pfj.54.2019.04.04.04.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 04:01:00 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] nvmem: sunxi-sid: add SID controller support for
 H6
To:     Yangtao Li <tiny.windzz@gmail.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20190402154514.11284-1-tiny.windzz@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <265346db-0039-3a66-2f3a-a4595a42078f@linaro.org>
Date:   Thu, 4 Apr 2019 12:00:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402154514.11284-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/04/2019 16:45, Yangtao Li wrote:
> Add SID support for H6, and do some cleanup.
> For endianness issue, add a new ref_read func.
> 
> Yangtao Li (5):
>    nvmem: sunxi-sid: fix wrong description in kernel doc
>    nvmem: sunxi-sid: add binding for H6's SID controller
>    nvmem: sunxi-sid: convert to SPDX license tags

Applied first 3 patches, please resend last two patches after rebase on 
top of next.

Thanks,
srini
