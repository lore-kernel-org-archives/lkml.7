Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFF6C4646B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 00:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D76205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 00:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHhGT9F1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfFYAPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 20:15:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43035 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbfFYAPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 20:15:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so8412227pfg.10;
        Mon, 24 Jun 2019 17:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EU8WFDmhHgtaBQ2SUJhJWTVAXwevn93OKXGEhrS/B44=;
        b=mHhGT9F1POSxJjgSSQrVWYtDWRfeB5ve9eOpiY/LBNsI6+oLuSglTITPKt06Hjv8p6
         pQ66GBvZctpsYhDFYG3MCsP7/bH0GJ9qAQDGOZUJrLui6F8h/2AtWsJieNyiJFXiOH2N
         XB6wmS+DS8j5L9DCvUfyccPiGbJ6MZa+PHMXPeiF4pGx1+ttTvlmZeKnPuPLrC5izVxI
         pP2OKpt8j5t3fdbewzG0/Glnhuj++U2bKobFTtXBeaRnICO5ZfGHQamtcMWtW5zuNNB2
         g3dtEjt1HW/b/Sra+0NngEIytar0RyWXzxR6fszSZFSXMbGW+TB3ej8AfAAuHSqRmEzq
         //3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EU8WFDmhHgtaBQ2SUJhJWTVAXwevn93OKXGEhrS/B44=;
        b=r5xakB+0hXE4L1ukJNiXd/yw+1BPkacx69OdSUDbkgZigL8FiE4EtqUBb//DMTBGvA
         n4/Y/W7y8vclZSSUKEmhfVQgq25YlHtpv8Q1rJZC/9vfIGCso41eL0Z78a+HFk2i0rf3
         +cJSkgedace1jy52IQiwMKs8JPBC25On2cXAZ2+rNpppx2MbIl306vVI7jvQV56QtEV5
         0G5GwHJ3hV89QWIgPNr984T5tmIQQBmUTHtnFT/GuqT4/xIggOQQEu0uhMhpz24mJ/Vw
         +RRhDdpOh4uMkcZCNQWfCvBHf5f8E08nFSOG27hxi+st8HvQC2nKmPAcyUO5H7IowvRI
         mICw==
X-Gm-Message-State: APjAAAWHDEvoUw0tZ5GNIq6EaDm5850v7RWi3jb2NMC6pXdgYNwJgtmB
        5jbGeAbdFHOnLviDfWgYqvwrwjhZ
X-Google-Smtp-Source: APXvYqw35rmzEA/jxzulA7c+cANRY6Ozz8Oa+7HibJBBNaeJJm4eyOeTaGjkl0/0Y+BOQtQ/nlvXDg==
X-Received: by 2002:a17:90a:206a:: with SMTP id n97mr28150047pjc.10.1561421742982;
        Mon, 24 Jun 2019 17:15:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k3sm11548789pgo.81.2019.06.24.17.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 17:15:42 -0700 (PDT)
Subject: Re: [PATCH 5.1 000/121] 5.1.15-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190624092320.652599624@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <cce74c67-5844-a60e-8fbc-9ebb29bef826@roeck-us.net>
Date:   Mon, 24 Jun 2019 17:15:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190624092320.652599624@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/19 2:55 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.1.15 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed 26 Jun 2019 09:22:03 AM UTC.
> Anything received after that time might be too late.
> 

For v5.1.14-122-g815c105311e8:

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 364 pass: 364 fail: 0

Guenter
