Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E90C04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 13:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE332177B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 13:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pidxJWcA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfEJNfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 09:35:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34547 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbfEJNfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 09:35:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id n19so3263013pfa.1;
        Fri, 10 May 2019 06:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NeNu8Mh7m3IwlBWHTASYpgap+Vz3CokQRpxTPJVez9A=;
        b=pidxJWcAHrSMI+Vbg/OJOssb+COYpqWOZ2r+xJlE/QH6jSkaZdLkdiBDiWwIJCWh1b
         aJFtDn+xdRc8jxQIMJclrDU3k421V2/WFUPPYMJ/gJQAiVlnFpSGt3DhtGrKtenisyzx
         OVUOuZtg+8ZqduxPvXBj4RTj0Rr/ZNE08QIMF33CXO7pMIbAnlyQWV4WaQO948p/EFl2
         YUmMLi4xL+j1QeSqJ68fzIzbDCOCnwtVQCE1gxA1QL+goUO8zsHcsFlXOA40UoagCz5O
         xzEjq6TETomhX7YZ4NcQ6h8pQEpw7E+IzfSrNXK7r9yb7jbVPXGBb5lu+a9bwqKXWJ41
         1FhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NeNu8Mh7m3IwlBWHTASYpgap+Vz3CokQRpxTPJVez9A=;
        b=iAWFCoihfsG4vc+30UPf7JQ9W1H6miYrkDDVo08FC++6UK8jIWcxRLLj1+VBRzjp9E
         paosui0tNNEinHBDHAziyzchgQ57j81mTnaiqphkwU7zlmDYJvhcUofBUMfTz/1Ca2Vp
         xZSF4qvYccqDZb0qh3GrMmTXT9aJUju00WLrx3Htze0vkWbX64PQE/KHTYb56RVpxBRh
         NLvXaSnK+lyD6uw1eGNXU4C1bHNvuTgxWI0oWFKWuNuKnXBOYlix7Z7c27tyeC8FnQEF
         ANR3b9ZnoiiEIOkKMqHnh0vG67XC51KyMmYv0kRtbFj54Pq6rEw0g4eu47HEeUqVGwKS
         0Nfw==
X-Gm-Message-State: APjAAAXO60EesCQ4ALQk0xXV6aUMl1tiZWLdDGkZEbvG41JIjG9vo/yO
        kYFU1WWDbhym8Uq3bhxk9rCf34+a
X-Google-Smtp-Source: APXvYqxhvSqABDA+3TmcpPDZrct95zdQSQd37539HYOmWh6zQ1tCrsANnnx1DQvdX30myse+WLSrUg==
X-Received: by 2002:a63:1b65:: with SMTP id b37mr13766278pgm.408.1557495322970;
        Fri, 10 May 2019 06:35:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j189sm13673266pfc.72.2019.05.10.06.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 06:35:22 -0700 (PDT)
Subject: Re: [PATCH 4.14 00/42] 4.14.118-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190509181252.616018683@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <809367e0-ad95-e764-dca2-59932961bf6f@roeck-us.net>
Date:   Fri, 10 May 2019 06:35:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509181252.616018683@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/19 11:41 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.118 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 11 May 2019 06:11:15 PM UTC.
> Anything received after that time might be too late.
> 


Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 333 pass: 333 fail: 0

Guenter
