Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E1FC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 05:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12162080C
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 05:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1dR2BTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfHZFNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 01:13:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34917 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfHZFNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 01:13:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id n4so9854677pgv.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 22:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RS54P8xWhN0WpqilfX3CeJTlw03oZ0bA+FF2sB+7VdE=;
        b=K1dR2BTgQvrbOF9jRsFWIkPFShaGlCPz35NWloS4Fv+m6/EhuR6r9hhY22ZCmXh9nw
         kMho4xHr1YYm9HYipqrdH03DaX8Y5T8ABJFwn/Bj5djDVplrze3YMP/rRJnYQBK3agjz
         j/2nMTQ1ibl/XU4niUZX34IsaSjsYMktRp+9VB+fmx/e741XRl+bh+v5TNaAg/uaYOyr
         rl+5noSQB64GhX2EutHURwwC1CTdpokKQLJ9YugJw0VkZNuI3DUpH0F3NQKM0T7eZvTA
         FT43OfyGLj7Ip10kVzPL9y+Mx6HJL+s1iQgTZy/qAX5MLtmk9pF2d3XkJyFBVEO4shaa
         PqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RS54P8xWhN0WpqilfX3CeJTlw03oZ0bA+FF2sB+7VdE=;
        b=E3TYLIoJ9BZjAMV90VnWXmzepzgXwGo7peXseODlFV+DHDiN/F2eJRVrFpptMgLwL1
         6PH9n+/4fxs187XV+sMl8al7gCGZTj7BYBns9hwbdMvP1i0v6RrYMjbaGuAzgIriuhoa
         DijUcXdXcSEM/BA9STFwtGLpVLM/RVjeUqJ4AMGY396rAbOfU8NxxVbcsLLBjYfMI7Fx
         0tSfqXFigY5JDI815NqajL69NNO6DvqU93/gF8XpI4xWoBi3gcalOqFkek0A+CDGFpQA
         ZRrsZvV5oNeJPqPwa2Ekywp7/Ot6jsADcy16sGgdJP/fM86FP3zlsiZEs/cbGUEeISpK
         mYDg==
X-Gm-Message-State: APjAAAVnjd6+JIU2UwGtbvatcZ9kzAJZkioi/HSE/J8qQm4iz1icsuCU
        HX0XO8aniEykbHgtXHdJmrU=
X-Google-Smtp-Source: APXvYqzsH1YZgcoQJAmfj/sq9jg7AkDH4XHU8wEYr6A3wUzKAcmf0uIlpnUP9bwKVzxF7h8VFXxPfA==
X-Received: by 2002:a62:8745:: with SMTP id i66mr17899570pfe.259.1566796425463;
        Sun, 25 Aug 2019 22:13:45 -0700 (PDT)
Received: from localhost ([110.70.50.154])
        by smtp.gmail.com with ESMTPSA id r4sm10753832pfl.127.2019.08.25.22.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 22:13:44 -0700 (PDT)
Date:   Mon, 26 Aug 2019 14:13:40 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Henry Burns <henrywolfeburns@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Henry Burns <henryburns@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2 v2] mm/zsmalloc.c: Fix race condition in
 zs_destroy_pool
Message-ID: <20190826051340.GA26785@jagdpanzerIV>
References: <20190809181751.219326-1-henryburns@google.com>
 <20190809181751.219326-2-henryburns@google.com>
 <20190820025939.GD500@jagdpanzerIV>
 <20190822162302.6fdda379ada876e46a14a51e@linux-foundation.org>
 <CADJK47M=4kU9SabcDsFD5qTQm-0rQdmage8eiFrV=LDMp7OCyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADJK47M=4kU9SabcDsFD5qTQm-0rQdmage8eiFrV=LDMp7OCyQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/23/19 04:10), Henry Burns wrote:
> > Thanks.  So we have a couple of races which result in memory leaks?  Do
> > we feel this is serious enough to justify a -stable backport of the
> > fixes?
> 
> In this case a memory leak could lead to an eventual crash if
> compaction hits the leaked page. I don't know what a -stable
> backport entails, but this crash would only occur if people are
> changing their zswap backend at runtime
> (which eventually starts destruction).

Well, zram/zsmalloc is not only for swapping, but it's also a virtual
block device which can be created or destroyed dynamically. So it looks
like a potential -stable material.

Minchan?

	-ss
