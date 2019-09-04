Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4EEC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18E922CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="H69Yl7Md"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbfIDOUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 10:20:44 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33128 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729993AbfIDOUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:20:44 -0400
Received: by mail-qt1-f195.google.com with SMTP id r5so19315230qtd.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 07:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FqKo9AIGflfwe+nTOQbNK48Ono8rjC9vrryTFd757pg=;
        b=H69Yl7MdXX1X8aGR/Rpg8MdYTCNSKGXy9pVbcMfXsr7L2a0aDmcpaeHqy4GNr7NOsA
         Jw3APKJnYiiHhamaHUMB7yvwCeC+OgirN/UZBSyAj1rwFC6z8t27zjebWUe+DcYOctNo
         EVT9yWtbndHZiIfdoa8cvob9H9KQS6DxJSOHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FqKo9AIGflfwe+nTOQbNK48Ono8rjC9vrryTFd757pg=;
        b=VyCAmCtzPIcBMESBSYVYjVo2IL+t9aAbs72iOTPgRjfdxphQHMza8FwRTbuHK+L1gx
         UmGgydZ48YyUX5Qb/ypI3eJ3C7mxsrrTm9JPrTx/KTP9ZDeX3fdISVWPUnQmRhcO/tQe
         fLxg4jogPz/lyG3PBJxpa9ppBYacfx1KyDIzVPfP0ARJBEcLWB4k0yVgRJ9iwnhIgHIW
         r6eHMSbZiKtymKcDj/i5D3awXByc2TvVM82YnrEnhROlw7mBlShXSu/fvkF4q2P11WJa
         CcFJL5yHbmIWHO5WsHT6u5/9rHmekW7fifrNmBxJ28+lLSFI68hdvkknqDK8YgWwTghv
         tvUA==
X-Gm-Message-State: APjAAAVRhaSAxw55eNmA6YVBhYvKlnZ3yBB7K5lVrsSUFQKt4kNpfeIu
        XBnwPxE3fTQvsTkWs6tFLfWO03eiQCOrOsskH8s6sg==
X-Google-Smtp-Source: APXvYqyoXwCJDcZaJ682D0SOtzeHM9+dJjmS5gdSpkrAzHTec9g5Q6F/pbofuoqsHy2yOosIA0EC/QLsJHG91rGp+7o=
X-Received: by 2002:a0c:99ee:: with SMTP id y46mr25823587qve.54.1567606843395;
 Wed, 04 Sep 2019 07:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190903161655.107408-1-hridya@google.com> <20190904111934.ya37tlzqjqvt7h6a@wittgenstein>
In-Reply-To: <20190904111934.ya37tlzqjqvt7h6a@wittgenstein>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 4 Sep 2019 10:20:32 -0400
Message-ID: <CAEXW_YSj5tdykM8txae66zd0jX_aJujrnS4jG=fHWRvCH7aR7w@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Add binder state and statistics to binderfs
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Hridya Valsaraju <hridya@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On September 4, 2019 7:19:35 AM EDT, Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>On Tue, Sep 03, 2019 at 09:16:51AM -0700, Hridya Valsaraju wrote:
>> Currently, the only way to access binder state and
>> statistics is through debugfs. We need a way to
>> access the same even when debugfs is not mounted.
>> These patches add a mount option to make this
>> information available in binderfs without affecting
>> its presence in debugfs. The following debugfs nodes
>> will be made available in a binderfs instance when
>> mounted with the mount option 'stats=global' or 'stats=local'.
>>
>>  /sys/kernel/debug/binder/failed_transaction_log
>>  /sys/kernel/debug/binder/proc
>>  /sys/kernel/debug/binder/state
>>  /sys/kernel/debug/binder/stats
>>  /sys/kernel/debug/binder/transaction_log
>>  /sys/kernel/debug/binder/transactions
>
>Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
>
>Btw, I think your counting is off-by-one. :) We usually count the
>initial send of a series as 0 and the first rework of that series as
>v1.
>I think you counted your initial send as v1 and the first rework as v2.

Which is fine. I have done it both ways. Is this a rule written somewhere?

>:)
>

If I am not mistaken, this is Hridya's first set of kernel patches.
Congrats on landing it upstream and to everyone for reviews! (assuming
nothing falls apart on the way to Linus tree).

thanks,

- Joel

[TLDR]
My first kernel patch was 10 years ago to a WiFi driver when I was an
intern at University. I was thrilled to have fixed a bug in network
bridging code in the 802.11s stack. This is always a special moment so
congrats again! ;-)





>Christian
>
>>
>> Hridya Valsaraju (4):
>>   binder: add a mount option to show global stats
>>   binder: Add stats, state and transactions files
>>   binder: Make transaction_log available in binderfs
>>   binder: Add binder_proc logging to binderfs
>>
>>  drivers/android/binder.c          |  95 ++++++-----
>>  drivers/android/binder_internal.h |  84 ++++++++++
>>  drivers/android/binderfs.c        | 255
>++++++++++++++++++++++++++----
>>  3 files changed, 362 insertions(+), 72 deletions(-)
>>
>> --
>> 2.23.0.187.g17f5b7556c-goog
>>
