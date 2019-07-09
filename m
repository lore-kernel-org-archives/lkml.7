Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CE1C73C5C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 22:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7D72082A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 22:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TxK8nEyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfGIWjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 18:39:10 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38219 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfGIWjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 18:39:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id y15so68239pfn.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 15:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7lStp7wKHf6Ask7O0Oc+ibRyWBiXzjLJTev2OPu1R8k=;
        b=TxK8nEyP+BHCYENCDLzIjf/lr/5HGTOL959SnV2yVYjPi6FK3vVxaRDjiCQKxcqdtG
         0qp7kBgnZ8I7VPmnloKcuPkRmLmfG1xRq3WbpCoM7PpWBpb/S8WfUj+S+AM/qoEUykZj
         PX9TC/sfh3jzPxeLGV7+a3YTZhW4U8iCW7406gtL5tfgz4nU2mzVWq3Lwwjb+mF2XE5m
         h6aKQmPc2+p6DCUXSb54VrZ8LhqZmnRvy2ikPfWioeDllOvDDjwUKNitNLuZVEkIC6/6
         iZntav9Q2GIQHts9q0F07ApQzggmhk82DiQqdT46IzcZcn/qlCrkPficVdKN901fvAep
         yjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7lStp7wKHf6Ask7O0Oc+ibRyWBiXzjLJTev2OPu1R8k=;
        b=QYUMvr2AYseSJIsaR90AcYkvgqU3Kw9a5Fvgh18spNKn58XQndfgsHS0sZq6z/372C
         N9MWjBmoB0vSMypKTco3qRT9I9xGe/eeMmIWWMz5HzTbbpZiXnyTWbJzrR4JElKbva+v
         st37/yJBOZzwbCdr/mBYAWvtLNsJxGealuCYhmx9c9VsF5p8I/TK05AWHETXQk2Je4ls
         IcVJu4wqxVkNTrxQFomVgUr73WH7iuOLy/rXIVqheNOI+GxPZKE+8JXs56OTZYW+CPNL
         F5ZhZI+R7VuM4iYzpDVJFZTMM7lx3N8vKkMW9JWCj3v+RwftbA4KCnazI3OhhOXpNdwq
         LiSg==
X-Gm-Message-State: APjAAAXuUEjKEa9RHpliPB/7J5VJx8tGw7eyh13Tt4YYnfVBGIWz+lnh
        RZFleIZHta2WEhQ2Zk58mkPxmPwbOqB/YxUogpP1SQ==
X-Google-Smtp-Source: APXvYqzbJ54HGVlXDIVraK2vlpHUMYu/or795QKC6xwteu9BT7bhsM1V6gPio+zzSpd8UHn3zJpAot9ufQCtPpl+tsY=
X-Received: by 2002:a63:52:: with SMTP id 79mr32862431pga.381.1562711948639;
 Tue, 09 Jul 2019 15:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190709221312.7089-1-natechancellor@gmail.com>
In-Reply-To: <20190709221312.7089-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 9 Jul 2019 15:38:57 -0700
Message-ID: <CAKwvOdkXwD6Wvyt5tYWJP7f3YePqUe1_TvST2RMNb_tSEc3cEQ@mail.gmail.com>
Subject: Re: [PATCH] IB/rdmavt: Remove err declaration in if statement in rvt_create_cq
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kamenee Arumugam <kamenee.arumugam@intel.com>,
        linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 3:13 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> clang warns:
>
> drivers/infiniband/sw/rdmavt/cq.c:260:7: warning: variable 'err' is used

Oh, !$*@, this is a tricky one.  While the if scoped `err` declared on
L250 is initialized when used at L260, the function scoped `err`
declared on L211 is not initialized when it is used on L310 when
control flow enters the if on L249 then the goto on L255 or L261.  So
this is a bug due to the if scoped `err` "shadowing" the function
scoped `err`.

Maybe not important enough to send a v2, but I feel like the commit
message should say something along the lines of `fix a potential use
of uninitialized memory due to shadowing`.  Either way, this fixes a
real bug, so thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

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
> There are two err declarations in this function: at the top and within
> an if statement; clang warns because the assignments to err in the if
> statement are local to the if statement so err will be used
> uninitialized if this error handling is used. Remove the if statement's
> err declaration so that everything works properly.
>
> Fixes: 239b0e52d8aa ("IB/hfi1: Move rvt_cq_wc struct into uapi directory")
> Link: https://github.com/ClangBuiltLinux/linux/issues/594
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/infiniband/sw/rdmavt/cq.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rdmavt/cq.c b/drivers/infiniband/sw/rdmavt/cq.c
> index fac87b13329d..a85571a4cf57 100644
> --- a/drivers/infiniband/sw/rdmavt/cq.c
> +++ b/drivers/infiniband/sw/rdmavt/cq.c
> @@ -247,8 +247,6 @@ int rvt_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>          * See rvt_mmap() for details.
>          */
>         if (udata && udata->outlen >= sizeof(__u64)) {
> -               int err;
> -

-- 
Thanks,
~Nick Desaulniers
