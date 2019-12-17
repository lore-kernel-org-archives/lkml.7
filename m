Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA6EC2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6133C24672
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="S8MaiI4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfLQPcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:32:16 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36206 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbfLQPcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:32:16 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so3663127wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 07:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jr1dFn2z1P4MsCtmqPO29rPINYbqBsWbvl95K0lo3qY=;
        b=S8MaiI4Z66kRaGiMhNUN5izJT/aLZ2SBTEoB/9/RfJGT+OLbgVeTb6CrjMk2gwEaEM
         iApa7Msqy8sCczZO6v7wBKLtLk0o2ps7CXJQeGl93tTlLgTx8zPCahSxnVSmPwoBo6gP
         QBL1DbYqpLBffIsBuRFiZz/01B9trZgNwndZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jr1dFn2z1P4MsCtmqPO29rPINYbqBsWbvl95K0lo3qY=;
        b=i0vrcoOmqmwBYwVEq0xUjLHqvGZoyWxsKWraLDkXQFQcqTiw6cvmD08720UmmCJifJ
         x8MVdUZe4bc0A3M3iz9qpgf/dhe5fSqaV/gyPWPSVSPGYAZjlKvesNjWpRsp2p+btiDo
         TwVywA7QurDK9CkRuNyvUCCqxmgOUn9LvbTnIzEkMxHYsvbQVFXrnNHhRCSpyXLFxsAH
         D3g9CFssXgp165+w1e28VlJh8fv3Rrhbn/4gD9cQlC0Ut+QDZU6thJIjRr6C1R8Iy30H
         Rx9/4DJJhWRfUqgCmUoz0D+PBcEtY8YH17godyOFV1vUed4CuKW45eqD409fom/t6z6w
         uEDQ==
X-Gm-Message-State: APjAAAWsXttdhaXAOheOiuMTnrSgNwBpj8eobiytvXkz/SdC3GDreI+U
        tfP+wSr4Yo6rMFOMRWe9DD7bNg==
X-Google-Smtp-Source: APXvYqzjU+JjhEXh9jQai0fkom/Xh8F1LV3x9ndI4wUqXHm32YZsa8QsrQNMx4xEzc2db+PVzyZe/Q==
X-Received: by 2002:a1c:1bc3:: with SMTP id b186mr6133038wmb.79.1576596734150;
        Tue, 17 Dec 2019 07:32:14 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:f184])
        by smtp.gmail.com with ESMTPSA id f9sm3320285wmb.4.2019.12.17.07.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:32:13 -0800 (PST)
Date:   Tue, 17 Dec 2019 15:32:13 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Qian Cai <cai@lca.pw>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol.c: move mem_cgroup_id_get_many under
 CONFIG_MMU
Message-ID: <20191217153213.GC136178@chrisdown.name>
References: <20191217135440.GB58496@chrisdown.name>
 <392D7C59-5538-4A9B-8974-DB0B64880C2C@lca.pw>
 <20191217144652.GA7272@dhcp22.suse.cz>
 <20191217150921.GA136178@chrisdown.name>
 <20191217151931.GD7272@dhcp22.suse.cz>
 <20191217152814.GB136178@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191217152814.GB136178@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Down writes:
>Maybe Qian is right and we should just ignore such patches, but I 
>think that comes with its own risks that we will alienate perfectly 
>well intentioned new contributors to mm without them having any idea 
>why we did that.

s/Qian/Cai/ :-)
