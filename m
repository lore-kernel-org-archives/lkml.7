Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E341CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 19:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E0421734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 19:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="GpVrTIU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfKATYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 15:24:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34926 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbfKATYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 15:24:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id 8so2972420wmo.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 12:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1wEIO/2YiEoRoYoTOxS9UGohqBdoKl+fmZ2tHjySO14=;
        b=GpVrTIU9RaUx/M7L1qvoh0UVu6B13MdTGeuB+rZDPyyv9VjXHehuBDXTlap5rRupNp
         dDeV7/gWPljqzbZj29H07br6CXEpXan3xPKO0QhnYsbBM6m3gKaUZtOiDWjur++xSx3e
         oLZJ3uQrsc6oiP+ozeM76ZB3oKbMz7Ql7/y7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1wEIO/2YiEoRoYoTOxS9UGohqBdoKl+fmZ2tHjySO14=;
        b=bLy8aba4QvHLz4u8oEXfIP2l3QKQLyzITIas/ADO3U1cxQGy5W08djPLwiLbZP2dBf
         vhSHmXuJwo+i3C3jz/tm0oVNUSGX9DikCs7OusHXQpya9M59JKO+nQPnHXehf489xmto
         UFXM0Z3ud5kbgYZkLUwcu5cPJ1UuLdGWqmezGGP5M+ul6cqdi8xVKNSf1idr3jUt11Sb
         81h6MwO1x/Jq85V+PKuAQvLDDgIlW9N2YoXWavZAe5Rd4B1crop4Kz27SIUHXw67LXud
         cucTeHEDF5j5Oqb113KlE0xmPp+D0LKl5YfU4jogxpLX73ELUHejj51nM+k3Wsi3RgMK
         F7/Q==
X-Gm-Message-State: APjAAAVxCkpLbus+U+/t8QJmMTg9Ij5RaSjtQtehaDJALrw+A2GMhHvX
        otMHbr7VX+NrijG9J7IAzF0ZyFOJVV2qtQ==
X-Google-Smtp-Source: APXvYqzhKELOJ9RzQ6qVqVkh8P/JQygqBphv8Nlt3tcnzxK6/UnOX5ZOkEBbTTEJb3+VnPupOp1Utw==
X-Received: by 2002:a1c:6144:: with SMTP id v65mr11972251wmb.53.1572636247197;
        Fri, 01 Nov 2019 12:24:07 -0700 (PDT)
Received: from localhost ([89.32.122.5])
        by smtp.gmail.com with ESMTPSA id 11sm9025390wmb.34.2019.11.01.12.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 12:24:06 -0700 (PDT)
Date:   Fri, 1 Nov 2019 19:24:05 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] kernel: sysctl: make drop_caches write-only
Message-ID: <20191101192405.GA866154@chrisdown.name>
References: <20191031221602.9375-1-hannes@cmpxchg.org>
 <20191031162825.a545a5d4d8567368501769bd@linux-foundation.org>
 <20191101110901.GB690103@chrisdown.name>
 <20191101144540.GA12808@cmpxchg.org>
 <20191101115950.bb88d49849bfecb1af0a88bf@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191101115950.bb88d49849bfecb1af0a88bf@linux-foundation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
>> > The only scenario I can construct in my head is that someone has built
>> > something to watch drop_caches for modification, but we already have the
>> > kmsg output for that.
>
>The scenario is that something opens /proc/sys/vm/drop_caches for
>reading, gets unexpected EPERM and blows up?

Right, but...

>OK.  What if we make reads always return "0"?  That will fix the
>misleading output and is more backwards-compatible?

...I'm not convinced that if an application has no error boundary for that 
EPERM that it can tolerate a change in behaviour, either. I mean, if it's 
opening it at all, presumably it intends to do *something* based on the value 
(regardless of import or lack thereof). It may do nothing, but it's not 
possible to know whether that's better or worse than blowing up.

I have mixed feelings on this one. Pragmatically, as someone who programs in 
userspace, I'd like failures based on changes in infrastructure to be loud, not 
silent. If I'm doing something which doesn't work, I'd like to know about it. 
Of course, one can make the argument that as a user of such an application, 
sometimes you don't have that luxury.

Either change is an upgrade from the current situation, at least. I prefer 
towards whatever makes the API the least confusing, which appears to be 
Johannes' original change, but I'd support a patch which always set it to 
0 instead if it was deemed safer.
