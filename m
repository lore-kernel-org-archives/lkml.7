Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9CAC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C150C217D9
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 21:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="rZ0i7K+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfHGVMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 17:12:48 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:46783 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbfHGVMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 17:12:48 -0400
Received: by mail-pg1-f178.google.com with SMTP id w3so5614160pgt.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 14:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HDsbOqdqt6WL/tNlrJsj+N++Ozhrzy+jd8MDoupW4xM=;
        b=rZ0i7K+4dO7YAgZr7g3eTN78Jx4YSreaML2nif7MCjeuCG2DcmetfvCHzYeNrxmOvI
         GgNIgk9auMbqEEL4L2Dq9xyLKXeJMKWWeLM4AqNXM7Br7+IG2anIx5/oI+zxEGfohjvB
         v1zGLGk/Qlid4kz6oWC1tVPUNHQkwN67sJEI0W3zw1nH6nLbmXJXLircrwcOItO9oRbX
         TvYbSjDDcgzXn5vO5RhaOWZo/FQL/WpG6HO+tCEHlomMbyhrislSd4//md2/z6bniBmJ
         8ZWDyU7PRL4sXRr65HxiDpbWjxA2+qAgo6lB/V7mYpK7VZHAmXLX/usE4cNGwbcvxUml
         yhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HDsbOqdqt6WL/tNlrJsj+N++Ozhrzy+jd8MDoupW4xM=;
        b=m0xn9NNlparYS5cdfO6aSWkc8YUzCu0Lck8GAiRWeSjU39sVLRCyDdAFmJBzDgCFZ/
         EWyRPyXkGIs5tdQM9ysYzbnI7SaMR7suuksjDUjDS7DSj1I+SjhJ2+LE+Tuc2vFgCFcF
         +ENqiSdGAgDBq0gjveLSqSnfe8gFNHT4Ds8N5vNIxyfrxtDemqBCoK0UFK9cfWmrrZ6d
         a9K/qBmJV5PCOJIcpw5XMHl9FPXf755Q5Tm6LYihMpgucY1FfhPzUbBY/ZBxK1/v7P91
         yAUWTz176RRaL6LCDBG4UXGlRovxa7zlOK7QsC3m93ef7igFjKMC6LEOUv991FCLxyJw
         NX/Q==
X-Gm-Message-State: APjAAAUwY6HpFs7XTWTDTspjfjJh5JO+3CXbMaCx6i01OPSNSR6fnrrP
        Z/+5bjjb7Uvw4ZzfNThAYG54Jg==
X-Google-Smtp-Source: APXvYqzHU2Qv90JaGiam0/j3y7qiJAsqUy0QsTn9ntikZSQbDjZ92rTTHkhUSHGxO7ewruuC5ndDhw==
X-Received: by 2002:a63:2b84:: with SMTP id r126mr9751854pgr.308.1565212367528;
        Wed, 07 Aug 2019 14:12:47 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:f7c1])
        by smtp.gmail.com with ESMTPSA id u16sm24716337pgm.83.2019.08.07.14.12.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 14:12:46 -0700 (PDT)
Date:   Wed, 7 Aug 2019 17:12:45 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: Let's talk about the elephant in the room - the Linux kernel's
 inability to gracefully handle low memory pressure
Message-ID: <20190807211245.GA11071@cmpxchg.org>
References: <ce102f29-3adc-d0fd-41ee-e32c1bcd7e8d@suse.cz>
 <20190805193148.GB4128@cmpxchg.org>
 <CAJuCfpHhR+9ybt9ENzxMbdVUd_8rJN+zFbDm+5CeE2Desu82Gg@mail.gmail.com>
 <398f31f3-0353-da0c-fc54-643687bb4774@suse.cz>
 <20190806142728.GA12107@cmpxchg.org>
 <20190806143608.GE11812@dhcp22.suse.cz>
 <CAJuCfpFmOzj-gU1NwoQFmS_pbDKKd2XN=CS1vUV4gKhYCJOUtw@mail.gmail.com>
 <20190806220150.GA22516@cmpxchg.org>
 <20190807075927.GO11812@dhcp22.suse.cz>
 <20190807205138.GA24222@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807205138.GA24222@cmpxchg.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 04:51:42PM -0400, Johannes Weiner wrote:
> Per default, the OOM killer will engage after 15 seconds of at least
> 80% memory pressure. These values are tunable via sysctls
> vm.thrashing_oom_period and vm.thrashing_oom_level.

Let's go with this:

Per default, the OOM killer will engage after 15 seconds of at least
80% memory pressure. From experience, at 80% the user is experiencing
multi-second reaction times. 15 seconds is chosen to be long enough to
not OOM kill a short-lived spike that might resolve itself, yet short
enough for users to not press the reset button just yet.
