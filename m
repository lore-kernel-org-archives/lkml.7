Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DFDC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 03:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06D2227BF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 03:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576811642;
	bh=bPIQ2H6z6H1BDc0p1s82YDlBks/ifeA9kALlMrh8icU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EmY8a+gqeKveZvuw6uI22b7/odmLj+05jJEPVHtWZ36VHUzvEtn/11axKefcAIN7V
	 POM1L1KV/0DPg+xuxJYc+uqsDk6qCR49TmvikXFZ7ATTzCSvqL+9CMVsM8tKuPYwwy
	 6W5oBEl+A6QQ3gbn6h2VIV3KZhDCwrvNSyWrwakM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfLTDOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 22:14:01 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172]:38900 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfLTDOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 22:14:01 -0500
Received: by mail-pf1-f172.google.com with SMTP id x185so4418079pfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 19:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xfe06hEYKZV5y/CiX8O7PEEEa9kQzA4lJHanH76zMXo=;
        b=W26zs5Rnwxo4y8u+Pd3Kc/YUbwHL6fR88qDymio6uEF+z3/t71UDMsRcNGs2Ndh9vD
         vJvecuE/Bi/HQaRdI2PhAd5eED7HpU5otuPR/r+RnE8zAkWMzOQvwjABnsuIrWJjBJDt
         zaizYO1c5tQL9Vtt1yzOTeBGVTvzRU2X5vNUKPlr+jipWO/5ISFBH0P4GaBAOizunkOZ
         Sazj+0Erc0SuJQZ1QA1x/Eemqg1W1cNMmUQb7aDdlV7OhvJvsqGreMWa2hzyJunemUau
         bfuPsh6QPmaQxX/zcbSdNM5E9urhal/kJpq+loMqzqvKchpplN4Pl3FFxJdVl0rI7a3g
         n43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xfe06hEYKZV5y/CiX8O7PEEEa9kQzA4lJHanH76zMXo=;
        b=oB3pOO4dQ2h84CUMleWzw2SXji3hdbC+G1LLo+HUC+mf/Uu7Sv5L/I+82WZ5EESZLt
         02mLe//TzKB2eICqTrLPNRgXdcxjOSsMtESzUi/5YbyUoVDr2TL1a/3175FLvfyYFwAT
         0iPHJkOYEsLwOBlrMQ+LMGGm2vU8MKK+7Zeenm1EANi0ZIEWliVG4+6kYgkI9OWoX0/O
         XyrswzBaf/wgy+Ry1PgMwf5AJ+flMIStEGON3vQw1AE6tdC2en3x4XtYcweEHEdm0lNn
         TnFLR7jkbVSS1j17qOop+A8sctWrUN2bJShvBrexqN2j9KK27jGPg+JhSYST4PZT54lR
         H0Tg==
X-Gm-Message-State: APjAAAWUBBJJRcLrUykze9PzkTJ4EaG+U7Ot0rxIMrPKxwvvy1DGA3b0
        xGJpcCGzsHAvegt38N7S+Oc=
X-Google-Smtp-Source: APXvYqwWyPJHxGvXLox8o543HskJF6C64WZzSS0rWOjZ9MgzjbFWG7TEigUTVHAiOwkl1C+ePJWbvQ==
X-Received: by 2002:aa7:9633:: with SMTP id r19mr13939808pfg.90.1576811640281;
        Thu, 19 Dec 2019 19:14:00 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id t23sm11021116pfq.106.2019.12.19.19.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 19:13:59 -0800 (PST)
Date:   Thu, 19 Dec 2019 19:13:57 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Vitaly Wool <vitalywool@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Streetman <ddstreet@ieee.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Henry Burns <henrywolfeburns@gmail.com>,
        Theodore Ts'o <tytso@thunk.org>
Subject: Re: [PATCHv2 0/3] Allow ZRAM to use any zpool-compatible backend
Message-ID: <20191220031357.GA39061@google.com>
References: <20191219151928.ad4ccf732b64b7f8a26116db@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219151928.ad4ccf732b64b7f8a26116db@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 03:19:28PM +0100, Vitaly Wool wrote:
> The coming patchset is a new take on the old issue: ZRAM can currently be
> used only with zsmalloc even though this may not be the optimal
> combination for some configurations. The previous (unsuccessful) attempt
> dates back to 2015 [1] and is notable for the heated discussions it has
> caused.
> 
> This patchset addresses the increasing demand to deploy ZRAM in systems
> where zsmalloc is not a perfect match or is not applicable at all. An
> example of a system of the first type is an embedded system using ZRAM
> block device as a swap where quick application launch is critical for
> good user experience since z3fold is substantially faster on read than
> zsmalloc [2].

Look https://lkml.org/lkml/2019/10/29/1169

z3fold read is 15% faster *only* when when compression ratio is bad below 50%
since zsmalloc involves copy operation if the object is located in the
boundary of discrete pages. It's never popular workload.
Even, once write is involved(write-only, mixed read-write), z3fold is always
slow. Think about that swap-in could cause swap out in the field because devices
are usually under memory pressure. Also, look at the memory usage.
zsmalloc saves bigger memory for all of compression ratios. 

You claims flexibility - some user want fast read. How do you guarantee
it is always fast? It depends on compression ratio. How can admin estimate
runtime data compression ratio in advance?  Their workload is read-only
if they use zram as swap? they are okay to lose write performance and memory
efficiency? Considering that, it's niche. I don't think it's worth to add
maintenance burden here for very limited usecase.

Think about why we replaced xvmalloc with zsmalloc instead of creating wrapper
to keep two allocators and why people push back so hard when we introduced even
zsmalloc. Why zbud was born at the cost of sacrificing memory efficiency was
concern about memory fragmenation of zsmalloc so freeing memory cannot make real
free memory so wanted to manage fragmentation limit(However, we introduced
object migration in zsmalloc afterward so the concern was gone now).

> 
> A system of the second type would, for instance, be the one with
> hardware on-the-fly RAM compression/decompression where the saved RAM
> space could be used for ZRAM but would require a special allocator.

I agree. For the special compressor, we would need other allocator, even
huge zram changes in future for best performance. However, I'm not sure
zpool is good fit for the case. We need discussion when that kinds of
requirments comes up.

Nacked-by: Minchan Kim <minchan@kernel.org>
