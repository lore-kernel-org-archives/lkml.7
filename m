Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87947C04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BB020862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gK3oowQ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfEOAcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 20:32:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37282 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfEOAcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 20:32:04 -0400
Received: by mail-qt1-f193.google.com with SMTP id o7so1340058qtp.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 17:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZuvtE8LhLnWnwrO3r/AvCgAsMqtJ3U02RYveyfJTTbU=;
        b=gK3oowQ0w4DMwVTNL1TIUlhxFvd1aXJCyiqugZPR5YvRVjwgL90DccyZfjk/QopKld
         Nkb6mmiB4CVkN5PZJAf5PuA2d1DWlLxLA2R9BVpDFPq5Bll/7aw+cPU3IzgUlGwZA2pL
         CncGKbWtYm7mU5ehYLMcdjU/W4Lxyhav2LF564uwe3Wmue3wJoL8ltjucjZ+6jvKOtAo
         Mya+oH4SHVxCN0yoyf6J0lMrs9G0SACQmwiZjrt8x8+Yr+/1VHr/437L9iJabaLvk+mm
         icdMbqNajjJjFsvLni/iFgsHAOafsSElB8iay+NsCjNPWh0gnuBRjTse5tWXbY0U0vYk
         8JVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZuvtE8LhLnWnwrO3r/AvCgAsMqtJ3U02RYveyfJTTbU=;
        b=CbtPAJ40DaGviJwy5nCoUf+p6ktnNiykfGrlnjT0DktsihLSUqm4Xc3ndKnBxKS5L0
         C/mggKazChWqfjZeLIYNhqnZF4b94rL59ps/4CKVgy8zjriqxi93ERfa2iTUjNVY1fc5
         byhaCXncMTlZEleYj+nX38uaOWNvm52CL2v1KWZq1sIrf62OvUpqHVtX+fM4DKMwtA/A
         EupS8Hl+p9i7u0T69npBYtB0Y11HyGid+ZhOy8SACjzhD7hhzaWRwVoh+9LyDd5KKBtB
         baRVXqWwY41jmpfvGEMltV+7u9v2Zamoak9PyrxaDkvCa1PPJgBVWN9ngr9LvctdIrHz
         9HIQ==
X-Gm-Message-State: APjAAAVp9Tyq8CbpPPJNS5RmgRZ+9RK/mjp/wfD3Xu+egXcg9XU17PGg
        2xud/uzzI1OgAeJhJNfGVoARwCHiW+k=
X-Google-Smtp-Source: APXvYqzMkFqpeQKTNm3VakW3JvjhtHcNW/1n5iqTqinImhuSdZ3N/zJFAS1xPsN7Uo4Vt2rZGUlT9g==
X-Received: by 2002:ac8:610e:: with SMTP id a14mr30710259qtm.51.1557880323092;
        Tue, 14 May 2019 17:32:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id t2sm188687qkm.11.2019.05.14.17.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 17:32:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hQhpy-0001qH-34; Tue, 14 May 2019 21:32:02 -0300
Date:   Tue, 14 May 2019 21:32:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        fengguang.wu@intel.com, kbuild@01.org
Cc:     Ariel Levkovich <lariel@mellanox.com>,
        Eli Cohen <eli@mellanox.com>, Mark Bloch <markb@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: undefined reference to `__aeabi_uldivmod' after 25c13324d03d
 ("IB/mlx5: Add steering SW ICM device memory type")
Message-ID: <20190515003202.GA14522@ziepe.ca>
References: <20190514194510.GA15465@archlinux-i9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514194510.GA15465@archlinux-i9>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 12:45:10PM -0700, Nathan Chancellor wrote:
> Hi all,
> 
> I checked the RDMA mailing list and trees and I haven't seen this
> reported/fixed yet (forgive me if it has) but when building for arm32
> with multi_v7_defconfig and the following configs (distilled from
> allyesconfig):
> 
> CONFIG_INFINIBAND=y
> CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
> CONFIG_INFINIBAND_USER_ACCESS=y
> CONFIG_MLX5_CORE=y
> CONFIG_MLX5_INFINIBAND=y
> 
> The following link time errors occur:
> 
> arm-linux-gnueabi-ld: drivers/infiniband/hw/mlx5/main.o: in function `mlx5_ib_alloc_dm':
> main.c:(.text+0x60c): undefined reference to `__aeabi_uldivmod'
> arm-linux-gnueabi-ld: drivers/infiniband/hw/mlx5/cmd.o: in function `mlx5_cmd_alloc_sw_icm':
> cmd.c:(.text+0x6d4): undefined reference to `__aeabi_uldivmod'
> arm-linux-gnueabi-ld: drivers/infiniband/hw/mlx5/cmd.o: in function `mlx5_cmd_dealloc_sw_icm':
> cmd.c:(.text+0x9ec): undefined reference to `__aeabi_uldivmod'

Fengguang, I'm surprised that 0-day didn't report this earlier.. 

and come to think of it, I haven't seen a success email from 0-day for
the rdma trees in some time - is it still working?

Thanks,
Jason
