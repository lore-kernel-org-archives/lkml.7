Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDC7C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2A221479
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlWtgtsi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbfEUEAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 00:00:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46728 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfEUEAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 00:00:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id y11so8295120pfm.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 21:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3eNkdh4mO8pIZ3fXGLoczke3nP1H3XUCZBixj8gSPtM=;
        b=FlWtgtsiqkqsJMsMh+w5KMie8AV1p53bkphNoR7ejMBqU9PX6KQSkxDFSUVE4Eeefg
         eve/6pSpoBZ5kxn6rCxyu/a9Kan/+MY/qzmiQC1UgIr0u4NYjJcGtbuXy09CuzcizweI
         y8ZKlBV1/FTvQQkRrGBIt3rZmdb6kJLQvKKSnmafOb3za0Re0gggz34TPAvZ65yVUSlh
         m7H8zRYYTsl1LaAa+c0ziNOTqAiRP9E9UUloXg48JFCz8ewCuqgTsQFeJqAJNsHhmBCP
         Qc5nB2P2UzhA7CFD4OSLJWOXnARNvQ0c6/9REKrv9tq7hDYuahXUF8CSw5GCDk9cDHxl
         JcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3eNkdh4mO8pIZ3fXGLoczke3nP1H3XUCZBixj8gSPtM=;
        b=eYlhsUDOZlEUVjLELnUDrowguY0NUo9pMqiiW2oGRg9vQPK/TvA7W8DP78ddEbC2ii
         B7NVpoj5ulK6TmRPBodsJIGGOmnZeZPZrbnUq/qfNhf9PHHbm2qcqSJ0AeB04kd6UcG3
         2BMPAINV1kudAI9FCyi/d155gcss8ZWVptTi/8Vz7ZW5BS4qZg0fv8r//CfUZPyXkzXo
         9iCCfGVmYfJer9TWboU3oFULFk4StDRWgJtJKZiaTuVivPRllVG5XI+YI/eZUvsl8M6H
         GAKRV+xQrtA4BQBkXg68GYIgVSsP4dDXcsYjh7Hi2bj3u83MA0GxWHyIqRg59DImVzGH
         2VWA==
X-Gm-Message-State: APjAAAXzwBxstbZBDLmXufRKn6jVE4dd10vhvwQQSryqM6A8spY6dd13
        OkN/J04u3YCpdWXydkA2HP4=
X-Google-Smtp-Source: APXvYqzYgoAuV3ojH5BDC4Uu8PdjYmIR1/yGSXn5GH+wLxwTbPaXJ3VUKmm99aKA4skGDHg/Wvb9jw==
X-Received: by 2002:a65:500d:: with SMTP id f13mr5514374pgo.151.1558411233744;
        Mon, 20 May 2019 21:00:33 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id t142sm13547983pgb.32.2019.05.20.21.00.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 21:00:33 -0700 (PDT)
Date:   Tue, 21 May 2019 12:00:19 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vt: Fix a missing-check bug in drivers/tty/vt/vt.c
Message-ID: <20190521040019.GD5263@zhanggen-UX430UQ>
References: <20190521022940.GA4858@zhanggen-UX430UQ>
 <nycvar.YSQ.7.76.1905202242410.1558@knanqh.ubzr>
 <20190521030905.GB5263@zhanggen-UX430UQ>
 <nycvar.YSQ.7.76.1905202323290.1558@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1905202323290.1558@knanqh.ubzr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 11:26:20PM -0400, Nicolas Pitre wrote:
> On Tue, 21 May 2019, Gen Zhang wrote:
> 
> > On Mon, May 20, 2019 at 10:55:40PM -0400, Nicolas Pitre wrote:
> > > On Tue, 21 May 2019, Gen Zhang wrote:
> > > 
> > > > In function con_init(), the pointer variable vc_cons[currcons].d, vc and
> > > > vc->vc_screenbuf is allocated a memory space via kzalloc(). And they are
> > > > used in the following codes.
> > > > However, when there is a memory allocation error, kzalloc() can fail.
> > > > Thus null pointer (vc_cons[currcons].d, vc and vc->vc_screenbuf)
> > > > dereference may happen. And it will cause the kernel to crash. Therefore,
> > > > we should check return value and handle the error.
> > > > Further,the loop condition MIN_NR_CONSOLES is defined as 1 in
> > > > include/uapi/linux/vt.h. So there is no need to unwind the loop.
> > > 
> > > But what if someone changes that define? It won't be obvious that some 
> > > code did rely on it to be defined to 1.
> > I re-examine the source code. MIN_NR_CONSOLES is only defined once and
> > no other changes to it.
> 
> Yes, that is true today.  But if someone changes that in the future, how 
> will that person know that you relied on it to be 1 for not needing to 
> unwind the loop?
> 
> 
> Nicolas
Hi Nicolas,
Thanks for your explaination! And I got your point. And is this way 
proper?

err_vc_screenbuf:
        kfree(vc);
	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++)
		vc_cons[currcons].d = NULL;
	return -ENOMEM;
err_vc:
	console_unlock();
	return -ENOMEM;

Thanks
Gen
