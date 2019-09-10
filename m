Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5503CC4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DEE620863
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPstgmGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388308AbfIJO3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:29:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45175 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfIJO3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:29:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id 4so9841590pgm.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 07:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=86T4EY0x21kDNmxHuLO5jp762W67PTiLmWNWsIfvTKY=;
        b=SPstgmGFZl9jfQC+Cn4h8Sbu7aPf7Uf+TuN8fM4Qwko1cE4LSkS5z2QmXQM9qT9xUW
         aBfPF2xzgnhyzM8u/k5d9I40FxpwcKo7/mnxJ1yqicls642NnsovipNDHzcNMBDbfRMu
         t0UJs/+xJbl9YwGvPSXydPXgTyxi2ROlLlDTJAwLee1fbaF2WAAL+pRjlrOmTbrOwKQI
         +kKLgM6X37BlVEs84a+8beKxQJ/NVfrBVyrW3AdLwIA+0WJKVMD6zPyqgX02Zhd86Fs8
         K5D9sR/yabKS5xhaGGNNJeQszIvYvpqWVHJVaJ6Rc//T4YstVyaymXKxo73/KG/xrvjW
         b2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=86T4EY0x21kDNmxHuLO5jp762W67PTiLmWNWsIfvTKY=;
        b=Jkkmtyw8U+9IG/oxSIMEkEx3NJyzSoNcZIdvFZvtrQLl3c18UEEMeLYB4gsUJ+2VxK
         y4FnJtYuQtGDyYyN+AlnAwKIFGq9V1O+aM4DkgPnPGV6mIive/JhXmJqmwNdwD8dlJ+Q
         vc9wcpPbUBzwrN54SG9K4zm6UMldwJS3AD/xBWJwKCuRkIW+ufEOqRnRF8ELtQX1BIh5
         Snyz2nqh08tL8c79M4FX3KMi5BMizTNcEpfbKwejfIUOv5Cy+Wymp7yI+cMj8Vg20fXn
         3TGpVO63HNDWXCd6IE7K8MHJEmnEB5VsFeyAGfEgY+o6XnQis//RmnDnNjTm/r3FiEHo
         hL1A==
X-Gm-Message-State: APjAAAWDxtWVMmvz7LA7InOfslaL/Uh7sr+cUoOZo4F44H3vqEveqBCM
        1596EczTXA9Mgi6MQ0N1O9xNZLVFKzG24Q==
X-Google-Smtp-Source: APXvYqxx2ED3ffxMQPO/lb7xIBwTIK9Ql8+eYWf+SLXLhETbUcqCfeyN8vh2lg2jUVd+Tq9DUu0v4g==
X-Received: by 2002:a65:62d1:: with SMTP id m17mr29380346pgv.271.1568125784847;
        Tue, 10 Sep 2019 07:29:44 -0700 (PDT)
Received: from mail.google.com ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id k64sm27061590pge.65.2019.09.10.07.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 07:29:44 -0700 (PDT)
Date:   Tue, 10 Sep 2019 22:29:38 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ftrace: simplify ftrace hash lookup code
Message-ID: <20190910142937.7mg72wco36ycpjs7@mail.google.com>
References: <20190909003159.10574-1-changbin.du@gmail.com>
 <20190909105424.6769b552@oasis.local.home>
 <20190910003321.d3q65j756z3vzhiw@mail.google.com>
 <20190910052804.57308909@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910052804.57308909@oasis.local.home>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 05:28:04AM -0400, Steven Rostedt wrote:
> On Tue, 10 Sep 2019 08:33:23 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > > 
> > > bool ftrace_lookup_ip(struct ftrace_hash *hash, unsigned long ip, bool empty_result)
> > > {
> > > 	if (ftrace_hash_empty(hash))
> > > 		return empty_result;
> > > 
> > > 	return __ftrace_lookup_ip(hash, ip);
> > > }
> > >  
> > We must add another similar function since ftrace_lookup_ip() returns a pointer.
> > 
> > bool ftrace_contains_ip(struct ftrace_hash *hash, unsigned long ip,
> > 			bool empty_result)
> > {
> > 	if (ftrace_hash_empty(hash))
> > 		return empty_result;
> > 
> > 	return !!__ftrace_lookup_ip(hash, ip);
> > }
> > 
> > But after this, it's a little overkill I think. It is not much simpler than before.
> > Do you still want this then?
> > 
> >
> 
> Or...
> 
> static struct ftrace_func_entry empty_func_entry;
> #define EMPTY_FUNC_ENTRY = &empty_func_entry;
> 
> [..]
>  * @empty_result: return NULL if false or EMPTY_FUNC_ENTRY on true
> [..]
>  * @empty_result should be false, unless this is used for testing if the ip
>  * exists in the hash, and an empty hash should be considered true.
>  * This is useful when the empty hash is considered to contain all addresses.
> [..]
> struct ftrace_func_entry *
> ftrace_lookup_ip(struct ftrace_hash *hash, unsigned long ip, bool empty_result)
> {
> 	if (ftrace_hash_empty(hash))
> 		return empty_result ? EMPTY_FUNC_ENTRY : NULL;
> 
> 	return __ftrace_lookup_ip(hash, ip);
> }
> 
> But looking at this more, I'm going back to not touching the code in
> this location, because __ftrace_lookup_ip() is static, where as
> ftrace_lookup_ip() is not, and this is in a very fast path, and I
> rather keep it open coded.
> 
> Lets just drop the first hunk of your patch. The second hunk is fine.
>
Sure, I will send a update short later. Thanks for your suggestions.

> 
> -- Steve

-- 
Cheers,
Changbin Du
