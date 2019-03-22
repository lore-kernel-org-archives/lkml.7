Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD3EC10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D8420830
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="t4bfZHjq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfCVPGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:06:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34589 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCVPGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:06:49 -0400
Received: by mail-wm1-f68.google.com with SMTP id o10so4513205wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 08:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mQ9n0LJWHq04GQyycgsbt63+kUhUfjFPp6Imgiozptc=;
        b=t4bfZHjqYlNcpYtbOTd0L2aL8YCrHmtR9jw4IXOpS4MH7a1j9hEA/EkLAVaIrYVSWW
         iG+Ru2fd+5vRNzfAq1wUg4XcUy8wpr9g+pnjcj3GOM8Kg6cwiTXlHWm8+mVQ4jxWDwBT
         mKqwDN8vorH0l/niQI2Vwwxw7HlAhsNq75efQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mQ9n0LJWHq04GQyycgsbt63+kUhUfjFPp6Imgiozptc=;
        b=luiOCUmZ44gFQtx1NJo3NejvEA6geUh1GYkfg/u+uIUZ0kY42hqsq0RQvsH44t/Afb
         ARcMQ0Yi+1u8l9a9wZ6RoJieSPfT/pCOzvwHzKnlZ7+fYi9DIIS5hvb5YgfMn248zoYJ
         4+1+EkvBs+tQVM6xpj98efPjXFdOwVV8CLiHgfMucrarcldWWbwB3YYnbMYOqx4Yksls
         5k64s/QFjXPnlV2ML3Napu5SeW8WUISSz24rTrOIg75QpRvtr5dPelkFrbt4HqCo3zmC
         RPjWrQBMUwuQ6lgXAdM3+JkhHBv5+lrjcQpeGEjb5iaWPVbATcJVfF0ugf8P9rABGwnJ
         1x/Q==
X-Gm-Message-State: APjAAAU42LB+Ewf03VUfHOvZnZ7ZNF+zyzzL7XUXfpQnF0sxeeG2+65+
        mErb0HedsoXgtvmwKQcn+7d+nQ==
X-Google-Smtp-Source: APXvYqwjcWjNHVr1ddFCyMelUwuxcf9h9A9xdWYy4x0PENAFJZinzN6+H78/cavWFkt7o9sovEYSlg==
X-Received: by 2002:a1c:6588:: with SMTP id z130mr3498438wmb.39.1553267207534;
        Fri, 22 Mar 2019 08:06:47 -0700 (PDT)
Received: from localhost ([2620:10d:c092:200::1:a21b])
        by smtp.gmail.com with ESMTPSA id g8sm19619754wro.77.2019.03.22.08.06.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Mar 2019 08:06:46 -0700 (PDT)
Date:   Fri, 22 Mar 2019 15:06:45 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH] fixup: vmscan: Fix build on !CONFIG_MEMCG from
 nr_deactivate changes
Message-ID: <20190322150645.GC32163@chrisdown.name>
References: <155290128498.31489.18250485448913338607.stgit@localhost.localdomain>
 <20190322150513.GA22021@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190322150513.GA22021@chrisdown.name>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Down writes:
>"mm: move nr_deactivate accounting to shrink_active_list()" uses the
>non-irqsaved version of count_memcg_events (__count_memcg_events), but
>we've only exported the irqsaving version of it to userspace, so the
>build breaks:

Er, "with !CONFIG_MEMCG", not "to userspace". No idea where that came from...
