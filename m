Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9442DC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F5120656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557420828;
	bh=x9XaOPV8oeYyRvbwF/5YSwBbDw9XI2ioXgXp4ApXfwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wVDaJmNPnkBfJsfGHLAihlhpeLhJ1D+Z8K51up8uYFeOe8fZknJm+qnDmJEqsfUfJ
	 p3iCNoilP/P4lmSsoni+iFfj2EParyUXE/rKJDk9wBOUjOIiwB2UYvPK4UPx5zFVIx
	 UkwqE7W88327U9o9ICDYHsN/gPNiGlefxpnZ+R5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfEIQxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 12:53:47 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42733 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfEIQxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 12:53:47 -0400
Received: by mail-qk1-f193.google.com with SMTP id d4so1866628qkc.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 09:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZCcib+4HBdkkyiz91cBBA/QR5BcBCmR0H5WvWgqdP7g=;
        b=tSLMv3drSwwbzlR1l0tGdAUZkzjeBZsSkb2DDjXqig1uiMKZ/8kp+42+xkoG7WeB6C
         Vx3k6EVgxmjqOd7jARsoPsDZ9YrEq1ZZWio+tyDv7RJKE1QW/LoahVe58RU12oHRHiTV
         IgeYm9KSmW5pv5nPpv9PCf5LYyAQw6AkgXxKoBZijKkrCmWhPgo3q2OQNs2LQsmiqmgw
         GDpg9IaFaGZyId30F2oQEsNOUqvvXnklPttau/fz3vte4EU5WIq53LeAmlovwexmzz4j
         SatcKgCI82BFbNiaKHOa6np+MmEOcm6WHW8i7EQ9xFkx+2Z+55m7zXL+OqbcltD8SiBN
         DsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZCcib+4HBdkkyiz91cBBA/QR5BcBCmR0H5WvWgqdP7g=;
        b=JCha4+F5iJVAb9npc3KVPdaS6K4s40nwq9a9SlNNW9Cc5kBeTWRQi1PYh42VM+12Yd
         NAwHY1JQQNdN43AUOvnEdB9DR2eWxxJzCOgEnpyP7EmL/H7VvTueJ3wvMDyYodOfghqq
         jzy7eCBoztytsyTPGRHxP7c+G20XaNMWvexiKPEwf4Od+ajSZ9VN2CaEG/8u2bRSxtD7
         g/T3WNBXvEPdfkKPIKdVflC7F3zb2PFp2mSU+VmPRWnAlK70uc7Z2QxIaeTIWOZ4qDgO
         3/d14tstOOq/A4MoaCsTUP17ahcG9wceknaXK0rUrHaoj+Z3JUPbH+MgzFaVFw3n4TFE
         8s1A==
X-Gm-Message-State: APjAAAVVno99Rw7puAWL8QAj8KtcF+d7GNd+JI3jV1G7XUAduL4Wk5xv
        GSRjzT0/iowvToXmuM/pw2I=
X-Google-Smtp-Source: APXvYqwyd1bvz2xFFOqtBakqR5lcCDiU+UfTUKK0uz1daQwE0Mzt2DrwuhcaZkc8nO11aGNRZryPRA==
X-Received: by 2002:a05:620a:1134:: with SMTP id p20mr4111090qkk.20.1557420825891;
        Thu, 09 May 2019 09:53:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:c346])
        by smtp.gmail.com with ESMTPSA id k53sm1489077qtb.65.2019.05.09.09.53.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 09:53:45 -0700 (PDT)
Date:   Thu, 9 May 2019 09:53:43 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Song Liu <songliubraving@fb.com>,
        Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/4] percpu_ref: introduce PERCPU_REF_ALLOW_REINIT flag
Message-ID: <20190509165343.GX374014@devbig004.ftw2.facebook.com>
References: <20190507170150.64051-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507170150.64051-1-guro@fb.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 10:01:47AM -0700, Roman Gushchin wrote:
> In most cases percpu reference counters are not switched to the
> percpu mode after they reach the atomic mode. Some obvious exceptions
> are reference counters which are initialized into the atomic
> mode (using PERCPU_REF_INIT_ATOMIC and PERCPU_REF_INIT_DEAD flags),
> and there are few other exceptions.
> 
> But in most cases there is no way back, and once the reference counter
> is switched to the atomic mode, there is no reason to wait for
> percpu_ref_exit() to release the percpu memory. Of course, the size
> of a single counter is not so big, but because it can pin the whole
> percpu block in memory, the memory footprint can be noticeable
> (e.g. on my 32 CPUs machine a percpu block is 8Mb large).
> 
> To make releasing of the percpu memory as early as possible, let's
> introduce the PERCPU_REF_ALLOW_REINIT flag with the following semantics:
> it has to be set in order to switch a percpu reference counter to the
> percpu mode after the initialization. PERCPU_REF_INIT_ATOMIC and
> PERCPU_REF_INIT_DEAD flags will implicitly assume PERCPU_REF_ALLOW_REINIT.
> 
> This patch doesn't introduce any functional change to avoid any
> regressions. It will be done later in the patchset after adjusting
> all call sites, which are reviving percpu counters.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

For all patches in the series:

  Acked-by: Tejun Heo <tj@kenrel.org>

Thanks.

-- 
tejun
