Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1884C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFB321655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eEZM3QuE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfG2QvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:51:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41437 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728895AbfG2QvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:51:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so28337463pff.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aoG/CujPMfUNVlv4vKQLSR0pGlxHql1vt1xZ+SM2evU=;
        b=eEZM3QuEtJ4JN4mdaj3YgffjMFlESFvZpNvVSBcO8QjQXXQKXPwrx7oRmFKdAFTv4O
         e6RMip7uGYfZRrmSxbKwzN3jKE4oPiG8D2pbJVibHbEQZSrsU0IkrOey1LwO4ytEt5eV
         z+gXkKTFPBu2RM4tpLhAffP4/wgkBIsBwtriU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aoG/CujPMfUNVlv4vKQLSR0pGlxHql1vt1xZ+SM2evU=;
        b=gYMu1qojDa4nIxc2yR4JNf4n0DPtrGYhaj8YXwF0K5dnFbxkTRno8Hpmz1PeDL+iZV
         nTNSz64TpSFmj40R6DZuQwC+OGfjkYu+nZKFBySgokRccBfS4l6e0OZ5lhJmplGFThBQ
         HK+2gVpIvLqlUmXxtj0sAUMRf4rgrHpnlZY7pHocKHL1Fsjb9cVpOQk2ElAewyFmvQF2
         poQKwt1qkL+5CpE9NvY0icRI5cbMZt/IoKQ96dRd8kKXQBPr9mWwoevO5JpK4eH3gAjG
         v3UOM3DTQ75IrvyxcleDdD6dxdGaiPKi8XF0RNknV2bzbvDmGdKLyCozf/lLr1NP+K3M
         cVEA==
X-Gm-Message-State: APjAAAUXVa1OhERAcNF1wNG98euz/7qfrbShw1h+HQBO/Pc0RFRievuf
        k/UIhpxgkzwQysQFNu9pRokvRhyYDug=
X-Google-Smtp-Source: APXvYqypNtAKQJZGTSkV39u4c7GLeVZyMUhrP0VaoGlM65upiz6NEPGMAURh5q4KoDvXmPMGybRvRQ==
X-Received: by 2002:aa7:9713:: with SMTP id a19mr19643019pfg.64.1564419066457;
        Mon, 29 Jul 2019 09:51:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j1sm85432865pgl.12.2019.07.29.09.51.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 09:51:05 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:51:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        NitinGote <nitin.r.gote@intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selinux: convert struct sidtab count to refcount_t
Message-ID: <201907290949.D08EC0379C@keescook>
References: <20190722113151.1584-1-nitin.r.gote@intel.com>
 <CAFqZXNs5vdQwoy2k=_XLiGRdyZCL=n8as6aL01Dw-U62amFREA@mail.gmail.com>
 <CAG48ez3zRoB7awMdb-koKYJyfP9WifTLevxLxLHioLhH=itZ-A@mail.gmail.com>
 <201907231516.11DB47AA@keescook>
 <CAG48ez2eXJwE+vS2_ahR9Vuc3qD8O4CDZ5Lh6DcrrOq+7VKOYQ@mail.gmail.com>
 <201907240852.6D10622B2@keescook>
 <CAG48ez3-qdbnJaEooFrhfBT8czyAZNDp5YfkDRcy5mLH4BQy2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3-qdbnJaEooFrhfBT8czyAZNDp5YfkDRcy5mLH4BQy2g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 06:55:47PM +0200, Jann Horn wrote:
> (Accurate) statistics counters need RMW ops, don't need memory
> ordering, usually can't be locked against writes, and may not care
> about wrapping.
> This thing doesn't need RMW ops, does need memory ordering, can be
> locked against writes, and definitely shouldn't wrap.
> 
> I agree that there are a bunch of statistics counters in the kernel,
> and it's not necessarily a bad idea to use a separate type for them;
> but this is not a statistics counter.

Right, yes, I didn't meant to suggest it should be. I was just bringing
up the "counter type" idea again, since it was on my mind here
originally.

-- 
Kees Cook
