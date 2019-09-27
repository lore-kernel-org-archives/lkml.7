Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC48C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1DB21906
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="brG/fn12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfI0NKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 09:10:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37801 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfI0NKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 09:10:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id f22so6117988wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 06:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fr22Se/lqcpKZvDg98f1QiTa8xSYmqt3dzLeNqTXF+0=;
        b=brG/fn12Av8FuCAtxDsMocEpw1NOvkyKnNkGwGFIJzLrNtaWCQJzS7dr1VZ9KizCJg
         KVQXwGPmkN1pGFi1tmRi34ojo2rHG93iqjPuF9zAVBJ9OF0ODgws94iE/2T+Ntv/vUKr
         xlpvO5pXIm11xeY06oal/r2Tng9dELshokEDLV+2nIy6AIxdMDooPAZ6fDAfO3pEknS2
         2mPWXvmvN42R1sB/YlK4mlQWD1ERz9P0MOjWHmMoTgIAae0ljbfUqFeRBtxtO/RYqSOh
         R/ijLcWQUdaDJ+PK+tJ1C0/EQOuTL1PUjZSiMD5IaWG8GHf9Tde0xlNz7j+VYh2Yzn54
         GgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fr22Se/lqcpKZvDg98f1QiTa8xSYmqt3dzLeNqTXF+0=;
        b=a99Y5kRGkdd4pbfNGifGZCHdekDzYJc1TTaYIsvSfXqFchHXZIFhHz87h//FNE/ukS
         EHFBi1aTdPBZoYhbvDARyv6O7tPH0Sv6rMADzGCwbQiC/iwepC497Xbbg06n6ntNGsi5
         GUrWq7hYpta4qqUI+LDRc+Bl5OP1FbAwP7J2uUfRlJX3Hk+wm9BzJ+L8sSejljZwdgtB
         gN7hP43qBOgUeW0aGOx6iM0RLHealT5ELdWtNJmZ5qJWHyzVIOWiRXU197SkI1YALEAc
         02f9nq9sELaK33VgYHxRel7MfLUMV8r4CDFUCxrnYyR++HA5P6nDNhUpkkhUNzGmgdTc
         9jEA==
X-Gm-Message-State: APjAAAWOo/ip3TuajsmvlhmU21Jop8f3oR0IjNkrRqM7R2/64HzLUPgI
        dLnHz28/XObdBZK8vLnH/5UqHg==
X-Google-Smtp-Source: APXvYqzMIdNS9whoJlO8DBcGsaX+ylXqan90LzfVaPF1v/zak3zVHbMpj3mp5Iu85UOGa2Z5ah9LVw==
X-Received: by 2002:a1c:7902:: with SMTP id l2mr7152512wme.55.1569589844903;
        Fri, 27 Sep 2019 06:10:44 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id r18sm5494216wme.48.2019.09.27.06.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 06:10:44 -0700 (PDT)
Date:   Fri, 27 Sep 2019 14:10:41 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] nsdeps: fix hashbang of scripts/nsdeps
Message-ID: <20190927131041.GA187147@google.com>
References: <20190927093603.9140-1-yamada.masahiro@socionext.com>
 <20190927093603.9140-7-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190927093603.9140-7-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 06:36:02PM +0900, Masahiro Yamada wrote:
>This script does not use bash-extension. I am guessing this hashbang
>was copied from scripts/coccicheck, which really uses bash-extension.
>
>/bin/sh is enough for this script.

Reviewed-by: Matthias Maennich <maennich@google.com>

Cheers,
Matthias

>Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>---
>
> scripts/nsdeps | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/scripts/nsdeps b/scripts/nsdeps
>index ac2b6031dd13..964b7fb8c546 100644
>--- a/scripts/nsdeps
>+++ b/scripts/nsdeps
>@@ -1,4 +1,4 @@
>-#!/bin/bash
>+#!/bin/sh
> # SPDX-License-Identifier: GPL-2.0
> # Linux kernel symbol namespace import generator
> #
>-- 
>2.17.1
>
