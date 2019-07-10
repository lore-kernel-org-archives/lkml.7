Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AF8C74A30
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2772086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KFJ/rKJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfGJRCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 13:02:19 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35419 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfGJRCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 13:02:19 -0400
Received: by mail-qk1-f195.google.com with SMTP id r21so2481470qke.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 10:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UWdZTbRnsOfkrH/gcvFB0nmiNziCHTNBkuYxVNvSC3M=;
        b=KFJ/rKJQwuFx0QxloQPg04YGFgrbogfNGTtlA0hv0mx17Fgjb0tQzdyrvEOK6kRqVz
         7V+L2vZL5axYHxpKV6n8NETnuOFvx37FqA1KdIe6t63DBxAo22WEW+NpazyKt4W7PU/F
         YZzlSjdDYOdL3qw4wSMRS05iRP/9F4VmlH4tG7RF5aVEXY+YbdicYqx3DAno8CHzgENV
         SYKHLnQgX6VR0QBtv7MzB0XcgF6wjcJGjL9NZuoMmbuz/5xH8ETaL64soSZk1BSbyJjw
         nJGUnB+cpnt2ly4hneJjgHp1qcMCq54f6L/fSPsxE+Z6xDxHcFLHJvjgE17iWIeMLTi3
         TQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UWdZTbRnsOfkrH/gcvFB0nmiNziCHTNBkuYxVNvSC3M=;
        b=RxOkLYlpopWDurhfmoNWBHcjKVvpGXl++SkWzh9UV3Ff4ToFJ2ghoTAZFM1rZrLZCu
         BOYJ1yZCvfFcxM2hThC0Ro3xbrfFvmVjyy0JVkFP++6re1Ud4V9U1Vhy/h8SO59S4yEs
         yJH5/t1jh6hXupThzdTImUCDwtzG/yiqb4db4BAOaLPErbm22NvUl122m7+ObB7SkgPV
         Nb1gpLNph6ar7dMeXdkfDeRz8jYlH92Kg+zDu9Y/xITB9kLfz56J4jQCoH13bi8LksCe
         qAcwDX7cxd488+Kh59PA4l5ENw3f0bl42STi8aXK4LEAg3kAZXFHx3/zJgpCeJgT+//O
         8c+g==
X-Gm-Message-State: APjAAAUiMfn1nnz21At5VSJeFGVSr2gJB2w5CRJ8RcqQX3DVI7BzQhv+
        8M8laSccBjYhqQQi4WNbxhPchA==
X-Google-Smtp-Source: APXvYqwQRvMw1qmf0I+iflnwNBy81igr/lgAIC0lwckLUWcLDJy+FXVNnTw++UOx4c3kGykVJaBT3g==
X-Received: by 2002:a37:a343:: with SMTP id m64mr24438145qke.75.1562778138173;
        Wed, 10 Jul 2019 10:02:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id r205sm1587546qke.115.2019.07.10.10.02.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jul 2019 10:02:17 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlFyy-0003xQ-Ve; Wed, 10 Jul 2019 14:02:16 -0300
Date:   Wed, 10 Jul 2019 14:02:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Kamenee Arumugam <kamenee.arumugam@intel.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] IB/rdmavt: Fix variable shadowing issue in
 rvt_create_cq
Message-ID: <20190710170216.GA15103@ziepe.ca>
References: <20190709221312.7089-1-natechancellor@gmail.com>
 <20190709230552.61842-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709230552.61842-1-natechancellor@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 04:05:53PM -0700, Nathan Chancellor wrote:
> clang warns:
> 
> drivers/infiniband/sw/rdmavt/cq.c:260:7: warning: variable 'err' is used
> uninitialized whenever 'if' condition is true
> [-Wsometimes-uninitialized]
>                 if (err)
>                     ^~~
> drivers/infiniband/sw/rdmavt/cq.c:310:9: note: uninitialized use occurs
> here
>         return err;
>                ^~~
> drivers/infiniband/sw/rdmavt/cq.c:260:3: note: remove the 'if' if its
> condition is always false
>                 if (err)
>                 ^~~~~~~~
> drivers/infiniband/sw/rdmavt/cq.c:253:7: warning: variable 'err' is used
> uninitialized whenever 'if' condition is true
> [-Wsometimes-uninitialized]
>                 if (!cq->ip) {
>                     ^~~~~~~
> drivers/infiniband/sw/rdmavt/cq.c:310:9: note: uninitialized use occurs
> here
>         return err;
>                ^~~
> drivers/infiniband/sw/rdmavt/cq.c:253:3: note: remove the 'if' if its
> condition is always false
>                 if (!cq->ip) {
>                 ^~~~~~~~~~~~~~
> drivers/infiniband/sw/rdmavt/cq.c:211:9: note: initialize the variable
> 'err' to silence this warning
>         int err;
>                ^
>                 = 0
> 2 warnings generated.
> 
> The function scoped err variable is uninitialized when the flow jumps
> into the if statement. The if scoped err variable shadows the function
> scoped err variable, preventing the err assignments within the if
> statement to be reflected at the function level, which will cause
> uninitialized use when the goto statements are taken.
> 
> Just remove the if scoped err declaration so that there is only one
> copy of the err variable for this function.
> 
> Fixes: 239b0e52d8aa ("IB/hfi1: Move rvt_cq_wc struct into uapi directory")
> Link: https://github.com/ClangBuiltLinux/linux/issues/594
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied to for-next with Mike's ack

Thanks,
Jason
