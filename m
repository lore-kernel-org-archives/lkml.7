Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5C5C10F05
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 04:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649F3218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 04:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBRWT19S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfCWEok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 00:44:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46520 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfCWEoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 00:44:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id a22so2811257pgg.13;
        Fri, 22 Mar 2019 21:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2c3rC1YatOrofpWEVpG6Z5VNcSszqOa9TqSsPB7SCIo=;
        b=WBRWT19SbeMza1f7BPBbYTmhW7Qp3GFok0CCYpfZxHQRRKc0sXopuWM0kWULdHZEvT
         67byPAJ3nGXbraDho7F4jXJHpn5cnDPpSaqVXOXLZp4d906akj6VxCXqHnZjtzf9CTai
         BcDQJILsvG9uRrbjSLgWrBx+ie93M24JaBYd+8KxjwdILHkCdPjkDCE26lBu1A/dLPdr
         Oyk0an+OevaGzo/9t9HdW3svAZ51iVZnV9qpxKBVjD9j9VOdt7Dab5mhfH3hOYbyw4VR
         A798VHSM9i7q0Ih8i0tVMXhNgXi4MFsubmYZyuyoldrQFtvU1Ac6jYc2gy93eoD8/QuF
         rv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2c3rC1YatOrofpWEVpG6Z5VNcSszqOa9TqSsPB7SCIo=;
        b=rPJmMTmuiubVY1dstmCVLhljyb59f0sQimDeQ6TXQWAy002rU2l6bklRUUKwg02XYc
         7bLoyl9xKsS5mT98MrI6t7+VxViFH5+9gr7OLYb/CZmJbeGLqadWF4fBJDvs/JjqVfjQ
         IDMdAgX9dEIWfPUMC19+w7UNMvQBYuh1C333en7vmaBNLQ0zkH8e7lAKKqraO2BwpY1O
         YcKpS5xOMELLHTofSrIAYnNFzWXXZuJAzJe4PQUIiceS96nojBFjfVgUMZTJlU1pZeUr
         6dyfNpNfpKh8EgsKheME+sLHgFePU7O0IFbRUgh61YVPlRa1y7VZOfXq3FpaRfFQRpL4
         Uung==
X-Gm-Message-State: APjAAAU/3HhFMOQBvwg45xIOyA+00DfV9bDnhCDxJomAO9bb6zLpOPLy
        n+aEO86J08uV7LkS5BJtsWVWkvxP
X-Google-Smtp-Source: APXvYqwBzygvvR8e+0q9EVh5+yplrrp+hI/nwRLX9o0ZPxjoz7pq0QT77NOtUkXaSnOzl5lcXdr6cA==
X-Received: by 2002:a63:525f:: with SMTP id s31mr11086270pgl.172.1553316278956;
        Fri, 22 Mar 2019 21:44:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p34sm15051684pgb.18.2019.03.22.21.44.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 21:44:38 -0700 (PDT)
Subject: Re: [PATCH 4.9 000/118] 4.9.165-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190322111215.873964544@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8803b6f5-d65d-a380-9699-d2942bcaae52@roeck-us.net>
Date:   Fri, 22 Mar 2019 21:44:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/19 4:14 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.165 release.
> There are 118 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 24 11:11:02 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 316 pass: 316 fail: 0

Guenter
