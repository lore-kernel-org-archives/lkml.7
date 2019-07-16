Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF41C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CA0206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="knBTmABI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388135AbfGPRLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 13:11:00 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34599 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGPRLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 13:11:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so10451733plt.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 10:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kwpOpWT2eWiCeBhDjuSXvGXNhdNaH2c1UD5BkyTJoqs=;
        b=knBTmABIgOoXo69WB++c8IiWB76RVPwIFTQLPCH60rHTf+UJ7FGF+ss1UJhIMPAq8x
         0EwUItQ8ZgDKhh+54f7rBkRV7MSkUDhNen+cxQRpDwq4odvt0AmVDnfhd5gDsDsim6Oc
         /NPzqJO1Ut/8JkDliDODiF4nieSIiOvRtiA2DDTkydoPrCpwaekiYCu4HxFCBNUMOdrv
         Kh+4kgtRPjClbTdLMdYDm8rTNtWJmYgbqv8d+6z8dyl0uMeRa9N2RZCdxwR9l/flo6FS
         TgIxRET8UFzLd1mskmgymFDDldbBvFBtSzi+kDwEtAaFdE8OH18mOJU1usfuTg9ZgWuu
         4sBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kwpOpWT2eWiCeBhDjuSXvGXNhdNaH2c1UD5BkyTJoqs=;
        b=hD04ry7TP8nhrQl9FkRfqiAhvbluYwb2CRzWP1jzW1WSf9l4bULAkE9QNlxzI70nKN
         deoE3MRtr9ubkwFJXmmClaL7dvauOsXW32VxttkXZ5BagUHSobC7fePGsNANwB5MRyqA
         ragVXoRM0wFasKcdwCxHamARLdyKtq329dMvTJKizk6QbvKINEDI+sfYM0reMrl+lBXz
         LkuqF/mtL+QJ7vXd4+MVuKISNNHYsMqCDp7mBH978nmusFkxtsvHsrkE8EyN9ReNbnpP
         2gG/SS8FR5SKXkJion3rwcJMp6vw696fcW3ESZrDZpGW3DrTXxegLa7tUz8JXfVqacBL
         Ii9Q==
X-Gm-Message-State: APjAAAU0fYvdFPLqfYbSHdqmEXoavXXRa6bTCR9j2xe8Q+qx0JR7lTU+
        k9NLdsom+YPkY1g+UKVuIvk=
X-Google-Smtp-Source: APXvYqzOUwUunYYbiDg94VvgRJzmfWkkNNf3nkG+b6uwrilA1j4IQ0R4BL7eXG7mU0JZW5y6MGQ9bg==
X-Received: by 2002:a17:902:381:: with SMTP id d1mr36353848pld.331.1563297059292;
        Tue, 16 Jul 2019 10:10:59 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::1:dd93])
        by smtp.gmail.com with ESMTPSA id j13sm20092099pfh.13.2019.07.16.10.10.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 10:10:58 -0700 (PDT)
Date:   Tue, 16 Jul 2019 13:10:56 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH REBASED] mm, memcg: Make scan aggression always exclude
 protection
Message-ID: <20190716171056.GA16575@cmpxchg.org>
References: <20190228213050.GA28211@chrisdown.name>
 <20190322160307.GA3316@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322160307.GA3316@chrisdown.name>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 04:03:07PM +0000, Chris Down wrote:
> This patch is an incremental improvement on the existing
> memory.{low,min} relative reclaim work to base its scan pressure
> calculations on how much protection is available compared to the current
> usage, rather than how much the current usage is over some protection
> threshold.
> 
> Previously the way that memory.low protection works is that if you are
> 50% over a certain baseline, you get 50% of your normal scan pressure.
> This is certainly better than the previous cliff-edge behaviour, but it
> can be improved even further by always considering memory under the
> currently enforced protection threshold to be out of bounds. This means
> that we can set relatively low memory.low thresholds for variable or
> bursty workloads while still getting a reasonable level of protection,
> whereas with the previous version we may still trivially hit the 100%
> clamp. The previous 100% clamp is also somewhat arbitrary, whereas this
> one is more concretely based on the currently enforced protection
> threshold, which is likely easier to reason about.
> 
> There is also a subtle issue with the way that proportional reclaim
> worked previously -- it promotes having no memory.low, since it makes
> pressure higher during low reclaim. This happens because we base our
> scan pressure modulation on how far memory.current is between memory.min
> and memory.low, but if memory.low is unset, we only use the overage
> method. In most cromulent configurations, this then means that we end up
> with *more* pressure than with no memory.low at all when we're in low
> reclaim, which is not really very usable or expected.
> 
> With this patch, memory.low and memory.min affect reclaim pressure in a
> more understandable and composable way. For example, from a user
> standpoint, "protected" memory now remains untouchable from a reclaim
> aggression standpoint, and users can also have more confidence that
> bursty workloads will still receive some amount of guaranteed
> protection.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Reviewed-by: Roman Gushchin <guro@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: kernel-team@fb.com

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
