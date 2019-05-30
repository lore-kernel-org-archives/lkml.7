Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD85C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 06:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1527125AE4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 06:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="XUEorjCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfE3Go4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 02:44:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34040 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfE3Goz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 02:44:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id c14so902673pfi.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 23:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OtJUoXoSDr8VsqZMlQCV4tuhz5lMclRWprZBC+48UZI=;
        b=XUEorjCrLN9OrKuTIaR8sqQcataBFWGo19e2lBEQq/O74XS3Rv/gHEewD1Xhxg87dF
         Li12khbvVst/JlwygCiwvAhusNa3tSQFd4Sci5NEM5LIDG4i1O/IuqU4NCA4JrjyTjI5
         Z8e+mv6BlLgw2Wij6fVvKbwpyso+4TBaM01wI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OtJUoXoSDr8VsqZMlQCV4tuhz5lMclRWprZBC+48UZI=;
        b=PiHEcUw/sRuwk7tJk80AmrejDYwHwhOWpK64b/HkeMRIHm7FXproDtCMTWp8Eyq8WS
         HVKwwTCHi2qXS2LzBtetFrP7n0iLmll/VYFoh/1siqbA9362hWAHnWx/Ulbmh/xM8/Og
         ABGuoDe0ckvx9oO9x45n1LVIPwrHA3pPf4gfc2X8Fa05k1n0C2wgWeQN3EAO0QFF3tSO
         sDj+oe6k15VwF3NJPcWrYKiUPsGqS8xPQJoYFUrqDCIQVHF3i97rj7BMt8kWy9RKghC6
         noIXL1fpfR6f08UB01y6BOl0S9sKHprcdPDxzoKYBwcObiELa1JV9e9BPNPt7bT0XsZd
         zPTA==
X-Gm-Message-State: APjAAAX2ED7hf5559uLjU8KeZB8vbH/4DvUeSfZVlwZTRia1hN4T/mMj
        1HK62NRmejsS55d8ctzNELpC5Q==
X-Google-Smtp-Source: APXvYqyoyOiL1g0uw5EVCPG0xAn0ze5ad3M0tRvk7mVR1v4xGNiEEXjkXPCgkCattXKsglAopRzh3g==
X-Received: by 2002:a17:90a:8089:: with SMTP id c9mr2007919pjn.68.1559198694988;
        Wed, 29 May 2019 23:44:54 -0700 (PDT)
Received: from localhost ([12.15.241.26])
        by smtp.gmail.com with ESMTPSA id x1sm1242193pgq.13.2019.05.29.23.44.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 29 May 2019 23:44:54 -0700 (PDT)
Date:   Wed, 29 May 2019 23:44:53 -0700
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH REBASED] mm, memcg: Make scan aggression always exclude
 protection
Message-ID: <20190530064453.GA110128@chrisdown.name>
References: <20190228213050.GA28211@chrisdown.name>
 <20190322160307.GA3316@chrisdown.name>
 <20190530061221.GA6703@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190530061221.GA6703@dhcp22.suse.cz>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko writes:
>Maybe I am missing something so correct me if I am wrong but the new
>calculation actually means that we always allow to scan even min
>protected memcgs right?

We check if the memcg is min protected as a precondition for coming into this 
function at all, so this generally isn't possible. See the mem_cgroup_protected 
MEMCG_PROT_MIN check in shrink_node.

(Of course, it's possible we race with going within protection thresholds 
again, but this patch doesn't make that any better or worse than the previous 
situation.)
