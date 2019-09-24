Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE28C4320D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F17121655
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Agzj3nU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389263AbfIXPYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 11:24:39 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42852 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729219AbfIXPYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 11:24:39 -0400
Received: by mail-ed1-f66.google.com with SMTP id y91so2214609ede.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 08:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2LjC3Sz3FAeLFylxSw7vOSd97CbkuJPbU7vrM2ZYkwU=;
        b=Agzj3nU9Lq3han+tHMTQ/hcILjte7FALVg8RFHyhhSa0FTG1KLiJ+QzzNy7FNnccfQ
         tnlC56Gu2Zo8+r8BgMBeGNhR1K37aoTsVx6dv331u7Ff/IXouHDE3/AqXavf/4DEcfIg
         FXtpcziFadX7aAJ2Iqns00NrivsLvCxddHSZRrIIPPoryXeffpfH8djH37shetJc24oS
         U3p1LvwHLCIOQWdsHxajATTxyvJ8TFsgf1nhZFoqw6B0czNLZLZ8Oe6u73UbsZ5SY/7k
         nqENbfF4KlDtpvBmwHe5icvyY+Qa/plSjmdXlXkz1jSUvH+d6DHDMeOlOdlLMb85KroH
         5GIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2LjC3Sz3FAeLFylxSw7vOSd97CbkuJPbU7vrM2ZYkwU=;
        b=S/9g+9XxL8dbV2myIGXz4d+gzYjttQXPR22iDYmsUBxXqvfUHkARiEHCZiMUQGQS7L
         L1Qgp92DGbONYf84DYygt4kv7Fe7DHZJJSLcuIGpyPa2PWVY4IUvqi73VNZx7RL83JHR
         cmDd5XWHYTnydaHkJ/8TddIIhZN10YOeKrBf/MBXk5MlRNHWnP2rFNEnMnIo/dsliyMF
         2Z8L2QiCdBtKOTPiw7ucYZ951g2htgd7SZvceQgxmijyNoz7+IAaClxZ9AEVYmE0e1ky
         JznbVJgbN8n1uep3xV/Bon1xRFpbk08rDaACmBy6APxv77nUEVnpRy8s+Cjl2YJWvsh4
         bhzg==
X-Gm-Message-State: APjAAAXrbA1IqG2wZG8wp5jeIac85nByIh0Jo+picZGm9GdnKmsVGA+N
        Gx/WRoylzZ5roW7yEKIDErno+g==
X-Google-Smtp-Source: APXvYqzVFnL2hc7YbQUxjbycKtUTfMSSxAWsGRNBE7rRfmYbR/t5MfpCZnvp/zZb59pblgDXYpBqBA==
X-Received: by 2002:a17:906:16cd:: with SMTP id t13mr2991274ejd.153.1569338676640;
        Tue, 24 Sep 2019 08:24:36 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i5sm419311edq.30.2019.09.24.08.24.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 08:24:36 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 877521022AB; Tue, 24 Sep 2019 18:24:36 +0300 (+03)
Date:   Tue, 24 Sep 2019 18:24:36 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 4/4] mm, page_owner, debug_pagealloc: save and dump
 freeing stack trace
Message-ID: <20190924152436.hxyu7ip5nrynicb5@box>
References: <20190820131828.22684-1-vbabka@suse.cz>
 <20190820131828.22684-5-vbabka@suse.cz>
 <20190924114242.q6rtv5h6xswxigim@box>
 <7098e036-c955-4ccb-6bce-fedf82ad0b1b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7098e036-c955-4ccb-6bce-fedf82ad0b1b@suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 05:15:01PM +0200, Vlastimil Babka wrote:
> On 9/24/19 1:42 PM, Kirill A. Shutemov wrote:
> >> --- a/mm/page_owner.c
> >> +++ b/mm/page_owner.c
> >> @@ -24,6 +24,9 @@ struct page_owner {
> >>  	short last_migrate_reason;
> >>  	gfp_t gfp_mask;
> >>  	depot_stack_handle_t handle;
> >> +#ifdef CONFIG_DEBUG_PAGEALLOC
> >> +	depot_stack_handle_t free_handle;
> >> +#endif
> > 
> > I think it's possible to add space for the second stack handle at runtime:
> > adjust page_owner_ops->size inside the ->need().
> 
> Uh that would complicate the code needlessly? The extra memory overhead
> isn't that much for a scenario that's already a debugging one
> (page_owner), I was more concerned about the cpu overhead, thus the
> static key.

Okay, fair enough.

-- 
 Kirill A. Shutemov
