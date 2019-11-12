Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C18C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50CEB21925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="y5/nTQrs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfKLPsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:48:47 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33748 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfKLPsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 10:48:47 -0500
Received: by mail-qt1-f195.google.com with SMTP id y39so20271860qty.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 07:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oX2RUUJ5hbLNK76X6QyX6ezOGkko2VCAlxrvKipPj6A=;
        b=y5/nTQrsRZXlN/SmnUnPqpq3yRbtQBn2KCJNT1eHTmPHrmYb27+rxnFkfwE4F60Q4Y
         eLfm7ZJbIXi3/4PEpAnGT1PERPNa826HjgOmVbRFJEyHK43yPoRan+L2eb6S8Bj/BPnN
         y49fftyBwZbA8xUK1XMlaZwchSADEOx/rRp2JAc2LcHULcfJFnXU8R2h7TDMfA6/3AX+
         2mmV7d+Ou3ZKSn4bxnyEJ5JIeETsr/RZzmJAdm8ply3by/YTsmC893CCW3az9iBvgcXe
         qAXs9LEUs6UWJpGvs2HBA6wZ3+EkS3eVz+b3ZfCY5TLMOjhUErMDiYovPl57H8HZIKrM
         thaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oX2RUUJ5hbLNK76X6QyX6ezOGkko2VCAlxrvKipPj6A=;
        b=ZKWInZQeRAzaaxrmvODUYLJU8ErJsvK0EGewm3j4HFwfHlvkMgUKDHuPASieGBybal
         IaapAhBbjLWOqXfxy+BIBrFpII6s7dKqLdJ9jFsvLMjFvcZAnH03ZovhF6wcae5Veezt
         Iy97vdoD/hpagdRMUuRX0S0p08qE5L06Vu+0GoGEOEFJoBN9ucUfBfmsF2YGMznD5IDn
         RUriNFdjIuR9VFQ4oMZxSr6ED17vTxa9MtJkKWiE9I290yrxs2Dr/DW7o8dQo37EjEdT
         VL3T6OEbfL7+hrimu+2KKSFhIwGdfObmdu7Icog8/unN5jwvQ/TGo4WFCgnINm2sB/0g
         BSew==
X-Gm-Message-State: APjAAAU6LwMj/SgaFPwudgjHLuSRCwUggaRbasMyZzWw84dBXC4rqpR1
        3tvE7q3vn3ZtQ8gFkQcDaM/aHQ==
X-Google-Smtp-Source: APXvYqwuMUtiv2HnwG4a0VCclUfrG4lepGDUIEOHsvZ0CLBdrLsxSYWb6zud4uKNuOiZA2L5iT62tA==
X-Received: by 2002:aed:3ef2:: with SMTP id o47mr32988985qtf.107.1573573726084;
        Tue, 12 Nov 2019 07:48:46 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::aa8c])
        by smtp.gmail.com with ESMTPSA id w15sm11040648qtk.43.2019.11.12.07.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 07:48:45 -0800 (PST)
Date:   Tue, 12 Nov 2019 10:48:44 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     tim <xiejingfeng@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] psi:fix divide by zero in psi_update_stats
Message-ID: <20191112154844.GD168812@cmpxchg.org>
References: <C377A5F1-F86F-4A27-966F-0285EC6EA934@linux.alibaba.com>
 <20191112154144.GC168812@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112154144.GC168812@cmpxchg.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 10:41:46AM -0500, Johannes Weiner wrote:
> On Fri, Nov 08, 2019 at 03:33:24PM +0800, tim wrote:
> > In psi_update_stats, it is possible that period has value like
> > 0xXXXXXXXX00000000 where the lower 32 bit is 0, then it calls div_u64 which
> > truncates u64 period to u32, results in zero divisor.
> > Use div64_u64() instead of div_u64()  if the divisor is u64 to avoid
> > truncation to 32-bit on 64-bit platforms.
> > 
> > Signed-off-by: xiejingfeng <xiejingfeng@linux.alibaba.com>
> 
> This is legit. When we stop the periodic averaging worker due to an
> idle CPU, the period after restart can be much longer than the ~4 sec
> in the lower 32 bits. See the missed_periods logic in update_averages.

Argh, that's not right. Of course I notice right after hitting send.

missed_periods are subtracted out of the difference between now and
the last update, so period should be not much bigger than 2s.

Something else is going on here.
