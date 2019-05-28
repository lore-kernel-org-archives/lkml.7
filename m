Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694E8C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3794C20B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="qG03h26g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfE1V4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 17:56:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40966 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfE1V4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 17:56:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id q17so136305pfq.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 14:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bTzfa4MPBlCsa2uhQknRd/UBV4ojcryy1ZVgr46O0Y0=;
        b=qG03h26gMGgX2CIkJTJdgFwW1fdUGvwM+12oszmGpSYZILYYex8mUqUYB6umJaX2Ge
         BPs7imkNRty6RvcxCTTiaTmPe5Xa7U8IH4yrqIXzMGTxxoN84iWr7xdRxHP+vD9H1P5p
         dq8iGcLIIIWikZqSc6UFy/+0zDb72gN/C0xjf1mr/a9yQaKT749fFHtZt2jdLd6q74oz
         9cto1oQA1PS9VLo2TFd0bDJmnEuDFf3JyqvvRgun2EM123fVGo3KtW0SHC90c8aDUUbG
         aNfTXaIBezA+iAftELYk80T9oTBtjgPINgmGAHwOZWxXxPIIrCx20PddZ/3IOb8uvPvy
         ZI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bTzfa4MPBlCsa2uhQknRd/UBV4ojcryy1ZVgr46O0Y0=;
        b=rUUEd9Fss5UfVbKaicur5ebkUvDHgg4zlLE9hdf/Fp9G6yHbvXlvJ9I2HfvaX8r6Yr
         5G5TOwktaZtPiUe5dwTyM5ueoWaIqKnSjUruuEBNG64lflWlZ/dZqdtrI9AmQc9jt+a7
         kzxXU9ak31ByDeMlhcw3wAvgnAnStBJRDdfQZuZeiY90f9z/GAhpKFtirv1MGQT4mwZa
         nOyjDL0MyrAAGfYxZ4J2HIo1cmGmSxEBD5bc1wHqF/Xk08dKZs2upkJJBQEulPe1n2go
         Fy9wKzCIUsn6BaJhY7cnT0GQByCJ7VnOJy3uOg42iXBRhiDt6oRBLmUhZISFXWsUkDCd
         ttWg==
X-Gm-Message-State: APjAAAW9+IbFrvmnu9RiJoOoyBTa/h4peK9K5VeUWFNTD939Ux4MQ6Le
        ODP4exe4dHea4j/q+F263R6gGg==
X-Google-Smtp-Source: APXvYqznXt8OYMnBy3Azq3tIojg91yQzx9R1e6BJtkRAhSjpY+ySRhViNsQx7rAzPfZ+zrQXA+VJhg==
X-Received: by 2002:a63:d347:: with SMTP id u7mr135250092pgi.254.1559080600401;
        Tue, 28 May 2019 14:56:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:77ab])
        by smtp.gmail.com with ESMTPSA id x23sm14860815pfn.160.2019.05.28.14.56.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 14:56:39 -0700 (PDT)
Date:   Tue, 28 May 2019 17:56:37 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 1/7] mm: postpone kmem_cache memcg pointer
 initialization to memcg_link_cache()
Message-ID: <20190528215637.GA26614@cmpxchg.org>
References: <20190521200735.2603003-1-guro@fb.com>
 <20190521200735.2603003-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521200735.2603003-2-guro@fb.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 01:07:29PM -0700, Roman Gushchin wrote:
> Initialize kmem_cache->memcg_params.memcg pointer in
> memcg_link_cache() rather than in init_memcg_params().
> 
> Once kmem_cache will hold a reference to the memory cgroup,
> it will simplify the refcounting.
> 
> For non-root kmem_caches memcg_link_cache() is always called
> before the kmem_cache becomes visible to a user, so it's safe.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
