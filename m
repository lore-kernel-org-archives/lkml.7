Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7011C31E5E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F4D21880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZR7FWN5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbfFSPTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:19:07 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40215 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfFSPTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:19:06 -0400
Received: by mail-yw1-f67.google.com with SMTP id b143so8439458ywb.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 08:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=497trEoQ+MnWiMrpBRDIQlRXiLccDLhvItPlHmc2I1Q=;
        b=ZR7FWN5U5wMegqY43k4e0b9xlbLxhcVnkfYP2AHyH+M2qYeniu7mKY8gJk9qmy9N+D
         Fcwbou95jnlSIcEp7YB8+U2/w75RN3uL9g+h0p61XsduShIlAJ/yp4GvBh7UVZzShYdL
         ywggJRFRqk8vYrbYPhJiSOd/027k/lIIfiCqwfLSN2Brxbqh+c7+7ZBp5WEEPUBhFEC8
         XoSEqYMf7pMdG3iK9KeaRn79zsByPzakG+RpzbNLFBTwmZpSeETcSRDV3T90ccSnm0mF
         j+wqkAVQh/BuznmcxjNDF2Ax5SNxY/5sXzEoWjCg0GoVB4txl/Xpnet5rX7H+rCzbb4y
         aIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=497trEoQ+MnWiMrpBRDIQlRXiLccDLhvItPlHmc2I1Q=;
        b=lv87fePoZTdPQP9AJ9FsUouhQewKFzvlgXQcaGEnb3hfwPyD6u6dqU2ThqCVZu4M4S
         /3rsWzukP2FiugG/ouWiitjF6C5+cMv3L/JlMXd9CGgrqlLdpzmMUAsTC8QBo3cot9rv
         sRDtWiGsEodAkJnqloDwCCgnRHwIa2WWae+vOSq11N+ZEZGmpWc4gYczLDbXdzX6A+x6
         MrETdWPxHZLQPCsJyTGjqaGbE5UxEQvVs5Rka7jLJpvujryWkU9tl9GH/ZXEuGVuoe8Y
         5YPQpXfBBdOVZ928AEDv0Vjg+JeF0bzxncvzSBO9tLex6HPCNGKkWdRvG/50CziSD/x1
         a+Og==
X-Gm-Message-State: APjAAAWjkqFwfm+dU9i7YSKHO5TQ/sEL8FNoKbqcigmbqdwId8vF7Sad
        /7h20FW+W0riU+JFq/E/2PNw8iNN5j6Ox5iyUpfAGw==
X-Google-Smtp-Source: APXvYqzDCJLSOt3Xcw9H6eTxGEbr9cfIpCmRnBVPNbrAC0K1NdNy1iodvCpMQZq0NRV5Hk0GqIh28j7YOAwbZBG+Gzc=
X-Received: by 2002:a0d:c345:: with SMTP id f66mr22624175ywd.10.1560957545673;
 Wed, 19 Jun 2019 08:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190619144610.12520-1-longman@redhat.com>
In-Reply-To: <20190619144610.12520-1-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 19 Jun 2019 08:18:54 -0700
Message-ID: <CALvZod5yHbtYe2x3TGQKGtxjvTDpAGjvSc8Pvphbn00pdRfs2g@mail.gmail.com>
Subject: Re: [PATCH] mm, memcg: Add a memcg_slabinfo debugfs file
To:     Waiman Long <longman@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 7:46 AM Waiman Long <longman@redhat.com> wrote:
>
> There are concerns about memory leaks from extensive use of memory
> cgroups as each memory cgroup creates its own set of kmem caches. There
> is a possiblity that the memcg kmem caches may remain even after the
> memory cgroup removal. Therefore, it will be useful to show how many
> memcg caches are present for each of the kmem caches.
>
> This patch introduces a new <debugfs>/memcg_slabinfo file which is
> somewhat similar to /proc/slabinfo in format, but lists only slabs that
> are in memcg kmem caches. Information available in /proc/slabinfo are
> not repeated in memcg_slabinfo.
>

At Google, we have an interface /proc/slabinfo_full which shows each
kmem cache (root and memcg) on a separate line i.e. no accumulation.
This interface has helped us a lot for debugging zombies and memory
leaks. The name of the memcg kmem caches include the memcg name, css
id and "dead" for offlined memcgs. I think these extra information is
much more useful for debugging. What do you think?

Shakeel
