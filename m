Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93943C47404
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFED206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 02:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="jpByXRk0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbfJJCXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 22:23:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32809 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfJJCXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 22:23:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so2891317pfl.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 19:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=aBeHMgOj8kOPkp/mXf555NmaRLhdV3k2lpJOHH9DSxs=;
        b=jpByXRk0Y1OKjPhmlZ2hdsZFkPAOQ4gxO6YktXsyMGFkt8zs5UgN01+ApBKqYIpXVK
         62tgy3MHc0GouJPG+0KS4EtpqXs+JfTGgCsCibU9/L/p7W3fNz4XIaljkvbpB/GJfOBk
         SJzZwqA3MxxYuPD6vTbXvuKFe6JaN29BwoL5yZLOVrrCQ90zwiRa/rgewEr4/5yYAsAI
         mL+IR3MJOlx78/XUXSCB6K42n4pMYMCbsRZt7EJg6wygNXptQ6Q4Y8XPXd/DAQFHP9W2
         toD8hZQvdaj6HQp4FouvgCR9vfHy4mwckHYbFov78+07qu8WLosCGCekNGILc1gurbXo
         GFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=aBeHMgOj8kOPkp/mXf555NmaRLhdV3k2lpJOHH9DSxs=;
        b=M09BGYMgN1POq+5oe0Y3PtvrnFf0/oxHGZt0EiXVSupa6ZFQZ0mS3xEdXN+S6mtSx/
         DRLFVLZWJjKJBmcvopOmKMFdPMDQmv6/JyPitnEFQlhfWHm6lt2KTw472dHPlpWFe4UL
         THCHHrRGmrIYqxp9J7YB4C97QWlz+t6IynECLkp8Cw72uwew1JM6toO7tIS6X6KLku/I
         uAgHh4pjZUy70B8988X9zhDLvSYDdQLfTOhk8LLPPA1KR+YzROlsDjhArnnhcMe/7Zo5
         OPlJPFRDLPjQCimmYgRsbnVsJa2BVIOLrtIi2jTT4Dld3iYEfeousKKwvM20uTFndNfa
         +fsQ==
X-Gm-Message-State: APjAAAVkPQSeWocbhTqtpS9KPuu2xr2c5DN0HhCAGoLU063d1+V5c2t7
        n9q27fSJ6gUveHv4aqsa4UuKww==
X-Google-Smtp-Source: APXvYqwIOi9sHsxYxViE9LtrIeUR0YAWQ5FeFfl7acya6XRrVGkRVJeHhp1JawccOJyWsSkcHBW47g==
X-Received: by 2002:a17:90a:24ab:: with SMTP id i40mr7955033pje.121.1570674229873;
        Wed, 09 Oct 2019 19:23:49 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id n15sm3166468pjt.13.2019.10.09.19.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 19:23:49 -0700 (PDT)
Date:   Wed, 9 Oct 2019 19:23:35 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] act_mirred: Fix mirred_init_module error
 handling
Message-ID: <20191009192335.3019d283@cakuba.netronome.com>
In-Reply-To: <20191009031052.40528-1-yuehaibing@huawei.com>
References: <20191009031052.40528-1-yuehaibing@huawei.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2019 11:10:52 +0800, YueHaibing wrote:
> If tcf_register_action failed, mirred_device_notifier
> should be unregistered.
> 
> Fixes: 3b87956ea645 ("net sched: fix race in mirred device removal")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Why does the subject say net-next, looks like the bug was introduced
all the way back in 2.6.36. For fixes for code which is already in
Linus'es main tree the subject should say [PATCH net]. Those are on the
fast path to the -rc releases and stable.

Applied to net, and queued for stable, please let me know if I
misunderstood the intention here.
