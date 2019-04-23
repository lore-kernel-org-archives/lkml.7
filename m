Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A42C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB190218FC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="upvRilg0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfDWPJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:09:16 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37608 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfDWPJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:09:16 -0400
Received: by mail-qt1-f193.google.com with SMTP id z16so16466335qtn.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 08:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uG3k+q0qMvAhFWbn3peh6h9/ncre9xPbbfkoeMgxHbA=;
        b=upvRilg0k/drpfGblV1LDwyQQ4L7NC81C8xP8okNZ94JBGIg4uBkBLp5zNVyg/+dgx
         46lvPMYgGr6oaWUAUnKBqA5NzM7JTqy/npmsVnNg9JCM0ClLE0PlLDcQH1HL+DfIwJkT
         zaZu7cmY8qKy4kx3Xjh5d2TxLCL33y9mSzJbuu6on5gbyuCeYcmFrgGdqzOEXgjsdd0w
         vUWVXcg6OlDVwpYi/DfCHJsLUsZ71dS/0vxh7SzsmQM7o6WwUSLPgF7EHYHKnGuz9m5H
         6XhHmMoT+C0vO6LZSNvs9nwJPPqpq3RGWd0bfSSswh3e1YPBnq1fZLF2fgNRfDe5syAE
         uukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uG3k+q0qMvAhFWbn3peh6h9/ncre9xPbbfkoeMgxHbA=;
        b=iSKQ0YnsYbzy/kDZp4Bl4D7yrPhkeQwz3T2HaZz68KVaBBTcCQTas2b9q1nQEoujg1
         xZYUVjxf52fL7PsSgdYg0zABU0P2yJhpaUCbFGHcOFltCpQ4KqdGhgAUFqqE6OYwUi4d
         AjqObrklVaNOcspepsuNH39siks37SnW2DMDei/0Nij2Y3RALxp199mkg0sHVZUP98XK
         0bCxFX1rTuvWzNRMuxMPXTupjd8Bkk1XqewHsx6jF2VhVj/JZe7psPCOO6t97hNHf6BE
         l4GwBOH8OqatZF3AIxUVceNX0b5eRbS7DXAUhFYq2ia+rt/xnn2D6kaqkdeBd1k0KAmH
         Az7A==
X-Gm-Message-State: APjAAAVreck5/wc2CkV16SPGaCldzGFnGcUgispLeKUkN+kjJzQDL6A/
        oj2zkQYjAUzJxtT1BulHjLY=
X-Google-Smtp-Source: APXvYqwYNSB4ieCaHALHwD8BjBCBTK64MWITlE3B7ITOn2sIvLrAZ44MMyb/HQFHjvt+Igj28Lh0Bg==
X-Received: by 2002:a0c:e014:: with SMTP id j20mr20994214qvk.172.1556032154974;
        Tue, 23 Apr 2019 08:09:14 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id i24sm7512053qtm.3.2019.04.23.08.09.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 08:09:13 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 58E774111F; Tue, 23 Apr 2019 12:09:11 -0300 (-03)
Date:   Tue, 23 Apr 2019 12:09:11 -0300
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     Song Liu <songliubraving@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        acme@redhat.com, tglx@linutronix.de
Subject: Re: PING: Re: [PATCH] perf annotate: Fix build on 32 bit for BPF
 annotation
Message-ID: <20190423150911.GA26729@kernel.org>
References: <20190403194452.10845-1-cascardo@canonical.com>
 <ABAEFCEA-E8C6-4246-B109-6D6A12AAB75B@fb.com>
 <20190423145847.GC5376@calabresa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423145847.GC5376@calabresa>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 23, 2019 at 11:58:48AM -0300, Thadeu Lima de Souza Cascardo escreveu:
> On Wed, Apr 03, 2019 at 09:34:02PM +0000, Song Liu wrote:
> > 
> > 
> > > On Apr 3, 2019, at 12:44 PM, Thadeu Lima de Souza Cascardo <cascardo@canonical.com> wrote:
> > > 
> > > Commit 6987561c9e86 ("perf annotate: Enable annotation of BPF programs") adds
> > > support for BPF programs annotations but the new code does not build on 32-bit.
> > > 
> > > Fixes: 6987561c9e86 ("perf annotate: Enable annotation of BPF programs")
> > > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> > 
> > Acked-by: Song Liu <songliubraving@fb.com>
> > 
> > Thanks for the fix!
> > Song
> > 
> 
> Thanks for the ack.
> 
> Pinging for getting this applied, as this is a build failure on i386.

Thanks, applied to perf/urgent.

- Arnaldo
