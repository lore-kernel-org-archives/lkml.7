Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA99C47E49
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DDE21479
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 22:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfLvQBJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfJ1WP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 18:15:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33034 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJ1WP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 18:15:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id s1so11553483wro.0;
        Mon, 28 Oct 2019 15:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tkzHQ5nWGsA97b2njnFWgc0ejNb84Tf9K2RtX0P4FFk=;
        b=pfLvQBJczZEr8TCZIBu3zCXvXs6DbNljdHUhoS+Fm5sGjkZaQyDpE4mhcXaJE9zu4a
         0CWFKXC8usexW+KUhxUiiHxLGOemFcD546w42TsuFHdVQ1S9Rf32tejbjfzMN6bYrkZ6
         edy/n989IGUoOo4djLqW4qj/7uc136TTEsF0Gj/N6W0P05yPuS6WCTkvR4YhAzrJawA0
         d/Q8oLp7SoZGcu4W/laU2GxUIk3jO9IcO/uUqVXej7e6Qjzd3oe2qAYHE9vCBNKrt1tH
         Ex0efxKUCr07RqGiT0HQyFdxM65n64TEOxwaLW/hfkX7e2SR44VpeWi0Kb+L6EHBXsPs
         3iFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tkzHQ5nWGsA97b2njnFWgc0ejNb84Tf9K2RtX0P4FFk=;
        b=EeEx+Nb69LQZvJD5ENJDaPsL6aEyJ9b7yur84LuFcrWgx/5d9ay0BPTE8vnoWIwiUK
         hvgpMTDyUijeWaSYYIVeYLwz25URVUC77XAu8/TjQOeCHsgDNp6w6pqi5NCDbcFlzwKw
         UwmE5THrt1H3p+GT+B1cEyfQulCywt7JDTVqHMKZwgdWC4JW4yHyXnaMftZ/v1l3iLSJ
         G/H9Vtkzi8tS2cx4l+Te2r4wpuUMeYDd1//XujOCJsCp8rKBthXj2eebktL9S9WD4n7U
         DVQ51+wTAMgf+QoXvPXvmRXqS/gxOFBDbkyRWTERf3t0sWLjxZKEtChA7olVkKkKRXVx
         osiQ==
X-Gm-Message-State: APjAAAXVvbYpQz/pZf5d6jUWzq0uzA+mP4YYMpJZ8wYudGDwx7lXzsx7
        JUJ/ZVbTl+w9JPyy6Fr7s/XwKe/5
X-Google-Smtp-Source: APXvYqwq5hrzqWLPjoLjBT8Rc48124DY7awC6FrRgI62haMHetPjjxe/lXSNcSgfeu/bDNTs7oo9TA==
X-Received: by 2002:adf:b1d2:: with SMTP id r18mr16228857wra.138.1572300925969;
        Mon, 28 Oct 2019 15:15:25 -0700 (PDT)
Received: from desk.local ([2a02:a03f:40ac:ce00:6dcd:e18f:2cd1:7611])
        by smtp.gmail.com with ESMTPSA id v81sm1068082wmg.4.2019.10.28.15.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 15:15:25 -0700 (PDT)
Date:   Mon, 28 Oct 2019 23:15:24 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-sparse@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] compiler*.h: Add '__' prefix and suffix to all
 __attribute__ #defines
Message-ID: <20191028221523.vlzdk6dkcglxei6v@desk.local>
References: <7a15bc8ad7437dc3a044a4f9cd283500bd0b5f36.camel@perches.com>
 <CANiq72=B6XKwfkC9L4=+OxWtjxCp-94TWRG1a=pC=y636gzckA@mail.gmail.com>
 <19fd23e98bab65a1ee624445193bd2ed86108881.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19fd23e98bab65a1ee624445193bd2ed86108881.camel@perches.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 10:59:47AM -0700, Joe Perches wrote:
> On Mon, 2019-10-28 at 18:37 +0100, Miguel Ojeda wrote:
> > Just in case: for these ones (i.e. __CHECKER__), did you check if
> > sparse handles this syntax? (I don't recall myself if it does).
> > 
> > Other than that, thanks for the cleanup too! I can pick it up in the
> > the compiler-attributes tree and put it in -next.
> 
> Thanks for asking and no, I did  not until just now.
> Turns out sparse does _not_ handle these changes and
> the checking fails for these __<changes>__.
> 
> sparse would have to update parse.c or the __CHECKER__
> changes would need to be reverted.
> 
> Perhaps update parse.c like:

...

Yes, this was missing. Thanks.
Can I have your SoB for this?

-- Luc
