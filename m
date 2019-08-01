Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121E7C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52D5206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Mvpx3v8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732864AbfHAQUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:20:38 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33120 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731915AbfHAQUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:20:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id r6so66578976qtt.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 09:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D5T2Uxf2pvzlQgNSYEF3ht0LNwLAYlgpi5hrr37GkRA=;
        b=Mvpx3v8Tm65xrnLV1EEww37UC+PyVjoVk0+zWXwvZuOSfAQOvUYvAIomjd6kZXE1gm
         fjhkNNRtdDpAu+RewXXHKx7mSV8JMWpKCGvIxwTvHgMK27WN/QZa/a7srPkJ/HxDu3V2
         L4k8BVG8VOyNSVwuZTpgxORfTSMmIcshkYReCcSchZWN5KARvBqEfc8kdMGiQBXUjIUl
         YFrLvqbdBF3FWqokJ5gbVYX2/kk6/jj28S7bgpAlFL6davzgmsWX2aYIDuj7lPw+9n2B
         I/mVkvDLFFDWnvklQinWPZ4RpGz+2EhoWotw4JVe3y5rClcRe4FvA1kWYpnKfD5YbNt0
         DS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D5T2Uxf2pvzlQgNSYEF3ht0LNwLAYlgpi5hrr37GkRA=;
        b=EtUIUc27eZ3S3oJOwYi16yKMr13KaTSz58obO4WtyRjiOcNFBKrsIWFt73gb9zztjK
         Xj1UD62AxboT03gDKAckGCxTMRpc3vTxjWOcSit5NQu2mlVQE/cRqkZyGt7AGLwAPpHI
         7f/vBFKij9S5UvtkNkVyIWQ7ztVcVUKyLvJvOoOqjWT0MW59z8kq1C6OIj7ZuHWHnQes
         3rmWb0WS9C8E72JUYDLca+XaG00WyzPNd3zWvjRTDIV2uJvTqG+EBQthBg2HQENSqhFC
         QvG0ziP9H1y9Z3eqI+s4CeQCfq75yJfRfaKmgx3zde3xejPmiHoKx/N+lZo93wvj7z1i
         soyA==
X-Gm-Message-State: APjAAAXz2funazYfXkoSBuO5EMxXGZpq2QmloLjYNWJ5uzBujRpK1k4c
        QB7SENuZSftuG4VfS6vD7ut69g==
X-Google-Smtp-Source: APXvYqzM49uTepjuXeJZkp34ZRE7q5866HZ2LXXYjec4bp0ukiC80b9AapClXJ0hht1pT/TpSFVcmQ==
X-Received: by 2002:ac8:2a99:: with SMTP id b25mr91869588qta.223.1564676437174;
        Thu, 01 Aug 2019 09:20:37 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 47sm41640083qtw.90.2019.08.01.09.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 09:20:36 -0700 (PDT)
Message-ID: <1564676434.11067.46.camel@lca.pw>
Subject: Re: [PATCH v2] arm64/mm: fix variable 'tag' set but not used
From:   Qian Cai <cai@lca.pw>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     catalin.marinas@arm.com, will@kernel.org, andreyknvl@google.com,
        aryabinin@virtuozzo.com, glider@google.com, dvyukov@google.com,
        linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Thu, 01 Aug 2019 12:20:34 -0400
In-Reply-To: <20190801160013.GK4700@bombadil.infradead.org>
References: <1564670825-4050-1-git-send-email-cai@lca.pw>
         <20190801160013.GK4700@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-01 at 09:00 -0700, Matthew Wilcox wrote:
> On Thu, Aug 01, 2019 at 10:47:05AM -0400, Qian Cai wrote:
> 
> Given this:
> 
> > -#define __tag_set(addr, tag)	(addr)
> > +static inline const void *__tag_set(const void *addr, u8 tag)
> > +{
> > +	return addr;
> > +}
> > +
> >  #define __tag_reset(addr)	(addr)
> >  #define __tag_get(addr)		0
> >  #endif
> > @@ -301,8 +305,8 @@ static inline void *phys_to_virt(phys_addr_t x)
> >  #define page_to_virt(page)	({					
> > \
> >  	unsigned long __addr =						
> > \
> >  		((__page_to_voff(page)) | PAGE_OFFSET);			
> > \
> > -	unsigned long __addr_tag =					\
> > -		 __tag_set(__addr, page_kasan_tag(page));		\
> > +	const void *__addr_tag =					\
> > +		__tag_set((void *)__addr, page_kasan_tag(page));	\
> >  	((void *)__addr_tag);						
> > \
> >  })
> 
> Can't you simplify that macro to:
> 
>  #define page_to_virt(page)	({					\
>  	unsigned long __addr =						
> \
>  		((__page_to_voff(page)) | PAGE_OFFSET);			
> \
> -	unsigned long __addr_tag =					\
> -		 __tag_set(__addr, page_kasan_tag(page));		\
> -	((void *)__addr_tag);						
> \
> +	__tag_set((void *)__addr, page_kasan_tag(page));		\
>  })

It still need a cast or lowmem_page_address() will complain of a discarded
"const". It might be a bit harder to read when adding a cast as in,

((void *)__tag_set((void *)__addr, page_kasan_tag(page)));

But, that feel like more of a followup patch for me if ever needed.
