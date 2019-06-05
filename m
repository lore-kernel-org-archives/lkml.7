Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CADC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F84820866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 22:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5egHtFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfFEWuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 18:50:32 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34130 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfFEWuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 18:50:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id c85so226542pfc.1;
        Wed, 05 Jun 2019 15:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KMuON6ySTEg+6H8pjxUj9BRC+sz/zQmc78T/LjVwpwI=;
        b=U5egHtFbaiocbs3pYMcH0MmDFlh9y6KTcGG6ImA3Q+zF7l8oM3qMVbSFSHxYc1cZnK
         jLGUqfckTXuVZPawQhH25E9XphZN5dQUcTmrGmyoAznOnp8WoBauB10ZczhoaxeP7MqH
         Kqp04KGheNPWF9nO9J2N8mU+7ym09YnQT+DKNw7rwu1qAEn/SoGKum+BKMhpWUy1PwZm
         CpBG/cFqyQkN8faOUpHzFkvlno0PwuUbCs4ujJ5Oc7S19yCNqdhzR1dtHwEa/SVCVzYY
         +VcxcBGabxtoD6GATbL9th/xO6cD/EBwWRKxjWRezTlFqNcXRdrE58lJcCzqS92ejnpJ
         l5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KMuON6ySTEg+6H8pjxUj9BRC+sz/zQmc78T/LjVwpwI=;
        b=fd/7n8OlrqlrrKgShINxJpEsBCb6N1qPZhvQ/WfkcVdKwqriNnN9HlAxKBiKFG78PQ
         2ncQMIfUwpe0PUigSvOT9gJz6xKQCyyeQiFvnFcBBkFp1ryFtiiMRpFw5AwY9irdKFPK
         js4DRb9pTqv2KJ31fLly4GJyTnIPVN9TrDBxPLsbieAUoZW1JXnu3qCHeZcuw1eyPKaY
         7opIoDM/QTW9Z0zF6oLJYi/JYPLwtzkdLOKznndg8PVUYpSpvh1Wd/WRUnSz20CgUdf7
         htvGP6+8d1Q7yjXIlBD7z6RrxlyTCHhJyIywzqEGvHEZg+mX3EZcnNiiaq97qdOXoylm
         MC7g==
X-Gm-Message-State: APjAAAVBrid+HlkBtVkq5lGRmykpTgZphEOEVGKMf42RmfhY71AkZBpk
        GKyYeP7ln9Glr13jEeUsps4=
X-Google-Smtp-Source: APXvYqyJKSDf9If2v0FN+9QJmJeZjfb25cz+w6IeTgX9t4FWSZjYzweyUXyZd0jJnZRICVaxXN+dLg==
X-Received: by 2002:aa7:804c:: with SMTP id y12mr48646968pfm.94.1559775031702;
        Wed, 05 Jun 2019 15:50:31 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e66sm18147pfe.50.2019.06.05.15.50.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 15:50:30 -0700 (PDT)
Date:   Wed, 5 Jun 2019 15:50:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>
Subject: Re: linux-next: build failure after merge of the hwmon-fixes tree
Message-ID: <20190605225029.GA25183@roeck-us.net>
References: <20190606083034.196219f0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606083034.196219f0@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 08:30:34AM +1000, Stephen Rothwell wrote:
> Hi Guenter,
> 
> After merging the hwmon-fixes tree, today's linux-next build
> (x86_64 allmodconfig) failed like this:
> 
> In file included from include/linux/notifier.h:14,
>                  from arch/x86/include/asm/uprobes.h:13,
>                  from include/linux/uprobes.h:49,
>                  from include/linux/mm_types.h:14,
>                  from include/linux/mmzone.h:21,
>                  from include/linux/gfp.h:6,
>                  from include/linux/xarray.h:14,
>                  from include/linux/radix-tree.h:18,
>                  from include/linux/fs.h:15,
>                  from include/linux/debugfs.h:15,
>                  from drivers/hwmon/pmbus/pmbus_core.c:9:
> drivers/hwmon/pmbus/pmbus_core.c: In function 'pmbus_set_samples':
> drivers/hwmon/pmbus/pmbus_core.c:1975:14: error: 'data' undeclared (first use in this function); did you mean '_data'?
>   mutex_lock(&data->update_lock);
>               ^~~~
> include/linux/mutex.h:166:44: note: in definition of macro 'mutex_lock'
>  #define mutex_lock(lock) mutex_lock_nested(lock, 0)
>                                             ^~~~
> drivers/hwmon/pmbus/pmbus_core.c:1975:14: note: each undeclared identifier is reported only once for each function it appears in
>   mutex_lock(&data->update_lock);
>               ^~~~
> include/linux/mutex.h:166:44: note: in definition of macro 'mutex_lock'
>  #define mutex_lock(lock) mutex_lock_nested(lock, 0)
>                                             ^~~~
> 
> Caused by commit
> 
>   8d719d6f3e97 ("hwmon: (pmbus/core) mutex_lock write in pmbus_set_samples")
> 

Fixed. Thanks for the note, and sorry for the trouble.

Guenter

> I have reverted that commit for today.
> 
> -- 
> Cheers,
> Stephen Rothwell


