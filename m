Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1B8C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603CF20989
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xi1rvf82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfE1ULI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 16:11:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44075 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfE1ULI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 16:11:08 -0400
Received: by mail-lf1-f68.google.com with SMTP id r15so15386lfm.11;
        Tue, 28 May 2019 13:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IhQcOeMQDDyAontCK40/Nbm1mljx7ySDbK1mzDX9hII=;
        b=Xi1rvf82R+sAQrYfabSK06Oc3zrxz8A4e+xmdG9AUs3GEvmrywT07vu1Cdbwq/n+xC
         dhTgk/se4eR4Ig+rHsTTHDJlcN63ODXw271T4KGgt4YkjXCyvu8qSH0f0fXf/g6urI3y
         c4yPQrnqmATMPqTEAeV8o+YdaFcJEC9ZveudH3c2ybsmgtfwNbKhVpH3jMiM2DCCRFZF
         Rl7v4N5R1yF+cGs9dD20FId6Cm/FCykxQSf4SR4+8tIu8TYJULxXWzwkhGQ8yvwSl9sx
         gENvr/QOA/o9+vwBi3YD8jXXztGw2Fmzgx0nKc79w9lc5uejD1VHiOJ/QV41g+10ChlG
         +K/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IhQcOeMQDDyAontCK40/Nbm1mljx7ySDbK1mzDX9hII=;
        b=SRnQkbrz3BrRlpGOppIC14t/TpCcOdz4icw+hFiFK+sWiMyf5Wzhf+m8qLxunavcKS
         OunKtMuMeBh+2eMeOSQeHCNmmrs+aitJzVL3fM5fOgZiTvkSqRt+yvqJ6FG4dz/0FLWK
         KhQlfYoNVVdb0N6X4Qorur3YQ/uTjmsNFsl9zCWbJrChVVitnkP8EstCtvwjHPRLloTW
         IkcIDmvKQr95+8ZUY06xfJNL+6qiitUFLm+A5rz70Ja8aIkGFkfN8esr9dIs+lf0gaV0
         Z7SRif0noqCgIjdb1gH9N4y62qSKd+Gg7yDZXt3ha3Q3Cc4+0QEk2d3RQx992Lfoqwe2
         Z5rg==
X-Gm-Message-State: APjAAAXM1M/leO7O2EH8Dvo9aKCv9nnA2jIzYWUIJdd3jqqnVnGNn/to
        kW7iyRAXJiFsVPlIlYUoTao=
X-Google-Smtp-Source: APXvYqxbtuiphdr7uOzm2RzAxCso5Xl2QTmkl8kXwKEa4vRk2eXXO+l8K2YzCgGuVBJOPQZ/zhBFOw==
X-Received: by 2002:a19:f601:: with SMTP id x1mr8477797lfe.182.1559074266579;
        Tue, 28 May 2019 13:11:06 -0700 (PDT)
Received: from esperanza ([176.120.239.149])
        by smtp.gmail.com with ESMTPSA id k21sm3592869lji.81.2019.05.28.13.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 13:11:05 -0700 (PDT)
Date:   Tue, 28 May 2019 23:11:02 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 6/7] mm: reparent slab memory on cgroup removal
Message-ID: <20190528201102.63t6rtsrpq7yac44@esperanza>
References: <20190521200735.2603003-1-guro@fb.com>
 <20190521200735.2603003-7-guro@fb.com>
 <20190528183302.zv75bsxxblc6v4dt@esperanza>
 <20190528195808.GA27847@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528195808.GA27847@tower.DHCP.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 07:58:17PM +0000, Roman Gushchin wrote:
> It looks like outstanding questions are:
> 1) synchronization around the dying flag
> 2) removing CONFIG_SLOB in 2/7
> 3) early sysfs_slab_remove()
> 4) mem_cgroup_from_kmem in 7/7
> 
> Please, let me know if I missed anything.

Also, I think that it might be possible to get rid of RCU call in kmem
cache destructor, because the cgroup subsystem already handles it and
we could probably piggyback - see my comment to 5/7. Not sure if it's
really necessary, since we already have RCU in SLUB, but worth looking
into, I guess, as it might simplify the code a bit.
