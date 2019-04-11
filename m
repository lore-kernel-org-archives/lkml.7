Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F366C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DBD2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="aETz7abn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfDKLI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:08:26 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42629 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKLI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 07:08:26 -0400
Received: by mail-qt1-f194.google.com with SMTP id p20so6494581qtc.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 04:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BrWL5cUJ7Q9VjCaWG7iC17HiKVbyiOuihuBRu7fgqyc=;
        b=aETz7abniOl4e7+DOb09PavxLRotel7kJCk74Ao7xi6iXh4035rmyXLnjLc1AC7QAO
         qmWcaPbYuO08VIlIweDHCdx2ELh+F+QAL4loRPySdpl+sE+HG2YeAgbXgprtG3jGQ/xA
         Od3nE4KuHXRpy+ZxFDJ+Hu9Vcw7BNN1fodzWKd+1vCLx/KZpyYKvCODFl55ylKIzk3RE
         nmElPELmiCkTB1cfq+2jSIDeJIpgNBy+LB2x030VbZQ9zzN7gniLAY1fVyMvxmEe97sV
         I1vak7UGl6CEfNrUNZE7j0eW8p2ItVHpcY44bnK1P9N+RmCA454t7rpukGpOBYhn7eQV
         QebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BrWL5cUJ7Q9VjCaWG7iC17HiKVbyiOuihuBRu7fgqyc=;
        b=HSFIUztL+vvDYE0RsKppfpwNL5rQudamj84Yz8jKqv1MpqoYHhlGb6LmmddspQQBp5
         7/hu+eURTSZdmahlFPk2a4ltRS9NjMf+BDqRavFcYKTp1FhDvM+j1S3aG9v9P0xvZ+va
         tzGvQS8gyv7LL/oWPHu95JvLS0ugzE3GFNSIol51a28+MKNihNJ721dbfnpx4wBN0dba
         CPBK+mvEIu7Wmtn1s6bUuBelKTQ1bVeNxGEaiGjgjoozw4fK7u3P1wIBu80NyzZ8zshq
         pSxnwrWrMvaaByTv71nUT0iOuRPI8uOWNdjQw2g1XMBdE57UcMU/tq8iBzhJFK0o9cFW
         10GA==
X-Gm-Message-State: APjAAAWDhfpKD/x5tXUn54StlZbdM9q4Pu9q1VGC6ttl0mC6KROU8jv0
        3c2Ndqejq0bsgU2jHC9j0yTQMg==
X-Google-Smtp-Source: APXvYqzJI/Ye781pG1kq/AXJLXP983d6SGgYHt0QuC/1Q91EfvxZngkCINzqhN2vJqknEOb7ng8/Pw==
X-Received: by 2002:aed:3a44:: with SMTP id n62mr42701258qte.147.1554980905245;
        Thu, 11 Apr 2019 04:08:25 -0700 (PDT)
Received: from Qians-MBP.fios-router.home (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g12sm21105028qkk.85.2019.04.11.04.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 04:08:24 -0700 (PDT)
Subject: Re: [PATCH] slab: fix an infinite loop in leaks_show()
To:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Tobin C. Harding" <tobin@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>
References: <20190411032635.10325-1-cai@lca.pw>
 <43517646-a808-bccd-a05e-1b583fc411c7@suse.cz>
From:   Qian Cai <cai@lca.pw>
Message-ID: <02049855-d37f-965e-12f7-f2549cae73ec@lca.pw>
Date:   Thu, 11 Apr 2019 07:08:23 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <43517646-a808-bccd-a05e-1b583fc411c7@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/19 4:20 AM, Vlastimil Babka wrote:
> On 4/11/19 5:26 AM, Qian Cai wrote:
>> "cat /proc/slab_allocators" could hang forever on SMP machines with
>> kmemleak or object debugging enabled due to other CPUs running do_drain()
>> will keep making kmemleak_object or debug_objects_cache dirty and unable
>> to escape the first loop in leaks_show(),
> 
> So what if we don't remove SLAB (yet?) but start removing the debugging
> functionality that has been broken for years and nobody noticed. I think
> Linus already mentioned that we remove at least the
> /proc/slab_allocators file...

In my experience, 2-year isn't that long for debugging features to be silently
broken with SLAB where kmemleak is broken for more than 4-year there. See
92d1d07daad6 ("mm/slab.c: kmemleak no scan alien caches").
