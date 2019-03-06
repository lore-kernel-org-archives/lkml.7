Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF82C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 00:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283DA206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 00:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDQVTKQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfCFA2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 19:28:36 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39382 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbfCFA2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 19:28:36 -0500
Received: by mail-pf1-f195.google.com with SMTP id i20so7002542pfo.6;
        Tue, 05 Mar 2019 16:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RAM2HMpl2HsmFvsKk1EDT375MaryroJEtdUbuA3WWWo=;
        b=hDQVTKQDvNz3FaAGZutJ6MQJgOxK98pVLdLlUrUg3dLOewdVEtn4bH0tDwz1xwNJeb
         f6nLMbXPS316qyrm0RsB2oMlMaKB5J/V1aOmqy0Rjf7Fv2FX7druw3bEr05GfIh/7ur/
         aaPh1NeZXwz/hwJICqc1oZS3ej49a7nqPw5w1Cd0p4k5S5mQJAyRHMabZMQHgCF9t38T
         JIxOsWq6te97d5n8E1zPhSgE3tIsEehuCwf3ozf6rDWQoEYwJvHN7ldFJkItC75Z3xM8
         bAfRLuV6R694fLIdIoPL7ds5b+t4zhNsUi23+SQkAa1LTrKV2eiUS7lf/6LwnUX1YdBg
         d1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RAM2HMpl2HsmFvsKk1EDT375MaryroJEtdUbuA3WWWo=;
        b=UZ33r4ehM6i3DKbFYgWI/Jq5oyFYx5wCg1gxhDYqy4JsnH4hFuKZfJ78ab4VxepC3N
         eGM7/G18BrP+60ATx8ega8ZiVqoQTn7oXTZvpkdOHkgbs76kwwTagK3qMKJ6BRYa2dnc
         +bP8pSu/6Z6SC793moL8ID0BsWDOBMovoGiKE51FnI8xhpTucG6o53fSMln7WoEI5iKO
         uxQHBQb2pExFrwNjdO2NfyXoJ2RsIDQOtk0+gNLqKx1lDuN6sZ0x8KP0nRFE5kd8Pbji
         S8UG1g/EtITPM6paYBclAIfSsbskhdw8KQPvCIcJw2/+uz4824Gk4S3mry7lI35VGP7G
         vq+A==
X-Gm-Message-State: APjAAAXTfLVArPfKP3+Cwzs5g9yc6pulB7INKfkIpNPSwHrrUxDl5kPz
        eQZtLlc1JzZciF1SAdME8GcLvvjXJvfoDyUB5QdXouqR
X-Google-Smtp-Source: APXvYqwMAIjU7f3E8M8u2UE+q2mLDTo5y4GTcUpWoFSwYkfQpGrQ0kFEj+dmgjJJGsNbER0oCAOJCUxWkuVUDVlTcIA=
X-Received: by 2002:a62:e716:: with SMTP id s22mr4438534pfh.35.1551832115146;
 Tue, 05 Mar 2019 16:28:35 -0800 (PST)
MIME-Version: 1.0
References: <20190304204049.2150878-1-arnd@arndb.de>
In-Reply-To: <20190304204049.2150878-1-arnd@arndb.de>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 5 Mar 2019 16:28:23 -0800
Message-ID: <CAM_iQpXC6s1fL_U-riRAoHT+gtcP8hE=w2MXyY7SGjSNO34dGg@mail.gmail.com>
Subject: Re: [PATCH] net/sched: avoid unused-label warning
To:     Arnd Bergmann <arnd@arndb.de>
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

On Mon, Mar 4, 2019 at 12:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The label is only used from inside the #ifdef and should be
> hidden the same way, to avoid this warning:
>
> net/sched/act_tunnel_key.c: In function 'tunnel_key_init':
> net/sched/act_tunnel_key.c:389:1: error: label 'release_tun_meta' defined but not used [-Werror=unused-label]
>  release_tun_meta:
>
> Fixes: 41411e2fd6b8 ("net/sched: act_tunnel_key: Add dst_cache support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  net/sched/act_tunnel_key.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sched/act_tunnel_key.c b/net/sched/act_tunnel_key.c
> index 2a5f215ae876..3beb4717d3b7 100644
> --- a/net/sched/act_tunnel_key.c
> +++ b/net/sched/act_tunnel_key.c
> @@ -392,8 +392,8 @@ static int tunnel_key_init(struct net *net, struct nlattr *nla,
>  #ifdef CONFIG_DST_CACHE
>         if (metadata)
>                 dst_cache_destroy(&metadata->u.tun_info.dst_cache);
> -#endif
>  release_tun_meta:
> +#endif

These #ifdef's are ugly, either we should select DST_CACHE
or provide a nop for these dst_cache_*() APIs when it is not
enabled.
