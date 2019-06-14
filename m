Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C56C31E4D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875392173C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="w85yzapM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfFNNsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:48:33 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40679 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbfFNNs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:48:29 -0400
Received: by mail-qk1-f193.google.com with SMTP id c70so1673565qkg.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 06:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rnGRxFxOoVoCJlpWf5YwCxAGlT+Sc1FUpYO8QlgwSjM=;
        b=w85yzapM6oQuLGvkrulj+iPAX76vQ9VdYBXRlGt9Hf8SiFTFl+1a7viss9jINwRpsN
         J9A+qVYyXcJ/tZhZ1RHj2aYpCaxlLR392Juyc6Gs6KJhXgkQaA1uUOCVvAbN950OW5kZ
         5d06dcracY0f2RCO7wti/DHByanIMsFUvNA/XzJzZ5+809Sqozt5M+rggEn7q5tTFqrb
         uE6JF6wincuKAPQ5HPmSmcSA4N5Y/Zn5eZeAaLgbC6iiZZ+P0hqEbE9zaNirjH0Hv9v1
         P9CAJkt+sqvxlR0u9VjU5FNAuaN7P/kDv1YkpAyYd4cRVdBXcV3T+G3nFkGRy/elTMOr
         OMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rnGRxFxOoVoCJlpWf5YwCxAGlT+Sc1FUpYO8QlgwSjM=;
        b=SYQwbuFmgn5GSBlFT6LgMS1qYC5cIb4bctO+jxi+PO9v256aBKc4D31a/8DSmgiSz7
         2cknOx0ob2z8ANwSVxmhdVEZwMaNn+Kh/V6NToEPcAIaaFQwzt9wtsAgHp2J9f/2T4vQ
         XwEXSLWKYYRisBxkl74UNXMNh/K/AyeEYEvyO4BLQX8CvsuFi4alMv+HRsATvmX1lHI5
         uB2JDdEFXELLcU2pm7LdcTzX4bPmmWq3UB8maz3kps/8NmzEh3zgq01VoFwzxkbUAn47
         /4r17ZiLrjH/Otn1s0FBoueQ9JWOt06cy1pB6QNXtwkNKQEqdToo8DmPzZ5rZq6bHbU6
         PKsA==
X-Gm-Message-State: APjAAAVQs34f31VJkDuI5WZ/jVeG+UumKemKPcCZWRSo8c8f0uFNnZzM
        FI3wEpzWetUVC+x9ANBzb/8wDA==
X-Google-Smtp-Source: APXvYqwsR8RvRpY6ld/gvqnd2sdXs0I92KrB7t3+rTb1qpbvIeD3KNowVm1Bjsyu4kJI09jR3h7lCQ==
X-Received: by 2002:a37:e30b:: with SMTP id y11mr57978829qki.100.1560520108439;
        Fri, 14 Jun 2019 06:48:28 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::a658])
        by smtp.gmail.com with ESMTPSA id w189sm1341749qkc.38.2019.06.14.06.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 06:48:27 -0700 (PDT)
Date:   Fri, 14 Jun 2019 09:48:26 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 5/8] Btrfs: delete the entire async bio submission
 framework
Message-ID: <20190614134825.ew3d2hfyczolylr6@MacBook-Pro-91.local>
References: <20190614003350.1178444-1-tj@kernel.org>
 <20190614003350.1178444-6-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614003350.1178444-6-tj@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 05:33:47PM -0700, Tejun Heo wrote:
> From: Chris Mason <clm@fb.com>
> 
> Now that we're not using btrfs_schedule_bio() anymore, delete all the
> code that supported it.
> 
> Signed-off-by: Chris Mason <clm@fb.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
