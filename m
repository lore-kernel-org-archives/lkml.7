Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20381CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 21:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCEB621D7C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 21:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571519942;
	bh=5NIgPeAorki+91Xyvn/g4IODdbGIXIetD+v6u829xr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IWzR+/eLFPVstw3xuuMDNvGmPmPQesHfhL6n8d40+UxrkoQwzBw8D1xGMJeY1EQAC
	 bYRJ+lreKH6DLY3gxqh9Dwa4tREVhLJ7GGlsOaoJYxpMWMcmdemV2y2NJF6H0Ww/p7
	 VMwA8L+NQ0aru+B6Iy8QicyqkXTCEPB3cqrtv9SY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfJSVTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 17:19:01 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42444 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfJSVTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 17:19:01 -0400
Received: by mail-qk1-f196.google.com with SMTP id f16so8646567qkl.9;
        Sat, 19 Oct 2019 14:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OInwu2l8kRk36qEJ8aNRyw7RXhD3MTVYTP7FbpPhse4=;
        b=msbumPEGjHgLWB8mpblDcXdfWf4cA3qLnXRTAY43JRS5vNYG8h7q5A3pKbFUke3ri/
         Fucckdkaf3jRiO7eGnRPrD1GB6swjdsp4Hye9h3DzAO3fCmepFHfLfW8EGjPB6gX+Hue
         7HCyFLS0hGxoIwQN5xEsncGcHAzrE+jJ61gxsOWVMOWgOCb2MJmXDwEz3vEKLY1SSYsn
         AGkIIFsY7+f+Hbwu9q8T2erHOrCoLHYFnDDhMqXFdiZOqtf/ahJG2X5PYog5rA1rWa8I
         g35+JsU5gLf1XHgOdevE9eN2FmrX/n9VM2pA3uaMP/w05zZGyuLgTdluJ4/Zo9/ThgvU
         QAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OInwu2l8kRk36qEJ8aNRyw7RXhD3MTVYTP7FbpPhse4=;
        b=bhvHIi74q+6YXn/lxws67JhsY+UijtcJF5gU5bByzX8AohWvgbJGHHBp/Yzhp+z9gr
         E0hhizfiS89E5KVrZYfR8mgNGghG2G7g5TANXqUEU9hZjNRx8XclvQvggp6+rtmJUR3E
         hybwG4yyB7bK+CJPTukdks0Yu1a2ZMKiETA7X0iwWayzsD+nRUrQO+0gq7g98lBy1hyK
         Gp/WQKJqgtBaHUaRJnM0JTo48abgG8Vtn1bGzPuipaBC3++5oBxZqwQGDmrIMhhJ74dE
         1ftETL+fSlURs0e8cYqtP++1I7aRtnGo08KiMVPU6TESzcaXRu7DE03Yu1hkIezYnWSc
         aCBA==
X-Gm-Message-State: APjAAAXell/LT8LLjv0Pttytp5olHDkd6tpgmrc/AmoBHkuDdl+3bXz0
        ieGXZxiA6Ble4Zc9eiNoQh8=
X-Google-Smtp-Source: APXvYqw5BihCOMh10bAyfZPbJrYrEXHCPtpu2iGDpXQkxzekBaAZfJHZ4nvYV095qX7yi2bTUXaNtA==
X-Received: by 2002:a05:620a:13c1:: with SMTP id g1mr8673058qkl.369.1571519939913;
        Sat, 19 Oct 2019 14:18:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1d0d])
        by smtp.gmail.com with ESMTPSA id h23sm4076165qkk.128.2019.10.19.14.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Oct 2019 14:18:59 -0700 (PDT)
Date:   Sat, 19 Oct 2019 14:18:56 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] net: fix sk_page_frag() recursion from memory reclaim
Message-ID: <20191019211856.GR18794@devbig004.ftw2.facebook.com>
References: <20191019170141.GQ18794@devbig004.ftw2.facebook.com>
 <dc6ff540-e7fc-695e-ed71-2bc0a92a0a9b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc6ff540-e7fc-695e-ed71-2bc0a92a0a9b@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, Oct 19, 2019 at 11:15:28AM -0700, Eric Dumazet wrote:
> It seems compiler generates better code with :
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index ab905c4b1f0efd42ebdcae333b3f0a2c7c1b2248..56de6ac99f0952bd0bc003353c094ce3a5a852f4 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2238,7 +2238,8 @@ struct sk_buff *sk_stream_alloc_skb(struct sock *sk, int size, gfp_t gfp,
>   */
>  static inline struct page_frag *sk_page_frag(struct sock *sk)
>  {
> -       if (gfpflags_allow_blocking(sk->sk_allocation))
> +       if (likely((sk->sk_allocation & (__GFP_DIRECT_RECLAIM | __GFP_MEMALLOC)) ==
> +                   __GFP_DIRECT_RECLAIM))
>                 return &current->task_frag;
>  
>         return &sk->sk_frag;
> 
> 
> WDYT ?

Whatever works is fine by me.  gfpflags_allow_blocking() is clearer
than testing __GFP_DIRECT_RECLAIM directly tho.  Maybe a better way is
introducing a new gfpflags_ helper?

Thanks.

-- 
tejun
