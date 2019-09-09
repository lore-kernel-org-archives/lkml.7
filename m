Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A362C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B4321924
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwJjRoh9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732244AbfIIOt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:49:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34851 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfIIOt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:49:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id s17so1719452plp.2;
        Mon, 09 Sep 2019 07:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3y2rn1zyYl3FAzWIcsCn6DEvZ0xQkk0FsNB4R1a2HOw=;
        b=XwJjRoh9E/RUaa4qCLH3rbaGZRWHbDc/KFU/JrUWV//td152t+F73t2nwGNVdJZm2O
         cCZ8egvY4KSPgtOdn4XIRI4zUWnkjy6XPQrfdXLSATIxgi1nogfDoAqfX3GURa+DeeD9
         Q3OGNGJ6k+bfQ+LSm+CLuno0YNBfG5CFTNQOf3eJy+jFWacEwu+7sUxokj+NOn5l6fNV
         wVOkSxvrj6a1RgJGdPW3KRap4F1nm13jcQ+gTU9O06DhsaEksAwBatiulez6ox/83H92
         j+VC4bqYzYrTKjxPmqKlRY6VxYLkv90NJClgiRDrAA5zs4/avmZELIuP4VQIYYm0kvU8
         DDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3y2rn1zyYl3FAzWIcsCn6DEvZ0xQkk0FsNB4R1a2HOw=;
        b=aaOHn8XZYE6xiq3MCOuH18w4Z4r4WWBX1jdbkgocYTVb1rIqIucLw2IUflvNihgMAi
         5SEIgHqBI4K+W/Dh4XJPFbQKrNIQ7OypJ9PljYlEANz1SmNaiAQDaOESCIIpVOTSe7sB
         pth59lJ+zfc65AL/DfgO4eq+MdNVRnVMja+8wLFrxS8frFL2QXYoqvi32JS3ZDqOP1le
         3V1KHWtQdVWx5eJ29d0RaI+7JPAeALcehSNAUO1V4Uyc0bFNdbxjJxOe1x6BvIrZNkIX
         Vta4G3FIZfQzgpHGBH+XeI1BD06HKUQ4nZDDtrYvHld14JEOSfit8jPiAqTKfkfvvjeL
         /YTw==
X-Gm-Message-State: APjAAAV8x0pZFa0Jh1n8BU00lGrmMFXalire4g6FJBDjNk+Iy5tWPapk
        vqTxQpl46RLVZoCKyOO5Tv0us2Sj
X-Google-Smtp-Source: APXvYqyQO2M6f4W8nkWG7T9ispMHkiaf0n2J3WzeCK4h3KvYYnftlV0gnMI6eDaOyjXw5JaM4bSV9g==
X-Received: by 2002:a17:902:9a88:: with SMTP id w8mr9795242plp.95.1568040597460;
        Mon, 09 Sep 2019 07:49:57 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.34])
        by smtp.gmail.com with ESMTPSA id u2sm3783951pgp.66.2019.09.09.07.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 07:49:56 -0700 (PDT)
Date:   Mon, 9 Sep 2019 20:19:49 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/23] 4.4.192-stable review
Message-ID: <20190909144949.GB4050@bharath12345-Inspiron-5559>
References: <20190908121052.898169328@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190908121052.898169328@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Built and booted on my x86 machine. No dmesg regressions found.

Thank you
Bharath
