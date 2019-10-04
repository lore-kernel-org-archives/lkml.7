Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C009BC4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93AF4222C8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 23:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPFToJxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbfJDXEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 19:04:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45029 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDXEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 19:04:49 -0400
Received: by mail-pl1-f194.google.com with SMTP id q15so3785179pll.11;
        Fri, 04 Oct 2019 16:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kvd3XdYJPJrKC2G6yGhfQQL9FmHqdszl8zXKtlM+7ng=;
        b=DPFToJxzZHro0CdJfIv0rC8EqRDrC8wiUxrqKYuc9t4ZAgEw9w8pPu3XhcOZLGYVW6
         lP2GYgW6UUaYxSB43yLDEms7al1s60XRc+efegwCFsSkxmOrumKo9HRC0QBJxyHWUybR
         28xlOk65Obh+YxVT5tyCC81bMVuUEY1MOX94BS8lJDRR0gmpK7air6YALty/03P9UHfC
         CgFww4iJJkEQeSbjlp2K1gvKrn4483de9luviS0vaYSdYWUfGR5nUJeBrWuZRDMQVKph
         B4G0BHVyfVfRt4Gw7LsJPQNuTpLDSOP/h2KgLcNAwMddLmLIvHRMHl5M8YCPVr40uxek
         jR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kvd3XdYJPJrKC2G6yGhfQQL9FmHqdszl8zXKtlM+7ng=;
        b=OPeDw2q03t7yxXryzYqwJ79ek7DUW0JxxMDiVGvUSQ6VCrQT2OsW/PeGK761KAjcE+
         cecbYdIc4XXS69+7S2dNSGaYKJ9U7R4BnaegbYJznyae6OsUukRjruCC/smFUIw5o5zW
         M7ce1Uu7CWJzH+ZPiBOegcZymv4hCjjxfBz59lm05bDRaH/kNPmWl/nKJqEqXAYnrX2l
         SVsVj5VCgtRm/WbF6dxabhG0Zk2AfufTIst5u26ebIbeqQ3d1yoSc8lROYd0ZThqR75x
         Pb1utfgUYo9SlzAMsIA6wJLc9PM+benpwqUl1HqCiUWsxD3GBWZUvHDVKZJAemqYDB5M
         +c0g==
X-Gm-Message-State: APjAAAW21EKxNrRGLLg82sxKQT+u4To25ujDDZYljsZjPCoGin0n6Lck
        08Of4d0qjkqbonnnLQ7uxpw=
X-Google-Smtp-Source: APXvYqxB7nPcHOHVq5/0E6waszXWxeOGjT1ULaCIy9iCXxYTfVLhgR08DzXoI4O02oGYvKN/UipnRw==
X-Received: by 2002:a17:902:6ac8:: with SMTP id i8mr17171956plt.22.1570230288902;
        Fri, 04 Oct 2019 16:04:48 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o9sm7400816pfp.67.2019.10.04.16.04.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Oct 2019 16:04:48 -0700 (PDT)
Date:   Fri, 4 Oct 2019 16:04:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.3 000/344] 5.3.4-stable review
Message-ID: <20191004230447.GA15860@roeck-us.net>
References: <20191003154540.062170222@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 05:49:25PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.3.4 release.
> There are 344 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat 05 Oct 2019 03:37:47 PM UTC.
> Anything received after that time might be too late.
> 

Build results:
	total: 158 pass: 158 fail: 0
Qemu test results:
	total: 391 pass: 391 fail: 0

Guenter
