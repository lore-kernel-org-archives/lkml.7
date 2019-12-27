Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E463C2D0DC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 04:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7209B20828
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 04:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q09vfW/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfL0EGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 23:06:01 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54946 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfL0EGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 23:06:01 -0500
Received: by mail-pj1-f68.google.com with SMTP id kx11so4198433pjb.4;
        Thu, 26 Dec 2019 20:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PJkLmBIgDAd224gT5d1DEVPXAmElvH5/SyzF20ifwMo=;
        b=Q09vfW/SGRVXtGM34/lTpgtjhPEwrGBE0/EEJtzI8/vsrFCra+4gqmIdydDRooImqY
         8muJdTK0JrpppOytreDPvtY/s0vepd+ye9WYnrhigJY9qnSBsf6KsYN6bItx3l/5JksD
         feGkXzrpe8ewZU02qrAJfZGfu541zCACZZrvS05Vz8ArDVYFf0xKdnawIfyDYnrnENYP
         TK0zNg89pxEI5wEhK4F59cITHcyUIvaKFyVvo8FTbTCAEvbvPg9Zi1jrF9Kx/VVg+TvR
         m9aQGLKkVxgNKbxBmvLEXSHdhoQxEBI3L8G4ORs3j5MumPoGhMOjE79ZsRvruWaxxOTE
         IcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PJkLmBIgDAd224gT5d1DEVPXAmElvH5/SyzF20ifwMo=;
        b=QZzQtXQmtD1feD3+bIGK+rHdjZvHF7tAweyKkp6gQuZoO3/YWDk3ChNxNFwBuG4k7H
         rVxtporNdg6fxb9DnMpNE8F5SU1ftE5jmCReF+8mXQ6nBgH5lj/T/nLcphqWDxzNc77y
         eGOalQGxO9dpvKLHhI1iLb6qguJVutOnPkJpW0zfYpij/p/iRyBEXkfquhGYsgrjXN3S
         aQ3ibtfQEVbT+K9tazEB0sZp8exX9VwN3Qi9EP+CNURU22r4pIL4/aCmxDUoeaJIRfFp
         vOUmTj7v+PyRVyzTYfK9JWx+D1dkjM3BMA/MQpCEexAhQSZ9YnKnq85Z2rVHuj/Z82jy
         MCjA==
X-Gm-Message-State: APjAAAUN6FrgM5P687QBgTAEZ/RMCJJBoH4C4s7fTXl8W2XNv4vsJcP+
        dG9tA4RHhOuwlZU4qOSi23g6UNAF
X-Google-Smtp-Source: APXvYqzOu6CINIEj+3Po9oup12+oEk7wt9we8AL0MVzW4ktlZFw08d31+E8r7YXUCsU9yx30F9mPqg==
X-Received: by 2002:a17:902:b087:: with SMTP id p7mr51612685plr.10.1577419560274;
        Thu, 26 Dec 2019 20:06:00 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d65sm38462733pfa.159.2019.12.26.20.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Dec 2019 20:05:59 -0800 (PST)
Date:   Thu, 26 Dec 2019 20:05:58 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: Don't try to enable critical clocks if prepare
 failed
Message-ID: <20191227040558.GA22856@roeck-us.net>
References: <20191225163429.29694-1-linux@roeck-us.net>
 <1jd0cbpg77.fsf@starbuckisacylon.baylibre.com>
 <fed37460-6097-1a3d-3c05-e203871610ac@roeck-us.net>
 <20191226215919.CFD572080D@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191226215919.CFD572080D@mail.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2019 at 01:59:19PM -0800, Stephen Boyd wrote:
> Quoting Guenter Roeck (2019-12-26 09:22:10)
> > On 12/26/19 1:51 AM, Jerome Brunet wrote:
> > > 
> > > However, we would not want a critical clock to silently fail to
> > > enable. This might lead to unexpected behavior which are generally hard
> > > (and annoying) to debug.
> > > 
> > > Would you mind adding some kind of warning trace in case this fails ?
> > > 
> > 
> > The really relevant information is:
> > 
> > bcm2835-clk 3f101000.cprman: plld: couldn't lock PLL
> > 
> > which is already displayed (and not surprising since cprman isn't implemented
> > in qemu). While I agree that an error message might be useful, replacing
> > one traceback with another doesn't really make sense to me, and I am not
> > really a friend of spreading tracebacks throughout the kernel. Please feel
> > free to consider this patch to be a bug report, and feel free to ignore it
> > and suggest something else.
> 
> Can the cprman device node be disabled or removed in the DT that qemu
> uses? If it isn't actually implemented then it shouldn't be in the DT.
> Presumably that will make this traceback go away.
> 
cprman feeds all clocks. If the node isn't there, the system doesn't boot.
Also, I don't modify devicetree files in my boot tests; that would defeat
the purpose - like, in this case, to find missing error handling.

Again, please feel free to ignore this patch.

Guenter
