Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937C5C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 18:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E45320657
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 18:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Akb5+D4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbfFXSot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 14:44:49 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46628 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfFXSot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 14:44:49 -0400
Received: by mail-qk1-f193.google.com with SMTP id x18so10520204qkn.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 11:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JXj+L0YSeQGtS2fIHaO4Yh9OylVxWOaB1JgmYQtoJ6s=;
        b=Akb5+D4tPxYc8+ahxrrLB4dMzZNlT7UadNth1lz9ji9q8qJeN+O6fnib/9pmI1JSzH
         2+CHeJzyxzJbmJEphRfLZLke0weEtA8690HETiI8M5gxUvb/BXPjFiVwiRwcw3lugzrE
         qe1gDqdT0Zb2LILRnf/MsmqwtSzWj1MmRddpOXdKMlUSZBk6WGS8FTPR4RizDBlsqwun
         U2J8JY7MAMu0zeIu4MnzGFI6hCcTUPyxQ5OqMeosu2S09R9G11BhVEQ7VZnNrkqWtpaR
         Sty+a2ezEJkArv7qbyyypSGFPn4pKGMD8D4jcXhhFHvOz/CVE7t2AVBLMLaRYQbVVXfE
         +SSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JXj+L0YSeQGtS2fIHaO4Yh9OylVxWOaB1JgmYQtoJ6s=;
        b=lc0rshzNtfkZfXfuKxelaxS2kHlUvVTaTEcgNn6hhrtXjmDsHNJj12VqrIWXhoVBNC
         GrhhRdXGAs3n8Hus/Y7kUJDPVNhjuBIKnAxeKsctiqtRDNJaGx9eb9DvSDND8NSya0ct
         3w1AtY1j59TtqZ6WGSFcZOhjg9LTnMqKp/VebGF6tgd4oD5JChWLHHr9tX3TN/auXWLU
         Sw1ecVML9x6YJz7PnZqrCllHTpx8yIOtsA7cVHfE6JpNSNJIXQ45pB8IoR3Lar8yh54g
         P2pD2u0+c+lw1h3zbD6oeCbqV3TpeM5d7M1Aqifd/iwPhKcWgabkFH6iguu1Iu6NRE6z
         LX4g==
X-Gm-Message-State: APjAAAU+kEEp/K4K6I/IpEGZdgEOWwXv49hVsP2GEGqeALN0T6dioqMV
        R8ggiUHNqwbHZ4lZAVPncaE=
X-Google-Smtp-Source: APXvYqx7o1DaZIsR9wzMEUpRc7tlaMuBRc+fXYH28RPu6r2sAce7n9/nQ3jwnprQj0A2Sr7mdHbdQA==
X-Received: by 2002:a37:4e8f:: with SMTP id c137mr1491249qkb.127.1561401888383;
        Mon, 24 Jun 2019 11:44:48 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id h26sm6824548qta.58.2019.06.24.11.44.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 11:44:47 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8657841153; Mon, 24 Jun 2019 15:44:36 -0300 (-03)
Date:   Mon, 24 Jun 2019 15:44:36 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf thread-stack: Fix thread stack return from
 kernel for kernel-only case
Message-ID: <20190624184436.GB4181@kernel.org>
References: <20190619064429.14940-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619064429.14940-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 19, 2019 at 09:44:27AM +0300, Adrian Hunter escreveu:
> Hi
> 
> Here is one non-urgent fix and a subsequent tidy-up.

Thanks, both applied.

- Arnaldo
 
> 
> Adrian Hunter (2):
>       perf thread-stack: Fix thread stack return from kernel for kernel-only case
>       perf thread-stack: Eliminate code duplicating thread_stack__pop_ks()
> 
>  tools/perf/util/thread-stack.c | 48 ++++++++++++++++++++++++++++++------------
>  1 file changed, 35 insertions(+), 13 deletions(-)
> 
> 
> Regards
> Adrian

-- 

- Arnaldo
