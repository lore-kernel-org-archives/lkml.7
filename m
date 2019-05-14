Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34FFC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 23:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF0F206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 23:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557876390;
	bh=hAH8vKz0SbQIdYNHsX3PVV+sy/lDevsJ/oN8uqEq6yw=;
	h=Subject:To:References:From:Date:In-Reply-To:List-ID:From;
	b=l/C/ozIFSVV+TUvj9I9RpzlJUNoZY+Mq+HKvSsm5x0TXvGAKtkXggxg9yREewjXyk
	 6tdsSYXL+jsJgr7Un3EIs40M1rt8ButtAfV6Rd/TeKg0mFMUNTTIRX6i3lN0TDDXVQ
	 3FatYMoS1GDPBJVyc6lT0/AZB63X84PAGRaDLW3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfENX03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 19:26:29 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37943 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfENX02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 19:26:28 -0400
Received: by mail-it1-f194.google.com with SMTP id i63so1595990ita.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 16:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=hAH8vKz0SbQIdYNHsX3PVV+sy/lDevsJ/oN8uqEq6yw=;
        b=I8ZpdsRXDFIYfpwTIovojf2MqVTACOwVs8NPzhyQ3cT6+XLE6pCDc49kf1DxgNkDcM
         Qxra2yyjtj5UJ6+Oy+FxmLZ4tt9bMzPTyxVqhDWSAqs+48nK/c/+wn9KXSlL5ByTCqI/
         3Oa2/DpHvuerMiZgrzfb1DE9FYEXtBa6MnGzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hAH8vKz0SbQIdYNHsX3PVV+sy/lDevsJ/oN8uqEq6yw=;
        b=rzOFFqqkFbma0zL5pG8PwPJ7hXWiX+v0lH5h/dFmHZbncKhvES5wzmWc5VoD1qsfV1
         JfFYgDZEAIzHGUGJvnjnCWB9YsyzBKV2iogfD+lRIOBog5yZnB25HqF6Z5fk65zC4NTL
         Jxmm76mi1Rz7aXnb9NYIqXrL5kbanhkHPOGpS/vv0ZOFQtxk9bKF6EFjB//t9oj/uf8Q
         lFgcNHiyn3wW3ZpuDBfIJRt2OFf36yGuQthS0YIcEgrcleI/jzMqCNkW8Yo4CCVqfgIh
         hhv2uWn7ellDrJZG9tYuajyC2RStcLrCsxY8dLQc4Wm1BW/o1C7+0CGP5aNsbc3VYsaa
         /m1Q==
X-Gm-Message-State: APjAAAWHy+wiQux8UukpsLH/KpWIACn6vJCZE6Rd59Qg8isAGILdekzm
        H5diFF88pKsjYa1gpWO0lKYjKA==
X-Google-Smtp-Source: APXvYqzz6wjr9rR0dcKYuIVtWRoyozIhVyv4pYB/pl9MYSqdpK8hRSYr6da+BpfHKegAj/ZOi72jzQ==
X-Received: by 2002:a24:5fc2:: with SMTP id r185mr6436229itb.43.1557876387377;
        Tue, 14 May 2019 16:26:27 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s10sm126380iob.29.2019.05.14.16.26.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 16:26:26 -0700 (PDT)
Subject: Re: [PATCH] selftests: pidfd: Create .gitignore to include pidfd_test
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
References: <20190512045711.4507-1-skunberg.kelsey@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f0f3c65d-2b1f-3633-ee18-7d49d18eb7a5@linuxfoundation.org>
Date:   Tue, 14 May 2019 17:26:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190512045711.4507-1-skunberg.kelsey@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kelsey,

On 5/11/19 10:57 PM, Kelsey Skunberg wrote:
> Create /selftests/pidfd/.gitignore which holds the following file name
> created after compiling:

This patch generates the following checkpatch warning.

WARNING: use relative pathname instead of absolute in changelog text
#85:
Create /selftests/drivers/.gitignore which holds the following file name


I fixed it and applied the patch. Please make sure to run checkpatch
before sending patches in the future.

thanks,
-- Shuah
