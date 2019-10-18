Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4CCCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 11:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0DE20700
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 11:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codeblueprint-co-uk.20150623.gappssmtp.com header.i=@codeblueprint-co-uk.20150623.gappssmtp.com header.b="VYgJsi1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633653AbfJRL5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 07:57:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36749 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729946AbfJRL5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 07:57:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id w18so5399611wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 04:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeblueprint-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zRYNmzrp3kZqPcX0U5nVEalEcyDENKz3gQlpuacgqLg=;
        b=VYgJsi1YIUXBdpBE59AiuN8Qu8gPH7VPiGIciZcz1o5jj5XjOLC+VjVEmcQ3Qapy2Z
         xGvgIjdupGdVKkYIdBHrrNgte8WL5ZlDrT/bYOt70xqOBFF6+Oo/jpawz7+t6Cidnhcw
         qfGGBXSjTjlEGqaGYwPirykYE9Wrf/MEmtU9Z5CrhINPPmjsZrNX/NO/KNRv2amrZodC
         4ZuoJiXx4ytIAiL6FucMYBx2hprS1Tq4NOxjcueiBdwYZK6HKBGdq7nsWZMqfhkiJBnI
         eN6+wJa+3SCzs+3Vc7lUactas8TrUzUG+UbPuEed6++MOJlnEmwfofF23NFtbzWbDevs
         KhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zRYNmzrp3kZqPcX0U5nVEalEcyDENKz3gQlpuacgqLg=;
        b=Ws9zmRcFLy8+rE1xupbLzcbk5ECPZT6aSFk67YTDXTluzk6v76mD9vc923xxQthgHF
         xWmhUzouWB5WbGky/d/k9sWhdD/boDs5cZE61Cb+YOIB1tjetflUu2O5a68Ev+0rUiF3
         4oQsB4IrtjcAONKWXIG+sR8JaEqdgYBOmWOls5iq2wfPF60oWMYdwziElaO/UGsISmSu
         YKQYDpvTp3/eqxI1uDuVDL4fxnj7HD0vMXOx2of140GsBRIRKfcAKs8PrukTG1APsYzY
         gJuc4KR4wx4RosXHZXVPC5hsv3etaq7S2GaLzf1HD2rAW58HcVesg8CDK7AMhvP/oAwT
         pUJg==
X-Gm-Message-State: APjAAAX3IUfropgdEOMCtXYyBiJrXU+IpqdrRDLX5vYfT/uJdakFKWnM
        KTPyCEcoLy752IGssw6yJao/ZA==
X-Google-Smtp-Source: APXvYqzLX8KPC0QMmVzYiPQqSWH5hON6TuvFHbkOq6nRp1+IXEJttqeKiz9lorG7gga0uSViRw6ddw==
X-Received: by 2002:adf:f64f:: with SMTP id x15mr3238507wrp.381.1571399823110;
        Fri, 18 Oct 2019 04:57:03 -0700 (PDT)
Received: from localhost (97e34ace.skybroadband.com. [151.227.74.206])
        by smtp.gmail.com with ESMTPSA id y5sm5579301wma.14.2019.10.18.04.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 04:57:02 -0700 (PDT)
Date:   Fri, 18 Oct 2019 12:57:00 +0100
From:   Matt Fleming <matt@codeblueprint.co.uk>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] mm, pcp: Share common code between memory hotplug
 and percpu sysctl handler
Message-ID: <20191018115700.GE4065@codeblueprint.co.uk>
References: <20191018105606.3249-1-mgorman@techsingularity.net>
 <20191018105606.3249-2-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018105606.3249-2-mgorman@techsingularity.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct, at 11:56:04AM, Mel Gorman wrote:
> Both the percpu_pagelist_fraction sysctl handler and memory hotplug
> have a common requirement of updating the pcpu page allocation batch
> and high values. Split the relevant helper to share common code.
> 
> No functional change.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  mm/page_alloc.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
 
Tested-by: Matt Fleming <matt@codeblueprint.co.uk>
