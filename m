Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34820C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 23:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A992175B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 23:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="F2HThYNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfCVXvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 19:51:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35054 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfCVXvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 19:51:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id w1so4097118wrp.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 16:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uB1/IWOEK+GFSUVXVpArQJE+Iwx/dVBKwpNZw8eSYdI=;
        b=F2HThYNwJG9xqwjVQ01U0dygceVtFhVN0zGiTc2s3fFci+rr5MHvTeD5KDR+N1swhg
         X3d076qrgSksIDL+shRkHOExAf9duEYrkKtDhF+zKxlEIWgd0PSqwXV4x63UJIIQCSve
         jF4basxGu6d75EeaUSo5T89X47nRmV5VwwpNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uB1/IWOEK+GFSUVXVpArQJE+Iwx/dVBKwpNZw8eSYdI=;
        b=sfK6cmWI2tuQL1RUThzzCVAv9Y5v9US6kwaYy93uJXu1MbWMaOX4ezMFcR7L/e3O6p
         yyUhXBsT+2Z/qbcwCbU/jfjshdPTgHpa7SvCKy3bZDlB7c60qpCnOqbBKKW7tFLgs57y
         MhJyHUT6W9Ox+L1kX+4KMmOc14vL4r7OtEkazN3NtNgN292Lehq4l3/T9is5aaEGPlfa
         b/5a/7N+P941OxByKDf4pEG0WBoQYRTs//rH7moAWeqSssdBhkjD1V2LOiqpYylURIFH
         hNJ5OoH2UwtYfkdtJA9SPWg/faNnC7nIaTe4muhKjoK3sSdiFQiIjRIBceva7whM+BPd
         VxWQ==
X-Gm-Message-State: APjAAAV5bzbt4zFgFMsM5ht4VpmBHdecEMxoNxrYK7y4R+3Hq0eXAnPZ
        BhHMc3K1aGuRLDhBWnFAvBYDfA==
X-Google-Smtp-Source: APXvYqyRBZybPLJFkSojkdSL5WTU/65TusoLI8KSoWFwV/aSQt7LQc2reLKao6ubYa/QY/UGQAr7PQ==
X-Received: by 2002:adf:fbd2:: with SMTP id d18mr8010207wrs.55.1553298681935;
        Fri, 22 Mar 2019 16:51:21 -0700 (PDT)
Received: from localhost ([89.36.66.5])
        by smtp.gmail.com with ESMTPSA id y125sm5899796wmc.39.2019.03.22.16.51.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Mar 2019 16:51:21 -0700 (PDT)
Date:   Fri, 22 Mar 2019 23:51:20 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH REBASED] mm, memcg: Make scan aggression always exclude
 protection
Message-ID: <20190322235120.GA31019@chrisdown.name>
References: <20190228213050.GA28211@chrisdown.name>
 <20190322160307.GA3316@chrisdown.name>
 <20190322222907.GA17496@tower.DHCP.thefacebook.com>
 <20190322224946.GA12527@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190322224946.GA12527@chrisdown.name>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Down writes:
>Are you certain? If so, I don't see what you mean. This is how the 
>code looks in Linus' tree after the fixups:

Hmm, apparently this actually didn't go into Linus' tree yet, so yeah, seems 
worth having as a fixup maybe indeed.
