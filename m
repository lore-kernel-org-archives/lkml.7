Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C22CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C7520663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkv8qqiZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfLQM45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:56:57 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38945 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfLQM44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:56:56 -0500
Received: by mail-pj1-f65.google.com with SMTP id v11so625654pjb.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 04:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=X9/NLTUkChqvclbQ38iR/7hGAt02+C8gSePlUjQQync=;
        b=dkv8qqiZaOVovvRnI3DMw7u2fi2CceV6E/ZiD+WEmz74Soagbo4fldXFD3Ua3Vv2KX
         jTAIQeDSATPVmsI8/I0dGyDc3s1a1hQVsNZYP+YAJIlpM32l+ZV9+ODgC2lGd+bw4R3I
         bWEvzVneJ7tesajNdHGYV1xWTZeFDGWAm/kK143VomWCMQvuJ3oTE1eJqJAg1JZltHbM
         wnK7rVCFL2jWV0JstndDsh5RMEkwE4kQIUnS9voGwuh+549AYC6LFBv4xJjhj9Pa9jyC
         wwonGvIL14DUcWb/iPHZGsAfKp+Z1boFAbCENiWdHQW9QRsl1QT76g46+h9Fv4iIeLU4
         Wkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=X9/NLTUkChqvclbQ38iR/7hGAt02+C8gSePlUjQQync=;
        b=CARiZ8tp2S1B0fG6ugUUuSU9uTbHv0GDvGlmiVcpT91MgXsg5+g6zL9K5fxz+BpzyS
         m8RepWfJPk4hKqaqOwCOvKrg/bPwfydytRrszpdOYB/pZKsYmKqHUxtwgEZsDPRrl2qV
         Vn2yB/TVgebLg5+jEoFes3i4o7BBLppuFv8jvaHrG5YVKAxEs6zvOfaPf+9aWT+wrwaQ
         qKxGFnZjnlOiMJcx2zqhT/exX5dhbNyOKt0/Lz8ZvvhNp4hkvU/kb3Dc7IdOWcWkoU9z
         m+zldnQyyjS0Fo+L6PNqc7aoe1DJByvcSuAYSxi/eo52+QrRcfTzBcT1Xdck0KN1AATM
         sQeQ==
X-Gm-Message-State: APjAAAVg8mOTYkvYm/EU/mFOlDZTzkgS9Nf+WdpkDK7LeJ8Sk6wmEqtP
        IADFTwkg5YTqwGyoYIqPXrQ6HQPKmzc=
X-Google-Smtp-Source: APXvYqw0RkAEXV2858CQpGVKDiwqHaYuSviWh4xOEA6Upc0QTzkadicjMaBY+aA1KAlDoIFzc/Ft5A==
X-Received: by 2002:a17:902:6b09:: with SMTP id o9mr12905855plk.209.1576587415901;
        Tue, 17 Dec 2019 04:56:55 -0800 (PST)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.139.134? ([2402:f000:1:1501:200:5efe:a66f:8b86])
        by smtp.gmail.com with ESMTPSA id 23sm26458702pfj.148.2019.12.17.04.56.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 04:56:54 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] kernel: kcov: a possible sleep-in-atomic-context bug in
 kcov_ioctl()
To:     akpm@linux-foundation.org, ishkamiel@gmail.com,
        rostedt@goodmis.org, dvyukov@google.com,
        andrea.parri@amarulasolutions.com, anders.roxell@linaro.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        elena.reshetova@intel.com, andreyknvl@google.com
Cc:     linux-kernel@vger.kernel.org
Message-ID: <3c4608bc-9c84-d79b-de76-b1a1a2a4fb6d@gmail.com>
Date:   Tue, 17 Dec 2019 20:56:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel may sleep while holding a spinlock.
The function call path (from bottom to top) in Linux 4.19 is:

kernel/kcov.c, 237:
     vfree in kcov_put
kernel/kcov.c, 413:
     kcov_put in kcov_ioctl_locked
kernel/kcov.c, 427:
     kcov_ioctl_locked in kcov_ioctl
kernel/kcov.c, 426:
     spin_lock in kcov_ioctl

vfree() can sleep at runtime.

I am not sure how to properly fix this possible bug, so I only report it.
A possible way is to replace vfree() with kfree(), and replace related 
calls to vmalloc() with kmalloc().

This bug is found by a static analysis tool STCheck written by myself.


Best wishes,
Jia-Ju Bai
