Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C92C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656BD23C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R66SrP4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfE2PZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:25:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34370 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfE2PZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:25:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id n19so1869910pfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 08:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8fDLamalhq9zwp0W3zCZkIPwsllp49nCKwsLUyTJ3Hc=;
        b=R66SrP4CmgFcNeUP8BET9lkK2bUkt81I/nJIZDpuDb6b54j4CNcYX91lBtMdtlSLEn
         7hXaQkv8+wCEduPHFzF5QQsZBB4EvxYNDJ0Yu0slJVXcyIHDE8PdP99/skhi4t5TfZns
         UnhObnEOY9cPJ+7qZsIDoNGlz9V0C2x0RjSb5EUK5LHgq/YI1u7Hms24qhK+5zG3NluC
         qHNoUPQX33HkAf6F6bd5cTqNpxR6AFN/sFlcg7Id6tsPNSC8qXto8nW5yiqL70eYzrYi
         2sVH5EKxfNO99oP8vxU9KSki1q2W9jKAMYSnRrmuZVTaUhNPYUwFTGTDr/BnWZhk47Li
         9xjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8fDLamalhq9zwp0W3zCZkIPwsllp49nCKwsLUyTJ3Hc=;
        b=XDc7YbJAaZubn4GtbSawEYZVZuqn65fqgKlDefb+Z0BuCSgEJP2GMVDISUHUg3UPiv
         iE3EZKVSQqBmj4/fFLa3cSfrpmwtJVzNbUvqSJIKSpUTl/rrrIPTdB9zYGWQlxEeizmv
         m/2CgbEDTHAU6djeH/JqrQHZ/FrKKDW6CqfpKD5eNbsLQSy6hLaJi8Je277Rw9JncIta
         rfCWE7M2Z2W3v8VUqOOS2/z7fhx8OEOiB9wwknbBOPYNSO/EmB8Y2ZXvThRGzerqSwyg
         fCSgdisn9bX3o1P/FFrYPFXNj3IEf/j+hPAniFalR08jsUTULNrFk7ukQe0H8VQ6Wzlw
         kC8w==
X-Gm-Message-State: APjAAAWR6jyk3z7jiUL1IO1LSQ7/L0Zps6vE6MGFKJJr9Qr4Ec6QH64/
        d1pbYs0/AXpQ75o6fnLl8U0D1/AC
X-Google-Smtp-Source: APXvYqyAA83krJlMy4Qvv+s+/SeDJPz5OhDu6JhT48rvqo/9btgZdD2u0/ydQebmJDOgdzcLJYI4Wg==
X-Received: by 2002:a63:6445:: with SMTP id y66mr29504576pgb.23.1559143501459;
        Wed, 29 May 2019 08:25:01 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id f2sm14826080pgs.83.2019.05.29.08.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 08:25:00 -0700 (PDT)
Date:   Wed, 29 May 2019 23:24:43 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] [PATCH] dm-init: fix 2 incorrect use of kstrndup()
Message-ID: <20190529152443.GA4076@zhanggen-UX430UQ>
References: <20190529013320.GA3307@zhanggen-UX430UQ>
 <fcf2c3c0-e479-9e74-59d5-79cd2a0bade6@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcf2c3c0-e479-9e74-59d5-79cd2a0bade6@acm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 05:23:53AM -0700, Bart Van Assche wrote:
> On 5/28/19 6:33 PM, Gen Zhang wrote:
> > In drivers/md/dm-init.c, kstrndup() is incorrectly used twice.
> > 
> > It should be: char *kstrndup(const char *s, size_t max, gfp_t gfp);
> 
> Should the following be added to this patch?
> 
> Fixes: 6bbc923dfcf5 ("dm: add support to directly boot to a mapped
> device") # v5.1.
> Cc: stable
> 
> Thanks,
> 
> Bart.
Personally, I am not quite sure about this question, because I am not 
the maintainer of this part.

Thanks
Gen
