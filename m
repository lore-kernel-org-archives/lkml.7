Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B27C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 03:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77E922CED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 03:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YcVaHG7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfH2D3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 23:29:04 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:46635 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfH2D3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 23:29:04 -0400
Received: by mail-pl1-f181.google.com with SMTP id o3so889388plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 20:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JGxbE50uXwCgfhAfE1eTU8tNsVQiLS6htVfulohzZj4=;
        b=YcVaHG7J8kEUDEEpnsah1aC33aFF/zVr9WtxqWBS/dVq90U/A5AgzuMSwi522I98nE
         JO8rA9dtet4C9wMyT2ZBAADep7t6cOkCV8+4UOo6nfksXdT4Rd6v/g4xKys4wjTQvkAG
         hhvxC14TXxXJauZWxqVQU8IzKF66W5niRk7fIdp8Ix9De6qGWEOhuAMoe6kKLhTxxf6t
         TtHfwstOlHFEUJr66LCpaRJWxc52yQZRenzaX/zb/M98dxweJf6eqPo1jJ1hhg+UCw3G
         Saes9+wAsSIoIkuN0nuZqPYVFo3jt6AceCpIOvGpk/p1tGh3dX2TQzyPA8xsqopw8kJA
         0RqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JGxbE50uXwCgfhAfE1eTU8tNsVQiLS6htVfulohzZj4=;
        b=lc1zavzMTRWcG4EX/tfKgwfa/jYNDbJLJf3Z9EJX00WXFU30TmzP5Ka7/oZ0NDn8NU
         oQ6/Uec0FUomnqSy47sNm37D2yG9djvSbJwXHc+cQgYpiKqeDQDMlUa3krSVQzDGbmbk
         MFx6Xyb31xsJUVWXWL/BWiW/PTs4jSYAY/Ypr/8utZNe8f2pXo0WsxSpo1njtOGzMywo
         rviCzY48ZzPM7KtJnFC3WR72bfbBTMsKQ+tHvfhAaI0Q1FyeSmW7+XTET4cA8ncc+SSq
         rszQ0OhcsVmYg3GGB0p/vc6PUES/E5tA6qSZzVgIGuza81w2pEPwd4x9nGKVY511gRRU
         aabA==
X-Gm-Message-State: APjAAAVlLsJFCNICYU35MCbIxIfRURDRYd5vM2RblD28NsBC4BeO6AGd
        MvIRV1JVVnT5bnaAuny65A/nFQ==
X-Google-Smtp-Source: APXvYqz+BYvMbypoZoZy80tENbu+/0EycC793rpafApGirMRqvp3VXLwhMl4+uoaKwWdC97/mFhG0w==
X-Received: by 2002:a17:902:8543:: with SMTP id d3mr7863103plo.80.1567049343394;
        Wed, 28 Aug 2019 20:29:03 -0700 (PDT)
Received: from [192.168.1.188] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id 136sm859015pfz.123.2019.08.28.20.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 20:29:02 -0700 (PDT)
Subject: Re: [PATCHSET v3 block/for-linus] IO cost model based work-conserving
 porportional controller
To:     Tejun Heo <tj@kernel.org>, newella@fb.com, clm@fb.com,
        josef@toxicpanda.com, dennisz@fb.com, lizefan@huawei.com,
        hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org
References: <20190828220600.2527417-1-tj@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f48b98fa-b33e-b3d3-2657-04f599e710fd@kernel.dk>
Date:   Wed, 28 Aug 2019 21:29:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828220600.2527417-1-tj@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/19 4:05 PM, Tejun Heo wrote:
> Changes from v2[2]:
> 
> * Fixed a divide-by-zero bug in current_hweight().
> 
> * pre_start_time and friends renamed to alloc_time and now has its own
>    CONFIG option which is selected by IOCOST.

This looks fine to me now, I've queued it up for 5.4.

-- 
Jens Axboe

