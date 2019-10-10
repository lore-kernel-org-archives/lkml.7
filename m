Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4969EC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC1A206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="EiIOmkCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388082AbfJJNMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:12:01 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42257 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387758AbfJJNL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:11:57 -0400
Received: by mail-qt1-f193.google.com with SMTP id w14so8568803qto.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 06:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hk1hpInDwW/dNG+9po1sQg3gFwOZob0BqkXZLvXNqAM=;
        b=EiIOmkCf6Pz+amb0XEBVILcMqQT+nNV5dTKIqEbDB83ogxN35UhT5mKC0V3oqycGaU
         QfBxOW47Y9U0kt9BxV8ndtvS9n9nUsVfafK15jqq+7Sa3gLpw6rgNzFdfPua+MntFLWI
         IP/Lnb1cwWB/NzGxrnl2bvsxi83RAzJF1a5pTF6nlCVoR1TIWLvbpRgmhuAWLbRNpysV
         gqTmCjzCzYaagkD9+n1TX2aneHXcRYwZ1Iov6lHl1rNjPvy+C10PeSsxdOQNUWXFqIJ1
         1Q/5hFnyB1ITV0XKbUanqtLp+nje2e0/db4cwv2oRNhFqLJM7QF72Jq/DxlqtJUZP4Wc
         yGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hk1hpInDwW/dNG+9po1sQg3gFwOZob0BqkXZLvXNqAM=;
        b=SHsN6/B1p79vX5qBaBFhXCR5UR6+bfo6vxcEawGSqHaaUjTSOueNEOWIi5Si+R5pOD
         tRASx/wXzQ+JV/RiJX/k97I/BWuIh0mL00HLvCZe6OKp6tuCb0SMy4+WP2crHBegtqH6
         eJu6fYJUlOi4L+X8pL+CfQkeHAlf3kMKXTi5E88KvgwGVjUu0/c0gK4liMoJ8uaG3JI5
         PyKA18P1hiONk4ua9YGiuyzGxBZWROZsJCgg33vLVW/Twi1AHA/8q71KOtBTN05LbbDQ
         ZCuUSL4mE4wIdckXdT5N8DV1B1XPqoh+a8zevZ6HyVhHurlhR8+HWP/7wOZQ4HrIgb2o
         KPew==
X-Gm-Message-State: APjAAAVPpUGWIhpIJxcDawfb4oviSciPj/et4aSXS9NjTZlsfs3Oentp
        9y2RhfBtp4DAUWBbkHhpGJDpWg==
X-Google-Smtp-Source: APXvYqzvL5aeR2zrCHaTnj4XHJNQdEw7kVcRg9U8rtJXBzf4fb5WImb1YG3jeAvtErb06d3XkUhFXg==
X-Received: by 2002:ac8:538b:: with SMTP id x11mr9745504qtp.216.1570713114446;
        Thu, 10 Oct 2019 06:11:54 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 139sm2577266qkf.14.2019.10.10.06.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 06:11:53 -0700 (PDT)
Message-ID: <1570713112.5937.26.camel@lca.pw>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, akpm@linux-foundation.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>, david@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 10 Oct 2019 09:11:52 -0400
In-Reply-To: <20191010105927.GG18412@dhcp22.suse.cz>
References: <20191009162339.GI6681@dhcp22.suse.cz>
         <6AAB77B5-092B-43E3-9F4B-0385DE1890D9@lca.pw>
         <20191010105927.GG18412@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-10 at 12:59 +0200, Michal Hocko wrote:
> On Thu 10-10-19 05:01:44, Qian Cai wrote:
> > 
> > 
> > > On Oct 9, 2019, at 12:23 PM, Michal Hocko <mhocko@kernel.org> wrote:
> > > 
> > > If this was only about the memory offline code then I would agree. But
> > > we are talking about any printk from the zone->lock context and that is
> > > a bigger deal. Besides that it is quite natural that the printk code
> > > should be more universal and allow to be also called from the MM
> > > contexts as much as possible. If there is any really strong reason this
> > > is not possible then it should be documented at least.
> > 
> > Where is the best place to document this? I am thinking about under
> > the “struct zone” definition’s lock field in mmzone.h.
> 
> I am not sure TBH and I do not think we have reached the state where
> this would be the only way forward.

How about I revised the changelog to focus on memory offline rather than making
a rule that nobody should call printk() with zone->lock held?
