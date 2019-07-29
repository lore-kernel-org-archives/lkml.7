Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE3BC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3759F216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 15:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="N5O4rWHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfG2PQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 11:16:46 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40403 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbfG2PQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 11:16:46 -0400
Received: by mail-vs1-f65.google.com with SMTP id a186so39398273vsd.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 08:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l1pHabDEE3g4EeAylWv1oViCKfwGFSQYwhq2VGGa9M0=;
        b=N5O4rWHtD/epf6qVwF4Wn0LoNVtFjib06C4Jy/5zF6Xfcu8Y16S+Sg+Oq06LX89tQy
         L9uSkwi2coFsv/hTKXddZOvOYPS243+ihDUB5aQvJBGcIj3ThIt96s1TleSxk4xTYswS
         +Ggw+8jIJ/cMXeC6r/kppJhy7q0gExEpXBHWKlJyPWrZuHv0U8fcZpZg+aqKEZzzkIoN
         ROs8LGMH+5IEog3+fe33eNQlZIWTzoJeS6Wd60dfvAdphT0gg5rh5xM0NuamC91Uy9vC
         jXWhde5CnpiEaW0YajwwlL2rLJ2RSp+V2zK1FWQm7MCnKOlxQJpxw8bG8DLLOwrRphYb
         nPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l1pHabDEE3g4EeAylWv1oViCKfwGFSQYwhq2VGGa9M0=;
        b=IVgpzGrIxsp364a43mc84cCK9icSwX9Xk6s7kM3dEVfBGofkZlDZ2XgJAb3NyU1Ekw
         4BOkVcayqNujTsM6IdXHNE2PH7QcihLxAnYXDwr4+tvQyhEhLyDonQXRjCiFiRIF1dZs
         +GL2BW9RHn4qGziMoQroHByaJvRkamB4XgUwEQP1Lg98JC5Vq07ungLsl8GPBLwpvgdF
         ljgx8ASuZLqzJmG9pEk613KZcp/rb3WfJwy4GQb4ODD3FrHsNkt0fVPm7391Q6ofFFm9
         vK13R55dkOyMolk8me3BHh3aP5ZdCNU2EEzUsPXRKCxzT0M0LAf0i+wNB3NLWPJ9vCJ2
         6ydQ==
X-Gm-Message-State: APjAAAUivhT3KAUYvMtOEOpP3l01PmdjQjsVcTg6wHdFAMJNXCyhwgO5
        7f9nagzH6BEpSoLQLE7TeAnvZg==
X-Google-Smtp-Source: APXvYqxxL6fgO0iX9KHIF7/4f14wRXKE/WZPJ+bSOSw9XoopYbOycg2dTak8BAOm6mRDa8pWh1WKkw==
X-Received: by 2002:a05:6102:3c8:: with SMTP id n8mr15262305vsq.135.1564413405198;
        Mon, 29 Jul 2019 08:16:45 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y18sm19483191vkb.35.2019.07.29.08.16.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 08:16:44 -0700 (PDT)
Message-ID: <1564413402.11067.26.camel@lca.pw>
Subject: Re: [PATCH] net/sctp: fix GCC8+ -Wpacked-not-aligned warnings
From:   Qian Cai <cai@lca.pw>
To:     David Laight <David.Laight@ACULAB.COM>,
        "vyasevich@gmail.com" <vyasevich@gmail.com>,
        "nhorman@tuxdriver.com" <nhorman@tuxdriver.com>,
        "marcelo.leitner@gmail.com" <marcelo.leitner@gmail.com>
Cc:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 29 Jul 2019 11:16:42 -0400
In-Reply-To: <158b26b6f3b24164aceacd2428095315@AcuMS.aculab.com>
References: <1564174659-21211-1-git-send-email-cai@lca.pw>
         <158b26b6f3b24164aceacd2428095315@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-29 at 10:39 +0000, David Laight wrote:
> From: Qian Cai
> > Sent: 26 July 2019 21:58
> > 
> > There are a lot of those warnings with GCC8+ 64bit,
> > 
> 
> ...
> > Fix them by aligning the structures and fields to 8 bytes instead.
> 
> ...
> >  struct sctp_setpeerprim {
> >  	sctp_assoc_t            sspp_assoc_id;
> > -	struct sockaddr_storage sspp_addr;
> > -} __attribute__((packed, aligned(4)));
> > +	struct sockaddr_storage sspp_addr __attribute__((aligned(8)));
> > +} __attribute__((packed, aligned(8)));
> 
> What happens to this one if you change both to aligned(4) ?
> Much the same way as:
> 	struct {
> 		int a;
> 		long b __attribute__((aligned(4));
> 	};
> is only 12 bytes on (most) 64bit systems.

No, that won't work. It because that,

#define sockaddr_storage __kernel_sockaddr_storage

struct __kernel_sockaddr_storage {
...
} __attribute__ ((aligned(_K_SS_ALIGNSIZE)))

#define _K_SS_ALIGNSIZE	(__alignof__ (struct sockaddr *))

A pointer is 8-byte on 64-bit systems. If changed "struct
__kernel_sockaddr_storage" to use,

__attribute__ ((aligned((4)))

it then silence the warnings.
