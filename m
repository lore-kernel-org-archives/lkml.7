Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9D7C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DCD207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j6yRt0oa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfK0Smv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:42:51 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:46406 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfK0Smv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 13:42:51 -0500
Received: by mail-pj1-f66.google.com with SMTP id a16so10404433pjs.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 10:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CZVXp4jTn3AxGkNEiypeb8rdOk5szYATq8RNyz6w/wM=;
        b=j6yRt0oaznyATDXrogCBscbi+Vg8MB0M2Z2pRH8rI3wIaFOVfPcEcp8qRb3zaNI8k+
         4jt5U8C8uD/xHkGHbIW2o3uH6cYJaKYKkVw/ItpOgENvfkyYoEw7c/HGR4yCMihM1v3f
         /zTXWOZd6w0TdXp0A66ksIzqq35QkODSG0GAZAebRcNg18gb64gx9cpVxiKbMWafXx+i
         u8Cf4XFxbVXtPHZHyeA5bmZp5X5zbaqUacB5uFtDWo2lXREJi1Q3OrK/Ay6MmeNmtMBS
         +c91qeiUPBlqlvoiu2yR2w6STXJe0ACUog4Lb356VHDKs9SgkdCfF7N4seEIgslGkjRl
         zfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CZVXp4jTn3AxGkNEiypeb8rdOk5szYATq8RNyz6w/wM=;
        b=tBvYJ63IHk2OjBsKSCYfRLsFCD12qHA6JHYrMKhPDqkqjWqw04rqgdr9JlO/3tgxwb
         ++IxhiQZbE3g6u5b2oGMSjyy4kCs0Wk98H2u4QSOixZQfcu/+Vbm7Zz1HaABiJnjQh5e
         1tuFtVVrXQJt98pigGCoSBWmkXLlvNwdbqUnmak1CaloLYyuF9DnmZispsHTLp+mGCnB
         Byj+kz+vCabl8LcLjtfWt2mh2YLh4qhUb2H1M//i4nO74oH9//MISseA7KzcsmzuCcoH
         wjN/5nhp8RM6BO/8z4fmH/CsG5Xix5W/cs9gqQE2PQHY55uewRJVG6eLAWzcy0AAql08
         ZueA==
X-Gm-Message-State: APjAAAWvd7Wzj4vfN0YR3e8wGVYnGna4WzcRq27BV5sRCEE/bVb0MnzB
        qSbkf6YTAPcl1i74nm4gUKg2iQ==
X-Google-Smtp-Source: APXvYqwkG6dHA1vS8RkBB3zlZfXMnaqbdTG/2aVXx/SvoAEkJtlFZADwufTjQcvmUjql/dBgQ7mpFg==
X-Received: by 2002:a17:902:900b:: with SMTP id a11mr5485790plp.116.1574880170025;
        Wed, 27 Nov 2019 10:42:50 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id u9sm17413696pfm.102.2019.11.27.10.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 10:42:49 -0800 (PST)
Subject: Re: [PATCH] x86/fpu: Don't cache access to fpu_fpregs_owner_ctx
To:     Borislav Petkov <bp@alien8.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Josh Bleecher Snyder <josharian@gmail.com>,
        "Rik van Riel\"" <riel@surriel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, ian@airs.com
References: <c87e93c3-5f30-f242-74b7-6c7ccc91158a@google.com>
 <20191126202026.csrmjre6vn2nxq7c@linutronix.de>
 <e4d6406b-0d47-5cc5-f3a8-6d14bd90760b@google.com>
 <20191127124243.u74osvlkhcmsskng@linutronix.de>
 <20191127140754.GB3812@zn.tnic>
From:   Barret Rhoden <brho@google.com>
Message-ID: <f4d5ca28-a388-c382-4b1a-4b65c9f9e6e7@google.com>
Date:   Wed, 27 Nov 2019 13:42:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191127140754.GB3812@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Use this_cpu_read() instead this_cpu_read_stable() to avoid caching of
>> fpu_fpregs_owner_ctx during preemption points.
>>
>> Fixes: 5f409e20b7945 ("x86/fpu: Defer FPU state load until return to userspace")
> 
> Or
> 
> a352a3b7b792 ("x86/fpu: Prepare copy_fpstate_to_sigframe() for TIF_NEED_FPU_LOAD")
> 
> maybe, which adds the fpregs_unlock() ?

Using this_cpu_read_stable() (or some variant) seems to go back quite a 
while; not sure when exactly it became a problem.  If it helps, commit 
d9c9ce34ed5c ("x86/fpu: Fault-in user stack if 
copy_fpstate_to_sigframe() fails") was the one that popped up the most 
during Austin's bisection.

>> Also I would like to add
>> 	Debugged-by: Ian Lance Taylor
> 
> Yes, pls. CCed.

To close the loop on this, here's what Austin wrote on the bugzilla:

> --- Comment #2 from Austin Clements (austin@google.com) ---
> I can confirm that the patch posted by Sebastian Andrzej Siewior at
> https://lkml.org/lkml/2019/11/27/304 fixes the issue both in our C reproducer
> and in our original Go reproducer. (Sorry, I'm not subscribed to LKML, so I
> can't reply there, and I'm on an airplane, so it's hard to get subscribed :)
> 
> Regarding the question about the "Debugged-by" line in the patch, debugging was
> a joint effort between myself (Austin Clements <austin@google.com>), David
> Chase <drchase@golang.org>, and Ian Lance Taylor <ian@airs.com>.

Thanks,

Barret
