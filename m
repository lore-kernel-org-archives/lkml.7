Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AC3C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B9820673
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyGy8EuC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfE2MSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 08:18:37 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40365 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfE2MSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:18:36 -0400
Received: by mail-lj1-f196.google.com with SMTP id q62so2207842ljq.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 05:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ocZGRjIT9lzGH4yxLz7TsaQbCwSn6UiWaCCQNWOG4yk=;
        b=qyGy8EuCTfA96eS9UMj6e4h4/mbwSLBPcPZYYysNf1tp5OfddxuBlliuajcU7yBonP
         m4oe5m3MxPkQtOV/VRJN8Nx5ffCBpCCBiM9T6hR1COdPsd/6s0zNLE8h64pilENJYXf/
         VLlRpdpIG7oVMlfLbWCSYDMtGF8aVn1n4h/JQ+igFyOQjNfRkG5YYqqbV1vT31CKB7GN
         Z6MsbIRKv0aeucQuN4yVWrBEQl+1g5GydbuKeUUgSpN5r8EMc3tMf+4wSDicHfrGY1ju
         tMoACkDsZexYxTpTMdwx8vGebGcPt5PXnf/DZ3osKSaS1SaedWXrwLszOHObLljX8A52
         uQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ocZGRjIT9lzGH4yxLz7TsaQbCwSn6UiWaCCQNWOG4yk=;
        b=E+BxJ3ktm30pCSGIgVK5TiSVPC+oOJRdXZe9sbqbDI5WusY0kGtzDZfj1TpkG3G6qn
         9MvPh7Rf+VuNILepnN2ZYmoB/SkvzB+qGXcBASlLVVxxAgusZIzgUXz6/43Pp/lOF2Gp
         W/j7kY8yKvYjQCrDsl2nyN7CEn//6NphDF3nqXdaqnhiLK9Trt8MWTvObCt2xvvEGiFr
         U7+y/WldX5gypd0JsCRQ56iza1xtWnphn2IkKW1TrGMIUYe2lcfGCST0+dMAzAEgwGHu
         5R2p97gJu51WUk6/8LB4vns5YFDwaHq9JFX8J1ItklXLSFbt7tePH/tFvt7BFcoMlh0O
         D7sA==
X-Gm-Message-State: APjAAAVzSi+pZEIYnxHFnSgZw7KMYiluy497RBgrzkf9w7w3kOOK/6kx
        FIySxUrxxfKuTcmff+uNpzbS+txkV4E=
X-Google-Smtp-Source: APXvYqzJfkCaCX6H3ZDnyAX6wSs+Z6sMkQ1ZKW08MdX2FmsOToV6lKy5cnHI4zBtj9pCXl4k3WLL5g==
X-Received: by 2002:a2e:2c17:: with SMTP id s23mr15361259ljs.214.1559132314723;
        Wed, 29 May 2019 05:18:34 -0700 (PDT)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id h10sm4001776ljm.9.2019.05.29.05.18.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 05:18:33 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id A0A6F460438; Wed, 29 May 2019 15:18:31 +0300 (MSK)
Date:   Wed, 29 May 2019 15:18:31 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Dianzhang Chen <dianzhangchen0@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel/sys.c: fix possible spectre-v1 in do_prlimit()
Message-ID: <20190529121831.GU11013@uranus>
References: <CAFbcbMATqCCpCR596FTaSdUV50nQSxDgXMd1ASgXu1CE+DJqTw@mail.gmail.com>
 <20190528071053.GL11013@uranus>
 <CAFbcbMAi_QhoT=JyU6NjNiJJwFbXF4Z1eV8TtfLv9UWJT-K_CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFbcbMAi_QhoT=JyU6NjNiJJwFbXF4Z1eV8TtfLv9UWJT-K_CQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 10:39:52AM +0800, Dianzhang Chen wrote:
> Hi,
> 
> Although when detect it is misprediction and drop the execution, but
> it can not drop all the effects of speculative execution, like the
> cache state. During the speculative execution, the:
> 
> 
> rlim = tsk->signal->rlim + resource;    // use resource as index
> 
> ...
> 
>             *old_rlim = *rlim;
> 
> 
> may read some secret data into cache.
> 
> and then the attacker can use side-channel attack to find out what the
> secret data is.

This code works after check_prlimit_permission call, which means you already
should have a permission granted. And you implies that misprediction gonna
be that deep which involves a number of calls/read/writes/jumps/locks-rb-wb-flushes
and a bunch or other instructions, moreover all conditions are "mispredicted".
This is very bold and actually unproved claim!

Note that I pointed the patch is fine in cleanup context but seriously I
don't see how this all can be exploitable in sense of spectre.
