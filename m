Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EB6C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45450206EC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="WX4D3wUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfLCQ6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:58:01 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33287 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbfLCQ6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:58:01 -0500
Received: by mail-qk1-f196.google.com with SMTP id c124so4160189qkg.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 08:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LGv6wPlEfaDQnYtGOAOevWoaZ+3uby3pI57SYgWQTNI=;
        b=WX4D3wUvamLHUCMd3X7827VO8nkX81yqK6948Lqq5p4ow0mTtHhgLvcCeKfPkOaI7a
         y9SHrhw8qF0DrowXPGDfmW6DwmH7foRrI1rbJ7iBmI9ZLvPZtA2GIf8j4j62DM5YNOqH
         7Mk2Qk639GMCkxuuhkM/ltrjoXLs+puXzkLYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LGv6wPlEfaDQnYtGOAOevWoaZ+3uby3pI57SYgWQTNI=;
        b=I+fdZUg/tDu9Oa5XWmh7VDX5FTT3YuAjsPMM4o6XsqYlelroDS9LEwHueJqABpb310
         6PbQTbhBXuBcLg7X9W2shwyG5p2Ow3HWzpH8dIXlijNAU4+7518mlm0oEKyg7rtHrsul
         dv2cBzlA5qgeH5JajbQ4dVux1D5W9Dlkzo25VZXPHa868Hbf+37rI0/ZraJb+18pxlaz
         2tL6UdqyqtyDfPb6/U7tjnhuxRdKrsuPcm4WeYpgUM8HwcIHrGWToN0WIZJITlKQYO/C
         ukDMyRPbTYFOyyWO85MLbvRUFGkiVFh8s4bHu/3gBOnz62/OxooCFDE5I7dYppcS6Acg
         zsjA==
X-Gm-Message-State: APjAAAVqf3h2tRVCpl/KkHVHsIoni2OaIB6EIejCEI+38/XkZ5oaIHKS
        ehM6y4RJw3UCOP6FuGDm2fDqSg==
X-Google-Smtp-Source: APXvYqz8XQ69dPqeLj+di3xVREf9lkPii5kNusdWFAKcRZBOhzDCl9XcLkNTKRxVZg8kogPEgQqtbg==
X-Received: by 2002:ae9:e710:: with SMTP id m16mr5690391qka.242.1575392279905;
        Tue, 03 Dec 2019 08:57:59 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:49ea])
        by smtp.gmail.com with ESMTPSA id y11sm902808qtj.81.2019.12.03.08.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 08:57:59 -0800 (PST)
Date:   Tue, 3 Dec 2019 11:57:58 -0500
From:   Chris Down <chris@chrisdown.name>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH kselftest-next 1/2] kselftests: memcg: update the oom
 group leaf events test
Message-ID: <20191203165758.GA607734@chrisdown.name>
References: <20191202234212.4134802-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191202234212.4134802-1-guro@fb.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Gushchin writes:
>Commit 9852ae3fe529 ("mm, memcg: consider subtrees in memory.events") made
>memory.events recursive: all events are propagated upwards by the
>tree. It was a change in semantics.
>
>It broke the oom group leaf events test: it assumes that after
>an OOM the oom_kill counter is zero on parent's level.
>
>Let's adjust the test: it should have similar expectations
>for the child and parent levels.
>
>The test passes after this fix.

Thanks! Hopefully b59b1baa will also avoid this going unnoticed in future.

Reviewed-by: Chris Down <chris@chrisdown.name>
