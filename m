Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39A4C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 23:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D0421479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 23:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IG4p+iPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfDRXSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 19:18:04 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41127 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfDRXSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 19:18:04 -0400
Received: by mail-pg1-f193.google.com with SMTP id f6so1847716pgs.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 16:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4+PQ66vk9KRKMNJbABmZKkCe2bugk7ReMnXEdIYwvBI=;
        b=IG4p+iPbyNpA5DfvBrjqIkow9ZGDTP4e5I92dn3w4N+2Gm8e1YPVxWOSqMwO7+nfqW
         KBqVgIaOtusZYM2UznQkt1u/GTa/RjF97Tn4CK4aR1XMtWrZUhRrzIwOS+XF41m/caRt
         Xe3qhavnAYKbnXpaZaimmlEHpHTcGXwNM4FVKvkvbVPxecn6SHzy0kXcICSc8ad1qe74
         rpyayAmTDI80FcovexHR4e6OtnoXU+X1oHhxr4Ale5TGMFK+9wM6glimRsoW5xE+csel
         OjNIVFxInhM8hQ3XHhc44Efw+lv1csq6qw/+d/XGUT7NX8QO6SS1hEN/vZww+7g7SGhq
         zTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4+PQ66vk9KRKMNJbABmZKkCe2bugk7ReMnXEdIYwvBI=;
        b=FuWDWA6OBwGzvtVI3ajg1qcERzHT0n6nNl/4RHwgPFc7P7JKYDj2AavhJa5HlCoMIr
         6NDHE5briVD/uJlQAB/c6vBIRFpCx4xjM7e68Hj998VbQSIdRVxuZyTIh2kNi2Mqqget
         xMKpEOSNiMYFERle+L5IH2ippibxUPteDHZTGYXqr2Lo1ZPEco5ZZz1Fl9Po3nRtFdmF
         9UGGlDPKQ/fH2UpcT38nWkn3Dqvo9c2irV4iAfJP/YPrup7hcGvUtntCZaejuUIdUVuU
         aCzob1LIYSN5EfbjDm4DWoDYdLJ3tLsmXY7K+x3mmvw3w2TDyoCXwLML/CB71utPe/Me
         27gw==
X-Gm-Message-State: APjAAAUNTPFOvbYkzMF6mRmTErYj/FT4SAfNrzP2rMEVurjB7g8RA61c
        QILWKlmZfcIABLkiFMlvqBU=
X-Google-Smtp-Source: APXvYqw4vd2gL8+Fu3zj86IT1o3HvPj5kfYzJY4yaXJLzb8gGzdXkUH13mg1+4utQSv2fmW4Y0T3iA==
X-Received: by 2002:a65:5189:: with SMTP id h9mr637421pgq.304.1555629483663;
        Thu, 18 Apr 2019 16:18:03 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id g4sm4832243pfm.115.2019.04.18.16.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 16:18:02 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] mm: refactor __vunmap() to avoid duplicated call
 to find_vm_area()
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Roman Gushchin <guroan@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Joel Fernandes <joelaf@google.com>
References: <20190417194002.12369-1-guro@fb.com>
 <20190417194002.12369-2-guro@fb.com>
 <20190417145827.8b1c83bf22de8ba514f157e3@linux-foundation.org>
 <20190418111834.GE7751@bombadil.infradead.org>
 <20190418152431.c583ef892a8028c662db3e6a@linux-foundation.org>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <05c40b0b-3621-6c07-346b-478679949d92@gmail.com>
Date:   Thu, 18 Apr 2019 16:17:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190418152431.c583ef892a8028c662db3e6a@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/18/2019 03:24 PM, Andrew Morton wrote:

> afaict, vfree() will only do a mutex_trylock() in
> try_purge_vmap_area_lazy().  So does vfree actually sleep in any
> situation?  Whether or not local interrupts are enabled?

We would be in a big trouble if vfree() could potentially sleep...

Random example : __free_fdtable() called from rcu callback.

