Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14CAC41514
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BBE2342F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="KujSBNcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfH3SG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 14:06:58 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42994 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727914AbfH3SG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 14:06:58 -0400
Received: by mail-qk1-f194.google.com with SMTP id f13so6864789qkm.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 11:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eh/2xbIwVNXN4tuwrJrTCLRZrKWzmJtO4ybIQHEw8mA=;
        b=KujSBNcd5SoFevO+SIWyVxNL2n8N59q866IgsFF+b4gnTMQoPBc4O3jXPhX+91LAlL
         EHWO226T7vbNq9hI1ljfS3DukO6LCC2psnfnNm66EMZXiODoPgArR8L90Tkqu1u7swFF
         ipL5OtwUyVIeld46J6UdhSPiznQJkydM2RVU342XX28AIeIO3WIME/q8Rs0yIt1vUThB
         /xJf00BWO/h6v/cyK8vHapVVSmQ8pebW1wGfPGTJzQ4GMJXdViWdl67rGFycGbuhVX81
         75KGcXJF/MzMXna8XIJwG0r14xvvRbIefhO0lzEgrkyS4ShAciBA0KThkeuYUnDUgvhR
         hhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eh/2xbIwVNXN4tuwrJrTCLRZrKWzmJtO4ybIQHEw8mA=;
        b=rc2iJwBONuI/KNp+ZSDFpK9y1UXZgNduQlRBj/YD8h5AKwqCyN3v5HfqZQ6GeGoBP8
         fk1KQlUdE2MPM/1Amhmol6F+BzkKKwmT66ooMCwNtwbC+Oc38eDZ6lp1Qqr4agdLg1ZT
         MBdB1op/T1SksKAdyXeY+s7swY3M93IcSGrNUGvppnuzi2UicY/sqmNdMaQ6Tr/OdbV1
         oM6tgViG8Z7IThNL3WRC6nFGdopnTM6330owgQcO8U0LRKgc8umA3S41nnvwckw4OVkx
         Apj9S68Ph8wx1i1aleSPK9jT4p1txr6Qd+vRjv/tfmJNVa8QB5vEykjBcuxTQLUCQgZJ
         Nlwg==
X-Gm-Message-State: APjAAAViZqHcDu512xeKSE+crg4AQGXoQ+5JyKME7CBRhjnrLgfqW7iR
        QAj1R6USClXyyxUoS5P7IKgqTS/LEOw=
X-Google-Smtp-Source: APXvYqypwYuBFK8wvrgeET1bmyo6DjclpnUDfuFsrQR2cf917OvSt7wSb8I7zRi8wHlfjL+eSSoXaQ==
X-Received: by 2002:a37:8905:: with SMTP id l5mr16945385qkd.152.1567188417069;
        Fri, 30 Aug 2019 11:06:57 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id e2sm2939266qki.70.2019.08.30.11.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 11:06:56 -0700 (PDT)
Message-ID: <1567188415.5576.34.camel@lca.pw>
Subject: Re: [PATCH] net/skbuff: silence warnings under memory pressure
From:   Qian Cai <cai@lca.pw>
To:     Eric Dumazet <eric.dumazet@gmail.com>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 30 Aug 2019 14:06:55 -0400
In-Reply-To: <229ebc3b-1c7e-474f-36f9-0fa603b889fb@gmail.com>
References: <1567177025-11016-1-git-send-email-cai@lca.pw>
         <6109dab4-4061-8fee-96ac-320adf94e130@gmail.com>
         <1567178728.5576.32.camel@lca.pw>
         <229ebc3b-1c7e-474f-36f9-0fa603b889fb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-30 at 18:15 +0200, Eric Dumazet wrote:
> 
> On 8/30/19 5:25 PM, Qian Cai wrote:
> > On Fri, 2019-08-30 at 17:11 +0200, Eric Dumazet wrote:
> > > 
> > > On 8/30/19 4:57 PM, Qian Cai wrote:
> > > > When running heavy memory pressure workloads, the system is throwing
> > > > endless warnings below due to the allocation could fail from
> > > > __build_skb(), and the volume of this call could be huge which may
> > > > generate a lot of serial console output and cosumes all CPUs as
> > > > warn_alloc() could be expensive by calling dump_stack() and then
> > > > show_mem().
> > > > 
> > > > Fix it by silencing the warning in this call site. Also, it seems
> > > > unnecessary to even print a warning at all if the allocation failed in
> > > > __build_skb(), as it may just retransmit the packet and retry.
> > > > 
> > > 
> > > Same patches are showing up there and there from time to time.
> > > 
> > > Why is this particular spot interesting, against all others not adding
> > > __GFP_NOWARN ?
> > > 
> > > Are we going to have hundred of patches adding __GFP_NOWARN at various
> > > points,
> > > or should we get something generic to not flood the syslog in case of
> > > memory
> > > pressure ?
> > > 
> > 
> > From my testing which uses LTP oom* tests. There are only 3 places need to
> > be
> > patched. The other two are in IOMMU code for both Intel and AMD. The place
> > is
> > particular interesting because it could cause the system with floating
> > serial
> > console output for days without making progress in OOM. I suppose it ends up
> > in
> > a looping condition that warn_alloc() would end up generating more calls
> > into
> > __build_skb() via ksoftirqd.
> > 
> 
> Yes, but what about other tests done by other people ?

Sigh, I don't know what tests do you have in mind. I tried many memory pressure
tests including LTP, stress-ng, and mmtests etc running for years. I don't
recall see other places that could loop like this for days.

> 
> You do not really answer my last question, which was really the point I tried
> to make.
> 
> If there is a risk of flooding the syslog, we should fix this generically
> in mm layer, not adding hundred of __GFP_NOWARN all over the places.
> 
> Maybe just make __GFP_NOWARN the default, I dunno.

I don't really see how it could end up with adding hundred of _GFP_NOWARN in the
kernel code. If there is really a hundred places could loop like this, it may
make more sense looking into a general solution.
