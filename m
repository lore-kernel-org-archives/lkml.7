Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D32EC4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 02:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FC620873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 02:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB0ridXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfJOCGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 22:06:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40373 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfJOCGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 22:06:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id e13so2919888pga.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 19:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S/YyVfFiQ4zhdWgFtT/NrbTV70gXySm0ldISWFaF1XQ=;
        b=YB0ridXEgdyyK+8EuvZI6Fjk0DCG5jSYrTh53PYQXSztPsDzboCghLoI8yHzSZGlSP
         /34HlcEXrEonPibACjwrmk29XUI4KQsWY+6gp6SpoU4kWXA9gY8Q60aXOoZh7xsafFAQ
         CU86bB/BIoLqHSA0ABU+wcuVzmwFg+t8aB46Ny5zJFbbxaSUXZB7S+gUXW/PgYxRPH8v
         YMLzoVeppF8Tbd4HkeD3/WkVaniwE3YG6isvEIheRVZTLnfdm5IoQRM57eofT8LyOf68
         NH8Si3DICe3vMe5BPlE4F0h7/HdEuBlA9BVi8oPaEEGPJ2IYDun+4acGH40AjWDXvekx
         vwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S/YyVfFiQ4zhdWgFtT/NrbTV70gXySm0ldISWFaF1XQ=;
        b=C9/Pxj9QsSOvzZuR1l8/Qmu1z4uGajk8SPq00vOzooMTqY8+QjnfQ2i8EN2p5xvdAQ
         iXGms0a7f3OPVzlWdPUth32MVdynezEcEQGDDktEuW/tzwqQjt41xlG8iDArso05HkqY
         Y703yota3WKeOgHe8cpT1cIPxMxPesqnA3bQogBObNo/Va2QAjBtSzI977FwyvzyFhNA
         NxuA82+5gV3Av55L5y3PL8z+ghrxt10cmOLuajo9q1Er127NtmDEejCQjTryaJgugs3u
         BQOhGyX0cuC4iwkydf/kF6cp63xhp018yq6/9UklCZCRueB6SPk0JhEHcXu3l++ZcTe7
         7LtA==
X-Gm-Message-State: APjAAAVC6RVgyO+BHILS5wjqQ7+7koe+shLArE2sHWC3+7PpGT0XToAw
        ROtDmOChbrU0yEm9E6Slmlg=
X-Google-Smtp-Source: APXvYqxvvK8rjcvyjkRG2UoPhrtwP0PBtNP8UilDMymJTA6xyTh25eUf2qHzUaVPvYZ4h9IFrGTzig==
X-Received: by 2002:aa7:96a9:: with SMTP id g9mr35550480pfk.147.1571105180740;
        Mon, 14 Oct 2019 19:06:20 -0700 (PDT)
Received: from localhost ([39.7.28.243])
        by smtp.gmail.com with ESMTPSA id c26sm17472959pfo.173.2019.10.14.19.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 19:06:19 -0700 (PDT)
Date:   Tue, 15 Oct 2019 11:04:03 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Vitaly Wool <vitalywool@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Henry Burns <henrywolfeburns@gmail.com>,
        Theodore Ts'o <tytso@thunk.org>
Subject: Re: [PATCH 3/3] zram: use common zpool interface
Message-ID: <20191015020403.GA1336@jagdpanzerIV>
References: <20191010230414.647c29f34665ca26103879c4@gmail.com>
 <20191010232030.af6444879413e76a780cd27e@gmail.com>
 <20191014104717.GA43868@jagdpanzerIV>
 <CAMJBoFOVs-W_RAocRmmFmf=zOwMBODxP7XFkrhcOHDii-aXkuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMJBoFOVs-W_RAocRmmFmf=zOwMBODxP7XFkrhcOHDii-aXkuQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (10/14/19 13:52), Vitaly Wool wrote:
> On Mon, Oct 14, 2019 at 12:49 PM Sergey Senozhatsky
> <sergey.senozhatsky.work@gmail.com> wrote:
> >
> > On (10/10/19 23:20), Vitaly Wool wrote:
> > [..]
> > >  static const char *default_compressor = "lzo-rle";
> > >
> > > +#define BACKEND_PAR_BUF_SIZE 32
> > > +static char backend_par_buf[BACKEND_PAR_BUF_SIZE];
> >
> > We can have multiple zram devices (zram0 .. zramN), I guess it
> > would make sense not to force all devices to use one particular
> > allocator (e.g. see comp_algorithm_store()).
> >
> > If the motivation for the patch set is that zsmalloc does not
> > perform equally well for various data access patterns, then the
> > same is true for any other allocator. Thus, I think, we need to
> > have a per-device 'allocator' knob.
> 
> We were thinking here in per-SoC terms basically, but this is a valid
> point. Since zram has a well-established sysfs per-device
> configuration interface, backend choice better be moved there. Agree?

Yup, sysfs per-device knob.

// Given that Minchan is OK with the patch set.

	-ss
