Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F60BC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472C82064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 08:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbfCFIdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:33:18 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40139 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfCFIdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 03:33:17 -0500
Received: by mail-qt1-f195.google.com with SMTP id j36so11936644qta.7;
        Wed, 06 Mar 2019 00:33:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5+5bZHekAAuMjDf5KwRWchXV4/J2EN4fLoaIgfuWWo=;
        b=GgSJQtTKw9gRtD1ivB0XZWld+TfLJSbdmqqs3pRHDofVczGSQrIVZDg5lbi8M2yOfs
         Td9AcXLQVdkTf63ScVj9IVQC5/Lnm/apBucZvNiokpTNA5OUnVwakL60v10FpbU9OpXO
         kGZ2x2cwD5O/y4enlD+G/pp/Api+JPFVXXXVNP22dE3BhzUQx4xEpgLjI4oc6mIJM5Tx
         hGrIGXVKW4O6fUhKnho8IiTRhO3puZnNnfW7etucolAr8Nmfy41EKoyAfejr/+kkblZN
         slmLTL2/65VppAQbvqAvzdkiDFw6eYeZIHHBtkTSdPUY0GiNmKN/p/DFQ141j3eU09R2
         u4Qg==
X-Gm-Message-State: APjAAAVUsbUNx33MnSM5mZEoomVytYs/D4Mqx7h1ITqRgCuA4DguQgrh
        FG1KmS9kIOCwoHUOoHINI0cOweMZZqfX8Xnh0h8=
X-Google-Smtp-Source: APXvYqzeNkXPnCm57TIQNkZS7IPibIJWu3CZuCrFXYBNilElYccNQIAYrVBW63vP7rYUCNNyEoBVTK62tzFJe3NvAcE=
X-Received: by 2002:ac8:33f1:: with SMTP id d46mr4677903qtb.319.1551861196501;
 Wed, 06 Mar 2019 00:33:16 -0800 (PST)
MIME-Version: 1.0
References: <20190304204049.2150878-1-arnd@arndb.de> <CAM_iQpXC6s1fL_U-riRAoHT+gtcP8hE=w2MXyY7SGjSNO34dGg@mail.gmail.com>
In-Reply-To: <CAM_iQpXC6s1fL_U-riRAoHT+gtcP8hE=w2MXyY7SGjSNO34dGg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 Mar 2019 09:32:59 +0100
Message-ID: <CAK8P3a3Wegxxpjn00Ru6PX4JpwrQUQFbw46EnABR9Q4ThZTe-A@mail.gmail.com>
Subject: Re: [PATCH] net/sched: avoid unused-label warning
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Vlad Buslov <vladbu@mellanox.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Davide Caratti <dcaratti@redhat.com>,
        Simon Horman <simon.horman@netronome.com>,
        Adi Nissim <adin@mellanox.com>, wenxu <wenxu@ucloud.cn>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 1:28 AM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> On Mon, Mar 4, 2019 at 12:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
> > index 2a5f215ae876..3beb4717d3b7 100644
> > --- a/net/sched/act_tunnel_key.c
> > +++ b/net/sched/act_tunnel_key.c
> > @@ -392,8 +392,8 @@ static int tunnel_key_init(struct net *net, struct nlattr *nla,
> >  #ifdef CONFIG_DST_CACHE
> >         if (metadata)
> >                 dst_cache_destroy(&metadata->u.tun_info.dst_cache);
> > -#endif
> >  release_tun_meta:
> > +#endif
>
> These #ifdef's are ugly, either we should select DST_CACHE
> or provide a nop for these dst_cache_*() APIs when it is not
> enabled.

I agree that would be nicer, or alternatively convert the preprocessor
conditionals to C conditionals like

diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
index 3beb4717d3b7..586343a5accc 100644
--- a/net/sched/act_tunnel_key.c
+++ b/net/sched/act_tunnel_key.c
@@ -327,11 +327,11 @@ static int tunnel_key_init(struct net *net,
struct nlattr *nla,
                        goto err_out;
                }

-#ifdef CONFIG_DST_CACHE
-               ret = dst_cache_init(&metadata->u.tun_info.dst_cache,
GFP_KERNEL);
-               if (ret)
-                       goto release_tun_meta;
-#endif
+               if (IS_ENABLED(CONFIG_DST_CACHE)) {
+                       ret =
dst_cache_init(&metadata->u.tun_info.dst_cache, GFP_KERNEL);
+                       if (ret)
+                               goto release_tun_meta;
+               }

                if (opts_len) {
                        ret = tunnel_key_opts_set(tb[TCA_TUNNEL_KEY_ENC_OPTS],
@@ -389,11 +389,9 @@ static int tunnel_key_init(struct net *net,
struct nlattr *nla,
        return ret;

 release_dst_cache:
-#ifdef CONFIG_DST_CACHE
        if (metadata)
                dst_cache_destroy(&metadata->u.tun_info.dst_cache);
 release_tun_meta:
-#endif
        if (metadata)
                dst_release(&metadata->dst);

Usually, you'd want to do that consistently though, and change all the
related checks at the same time, so I would keep that separate from
the trivial bugfix.

     Arnd
