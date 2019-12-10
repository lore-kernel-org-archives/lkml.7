Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6DCC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266972073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mX+5okY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfLJMu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 07:50:28 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44907 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfLJMu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:50:28 -0500
Received: by mail-wr1-f67.google.com with SMTP id q10so19935678wrm.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 04:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lI5pM/n8uiSh8KTVwUz7eAB/fPL9JGA14tKmFhfulhM=;
        b=mX+5okY0gaNAHvUs0Y9oF9+BYZ5VWfqKuuSrmT8sfYc/vtsyT1jnndfAVOQ8N+XEix
         7wlcXNn3JX5TaZfm4WPjhgxPgA40OdMVAGQiamq5vwfzbsqO71cLEaS0GpU77u5NVBf3
         F97j9VD629Cgfv6WbXeJKdojGEajl7pDdMWrX9tLWOX4Bj6LDMkDoop7Duv16ssCHFWt
         KUtHboi6ch/Ajjlsk2M6fFWJyr+Yh0ZgQd3MJt4RsBx0vk225fWVkSMzW55EIYfo69PY
         oUZdkwoHvX+h3s/7+zkWyBcbvsYg9kZ8+Im8DNQFa1FodbJYqUAIbmDaHg99SToaTC4r
         sDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lI5pM/n8uiSh8KTVwUz7eAB/fPL9JGA14tKmFhfulhM=;
        b=s656yDGelXM0SoznVFhqUF9mB3MvkLj/9Hl3q1KneMc9mTOolaBIyjw0tS59xN1dHF
         aliAjG1hmm+XG1qySER5hc6mF7NSUbZI0Gmsq1d+jBS1jTZHMmpqoAadeqzcIxBuaCDA
         ymt64b6tCviCsYMY95NjZIyAuZEMp2BmuYkuuR5wz1t1d5mkEKStXbgYndJTZEUhR5IA
         hJ0kY6Hpo5Au6nSRIkD5oxhjJrP0CjtnvYWrzFDAKbFeh50/QIGpPg1J8HTPo5jXyLsT
         yLySj7QvnKmlvqHqseOUhriYYonbl08RiMNfb6vePMbcVIim6pkmC+oFV//z0lnSW8jO
         3Eig==
X-Gm-Message-State: APjAAAVR/bRRqHPG6n/0Bdn7MGHKs2A8/ENsemcAsMIvrbd0hUbgNxRS
        TQUEKXKWfggXjeY1C8AUxESwig==
X-Google-Smtp-Source: APXvYqxg2JhBzis4u9LzgCqNX+LmzpEmCDpT30Z50zEwz63i+DGwevHmE8csLVi5+DdS0TJf/g/Rew==
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr3197320wrs.106.1575982224331;
        Tue, 10 Dec 2019 04:50:24 -0800 (PST)
Received: from dell ([2.27.35.145])
        by smtp.gmail.com with ESMTPSA id p5sm3156979wrt.79.2019.12.10.04.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 04:50:23 -0800 (PST)
Date:   Tue, 10 Dec 2019 12:50:18 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Tuowen Zhao <ztuowen@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        acelan.kao@canonical.com, "Luis R. Rodriguez" <mcgrof@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v5 2/4] lib: devres: add a helper function for ioremap_uc
Message-ID: <20191210125018.GU3468@dell>
References: <20191016210629.1005086-1-ztuowen@gmail.com>
 <20191016210629.1005086-3-ztuowen@gmail.com>
 <20191111084105.GI18902@dell>
 <CAMuHMdXVGuu5ZpwA-H=1QJ4PHZeH22CG_AU71nJDYqro3pz6hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXVGuu5ZpwA-H=1QJ4PHZeH22CG_AU71nJDYqro3pz6hQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2019, Geert Uytterhoeven wrote:

> On Mon, Nov 11, 2019 at 9:45 AM Lee Jones <lee.jones@linaro.org> wrote:
> > On Wed, 16 Oct 2019, Tuowen Zhao wrote:
> > > Implement a resource managed strongly uncachable ioremap function.
> > >
> > > Cc: <stable@vger.kernel.org>
> > > Tested-by: AceLan Kao <acelan.kao@canonical.com>
> > > Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>
> > > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> > > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  include/linux/io.h |  2 ++
> > >  lib/devres.c       | 19 +++++++++++++++++++
> > >  2 files changed, 21 insertions(+)
> >
> > Applied, thanks.
> 
> This is now commit e537654b7039aacf ("lib: devres: add a helper function
> for ioremap_uc") in upstream.
> 
> Do we really need this? There is only one user of ioremap_uc(), which
> Christoph is trying hard to get rid of, and now you made it mandatory.
> https://lore.kernel.org/dri-devel/20191112105507.GA7122@lst.de/

Patches welcome.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
