Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B015C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 111062178F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573141458;
	bh=d9dF0Q/qd3z+A4UKBsKzDYeQToC5lalLnXqt3EBbiEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DfzZXAVTZjkhEGHnDt70iMS5fgP2VJwy2MLS0fCvqy78s9TWRUPjwWtI+B8UjgzQ4
	 TYBOVpfBXYE+qVSLeSFIybAqDP9YZuktpX8IqU3YCA3tUdgg7mWP6+uiCNdTtHt7qj
	 AaK5pYKImL7GGVfgPyC1sN/sv/osthVr/6G732ws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389244AbfKGPoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:44:17 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39777 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388901AbfKGPoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:44:16 -0500
Received: by mail-qk1-f195.google.com with SMTP id 15so2365387qkh.6;
        Thu, 07 Nov 2019 07:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/VLsWSGCw7M78G2ciEeMt8ki0nUc+nWXcIjdygNoX4M=;
        b=POhLYOxufAI7xHlzUJDemniGTcznmIvhHjolHRByJVTX3xroAktxe3C1Liz/KxCXZ6
         6VaC61mFQW0hAuUJlPxrGVCEzcw2PkEKtvRl/1fnuD/Ag6A7t5p/cwE6gBWJptUI60Vk
         e7V9SH8Fe3pHCGnaPrPWX7HMYocKHMr/nJa2UcRmmpYynv24nKSwcNzkqdvw5fc3xFTW
         5DPNQz2AZIX8ZEgYZhdcp2jrSvcUALboEuXkf5JBt1iEZtM7OLE1rgbj767PvQ1fMnAO
         ROaVcKgdglj5gXWKGQh0RjoC5feo/Iv3LeIPq0C2wwP1PXRpKv+wFE0bxrGEw5cPehHw
         DYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/VLsWSGCw7M78G2ciEeMt8ki0nUc+nWXcIjdygNoX4M=;
        b=cGqQ+AfKJkoldgyFi/dws2KebqKLznAuRiJnhaUcw9ulXOtuoj4bnJfpjLpOk2Gs4W
         qLwE9L5UUMPR6K5MkKMtSOgApEcPS/W2Ro+veqUfsN7Iw1+lgV8c3cfMQc/J/72Ygzzw
         ISVKACDaFm5yaXUhzInNlR3M+anQcODB7XkRmi/c8MSS10+nDXAvsX4z1QkG/KmSzhRf
         FfZvM7POECNyWRe0nm9EzVtO5PwdQvJOrKymKH0hu4WSOdrRLp727L8UEcLlLmrfFoEN
         CBQ2VrOw7CFKD6ylW78kNXkdgMAcZZWuWtlC8jZIoY5ScgdLVfjuabBCDh3X+H8j2lW9
         hoCQ==
X-Gm-Message-State: APjAAAVme72tYQPZ5PQYuy7m1U3BC0tbOiRcky4RG/UJ2I8SwCBWuUL+
        IS7/quzfU/jnIA/4N0siZvw=
X-Google-Smtp-Source: APXvYqynNCHiUDdEWnZVcJRvtZWFE3Xbj5ykMaCKEADa4CIKtYZS7E5JETW/Bpzi8CvOCLGCFF7hug==
X-Received: by 2002:a37:a950:: with SMTP id s77mr3448271qke.463.1573141454976;
        Thu, 07 Nov 2019 07:44:14 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:3f13])
        by smtp.gmail.com with ESMTPSA id 19sm1330971qkg.89.2019.11.07.07.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 07:44:14 -0800 (PST)
Date:   Thu, 7 Nov 2019 07:44:13 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: hugetlb: switch to css_tryget() in
 hugetlb_cgroup_charge_cgroup()
Message-ID: <20191107154413.GZ3622521@devbig004.ftw2.facebook.com>
References: <20191106225131.3543616-1-guro@fb.com>
 <20191106225131.3543616-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106225131.3543616-2-guro@fb.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 02:51:31PM -0800, Roman Gushchin wrote:
> An exiting task might belong to an offline cgroup. In this case
> an attempt to grab a cgroup reference from the task can end up
> with an infinite loop in hugetlb_cgroup_charge_cgroup(), because
> neither the cgroup will become online, neither the task will
> be migrated to a live cgroup.
> 
> Fix this by switching over to css_tryget(). As css_tryget_online()
> can't guarantee that the cgroup won't go offline, in most cases
> the check doesn't make sense. In this particular case users of
> hugetlb_cgroup_charge_cgroup() are not affected by this change.
> 
> A similar problem is described by commit 18fa84a2db0e ("cgroup: Use
> css_tryget() instead of css_tryget_online() in task_get_css()").
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: stable@vger.kernel.org
> Cc: Tejun Heo <tj@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
