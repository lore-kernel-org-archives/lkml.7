Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86B3C00523
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E8820866
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mrSqENRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgADApC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 19:45:02 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35343 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbgADApB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 19:45:01 -0500
Received: by mail-pj1-f67.google.com with SMTP id s7so5330039pjc.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 16:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=yueUb/2kKIa7znFfBTW3dbm2LtvKwc/fgWoUwv6QXa8=;
        b=mrSqENRxgPFzYjmvtbYUobSHdxD/gmPB8X3hNTXHwmWPCtHOKOY54ixHxasePPe/cc
         T2+yc3YpKwej9x8VwJ+mOO5DoH35aHhFDhbCdJalumQcWaes9OO05xzW5iKPb+y7FAAP
         XQ0MbV77UazX0jY9hxS8OVIFP5jFIxnhHHH5QhHoQeaXlRJ5pzKHmn2BpYoAZ5IyqodW
         F8RyV1oPchLvurdpYR3G65+tdA6DZwn7cgV36RQxVg9O+2+zR3ONkNuweFY8DUHfUMlz
         tVuCOWgc8341ZFLHp4DNobjomQY41eU/Xx0P5whxV7yedd8FP/vixBnLYFx8SFe+hXnL
         zjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=yueUb/2kKIa7znFfBTW3dbm2LtvKwc/fgWoUwv6QXa8=;
        b=MXUwT+Qki0fUA0eUcP/xtLrM08BWBe8dyy5Qne8VcZ71BA8viuYXZ4fmHbp02oEDnK
         w3Nvw3UM9aWvYY09n4mKwsu72zxvxgFj9ZuoKnmxglXot76v23pRcTQrm/dDYSgfZYdi
         uFUDZoOLs/sKgyri4LyKL50OHaa3wyESZfCvkbONIGiGveomBkO4VXk8XxSr5u5ccAGl
         pfxuF6SD8A7nIE4bmG/na5pDAQ2lnrsuxeSw7KoHLhM17a0zujmYyqVy/yYkQBW83Ws2
         nz7lOFc79fexXMGrnlOQU5f4yuhQmMjo1eOVJiG9gfR/FHCNJvBziwB7PsSXnJuXMLIg
         alLg==
X-Gm-Message-State: APjAAAWonl3Vq/u4/VT8RA0fqbZH1qZfxqGfFt0Bgke4fcCfRR0VHdWR
        RwMj0SiVn4U5VZb4yaVo39F/TQ==
X-Google-Smtp-Source: APXvYqx/Y0M5wIAfPK4sXD/h1uhec4zOldt+8ptaybbZcvoLpd+Puwt9SM51mH7YzkjNLr+8gprW0A==
X-Received: by 2002:a17:90a:eb14:: with SMTP id j20mr29928414pjz.95.1578098700912;
        Fri, 03 Jan 2020 16:45:00 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id a28sm68401959pfh.119.2020.01.03.16.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 16:45:00 -0800 (PST)
Date:   Fri, 3 Jan 2020 16:44:59 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Wei Yang <richardw.yang@linux.intel.com>
cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com
Subject: Re: [RFC PATCH] mm: thp: grab the lock before manipulation defer
 list
In-Reply-To: <20200103233925.GA3678@richard>
Message-ID: <alpine.DEB.2.21.2001031642530.92066@chino.kir.corp.google.com>
References: <20200103143407.1089-1-richardw.yang@linux.intel.com> <alpine.DEB.2.21.2001031128200.160920@chino.kir.corp.google.com> <20200103233925.GA3678@richard>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Jan 2020, Wei Yang wrote:

> On Fri, Jan 03, 2020 at 11:29:06AM -0800, David Rientjes wrote:
> >On Fri, 3 Jan 2020, Wei Yang wrote:
> >
> >> As all the other places, we grab the lock before manipulate the defer list.
> >> Current implementation may face a race condition.
> >> 
> >> Fixes: 87eaceb3faa5 ("mm: thp: make deferred split shrinker memcg aware")
> >> 
> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >> 
> >> ---
> >> I notice the difference during code reading and just confused about the
> >> difference. No specific test is done since limited knowledge about cgroup.
> >> 
> >> Maybe I miss something important?
> >
> >The check for !list_empty(page_deferred_list(page)) must certainly be 
> >serialized with doing list_del_init(page_deferred_list(page)).
> >
> 
> Hi David
> 
> Would you mind giving more information? You mean list_empty and list_del_init
> is atomic?
> 

I mean your patch is obviously correct :)  It should likely also have a 
stable@vger.kernel.org # 5.4+

Acked-by: David Rientjes <rientjes@google.com>
