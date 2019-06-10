Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C3BC43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4522082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="uFpTPEcn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390146AbfFJV0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:26:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36805 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390113AbfFJV0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:26:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id u8so738330wmm.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 14:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mc4UMWOXRpniRfg/YA6rdVKg83xokm7a/gCcz99OO9Y=;
        b=uFpTPEcnhoeUfN6R5mS/lOy4jy1oPL6nbblkSqTL3TG6ZYKl4Pxl1LdjYlVGHE4QBh
         7cobvOiTm4Dt7Qxl5Wsm3bfUlRnGLQy++U5KUM2lb2RdGwjgtEUOTXKcJ/qaAdwKdIn5
         MigvAWwh4TWhqmQVABnzUWlYcGGL4jRKXiAUU115FuXk7VhXUn4aBBg251VqgU29hXob
         qbohthz5As7xrUJR2P6wDk6eviIerj1oIFJnSjgX+lq2S2z5rcKFPZ3mjNSFvqS0SJ+F
         YCawArjFy69uVVtkh42D83IbsOqKwQT10kjuIjbitXErUWL6s2RQ3PZCMCLO+9VCrpxR
         kv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mc4UMWOXRpniRfg/YA6rdVKg83xokm7a/gCcz99OO9Y=;
        b=XbrIlEjNJZCw3FtQU9ZCl5F9KE3Y6qmMjTrxsDjqKX0G7qe8Plb71Iq8SdHFXNKvdj
         3nZP+3/gh7TnyM8a+BMKf28xEyR3w5sXMP9O579COaDUkxSXugkqYx63SFkiG3cmpNTb
         H7qyoOgE20TQoX4Rld6Qq/pCGKYny7Hb7fpi0epK4gboJLu+MNzmq9B/8tgzMMTZHzeX
         vaxQ74N5UqpQzfg938j5HkuwBORcnY/cZU6DNcFJ9RbqIhhsjTi2u4x/taq3/vPoIZ5l
         jkGBP0+8x51JZBoXi8rIkOWSRAN9UM0XiEB5qv3FbBhommK7+nBjA2RydPUKYjtwZgji
         UPqw==
X-Gm-Message-State: APjAAAU1sxvTFPtymLwAER2o6quS7zYnTRQzrcGAeApqoc0dlQOfPPme
        A/ota2GvprovTnqeRx9BendpIX0O45k=
X-Google-Smtp-Source: APXvYqyeuGvHOcZX+1y8oIDrqD5qVR9OcS4PL/eW8U0fC1mdpO/PrNdlwlgxUsIg+qiq3RWx1Xo/GA==
X-Received: by 2002:a1c:108:: with SMTP id 8mr13793453wmb.159.1560201982401;
        Mon, 10 Jun 2019 14:26:22 -0700 (PDT)
Received: from localhost ([94.1.151.203])
        by smtp.gmail.com with ESMTPSA id r5sm22420399wrg.10.2019.06.10.14.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 14:26:21 -0700 (PDT)
Date:   Mon, 10 Jun 2019 22:26:20 +0100
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] sched/topology: Improve load balancing on AMD EPYC
Message-ID: <20190610212620.GA4772@codeblueprint.co.uk>
References: <20190605155922.17153-1-matt@codeblueprint.co.uk>
 <20190605180035.GA3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605180035.GA3402@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jun, at 08:00:35PM, Peter Zijlstra wrote:
> 
> And then we had two magic values :/
> 
> Should we not 'fix' RECLAIM_DISTANCE for EPYC or something? Because
> surely, if we want to load-balance agressively over 30, then so too
> should we do node_reclaim() I'm thikning.

Yeah we can fix it just for EPYC, Mel suggested that approach originally.

Suravee, Tom, what's the best way to detect these EPYC machines that need to
override RECLAIM_DISTANCE?
