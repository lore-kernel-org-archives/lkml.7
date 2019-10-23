Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D54CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4932086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 15:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="skavQFPt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406854AbfJWPvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 11:51:48 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36809 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403945AbfJWPvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 11:51:48 -0400
Received: by mail-qt1-f193.google.com with SMTP id d17so18378321qto.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 08:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MxZvQ5ahYDyvo9zRmiCgox63DQt65JRMrjon3hrPmgU=;
        b=skavQFPt7lvx7dsxZg2sUqnDpF2yvxFgElf7B/R1pymBsjEs5w9lH2buBsjIAMjEl6
         b2i+Zfs8l8hzJ5VJjSa9mqKk27YmQF5XMjYMAu1EhOderwR/zFbCj/I1xJKPM+wHXD5N
         l3+wMI6W0rvZnR5MuxVWazlHZs5YA9sQ+/O91xsLnH4CEAENIIYG1maEi9Nsw1BhnNrN
         BVKaxef7M3DH6kNmhi9xhTkC2IVenP3EiJ36E3tndqMhOEE07U9Bif7+WJKMjxasyZn6
         R4SeyBahLSmgd5Ra17i19Fu0yXSsHnESJypkP6kI1LlH1lu/G9bFylZ76AoSAe/m8Z1A
         wM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MxZvQ5ahYDyvo9zRmiCgox63DQt65JRMrjon3hrPmgU=;
        b=W6aM8920/IsPLxWFaYnYTR//WZ+Lc1LmXoDsjZt0v1tOdZJW2uJhclnZ10YTi7Y/A2
         lAiCUXShADBmDY8iMgv3jMt9ryBqSQowyTc5Fyto6IKNnq017RAfyQvPeF0xQC1Yfgyv
         ur0/k26xLnq4mSasCBzuz5ZIueIEJmvLBGFX0oSRtCxTNQAyh48pgMPnXqpwPt06kQFJ
         Z5rhw2FBUaaofg9JYM3mulZT5X7JCYxKvshGGH8VnrtlvZLwLE0NQH0x/wpRAT3fw4VE
         Uoo7F01Fv5FUWthSUnjY7ox27fvedP5Eg+lxIZdTj3O/WsaRUXEq1tKDJ6YJfszT0xtr
         m/pw==
X-Gm-Message-State: APjAAAWbEWZG8aQKZNUIW9WMq/X6xz7ynWkXD8smgCkKmGUaqsSMK+mL
        M+844DK7be0HzVX+WZ0wp59r7Q==
X-Google-Smtp-Source: APXvYqxgRE1MSPCporiCYj6UuGJ4GgaFhDKdNNDojsygw+b3NW02XupzgPK+ACzdKNGC2OwjYi4tPw==
X-Received: by 2002:ad4:53c8:: with SMTP id k8mr9677187qvv.240.1571845907082;
        Wed, 23 Oct 2019 08:51:47 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id r36sm10713980qta.27.2019.10.23.08.51.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 08:51:46 -0700 (PDT)
Message-ID: <1571845904.5937.89.camel@lca.pw>
Subject: Re: [PATCH] mm/vmstat: Reduce zone lock hold time when reading
 /proc/pagetypeinfo
From:   Qian Cai <cai@lca.pw>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Jann Horn <jannh@google.com>, Song Liu <songliubraving@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Wed, 23 Oct 2019 11:51:44 -0400
In-Reply-To: <20191023150319.GD22601@optiplex-lnx>
References: <20191022162156.17316-1-longman@redhat.com>
         <20191022145902.d9c4a719c0b32175e06e4eee@linux-foundation.org>
         <2236495a-ead0-e08e-3fb6-f3ab906b75b6@redhat.com>
         <1571842093.5937.84.camel@lca.pw> <20191023150319.GD22601@optiplex-lnx>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-23 at 11:03 -0400, Rafael Aquini wrote:
> > > > this still isn't a bulletproof fix.  Maybe just terminate the list
> > > > walk if freecount reaches 1024.  Would anyone really care?
> > > > 
> > > > Sigh.  I wonder if anyone really uses this thing for anything
> > > > important.  Can we just remove it all?
> > > > 
> > > 
> > > Removing it will be a breakage of kernel API.
> > 
> > Who cares about breaking this part of the API that essentially nobody will use
> > this file?
> > 
> 
> Seems that _some_ are using it, aren't they? Otherwise we wouldn't be
> seeing complaints. Moving it out of /proc to /sys/kernel/debug looks 
> like a reasonable compromise with those that care about the interface.

No, there are some known testing tools will blindly read this file just because
it exists which is not important to keep the file.
