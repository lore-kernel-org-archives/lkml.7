Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64741C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3534321734
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="cxzzcGAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfEHRtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 13:49:20 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45099 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfEHRtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 13:49:19 -0400
Received: by mail-qt1-f193.google.com with SMTP id t1so4016064qtc.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 10:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MYokK5wm2I2ALJEgNMuacgIvUBpvCuKZvYIQRVxW+n4=;
        b=cxzzcGABhAO7WvvlBq3PxupkpQLtH7rV+VckH/4En1y7BYRa8ppp15DjkpiAiXY1d5
         AbwzAR4zHINJeV4U+3BNsFYz+OwWGPL6h/5H2dEIjfxIYlUbFsNExKXbREdCJvER0Ogt
         8wRoWFdWXFE9Q6SZc9i0bXTSlZm8qkXB/sMxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MYokK5wm2I2ALJEgNMuacgIvUBpvCuKZvYIQRVxW+n4=;
        b=YY4tRO6nUUpXsELq3fwLx+IgzQqHVJ6jx+CPFWAe57lFT8udCZxLfMpW1FUz58cO9i
         ZNXZgX3gYZXQhXirUAi2z4nxef54FFHGde6honPwne5r0tAbRi0FP6aTZPUNVYPBj0mC
         2tu2HxTy7eb0F5BWFKh0qiQ6fdXqQatymGeggZU4SiKHqaSOz4tPMPOyBvyxBlWQsNxZ
         Rt84X0sA9cyNKurcM5TyiCfEhSxwjCojJmJQWk9vVK+VdfBQJTFCT7zieU6yi7VUWFh0
         jWbGCuvruBu/+xu2ZFJKZ0NGRsNuMwcqoFKkWWjsX7/4Y+kUxb91IGw+5GXClKjg7sT1
         n/yA==
X-Gm-Message-State: APjAAAWIcDKnbOF1qipB5s39RpZD2EQ0WliBdSRsp9bE2SIOw/rWsvrf
        IMGriAfEAPMabT7BUASYJHm5jA==
X-Google-Smtp-Source: APXvYqzFefyRlWR/pOxdSeFXzfWQw1bV4Jo4xJ7a+BIhyYmUP/zIIViSajTbu68stcyHws1FEEuwUg==
X-Received: by 2002:a0c:96eb:: with SMTP id b40mr30408822qvd.188.1557337758833;
        Wed, 08 May 2019 10:49:18 -0700 (PDT)
Received: from sinkpad (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id n66sm9496354qkc.36.2019.05.08.10.49.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 10:49:18 -0700 (PDT)
Date:   Wed, 8 May 2019 13:49:09 -0400
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Phil Auld <pauld@redhat.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
Message-ID: <20190508174909.GA18516@sinkpad>
References: <20190423180238.GG22260@pauld.bos.csb>
 <20190423184527.6230-1-vpillai@digitalocean.com>
 <20190429035320.GB128241@aaronlu>
 <20190506193937.GA10264@sinkpad>
 <20190508023009.GA89792@aaronlu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190508023009.GA89792@aaronlu>
X-Mailer: Mutt 1.5.24 (2015-08-30)
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-May-2019 10:30:09 AM, Aaron Lu wrote:
> On Mon, May 06, 2019 at 03:39:37PM -0400, Julien Desfossez wrote:
> > On 29-Apr-2019 11:53:21 AM, Aaron Lu wrote:
> > > This is what I have used to make sure no two unmatched tasks being
> > > scheduled on the same core: (on top of v1, I thinks it's easier to just
> > > show the diff instead of commenting on various places of the patches :-)
> > 
> > We imported this fix in v2 and made some small changes and optimizations
> > (with and without Peter’s fix from https://lkml.org/lkml/2019/4/26/658)
> > and in both cases, the performance problem where the core can end up
> 
> By 'core', do you mean a logical CPU(hyperthread) or the entire core?
No I really meant the entire core.

I’m sorry, I should have added a little bit more context. This relates
to a performance issue we saw in v1 and discussed here:
https://lore.kernel.org/lkml/20190410150116.GI2490@worktop.programming.kicks-ass.net/T/#mb9f1f54a99bac468fc5c55b06a9da306ff48e90b

We proposed a fix that solved this, Peter came up with a better one
(https://lkml.org/lkml/2019/4/26/658), but if we add your isolation fix
as posted above, the same problem reappears. Hope this clarifies your
ask.

I hope that we did not miss anything crucial while integrating your fix
on top of v2 + Peter’s fix. The changes are conceptually similar, but we
refactored it slightly to make the logic clear. Please have a look and
let us know

Thanks,

Julien
