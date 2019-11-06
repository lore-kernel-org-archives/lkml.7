Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B39C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 07:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E7B2173E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 07:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="WAw9vU4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbfKFHoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 02:44:37 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39950 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731553AbfKFHoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 02:44:37 -0500
Received: by mail-lj1-f193.google.com with SMTP id q2so18352987ljg.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 23:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GQiDbpJ2lWoQjxogiLC76wvVDvALWHHs4GpRXuiccOI=;
        b=WAw9vU4JDVSEM4/tX3dXF8lllf4N+YzqBd5KUQ8snC5w5eDIIZ+umT4kLbyVnFM++0
         ZB8hLVMoITJnSq1rOsxgeKtkROl/uFH9ESV8xVpi8yb698FGYQmgutU67Wm0q//x2Bsj
         SZ/Bk5cn1mPajr330aCYxLLHJQpMBwRD7lKS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GQiDbpJ2lWoQjxogiLC76wvVDvALWHHs4GpRXuiccOI=;
        b=gGbgq83uBcvYw8mhVfOzd2HgI90WxYZDE5QU5Mg96JtVkgvexpA5gUu0jY16YX3GPJ
         6obA8IGvV9SuvooGOrOUEUf5X73uCI/Qd0pzTrdU0bszwhmChMGAasiY9tPlzQarxq+C
         ws7v8r+F3dLcRz37GkkbPexu2zRkI+qTW0LvRZx3AuFIg8Cp0kBssOWrcj8tFiOWug8E
         vcFL8Mn7sKeo32aJyRLI3Ga/N7Ow1q7AOw/jGuNtxw/rMAsQ1IFxCX01Xa49IIQQQLtH
         xuAI6g7+tyfpx3VnhFgHxyt2NESeNzPoidbTmrpxHpCWLWCbBzgIe/ihuKKdZUzw21Dv
         rQQQ==
X-Gm-Message-State: APjAAAXdhk0wrSuToSwuVxmdLYo85bv59MrVu1KJfGh5ZWw+RWckL+pX
        wiQ8jaG3odmE7NOyuDq26bNsjA==
X-Google-Smtp-Source: APXvYqw8lqO4bBk2ADhwLIclnOcuGlmrYsbeOu9P1od+oauKtzslw1xjfudWN5y+gXx9dri9uatmXA==
X-Received: by 2002:a2e:6a19:: with SMTP id f25mr798316ljc.147.1573026274938;
        Tue, 05 Nov 2019 23:44:34 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id t16sm8449870ljc.106.2019.11.05.23.44.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 23:44:34 -0800 (PST)
Subject: Re: [PATCH] watchdog: make nowayout sysfs file writable
To:     kbuild test robot <lkp@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     kbuild-all@lists.01.org, Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20191105123125.25985-1-linux@rasmusvillemoes.dk>
 <201911060551.VIFgN8pe%lkp@intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <fdc909d7-bf73-740e-0da0-1aad41806734@rasmusvillemoes.dk>
Date:   Wed, 6 Nov 2019 08:44:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <201911060551.VIFgN8pe%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2019 22.16, kbuild test robot wrote:

>    In file included from include/linux/mutex.h:14:0,
>                     from include/linux/kernfs.h:12,
>                     from include/linux/sysfs.h:16,
>                     from include/linux/kobject.h:20,
>                     from include/linux/cdev.h:5,
>                     from drivers/watchdog/watchdog_dev.c:31:
>    drivers/watchdog/watchdog_dev.c: In function 'nowayout_store':
>>> arch/ia64/include/asm/current.h:16:19: error: expected identifier or '(' before 'struct'
>     #define current ((struct task_struct *) ia64_getreg(_IA64_REG_TP))
>                       ^
>    drivers/watchdog/watchdog_dev.c:460:22: note: in expansion of macro 'current'
>      unsigned int value, current;
>                          ^~~~~~~

:facecpalm:

And it happened to work just fine in my test because I was targeting
ppc32 where unlike most other arches, current is not a macro but a
(more-or-less) ordinary global declaration

register struct task_struct *current asm ("r2");

Oh well, already fixed in v2 which dropped current for other reasons.

Rasmus
