Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930F2C432C3
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 00:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6618020714
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 00:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="if7QJoKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfKXAmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 19:42:54 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38588 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfKXAmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 19:42:53 -0500
Received: by mail-io1-f65.google.com with SMTP id u24so10472188iob.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 16:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=NEwv7Ctd0s3pJvZSJKBeLbu9Xr1mygbb2DEuKdPu16s=;
        b=if7QJoKESnrgCMXT6dXWrS3POLEX6gzFKSI2QBITCLDOuQwihjB5pDMq1XTWZikyTx
         vMfnXNW6WlMUhLxKdnDu2mBNqJpUOe6BYucrvWJVki0i9E0mI0CGdS6bMYRg8BtirZdO
         mUZeWdX+pgMd86tkC/3RIBHEhnaUqdCfwKIUlX0/YhP5ZefPpoNqFj5mwBidZVO8kHUx
         Ppv7qHOvnCJ7RYyPlULmbm7hw+vSWeSNHsvd5rM8rNCs5a+U1U6az9eZXJWl7UfZdfNC
         GAolbxm2pTzYFV5im2d1hVCEjNZ4Euelf3gHL6LbrYOgbuRmL+b9SURUpW4/5le+H4y8
         0Xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=NEwv7Ctd0s3pJvZSJKBeLbu9Xr1mygbb2DEuKdPu16s=;
        b=rnJMZoX0VI+0YmyFwqeLmlGvZghy33oVsShTtteCxVo37lKHR/8iQq8Tn8GbICs8uy
         lhIfOBe357uXYAJd2jfqqv64dFicZgnnHmHxdxrk2MmfBNfUfe7DgTcn3oADSTTYvoRD
         JfhQVDaOc/OPKJ2E7PHQeA7Wtbz+ZeDwEuEvvxgSVuEA0mOqG3vHi2VefWnHYAdwv2Ph
         xIOP8Nq+4MzzdpDn7tavSC/414fELW9LR4KCTkWEla/7yvd3nyvqpc5nNNaCfv8/b/fK
         Lbunm5MwAkuoWcXnn5jzCQsN5MytjsvPWsQ/SGsVisLneyTUMhRv8DGfsDRuwojf4bZe
         JYfg==
X-Gm-Message-State: APjAAAWUGedsG7FBzySzz3o6hWb7gNRFvxGoy7wfP2zXbRRAnBmamu6j
        TN7ESNsbTG50WqG1wM1+WrrLP6e5m/Y=
X-Google-Smtp-Source: APXvYqzIb0dcVyYwRcg7Tk3IeMdpucAz41uHdS6zoLje+ty3GvbO5r/l90RSc3TvkKoSDvIhz0kmBA==
X-Received: by 2002:a02:7708:: with SMTP id g8mr11003741jac.9.1574556171387;
        Sat, 23 Nov 2019 16:42:51 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id e13sm622547iom.50.2019.11.23.16.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 16:42:50 -0800 (PST)
Date:   Sat, 23 Nov 2019 16:42:49 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Dan Williams <dan.j.williams@intel.com>
cc:     Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, krste@berkeley.edu,
        waterman@eecs.berkeley.edu,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] Documentation: riscv: add patch acceptance guidelines
In-Reply-To: <CAPcyv4hBNfabaZmKs0XF+UT9Py8zJqpNdu5KsToqp305NASKNA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1911231637510.14532@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1911221842200.14532@viisi.sifive.com> <20191123092552.1438bc95@lwn.net> <alpine.DEB.2.21.9999.1911231523390.14532@viisi.sifive.com> <CAPcyv4hmagCVLCTYmmv0U8-YD5BEoQPV=wtm5hbp3MxqwZRQUA@mail.gmail.com>
 <alpine.DEB.2.21.9999.1911231546450.14532@viisi.sifive.com> <CAPcyv4hBNfabaZmKs0XF+UT9Py8zJqpNdu5KsToqp305NASKNA@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Nov 2019, Dan Williams wrote:

> I took a look, and I think the content would just need to be organized 
> into the proposed sections. The rules about what level of ratification a 
> specification needs to receive before a patch will be received sounds 
> like an extension to the Submit Checklist to me. So I'd say just format 
> your first paragraph into the Overview section and the other 2 into 
> Submit Checklist and call it good.

I'm fine with doing that for this patch.

Stepping back to the broader topic of the maintainer profile patches, one 
comment there: unless you're planning to do automated processing on these 
maintainer profile document sections, it's probably better to let 
maintainers format their own profile documents as they wish.  

Just to use the arch/riscv document as an example: the last two 
paragraphs, to me, don't belong in a "submit checklist" section, since 
that implies that the text there only needs to be read before patches are 
submitted.  We'd really prefer that developers understand what patches 
we'll take before they even start developing them.

I imagine we wouldn't be the only ones that would prefer to create their 
own section headings in this document, etc.


- Paul
