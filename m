Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B008AC10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F282218D4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="JEjXZibp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfCTVBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 17:01:19 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:46172 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfCTVBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 17:01:18 -0400
Received: by mail-yw1-f68.google.com with SMTP id v127so3133131ywe.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 14:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ac3c8BuwXRGufN3K90gjwkHmlf5WusrlHW6NBm1q4lU=;
        b=JEjXZibp3H4f5ucHf9/nYNdp/ytl0tGHWy0AKX8AmsOYBRlU8V7e7ASVsOt5LncbG1
         gCS3JBKOn47BLQ8g8YjIgv5iVaKorzkc91V8QDkcVsYe9/uFey0bvFZJ40zD0zOsl8II
         nHTxk66AWJwMWj4oEKBm1cbfvp6BYEg7JuMVewxzaYlEdBuWcOECG93P/lHKqFr/4AtI
         Ay0134rkQc9XtvkOKQ5mUy2sa9+TvRSVaXpfbxTCCpsuq4KZKEtKZF+CElW2vAYDxjNZ
         iH6/4zmve2aF6+bRlPsYN4X24H06xqEBtv9npU1i8LLPi3xQMpqTA2LPRN+hWfZwilZn
         FBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ac3c8BuwXRGufN3K90gjwkHmlf5WusrlHW6NBm1q4lU=;
        b=li4GABgmUEhzK2jC1uM6X02XHHWbS48ZXCINHuKmXUzkC8kl/P74Ijt7b9YB8tM/Cp
         s8aLT6CkJy9GRpsDBlvWBtMKzEb44htGegcoY057tmFtI3MZB/UsA/mrgHVVsqkoDYaO
         1urjd4yb+Fauc9pZRixBnO7fpK/cey8J/UUuXMakUdyrIA3qeIm4PhvvSn3QjryTHj2K
         PgFjN6UkiAkVsXWMCgEOGTZo/EOlDYc8yJBM0rGwjfI+iLhBVj9ZxrtNSLc7SV6GcFUw
         fv6jF+kOj7Iwepcb/T4Osihn0W2ROcaCIuZc9srXvE/ajc/Xa7rLMwSsgGZQOfD17RsJ
         WHiw==
X-Gm-Message-State: APjAAAWVLKqI0wCTFmWaPDC99+daybSIwIYDRP/nAZOLcpEw/6iL4TKy
        L1w1eC/BdF/MPBsfLTexptBSTveoToo=
X-Google-Smtp-Source: APXvYqwtzykOHbzXPKJJWcXH+CWrw+RxKVwf2qkPOM6F/W9FMVFsz+4hKQS1ImujNybU7Y3XRpcA9g==
X-Received: by 2002:a81:430a:: with SMTP id q10mr156204ywa.508.1553115677811;
        Wed, 20 Mar 2019 14:01:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:b52c])
        by smtp.gmail.com with ESMTPSA id 207sm1091449yws.38.2019.03.20.14.01.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 14:01:17 -0700 (PDT)
Date:   Wed, 20 Mar 2019 17:01:15 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org, lizefan@huawei.com,
        axboe@kernel.dk, dennis@kernel.org, dennisszhou@gmail.com,
        mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v6 5/7] psi: track changed states
Message-ID: <20190320210115.GD19382@cmpxchg.org>
References: <20190319235619.260832-1-surenb@google.com>
 <20190319235619.260832-6-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319235619.260832-6-surenb@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 04:56:17PM -0700, Suren Baghdasaryan wrote:
> Introduce changed_states parameter into collect_percpu_times to track
> the states changed since the last update.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

This will be needed to detect whether polled states activated in the
monitor patch.
