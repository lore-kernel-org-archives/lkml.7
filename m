Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B8AC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6658F21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 00:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWxB6oLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbfDQAe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 20:34:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36257 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728959AbfDQAe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 20:34:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id 85so11147554pgc.3;
        Tue, 16 Apr 2019 17:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m6Evmiu6N3CMu8nqqs5KUJxPxiVSmDM0bjR0jghXw/0=;
        b=MWxB6oLr9JJwbBuU0dQgJUWw1gP4zzVYKHoAffPfz39brpls0BJywYQ9Kqy8j8b8Ep
         W2Kl3CXc6x4id7fGy0aVDxxMU2du+uCXZRunn2r4GSNLHm33FcmaBGujQRBEP8akMtUh
         RnbD6Fuz3uVcji1WJuNYy+uJ/XqH3ZgLfTdghRhDm4mbp8/B0mhrUuzELFAeUuybts2i
         HCj6YDvVQTt0WtghW9T5J+Y4d2UJlaNHr1KBtUSj3Xbl9masV3SZNoX/wsuRTmT73qmS
         PyoMXsete6KtrFV5C0EWs1pdzlqkIEQ9sEgvlVDz/ZO/uHtnIXZ9QKtIYTmAD2FEfVYl
         uDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m6Evmiu6N3CMu8nqqs5KUJxPxiVSmDM0bjR0jghXw/0=;
        b=dfaU9q5DVQJdwn9MKpPCgiNTmV7QAF8x49ga68VJpLZKcFa8hDTdgwn/oPf4QMrD3V
         8ElpKrpfgmXGXkkhfXZ44vs6uXJnDGJxzGwYkb5vRjFHuB+uU6Q9r5V0oqT4JPhVc8RQ
         ZZRvt0TsgR3viYGzIz32ISzrfGsLufcphcuQWTv0Z9K2G+bpK873Fe1BKeiKso8rhA1m
         zmeBY+//ydT/hpX4mHk01clyOBP36M2u5103Ch7Vpulz2TR8I1y+D++kkdoTsQPnKCav
         mxRz+iczSjneuAEUWIhVQukC45PSjPAFKFgUDCkfn31+KqiV4rVQSAMcMKHTXN/N4ZpH
         sUGQ==
X-Gm-Message-State: APjAAAV7oTB8yrwrlTJnaWg5kbAdST9epkG0zcsgTiAXm+PJB06ZSbpk
        6LsD0WcKAJs4hv4K6fOA6sM=
X-Google-Smtp-Source: APXvYqyFGato7ZM2M7Hdryhhisysgb2wHyGP6HEwcNIEoxQV9VNRS2iecGfXXYn4suvMeB9c83G1cw==
X-Received: by 2002:a63:5947:: with SMTP id j7mr78075729pgm.62.1555461298198;
        Tue, 16 Apr 2019 17:34:58 -0700 (PDT)
Received: from localhost ([175.223.21.206])
        by smtp.gmail.com with ESMTPSA id l88sm87504792pfb.104.2019.04.16.17.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 17:34:56 -0700 (PDT)
Date:   Wed, 17 Apr 2019 09:34:53 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] zram: pass down the bvec we need to read into in the
 work struct
Message-ID: <20190417003453.GA16316@jagdpanzerIV>
References: <20190408183219.26377-1-jglisse@redhat.com>
 <20190410194350.GA25351@redhat.com>
 <20190416165345.df90a7491b94f4e9eea9978d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416165345.df90a7491b94f4e9eea9978d@linux-foundation.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/16/19 16:53), Andrew Morton wrote:
> > Adding more Cc and stable (i thought this was 5.1 addition). Note that
> > without this patch on arch/kernel where PAGE_SIZE != 4096 userspace
> > could read random memory through a zram block device (thought userspace
> > probably would have no control on the address being read).
> 
> Looks good to me.
> 
> Minchan & Sergey, can you please review?

Sorry.

Looks OK to me.

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
