Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B334C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1452166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="m3NGDl7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbfH2Sxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:53:43 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35006 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbfH2Sxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:53:42 -0400
Received: by mail-ed1-f67.google.com with SMTP id t50so5196910edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 11:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=8DrLJYkJSDE8yNy0hRWD87xXnqGiLOj6Q5kMDIVILTo=;
        b=m3NGDl7hjD+pzGgurTlgTCSL/BEaKxEELRGKgiRlKZ/FPBlvDKeFYDy8pUB5aMUjop
         R1imImwALYyWHL+UzB2n1ZoevwjUcrNiarQjRCaR9mAVrZg5kPskOWCqxJJ5XvEEJER+
         5YYooJ1a4H0TCpLtIceMxZP+jLsGSZhQzGg7w73h1dIkYdnQTuEVVk4J3IMmUrIke3E9
         55Fn5mGoyrv6vB7KyAZRbUjhs7Iu/oQEfflYsxmjmCG/xutlzUMglCQi4oGyBisLuWEj
         mAzlM0ZDkHP6gwkHxv5TARcTE1TrIkbJiWshIBdpA7PyOtHjrB7uIrkgKallm9m3k6HW
         3uHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=8DrLJYkJSDE8yNy0hRWD87xXnqGiLOj6Q5kMDIVILTo=;
        b=q8V7N6yjR5hKd3znqq1Vh2FJ/JWzbQ9TW9cN5gwLwmcctk0BkhFygzQ9tD4BxLwwLy
         iWgU9RJTCMKUj/cv4stTnCcC2hd59InTyHRbKL/oNMHKJ2JKN3pFeKGRAJkGBhKTykVz
         3loEuOFr6PBA6QO6XqU0sQxHpGzO0chSlgzjszVCwcjHzHN73vlw8mu7mFFLhdVBXWDj
         0bEzs7LWxsWyuLjVGRiMrJuAwflCV3zL+XvFgmh05jKgZP112mZysYQRc0j7yD1RB28x
         +on5u5GhWZaZpvscFUQYelGMihMKsSVPL61nAKWHGk91IO0pN1JvgCdg3UQp8Gbaun3x
         DlKg==
X-Gm-Message-State: APjAAAV5JUNiMaSbQFSVfGtMI6XJLx/shGMf163X4/b+TjlEwLjhB9P/
        arWrBfCOa6ToD+epPik2OdI5kQ==
X-Google-Smtp-Source: APXvYqxEU5dPHwogKs7meFTghoVkRShv2YncuB/Wrey1TYBX0MK6m3BZ6WFZ1VoroG6wLOe39AwyuA==
X-Received: by 2002:a50:8ec9:: with SMTP id x9mr11413207edx.89.1567104821374;
        Thu, 29 Aug 2019 11:53:41 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id s22sm590615eds.67.2019.08.29.11.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 11:53:41 -0700 (PDT)
Date:   Thu, 29 Aug 2019 11:53:15 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+7a6ee4d0078eac6bf782@syzkaller.appspotmail.com>,
        aviadye@mellanox.com, borisp@mellanox.com, daniel@iogearbox.net,
        davejwatson@fb.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in tls_sk_proto_close (2)
Message-ID: <20190829115315.5686c18f@cakuba.netronome.com>
In-Reply-To: <5d681e0011c7b_6b462ad11252c5c084@john-XPS-13-9370.notmuch>
References: <000000000000c3c461059127a1c4@google.com>
        <20190829035200.3340-1-hdanton@sina.com>
        <20190829094343.0248c61c@cakuba.netronome.com>
        <5d681e0011c7b_6b462ad11252c5c084@john-XPS-13-9370.notmuch>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019 11:48:32 -0700, John Fastabend wrote:
> Jakub Kicinski wrote:
> > On Thu, 29 Aug 2019 11:52:00 +0800, Hillf Danton wrote:  
> > > Alternatively work is done if sock is closed again. Anyway ctx is reset
> > > under sock's callback lock in write mode.
> > > 
> > > --- a/net/tls/tls_main.c
> > > +++ b/net/tls/tls_main.c
> > > @@ -295,6 +295,8 @@ static void tls_sk_proto_close(struct so
> > >  	long timeo = sock_sndtimeo(sk, 0);
> > >  	bool free_ctx;
> > >  
> > > +	if (!ctx)
> > > +		return;
> > >  	if (ctx->tx_conf == TLS_SW)
> > >  		tls_sw_cancel_work_tx(ctx);  
> > 
> > That's no bueno, the real socket's close will never get called.  
> 
> Seems when we refactored BPF side we dropped the check for ULP on one
> path so I'll add that back now. It would be nice and seems we are
> getting closer now that tls side is a bit more dynamic if the ordering
> didn't matter.

We'd probably need some more generic way of communicating the changes
in sk_proto stack, e.g. by moving the update into one of sk_proto
callbacks? but yes.

> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 1330a7442e5b..30d11558740e 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -666,6 +666,8 @@ static int sock_hash_update_common(struct bpf_map *map, void *key,
>         WARN_ON_ONCE(!rcu_read_lock_held());
>         if (unlikely(flags > BPF_EXIST))
>                 return -EINVAL;
> +       if (unlikely(icsk->icsk_ulp_data))
> +               return -EINVAL;
> 
>         link = sk_psock_init_link();
>         if (!link)

Thanks! That looks good, if you feel like submitting officially feel
free to add my Reviewed-by!
