Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9EBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1126921B18
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="dzOycvFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfCVWtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:49:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36842 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbfCVWtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:49:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id h18so3626860wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 15:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y9aDRaeIImkqbs3RD6gMjzp9RFeZ93eNkXfZogPMzV4=;
        b=dzOycvFR3LXcdAJzc1cZuTdB5YuJ4celv5OXmLq76bC6fhuIRBXXymUZ2X1e4X3GPz
         g+RHtQxVTPHKrMHRvLhSlNJtytCLr+c/sSTjz6Ejtz9K6fAOuiJqD90x+aTB17NOUbU2
         C2jzjifh8zT6akDauo5+bFHj33WXlPFIZB7+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y9aDRaeIImkqbs3RD6gMjzp9RFeZ93eNkXfZogPMzV4=;
        b=t4pNThUn0jwDN8OMGttHLF6aDFH0eOlpK2vr+U+4bOpgMfc1NKkfQqV7+YJhtIxKAv
         JQgyWAlQG3391QNqkkMNpPKR2WMrRtbbVX7njYE9+xOSAGcvuyE3B3q+pbRXDk533IrJ
         MEwJE8tQWz2wdMa8aD0VaMY6wsdyaVpE/I/g1s8zhHuqz36YvSjvWUylqP0dDq32gNkm
         GsYP7IT3xjIYWo0u8y5/mGjZXXTrDNK6V2PJAqRXKkq/JDuFQksyLExVu3lXNQkqKwhx
         dijNjjUrkIkYPFtLRgkLW+iz9fIZqJfWrh4rDMSPrNfLQpdyZsE/M1aOWQdIbHxWj5Hx
         2Lig==
X-Gm-Message-State: APjAAAVy2rMZ8EjwpIyNMttcLcferBi18M51scrIvpcO2zevOqLMgw6f
        skV26QSLE5yk7HIVvnaGy3J0rg==
X-Google-Smtp-Source: APXvYqwdz61zVqNkLMZqtOFJF0lk6vAo9J3Kz5QBK9eFpbbP8HIiqceSQ3TxUDoETV5aA9ODpBzhFQ==
X-Received: by 2002:a1c:ac87:: with SMTP id v129mr4695169wme.72.1553294987958;
        Fri, 22 Mar 2019 15:49:47 -0700 (PDT)
Received: from localhost ([89.36.66.5])
        by smtp.gmail.com with ESMTPSA id u12sm9138257wrt.2.2019.03.22.15.49.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Mar 2019 15:49:47 -0700 (PDT)
Date:   Fri, 22 Mar 2019 22:49:46 +0000
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
Message-ID: <20190322224946.GA12527@chrisdown.name>
References: <20190228213050.GA28211@chrisdown.name>
 <20190322160307.GA3316@chrisdown.name>
 <20190322222907.GA17496@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190322222907.GA17496@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Gushchin writes:
>I've noticed that the old version is just wrong: if cgroup_size is way smaller
>than max(min, low), scan will be set to -lruvec_size.
>Given that it's unsigned long, we'll end up with scanning the whole list
>(due to clamp() below).

Are you certain? If so, I don't see what you mean. This is how the code looks 
in Linus' tree after the fixups:

    unsigned long cgroup_size = mem_cgroup_size(memcg);
    unsigned long baseline = 0;

    if (!sc->memcg_low_reclaim)
            baseline = lruvec_size;
    scan = lruvec_size * cgroup_size / protection - baseline;

This works correctly as far as I can tell:

low reclaim case:

    In [1]: cgroup_size=50; lruvec_size=10; protection=2000; baseline=0; lruvec_size * cgroup_size // protection - baseline
    Out[1]: 0

normal case:

    In [2]: cgroup_size=3000; lruvec_size=10; protection=2000; baseline=lruvec_size; lruvec_size * cgroup_size // protection - baseline
    Out[2]: 5
