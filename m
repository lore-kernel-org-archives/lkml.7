Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEABC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2572084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YSqx2orv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfDAVoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:44:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37990 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfDAVoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:44:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so5424683pgl.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 14:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J/rgIXbeVfFpp6tKhHvFuKSACeL4zl4ndsKmtbE3iYk=;
        b=YSqx2orv1wQndr9zgl54ZML4zR/394knjgnMUBWGcxRSYnWjWn4ADo5bRO0rgXPwHL
         rOLlUO8xjpH8PK2/LBBl0+vlA1l6TIlOqrXWAyN2O+aTn4Agee8QnJaF7h0JfL/c5YeA
         wIsCI8wW6ZIFa4rIm33ib/rFujh9fcbMw0LUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J/rgIXbeVfFpp6tKhHvFuKSACeL4zl4ndsKmtbE3iYk=;
        b=NQQxXfLBsbLXlJ9mfT5oYvxqzCLhTJmT0DlYx8bJoAoTFtmH8yRQzLvKez89OnBKUj
         otaMjaHdMlNlR8c9ikJi7BVKRt1caOMQGH3pj+XaRxK9L/XjpgpIuJziyqX4WE5M/OjH
         i4lCPlEB5DuDyrdfjVItqMN+xBlyD3P/TtEPjJJymm2aj4Eo6iRBnbqLWQj+n0kwlz5q
         7hpOD5Nvsb9mGEXwbOYk71KndmGJg5T64bYESio/i1DQGrfzeQvVv6IkldUUY/N77Uy0
         PCDylj5zDHfrli7kgk1IM97J0B1qcIik4f6i9ds9M05RwlTNw1bo45V/g7WqzkOx8u/h
         V0Hg==
X-Gm-Message-State: APjAAAU0ONpKBpUSYkpm/bTNjuCbUN4T27vpInSXbLyCixb81aPkgnrD
        EzVlTyal1SYODlyeg1MCs2oxVA==
X-Google-Smtp-Source: APXvYqwBsyS9Rhw8cIltbMqPzZt4fdZOI3F+StNoC3MG8lX6C00SjN3nqVbooZzMW1C21DAi/dNIhQ==
X-Received: by 2002:a63:ff26:: with SMTP id k38mr30529895pgi.123.1554155051952;
        Mon, 01 Apr 2019 14:44:11 -0700 (PDT)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id o68sm31397108pfi.140.2019.04.01.14.44.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 14:44:11 -0700 (PDT)
Subject: Re: [PATCH v5 0/8] iProc I2C slave mode and NIC mode
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
References: <20190214175725.60462-1-ray.jui@broadcom.com>
 <20190327222712.GD15396@kunai>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <c6d1e148-fe2b-9c50-10e1-3052fd971361@broadcom.com>
Date:   Mon, 1 Apr 2019 14:44:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190327222712.GD15396@kunai>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/2019 3:27 PM, Wolfram Sang wrote:
> On Thu, Feb 14, 2019 at 09:57:17AM -0800, Ray Jui wrote:
>> This patch series adds the following support to the iProc I2C driver:
>> - Increase maximum read transfer size to 255 bytes
>> - I2C slave mode
>> - Polling mode
>> - NIC I2C mode
>>
>> This patch series is based on kernel v5.0-rc3 and available at:
>> https://github.com/Broadcom/arm64-linux.git
> 
> So, I had a high level look at these patches and made a few comments. For
> the details, I trust you (being the maintainer :))
> 

Thanks for the feedback, Wolfram. We'll reply and address your comments.

Ray
