Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBC8C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 17:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBD220663
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 17:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="LG0YVlzd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfHMR1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 13:27:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35308 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfHMR1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 13:27:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id u34so7843335qte.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 10:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=jQhsDf1DznRSex/a7LVwp8uWG/IPk+ZwRH7Fgge5e4w=;
        b=LG0YVlzd3D7ukoBtj9pOruzMr2XJeS1j9cooymdGGntcDQotIz2RiRcChYMLTW67O/
         pwT+5TRXldqzb/hJKnC7Bi7cI+ASuHfJGwEtzJkBG6hwJgkmRoFiytHmMRwmSB9s2JHP
         1KObcEkt0M7Fc8ZdgQKdJcCStoxms4u8QoD9mH9ryq0EImt01JXzyD4ndfsNZaxZfRf2
         i+18j7kwEivuTMOkscTmHDGjFnBJMd1L74tUUqwjdkT7N9nMlnjmpkBK59UkY8WqRvIz
         vuZAnTtoU1G+RP4F0rQStT26JstGmqmOzOd2U1lxhoF2ANeOqqRP+l6VZx+526UM3lzI
         39cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=jQhsDf1DznRSex/a7LVwp8uWG/IPk+ZwRH7Fgge5e4w=;
        b=WlrgEkO25mkkFlE1HXU/CXLhTOSdcJV6a9ssA3k5II+g+/v140CS7Cy/uxVNxUMHTp
         h0C3en/Em3PugMvHMOfAGtBTJzpXSltjsIIFAf63JwsvBjRvRqYkYQr1FQUCNCl3dz3d
         QsGKh3jl7NYb9xrNnL7OSRh+9OG22anHkzRI5Ii4Akr+nA4OuUCMF3COTQHNufRoRUZD
         /mjxE1dIbbffD8gXYlYEzDJRW1rqEx0VUZvLh7NBwYW20lx3JW3Kdvbn8Xpx1nl4AIlF
         2ftdKH8pMo9OQe624HVfAXSMH8kC3Khl0ErxhRSrRq2mHZ2KHjxApiGTzPDEWVcvbSuC
         UI1A==
X-Gm-Message-State: APjAAAW7OyESc1aqy+z+It2t1FmYtZhKvqwn8REBREvCFM4BS/cJXDXs
        BYEIAioTUwLFSZdX8bGhahRGJg==
X-Google-Smtp-Source: APXvYqxx59bFR+LNu82qtjIyppKZl/hQoeMxMPtGJS0Z3hzxRd4qTu0P5JaiUM5/+bfTzsn8gAkOzQ==
X-Received: by 2002:ad4:448c:: with SMTP id m12mr4015867qvt.196.1565717236514;
        Tue, 13 Aug 2019 10:27:16 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id x28sm6883912qtk.8.2019.08.13.10.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 10:27:16 -0700 (PDT)
Date:   Tue, 13 Aug 2019 10:27:05 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+dcdc9deefaec44785f32@syzkaller.appspotmail.com>,
        aviadye@mellanox.com, borisp@mellanox.com, daniel@iogearbox.net,
        davejwatson@fb.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com, syzkaller-bugs@googlegroups.com,
        willemb@google.com
Subject: Re: general protection fault in tls_write_space
Message-ID: <20190813102705.1f312b67@cakuba.netronome.com>
In-Reply-To: <5d52f09299e91_40c72adb748b25c0d3@john-XPS-13-9370.notmuch>
References: <000000000000f5d619058faea744@google.com>
        <20190810135900.2820-1-hdanton@sina.com>
        <5d52f09299e91_40c72adb748b25c0d3@john-XPS-13-9370.notmuch>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2019 10:17:06 -0700, John Fastabend wrote:
> > Followup of commit 95fa145479fb
> > ("bpf: sockmap/tls, close can race with map free")
> > 
> > --- a/net/tls/tls_main.c
> > +++ b/net/tls/tls_main.c
> > @@ -308,6 +308,9 @@ static void tls_sk_proto_close(struct so
> >  	if (free_ctx)
> >  		icsk->icsk_ulp_data = NULL;
> >  	sk->sk_prot = ctx->sk_proto;
> > +	/* tls will go; restore sock callback before enabling bh */
> > +	if (sk->sk_write_space == tls_write_space)
> > +		sk->sk_write_space = ctx->sk_write_space;
> >  	write_unlock_bh(&sk->sk_callback_lock);
> >  	release_sock(sk);
> >  	if (ctx->tx_conf == TLS_SW)  
> 
> Hi Hillf,
> 
> We need this patch (although slightly updated for bpf tree) do
> you want to send it? Otherwise I can. We should only set this if
> TX path was enabled otherwise we null it. Checking against
> tls_write_space seems best to me as well.
> 
> Against bpf this patch should fix it.
> 
> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index ce6ef56a65ef..43252a801c3f 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -308,7 +308,8 @@ static void tls_sk_proto_close(struct sock *sk, long timeout)
>         if (free_ctx)
>                 icsk->icsk_ulp_data = NULL;
>         sk->sk_prot = ctx->sk_proto;
> -       sk->sk_write_space = ctx->sk_write_space;
> +       if (sk->sk_write_space == tls_write_space)
> +               sk->sk_write_space = ctx->sk_write_space;
>         write_unlock_bh(&sk->sk_callback_lock);
>         release_sock(sk);
>         if (ctx->tx_conf == TLS_SW)

This is already in net since Friday:

commit 57c722e932cfb82e9820bbaae1b1f7222ea97b52
Author: Jakub Kicinski <jakub.kicinski@netronome.com>
Date:   Fri Aug 9 18:36:23 2019 -0700

    net/tls: swap sk_write_space on close
    
    Now that we swap the original proto and clear the ULP pointer
    on close we have to make sure no callback will try to access
    the freed state. sk_write_space is not part of sk_prot, remember
    to swap it.
    
    Reported-by: syzbot+dcdc9deefaec44785f32@syzkaller.appspotmail.com
    Fixes: 95fa145479fb ("bpf: sockmap/tls, close can race with map free")
    Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 9cbbae606ced..ce6ef56a65ef 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -308,6 +308,7 @@ static void tls_sk_proto_close(struct sock *sk, long timeout)
        if (free_ctx)
                icsk->icsk_ulp_data = NULL;
        sk->sk_prot = ctx->sk_proto;
+       sk->sk_write_space = ctx->sk_write_space;
        write_unlock_bh(&sk->sk_callback_lock);
        release_sock(sk);
        if (ctx->tx_conf == TLS_SW)
