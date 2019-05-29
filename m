Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D57C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9294822CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 13:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uXjwPjRZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfE2N6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 09:58:30 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34824 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfE2N62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 09:58:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id h11so2596670ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 06:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FvnuOzvWWHxvWxRXVyec6ngD8uETWcADOgiOUZyOXOI=;
        b=uXjwPjRZCt5+NzEnNPmdCCkF3iYjQdmKQjzHPmIBvcHk21+tVcQk6R/TffAC7mbzK7
         3OwgsrDjSkovmg4CpeCxkjLO/kQQvYs0pmQohCNI7L8gZdD8RGrfY4VGJdYTU4SoFB3v
         vxOJmH2NmOUBLSaEMsTV4T0d7uI//nBlM9nMZjIItiftF4IVJAOz7r5HkBkNRO1ocej9
         uSw6MboF7GCpcr9BVSt1oVeMNInBa+xY8WKUwIpqaSATf3Ri/vgGphqjpJDKCfIuJNPw
         2XVz/73HtiI5Ls00TDoUhrA2TsMBVDDDh2a2MIgaAD8+i7k63TUUX87Zz6QC0oBlSFQ1
         qdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FvnuOzvWWHxvWxRXVyec6ngD8uETWcADOgiOUZyOXOI=;
        b=IB4u2HMrPDiAfJsqlHFdM8iroYEZuh1/pPdrcYNEIBCMtwm4Q41BxPWVROfw6vrEj+
         maJo9iUxgclFzELJvoFyDVwCKj169ryf1MeiRyQMVnam9J2Qk3ORNJATN+7KEXTQf/Py
         UEQHdaMgNnhc7rrFgh/WIqCM5d47jLpratn++kD/0E9/FMOG2wpAZHA6GmJPvLSZ154v
         iaKSBuZ3vq5+2LtQSZhz3UUk9mPErGbgD6YKyN5ZHBKICOvMBf2UM4IIKWwYJRuA6Imb
         KqMDC6fXo7+Tggwi5qu2Rbzr2vQ69zwsyRwOIBR81Wnkh+RU5Izb4BYuF+SXNzAdecWa
         t6aw==
X-Gm-Message-State: APjAAAVe3UG6IgmIgH15P2YMBPLcVuAJamEFyAa7i6+IvnzyfDQp0MNq
        QphImuqckkLHju0KyR17fFg=
X-Google-Smtp-Source: APXvYqxJcXNy9tjvGvb6p0Lmjk07Ff52IXEus1xxpwJYnnL8XqCx75U51Gw9O4dVXAeZBa+45pmDaQ==
X-Received: by 2002:a2e:a0ca:: with SMTP id f10mr1708409ljm.113.1559138306581;
        Wed, 29 May 2019 06:58:26 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id d18sm3473580lfl.95.2019.05.29.06.58.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 06:58:25 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 29 May 2019 15:58:17 +0200
To:     Roman Gushchin <guro@fb.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 4/4] mm/vmap: move BUG_ON() check to the unlink_va()
Message-ID: <20190529135817.tr7usoi2xwx5zl2s@pc636>
References: <20190527093842.10701-1-urezki@gmail.com>
 <20190527093842.10701-5-urezki@gmail.com>
 <20190528225001.GI27847@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528225001.GI27847@tower.DHCP.thefacebook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Roman!

> > Move the BUG_ON()/RB_EMPTY_NODE() check under unlink_va()
> > function, it means if an empty node gets freed it is a BUG
> > thus is considered as faulty behaviour.
> 
> It's not exactly clear from the description, why it's better.
> 
It is rather about if "unlink" happens on unhandled node it is
faulty behavior. Something that clearly written in stone. We used
to call "unlink" on detached node during merge, but after:

[PATCH v3 3/4] mm/vmap: get rid of one single unlink_va() when merge

it is not supposed to be ever happened across the logic.

>
> Also, do we really need a BUG_ON() in either place?
> 
Historically we used to have the BUG_ON there. We can get rid of it
for sure. But in this case, it would be harder to find a head or tail
of it when the crash occurs, soon or later.

> Isn't something like this better?
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index c42872ed82ac..2df0e86d6aff 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1118,7 +1118,8 @@ EXPORT_SYMBOL_GPL(unregister_vmap_purge_notifier);
>  
>  static void __free_vmap_area(struct vmap_area *va)
>  {
> -       BUG_ON(RB_EMPTY_NODE(&va->rb_node));
> +       if (WARN_ON_ONCE(RB_EMPTY_NODE(&va->rb_node)))
> +               return;
>
I was thinking about WARN_ON_ONCE. The concern was about if the
message gets lost due to kernel ring buffer. Therefore i used that.
I am not sure if we have something like WARN_ONE_RATELIMIT that
would be the best i think. At least it would indicate if a warning
happens periodically or not.

Any thoughts?

Thanks for the comments!

--
Vlad Rezki
