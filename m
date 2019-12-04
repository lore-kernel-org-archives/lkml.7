Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF0CC2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E612206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImE/3Sdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfLDTFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 14:05:46 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44614 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728788AbfLDTFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:05:46 -0500
Received: by mail-pl1-f193.google.com with SMTP id d19so99853pls.11;
        Wed, 04 Dec 2019 11:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6HO1j0LSIu7hp1mtkRbzUIAnNvF3KRzw30AyAHtxU7Q=;
        b=ImE/3SdhMTA3rHkNRvVOfIzrEt++hra7hOIFslzg54UnDFMA/ZsxRtxBsxA5S3tgl4
         MuJtQchUysVYDHcK8J59XRnsMCy21GSWD6Qyc8fwM+qC7eToMX/Q8AdKZgGDPNnMxJuj
         jqTMmiq3Ui1zaKypUE1lYsuhDeL7MWOQQE/oFizD7tsUxBSELnRSBb10UKpophDopor6
         fdkoWY+TsIG/lirT7g1VjT/wi7P7TUcTcuakCjbhNvro0hF5kx/1jV19wbhUjMGECI10
         6cotTU+srHe88TgKR27NBFKNZvFDe6JBupw9wt9J3d1larjQLxdPzbqSf6WIiOzCqhXP
         0ahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6HO1j0LSIu7hp1mtkRbzUIAnNvF3KRzw30AyAHtxU7Q=;
        b=OQ/L5ZXMip3P5hqOMW1dxWDXNZkxuZqXlW3i4glD/s+Hjx7hQWlTqfySbSmL89IfSN
         hr9ZGKZ88gTldELVH1yZVUM6Qca8/XgWWzhQqZ56MIqqcpYMQxMsnV8n+uDgGsBNYxxE
         4RexAqvptcG7ULI45WelFcgEg+6TdEQwUjJJxFkU0IzfMunpiOT+OUOfIHbkC6SPbWZ5
         ASpz5iUig1kATpqCpPVzqt8vudZEngKVaV7SRiLY2l2DSLyRe3DNA6tZHlffkLSCghYN
         zHDpwkMAKGIDAzVI1+PZFJPYCQ/5gQhB/Zrk0Ue0Qn8YPgp91/UpYGaLoXQkkgU9tGnK
         YNCg==
X-Gm-Message-State: APjAAAUiU40cKtWoAHtN6NT1zBZqXqkF8nOZ77f4JaV8MyDOsiocZwTH
        maSq0XtQvXgGjPGbo34a230=
X-Google-Smtp-Source: APXvYqw+K7p7YnAr911S0o6Kk3LK+HfDuuqjym7W9zwqJ3yzP1I07hjUCcvGNTRAfxa85/UH7N3RPQ==
X-Received: by 2002:a17:902:ba84:: with SMTP id k4mr4791186pls.141.1575486345440;
        Wed, 04 Dec 2019 11:05:45 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f5sm7120278pjp.1.2019.12.04.11.05.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Dec 2019 11:05:44 -0800 (PST)
Date:   Wed, 4 Dec 2019 11:05:43 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.4 00/46] 5.4.2-stable review
Message-ID: <20191204190543.GD11419@roeck-us.net>
References: <20191203212705.175425505@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203212705.175425505@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 11:35:20PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.2 release.
> There are 46 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 05 Dec 2019 21:20:36 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 158 pass: 157 fail: 1
Failed builds:
	mips:allmodconfig
Qemu test results:
	total: 394 pass: 394 fail: 0

No regressions.

Guenter
