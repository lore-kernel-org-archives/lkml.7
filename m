Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010B7C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7C52084F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NF3dSVAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfKLOSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:18:06 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44417 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfKLOSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:18:05 -0500
Received: by mail-qt1-f196.google.com with SMTP id o11so19837334qtr.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 06:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/+LUYXsVs57NZ9nj7s0aknJuCeTdgEzwpPK38E27wfE=;
        b=NF3dSVAMp71p4SkyeY6fpE7IwvJGNXZgmI+Yp4nbUwWsLIyUOJy6aq3oAi1H62iPYB
         MggPAt5Lmo0IKt6qMXYMrr9V5bbO5YoXVlXSvIiRZBgD1IUUOwkUGgr2u+5XFeUVJnSA
         B+Ry9SnWt3iSkFtX3EXUOCTl49Vfr35AYfPkP8sMBPtqQFjeHxCY1JNIl2ctDhSnpaDI
         XrzCZeve+tTmb7p/0ck3AReUZQo+e5crmWeWAeJxaXJkqhakw3BIJcqbto/IDJHuLl88
         8zwdO26LSbxmtphFzE0sw5n/L4z6h64uAQJN0t2nbpdoGVyMr8FPsltHZy6YKnVdIX0a
         TvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/+LUYXsVs57NZ9nj7s0aknJuCeTdgEzwpPK38E27wfE=;
        b=h2D1dke2mwaOPW8/tGWBivHblO0PsQUmJesp5392xZvCnvzmuoRN4UcYruPFzU8+bl
         0BgjjkigBeH7n5M1b51frutkiqtD/Es+mJT114JvLQ7cBAAPFQYDubcqQayoQiv3gb4o
         5Zm3N+lnl6XzO/jKcXeb7CT3yNCoSLIlOj6rXIiXl0Kd10njobqzm1Vjcrko09BmGu40
         nXgUnIAf8qnjWhcipBYlW6WSarsjfVu1zG4JNMt4kYG39i4PoL1j8GWwfJqdnkViApfO
         WfrOs6+lpB+E4n9r2WklKdEHK46ibAWB1+KPvK/RwkMF/Bg8SnJt+fOdeeKOD/XUJl5a
         /Wgw==
X-Gm-Message-State: APjAAAWSgtlreEE+hUIVWWmb75pmoRfQ5YIczEASYgcnLesxjc4b9IMP
        ZJJYLmzhQ88mjbsWXW0i6tk=
X-Google-Smtp-Source: APXvYqwylrIqEzA7wLWdPWQrxMYaUujbvWV7j5PilWPu7uOhNdkPuWy7dDmDdp/0q/A9cJ/1Fa83Xg==
X-Received: by 2002:ac8:605a:: with SMTP id k26mr29217448qtm.212.1573568284318;
        Tue, 12 Nov 2019 06:18:04 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id a7sm4246884qka.136.2019.11.12.06.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 06:18:03 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 21DCB411B3; Tue, 12 Nov 2019 11:18:01 -0300 (-03)
Date:   Tue, 12 Nov 2019 11:18:01 -0300
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        jolsa@redhat.com, kan.liang@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf report: Fix segfault with '-F phys_daddr'
Message-ID: <20191112141801.GA10207@kernel.org>
References: <20191112054946.5869-1-ravi.bangoria@linux.ibm.com>
 <20191112110417.GH9365@kernel.org>
 <53a89f25-d29f-0df4-61c9-77d70a507117@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53a89f25-d29f-0df4-61c9-77d70a507117@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 12, 2019 at 07:28:06PM +0530, Ravi Bangoria escreveu:
> 
> 
> On 11/12/19 4:34 PM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Nov 12, 2019 at 11:19:46AM +0530, Ravi Bangoria escreveu:
> > > If perf.data file is not recorded with mem-info, adding 'phys_daddr'
> > > to output field in perf report results in segfault. Fix that.
> > > 
> > > Before:
> > >    $ ./perf record ls
> > >    $ ./perf report -F +phys_daddr
> > >    Segmentation fault (core dumped)
> > > 
> > > After:
> > >    $ ./perf report -F +phys_daddr
> > >    Samples: 11  of event 'cycles:u', Event count (approx.): 1485821
> > >    Overhead  Data Physical Address  Command  Shared Object  Symbol
> > >      22.57%  [.] 0000000000000000   ls       libc-2.29.so   [.] __strcoll_l
> > >      21.87%  [.] 0000000000000000   ls       ld-2.29.so     [.] _dl_relocate_object
> > >      ...
> > 
> > Shouldn't we instead just bail out and state that this isn't possible
> > and leave the user wondering why what was asked isn't presented?
> 
> You mean popup with something like "phys_daddr is not available in perf.data"
> and also don't show that column in perf report?

Just bail out completely, something like:


   $ ./perf report -F +phys_daddr
   "phys_daddr" is not available in perf.data, use 'record -e some,thing' to have it.

- Arnaldo
