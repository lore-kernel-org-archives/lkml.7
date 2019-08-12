Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892C1C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C5720644
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 17:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c9m2bRW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfHLRTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 13:19:30 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43802 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfHLRT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 13:19:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id 4so41128246pld.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 10:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jQdWi79UOET3NcbXkAwjygJB1Ir2fsPCLcASHFDPOY4=;
        b=c9m2bRW2HxuvJEovBcFUuEjhkoaeh3/hBEi96hf8jC4GhpACXRSOH0yNlpDL3OIUbE
         vwQd9eJVNG/ktDg4zdgWQ3zTq12opNssQy/H8Pae3V5y22ELcxrwUYkuTDnzLK4GnXc/
         PDJioUs8RXnlaFZFm6PkEx6IwDnD8BzaoJ0CI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jQdWi79UOET3NcbXkAwjygJB1Ir2fsPCLcASHFDPOY4=;
        b=qUBZ3qSbGY4k3Rl00BedJXuO0AQGOUbk6erRz9C7WFwvLveGgjtZ/iOfEJgC3vgYhL
         STBQyinMwdJb3EdrsUABN9io6/llnBjnPetZA4vlcgJLSUW7h+xN/41jV+x8Yb4FBYux
         CxqHBrAHLwfwphCcrzz8NldvRCFSf0oDBZqciq6E198qHOpiMexa1LMbo6agIh/f80kQ
         PRiRELX5iqTCJfUJouFM/qblzZtpmhItLqtcBAlBf87PA2CvD4yThKMMpUsW9s6MySCB
         bmiNOyA8KhodCsUIVzI+1qZDx2OnRWenfM9ycyJ9gEeoWMDHcI89igQUUL82g4W2wuGR
         veOA==
X-Gm-Message-State: APjAAAX9uqK/gDH6TkvfmU8bq2xZj7XUTgecs1nXk6PKIOY1FmCQXsmI
        IA3SHRZenpazZtPsYGxlWwBG/g==
X-Google-Smtp-Source: APXvYqy10JjsFB3axHFNMgROpGcmwPwO4mBb8G1S0iRV3C7gVjicasx85fhT3Py/5umslxym0I5lrg==
X-Received: by 2002:a17:902:b698:: with SMTP id c24mr34036132pls.28.1565630369208;
        Mon, 12 Aug 2019 10:19:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e9sm161724pja.17.2019.08.12.10.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 10:19:28 -0700 (PDT)
Date:   Mon, 12 Aug 2019 10:19:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-sparse@vger.kernel.org, Mao Wenan <maowenan@huawei.com>,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH net-next] net: can: Fix compiling warning
Message-ID: <201908121001.0AC0A90@keescook>
References: <20190802033643.84243-1-maowenan@huawei.com>
 <0050efdb-af9f-49b9-8d83-f574b3d46a2e@hartkopp.net>
 <20190806135231.GJ1974@kadam>
 <6e1c5aa0-8ed3-eec3-a34d-867ea8f54e9d@hartkopp.net>
 <20190807105042.GK1974@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807105042.GK1974@kadam>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 01:50:42PM +0300, Dan Carpenter wrote:
> On Tue, Aug 06, 2019 at 06:41:44PM +0200, Oliver Hartkopp wrote:
> > I compiled the code (the original version), but I do not get that "Should it
> > be static?" warning:
> > 
> > user@box:~/net-next$ make C=1
> >   CALL    scripts/checksyscalls.sh
> >   CALL    scripts/atomic/check-atomics.sh
> >   DESCEND  objtool
> >   CHK     include/generated/compile.h
> >   CHECK   net/can/af_can.c
> > ./include/linux/sched.h:609:43: error: bad integer constant expression
> > ./include/linux/sched.h:609:73: error: invalid named zero-width bitfield
> > `value'
> > ./include/linux/sched.h:610:43: error: bad integer constant expression
> > ./include/linux/sched.h:610:67: error: invalid named zero-width bitfield
> > `bucket_id'
> >   CC [M]  net/can/af_can.o
> 
> The sched.h errors suppress Sparse warnings so it's broken/useless now.
> The code looks like this:
> 
> include/linux/sched.h
>    613  struct uclamp_se {
>    614          unsigned int value              : bits_per(SCHED_CAPACITY_SCALE);
>    615          unsigned int bucket_id          : bits_per(UCLAMP_BUCKETS);
>    616          unsigned int active             : 1;
>    617          unsigned int user_defined       : 1;
>    618  };
> 
> bits_per() is zero and Sparse doesn't like zero sized bitfields.

I just noticed these sparse warnings too -- what's happening here? Are
they _supposed_ to be 0-width fields? It doesn't look like it to me:

CONFIG_UCLAMP_BUCKETS_COUNT=5
...
#define UCLAMP_BUCKETS CONFIG_UCLAMP_BUCKETS_COUNT
...
        unsigned int bucket_id          : bits_per(UCLAMP_BUCKETS);

I would expect this to be 3 bits wide. ... Looks like gcc agrees:

struct uclamp_se {
    unsigned int               value:11;             /*     0: 0  4 */
    unsigned int               bucket_id:3;          /*     0:11  4 */
...

So this is a sparse issue?

-- 
Kees Cook
