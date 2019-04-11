Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09104C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D642083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JigCMARg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfDKI1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:27:33 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:58035 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725793AbfDKI1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:27:33 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 663755A4B;
        Thu, 11 Apr 2019 04:27:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 11 Apr 2019 04:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=8u2aEsZLEcR3+NjWzB2WQbH67+zA4PHcHkWEVgf17
        q8=; b=JigCMARgrDNIum5VLN/vsLwM+7b/HmaMjhOl1gQgI1DMsfEtQqx1Lp7V+
        I1LKTlANOniVThkARVNXhfzle/8SlP4NfgNpkJTg8HIUvDryMe5NqsIfP9ZPnBpj
        cm1QmSfLlvmamSRIQ/7QJZz9c2WKBAmZllGZvlhijoyOLXwG4O/QleI0bnmAf9A0
        dyZxq7AqyAL/j9MWFghdSCXxSmZI/oYZ8rkzytD1JbwlP5znLwquo9CdX+c+ZrIm
        FKIh6n+Qcvb9+OW9or4cHefL1Gop8IEXaP66p+iBv/6SWUMb4mx+12wNXyutZi1P
        qZO3AK7K/isKWsgBGqfEZn5IdM98Q==
X-ME-Sender: <xms:cvquXPlLS1jKDZyF9S0eQ_ARSvEfJaE7UTphtybQYLmmgUSR3eXa8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudelgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefrvghkkhgr
    ucfgnhgsvghrghcuoehpvghnsggvrhhgsehikhhirdhfiheqnecukfhppeekledrvdejrd
    effedrudejfeenucfrrghrrghmpehmrghilhhfrhhomhepphgvnhgsvghrghesihhkihdr
    fhhinecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:cvquXCamhNVXpsG2lkdemOFWlAxkJKq2ForH_5aE07efjcGoYJK3jw>
    <xmx:cvquXMEySeVlh6qzIBe5XnJoCw6dGLvQ3VvBDKXlDYuPz6GDL22hiQ>
    <xmx:cvquXHLQew1GiXylqBoe1ISWPi81u7HBHR74FEMTlUI8Fdss_PzvJQ>
    <xmx:dPquXBf-aX-K65DfcfNHEHMBQsnTnMeRjjbt4v2zvPC6APqNaf3OqA>
Received: from [192.168.1.104] (89-27-33-173.bb.dnainternet.fi [89.27.33.173])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2B2E01030F;
        Thu, 11 Apr 2019 04:27:28 -0400 (EDT)
Subject: Re: [PATCH 0/1] mm: Remove the SLAB allocator
To:     Michal Hocko <mhocko@kernel.org>, "Tobin C. Harding" <me@tobin.cc>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Tejun Heo <tj@kernel.org>, Qian Cai <cai@lca.pw>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
References: <20190410024714.26607-1-tobin@kernel.org>
 <f06aaeae-28c0-9ea4-d795-418ec3362d17@suse.cz>
 <20190410081618.GA25494@eros.localdomain>
 <20190411075556.GO10383@dhcp22.suse.cz>
From:   Pekka Enberg <penberg@iki.fi>
Message-ID: <262df687-c934-b3e2-1d5f-548e8a8acb74@iki.fi>
Date:   Thu, 11 Apr 2019 11:27:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190411075556.GO10383@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/11/19 10:55 AM, Michal Hocko wrote:
> Please please have it more rigorous then what happened when SLUB was
> forced to become a default

This is the hard part.

Even if you are able to show that SLUB is as fast as SLAB for all the 
benchmarks you run, there's bound to be that one workload where SLUB 
regresses. You will then have people complaining about that (rightly so) 
and you're again stuck with two allocators.

To move forward, I think we should look at possible *pathological* cases 
where we think SLAB might have an advantage. For example, SLUB had much 
more difficulties with remote CPU frees than SLAB. Now I don't know if 
this is the case, but it should be easy to construct a synthetic 
benchmark to measure this.

For example, have a userspace process that does networking, which is 
often memory allocation intensive, so that we know that SKBs traverse 
between CPUs. You can do this by making sure that the NIC queues are 
mapped to CPU N (so that network softirqs have to run on that CPU) but 
the process is pinned to CPU M.

It's, of course, worth thinking about other pathological cases too. 
Workloads that cause large allocations is one. Workloads that cause lots 
of slab cache shrinking is another.

- Pekka
