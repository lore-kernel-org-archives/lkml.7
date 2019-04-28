Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F286EC43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 17:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BBB20679
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 17:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktt4S2uw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfD1Rth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 13:49:37 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39956 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfD1Rth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 13:49:37 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so3980399plr.7;
        Sun, 28 Apr 2019 10:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ReMa3lA4dTqx6S8UgW8LBG5rG/kkJQz95pkoLA0UvGQ=;
        b=ktt4S2uw6GUN2+dnog/70saXglSNa1lsCTrZ7RFKkfGcfC4hLQb/Xf3eWwsAamz7GB
         ZKnCoeYzc7Gy5FNYm3F+rCAj8FNlDB6CH+xVwZAU/Z780wTAg48caGKxrkOD34omKuFn
         Om8X4OGn3gIL5On0U6VGoa3N53FKaS2GYBPL4M33RkxA2hRQcBEDsCodl7MP/gk9Ouyp
         5sY7sH0Ckxor7J7gWQ9QcYXUXNnf55SntBafL8n7/O3KGYQA7YSvQ499loyvjsnh/0GE
         HatukgZBgNjjtnebV3L2wAswpotfc0ZVeGLltCDXABr64lwXPK/IzqgEPqC0lC/8CBrR
         +sWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ReMa3lA4dTqx6S8UgW8LBG5rG/kkJQz95pkoLA0UvGQ=;
        b=MCBONwu25huniWbAesbyodCtONKxNUTGro0FEKdhJFFU11sHEqH8C+2eXcFDTveIj1
         /1dD3MUHwl3vIYUWtjS4RQEy9BS3I2R9lNR9iiPNa0wlYtfTbFDLvZXn6M97gWwkP0Ws
         jV+flEQwCaSw74+P/FBxElHaGt++wtWUxn/dlmPQc+ZDo//L+q68kZSXSzGG/Q+BDdrm
         cfTcebkC5HCgpUhPa47vJesyI4GJJh6hxwV11U5l58Qe+y7f5fNOi0alvDVyUjBhy7rn
         R8EgsdC/mRkL3vFxRXnCqsAtGQ3Jg8K6NP+Z792Pm/ygj3lz5Mh3sBgMTN4WX6L449vR
         8Q8w==
X-Gm-Message-State: APjAAAUdEMgUSfNM4k3SQ/mqMH/idK6cALoeFANXNgxF0p7Qu7FkTPeU
        58Rr+qjstZV0aLBpScsqSmi3qqAdO8J266HedN0=
X-Google-Smtp-Source: APXvYqzy8bUNyNWSC+RH4tcYn/fHYB4xffijJO1x4Vh3LVRueQnvu6qo0VUj8XQJ7YkyP+K4NyVvvNdwdBUOqOR/N6k=
X-Received: by 2002:a17:902:e405:: with SMTP id ci5mr23596907plb.224.1556473776553;
 Sun, 28 Apr 2019 10:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <71250616-36c1-0d96-8fac-4aaaae6a28d4@redhat.com> <20190428030539.17776-1-yuehaibing@huawei.com>
In-Reply-To: <20190428030539.17776-1-yuehaibing@huawei.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Sun, 28 Apr 2019 10:49:25 -0700
Message-ID: <CAM_iQpX5RgaixruwWW=3YdMHR69yjcPME+bXnC0PozxOnCM0hg@mail.gmail.com>
Subject: Re: [PATCH] tun: Fix use-after-free in tun_net_xmit
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     David Miller <davem@davemloft.net>,
        Jason Wang <jasowang@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Li,Rongqing" <lirongqing@baidu.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Chas Williams <3chas3@gmail.com>, wangli39@baidu.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 8:06 PM Yue Haibing <yuehaibing@huawei.com> wrote:
>
> If tun driver have multiqueues, user close the last queue by
> tun_detach, then tun->tfiles[index] is not cleared. Then a new
> queue may add to the tun, which using rcu_assign_pointer
> tun->tfiles[index] to the new tfile and increase the numqueues.
> However if there send a packet during this time, which picking the last
> queue, it may uses the old tun->tfiles[index], beacause there no
> RCU grace period.

This analysis makes sense. It is a normal scenario for RCU,
where readers could still read even after we unpublish the RCU
protected structure, we only need to worry about when we free it.


> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index e9ca1c0..3770aba 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -876,6 +876,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>          */
>         rcu_assign_pointer(tfile->tun, tun);
>         rcu_assign_pointer(tun->tfiles[tun->numqueues], tfile);
> +       synchronize_net();
>         tun->numqueues++;
>         tun_set_real_num_queues(tun);

But this fix doesn't make any sense, we only wait for RCU
grace period when freeing old ones, not for new ones. RCU
grace period is all about readers against free.

This is why I came up with the SOCK_RCU_FREE patch, which
is also blocking-free.


Thanks.
