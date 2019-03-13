Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22309C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16C0206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 16:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="dGdqiWPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfCMQAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 12:00:20 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33449 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfCMQAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 12:00:19 -0400
Received: by mail-yw1-f68.google.com with SMTP id a199so1889694ywa.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 09:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kfs3heF+8ue5fPhJOE/1L32aZGxH5YHBEa9Vc48MxT0=;
        b=dGdqiWPo1BOx1Hrm9Yb+fmpMIctPhEyDjRuPEMfrsn/Kt3uPznTjItkUMy2bpQMkQq
         XOYyDXCPqUUbQyfrVo9hxOy8cYORZfSPejYoVDe4rwugqGjQrmP7bE6g+d4055mdv94g
         f8F56Qk5Irl6ERWKfsSoNNUIZ90EecAB46rjEJFZ6Zs/jfURwKv0AmY+pVvS8fwmIcRK
         I5RYS3nVJO4MTfBMA2OoQpzpmlWz3gRLoT0hp6pdkH6T0vjyZJRkCaaq+o5Kk3mLCC+X
         jHtDw6/k3XpwqdP0ueQ4wM2KfvFTVxbuxDX4IWvI6ywSfu9pTCyuImllQMhznFZh41Jj
         iecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kfs3heF+8ue5fPhJOE/1L32aZGxH5YHBEa9Vc48MxT0=;
        b=D55Ows4TpcPjxFvEgSpnK8Uq3F46R/wxfTBjREvWRKc3xw2bS16YCZPuVWIJLkp5hv
         pq4Y+f+bI8ZC0eKv7yPs2DzniA6K5f/FSYBF9XNoclUp8EsVjCaEdtQF2AUGb83m693w
         GdnL/KfoS7qVcsTg7QcT4M66ewol/3P/2tQIRlSj4t5vRM04BdiJ1o0WJPIxmH3w+7Jn
         KuE6iRxaLjEewVmttj4UdVUay/WKcK5Bks8+cJvikLKeZbcRIWrlMslAIy6U8pYzu/KF
         Ix/FR1rvbE+HFiUYuLGBhQMBncxnFIa7N4CDsnfL1lAXIJDm5c/v5O0ts7eTg1MNjjeZ
         KCYA==
X-Gm-Message-State: APjAAAUSRrqwuwGsHzji3ffA5AOfQqK5xXjmy2L3w9CJz7Pi0yFizFqJ
        WTOKa1q9Kl/zHdhVXgjxQzDyJk18fqA=
X-Google-Smtp-Source: APXvYqxxouOQGLIOlx87tzAbVKhhhLdCSYZWRYS4+anzMp8teZfEjVRDQ/PJhjsFB5CB1/xBLaz/JQ==
X-Received: by 2002:a81:9ad1:: with SMTP id r200mr12040290ywg.287.1552492819181;
        Wed, 13 Mar 2019 09:00:19 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:9a85])
        by smtp.gmail.com with ESMTPSA id q1sm5606033ywe.14.2019.03.13.09.00.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 09:00:18 -0700 (PDT)
Date:   Wed, 13 Mar 2019 12:00:17 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     linux-mm@kvack.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v2 5/6] mm: flush memcg percpu stats and events before
 releasing
Message-ID: <20190313160017.GA31891@cmpxchg.org>
References: <20190312223404.28665-1-guro@fb.com>
 <20190312223404.28665-6-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312223404.28665-6-guro@fb.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 03:34:02PM -0700, Roman Gushchin wrote:
> Flush percpu stats and events data to corresponding before releasing
> percpu memory.
> 
> Although per-cpu stats are never exactly precise, dropping them on
> floor regularly may lead to an accumulation of an error. So, it's
> safer to flush them before releasing.
> 
> To minimize the number of atomic updates, let's sum all stats/events
> on all cpus locally, and then make a single update per entry.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Do you mind merging 6/6 into this one? That would make it easier to
verify that the code added in this patch and the code removed in 6/6
are indeed functionally equivalent.
