Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7E9CA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 10:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348F021734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 10:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="VwZmEH6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbfKAK7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 06:59:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55761 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbfKAK7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 06:59:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id g24so8925556wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 03:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LtFp0F0HrsUYyNBlzjAg/7imere0s3lC3VUOl+c6wWo=;
        b=VwZmEH6BFuBX/lEfDq2gTf28+aE6bseQhEvwyXhZetLJ4XDt/sc7VtvJm2m6W3fQmY
         no1u3HUstUiMEtr5X1fKOoazXhc1ODwZ45XAWZVFgdDjaDzy9pJD1gt4iGfDW/vbiDzh
         pY0rw1SBF/npTDRTKj0yNA99/wWXgRn1wAMXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LtFp0F0HrsUYyNBlzjAg/7imere0s3lC3VUOl+c6wWo=;
        b=hMXsNkRFjTmNVIhEU9+tL0xK9ODAPxCF4YrsnmA9WjqKhADbpO4BFeVBZRUyBFfGSG
         QTSoR+ODs/apIn1jQ06dv+jlavmMZvuDQpJkrU5R9D1OBRsDRzQAZqqPO5y8LSX3WgD2
         4ilHvVUGUGiKrC/HEw0O+0l5xUGzHi5Fsu8O7csv6Aovue3R+euExC8cE2FGvPxqePlK
         ghU0ULgYWqrYWAIxE4nQvIKo0WUDf1kSCS6i571AsxFSDPNubebTEFhICPgdzIKL1FXP
         HJLlaAAIAjINWvOXEa5wNv6clVC1fc285RIwJaFTA0AfL6G+CjjHAxoUviCCqYsVaKNb
         QI7Q==
X-Gm-Message-State: APjAAAWgZbtWORLt2gpR28NLRYNmEOQmT7pd2UzUroaT4OYag5BvSTvd
        BEvoIrqjaWtcmXXuYOphVXnq8w==
X-Google-Smtp-Source: APXvYqw+3+Gejtx1dbHSz1D4wdx8qwJDsgqG3o9gN8mxHqhJ5uVwTa8a/3Zk4qq+GGthKlyftuHaWw==
X-Received: by 2002:a1c:7704:: with SMTP id t4mr8981357wmi.4.1572605940145;
        Fri, 01 Nov 2019 03:59:00 -0700 (PDT)
Received: from localhost ([2620:10d:c092:180::1:f970])
        by smtp.gmail.com with ESMTPSA id n13sm1507441wmi.25.2019.11.01.03.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 03:58:59 -0700 (PDT)
Date:   Fri, 1 Nov 2019 10:58:58 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] kernel: sysctl: make drop_caches write-only
Message-ID: <20191101105858.GA690103@chrisdown.name>
References: <20191031221602.9375-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191031221602.9375-1-hannes@cmpxchg.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Weiner writes:
>Currently, the drop_caches proc file and sysctl read back the last
>value written, suggesting this is somehow a stateful setting instead
>of a one-time command. Make it write-only, like e.g. compact_memory.
>
>Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Since we already have the kmsg notifier when it's used, this seems reasonable 
to me.

Acked-by: Chris Down <chris@chrisdown.name>
