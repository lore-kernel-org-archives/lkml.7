Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D89CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAF221835
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 11:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="nRSM804q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbfKALJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 07:09:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37176 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbfKALJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 07:09:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id t1so3370554wrv.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 04:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PNqWAL/vcdIkzWkk07XofANRcuWQjzPIpS1/GtEbKcU=;
        b=nRSM804qrZvift9Sh05oWVFc4gK8vA+tN8Q5awmIhEf7D56uQzsrhVEwmH9i7r2CqC
         qZHIOSKKZNx2DDqZ2sLIVtBzTX34ue815t86YY1RhnRdUZShaZw722hlrxtIeFOSi+mC
         sepoIBwqrGvjU06MqnATXk7czNawaz2Yu2RAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PNqWAL/vcdIkzWkk07XofANRcuWQjzPIpS1/GtEbKcU=;
        b=Mdf3vfi/8hDkQctjDvhrAkWhSPExii+gepQ7+9dPc/Qr/KaNUcfBQbaLrCSotn+ciI
         nIIGfJ5FgEBGGiHnhmW2iDeWVwq+Xcffzd3FCXN9ZqAbY3JD+SqITezYJFAtawuiGug7
         5L1C5LaXc/XkXDeVgUgByurZfrSqdPrO+KlYaCDorXRY8iiSWpBQvLf3oXsox8SnbdOr
         K0AzsASLE5VaN3/cYIiLRXcGRyfQO3sN2hT+DEMM4EFl8852ZDA8bfa8kiBg0R0F3vLy
         KJmQiBtNvzGKSCEX3u9LDHDgZSezheKbCVl25+O8eDBLipofByNNDm1ERccLoDeyCV2Q
         K34Q==
X-Gm-Message-State: APjAAAUTYAWJCQhUGLw3uQrM349I+gTh01e8BlTk9sKULu9JwzycNrUN
        9xdkMW21YVmqvlqWYewCfiTwQA==
X-Google-Smtp-Source: APXvYqy2l0PDMZPx7dSHoMcIgMT8UP4V/5TqGtuFA71u3xhya0ajNZFM5P9rdj15G2bswWsroasc9Q==
X-Received: by 2002:adf:c409:: with SMTP id v9mr10205437wrf.41.1572606543510;
        Fri, 01 Nov 2019 04:09:03 -0700 (PDT)
Received: from localhost ([2620:10d:c092:180::1:f970])
        by smtp.gmail.com with ESMTPSA id d4sm10304948wrc.54.2019.11.01.04.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 04:09:02 -0700 (PDT)
Date:   Fri, 1 Nov 2019 11:09:01 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] kernel: sysctl: make drop_caches write-only
Message-ID: <20191101110901.GB690103@chrisdown.name>
References: <20191031221602.9375-1-hannes@cmpxchg.org>
 <20191031162825.a545a5d4d8567368501769bd@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191031162825.a545a5d4d8567368501769bd@linux-foundation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hm, not sure why my client didn't show this reply.

Andrew Morton writes:
>Risk: some (odd) userspace code will break.  Fixable by manually chmodding
>it back again.

The only scenario I can construct in my head is that someone has built 
something to watch drop_caches for modification, but we already have the kmsg 
output for that.

>Reward: very little.
>
>Is the reward worth the risk?

There is evidence that this has already caused confusion[0] for many, judging 
by the number of views and votes. I think the reward is higher than stated 
here, since it makes the intent and lack of persistent API in the API clearer, 
and less likely to cause confusion in future.

0: https://unix.stackexchange.com/q/17936/10762
