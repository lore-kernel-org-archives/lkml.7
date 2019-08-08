Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45700C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15AF02171F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ktxy4neM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733186AbfHHNib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:38:31 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34702 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733076AbfHHNia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:38:30 -0400
Received: by mail-qt1-f193.google.com with SMTP id k10so22994814qtq.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 06:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ul9qKDqAXolsopwmrNlswmWFFioYEniSvgqZsoKzlLA=;
        b=Ktxy4neMLsewiehz3AwWRyo7VnNO9L2QkOp4iIWvNvuyehQvS9sKXKeH0+GcE3iQnH
         Avl+v3kGaLDs51rKLePsEZSGwMX/Gn5fdjg+/gDHLbraGIu1XTaK6/GtlRn1vP42GImX
         qbSvN3SE5HEy/7qzfDryrkqnVyPSn4nLZS9tGv39bNOxakNNEL6Es29B3uzb3fo9sw+0
         G/GgMtsmdIk1di7gnw1/fnWaKgOYCg7F4L4RvFpo7SEf3qgzb1abz+YCxYRY0gQZPxH6
         HQTrkq8DSu9M4YRkTdw8WooiXPRfhgjEZC/BteX1JS5bCu8167TVtLDfPqDhS0SCc82J
         vg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ul9qKDqAXolsopwmrNlswmWFFioYEniSvgqZsoKzlLA=;
        b=RxB3U4apj9/deulsQW0g3SHgq23UUyKN+58YSDuTw1Px3xfTUgqcjMb85ZxB1sNsrw
         nMvqazePgXVVrD30XWBySaB8Cr/Ueo1+DsQ7Unc2oU9EtDkrT7FdAYSndCaTug2pYdE5
         nVINUGlvc2RtbQSiRpgbI1JfuU+N88pVpQwTDhmc4hr1s2rQzJ2txtag+lSiJooN4Lj2
         i+B5CGbRzUXuBNOM/+AplMFyy+gMAHKrQA77jvVRa0ntjbUsY2nb/ycehLLfWt/E85fj
         4ediu1T41rKH9qAnUFIXvl9TdaOZ4rvRYsiuzBkYHZt38qdBwc++E7KZLE+6jKDf/PBQ
         F4Qg==
X-Gm-Message-State: APjAAAVvVdG6nc1Nswp1JWl9im8ahqfjG9nWWmuHABCgWGPwlMTWbgBo
        2gITkTAame09GbKG04NjiWexmWsU
X-Google-Smtp-Source: APXvYqyDR1JZxrO+2beLS/IXsd/uhg4qEN1jNhH015u1axAdlO3t13iMeqcgKLec5rzGh/cgCW43XA==
X-Received: by 2002:a05:6214:1c5:: with SMTP id c5mr12850851qvt.97.1565271509570;
        Thu, 08 Aug 2019 06:38:29 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id z33sm42264708qtc.56.2019.08.08.06.38.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 06:38:28 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9BBEE40340; Thu,  8 Aug 2019 10:38:26 -0300 (-03)
Date:   Thu, 8 Aug 2019 10:38:26 -0300
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Masanari Iida <standby24x7@gmail.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org
Subject: Re: [PATCH] perf tools: Fix a typo in Makefile
Message-ID: <20190808133826.GD19444@kernel.org>
References: <20190801032812.25018-1-standby24x7@gmail.com>
 <b9d6455f-4d9c-35b5-5a4a-863ba6a1d0f4@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9d6455f-4d9c-35b5-5a4a-863ba6a1d0f4@codeaurora.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 02, 2019 at 10:54:28AM +0530, Mukesh Ojha escreveu:
> 
> On 8/1/2019 8:58 AM, Masanari Iida wrote:
> > This patch fix a spelling typo in Makefile.
> > 
> > Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> 
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Thanks, applied.

- Arnaldo
 
> -Mukesh
> 
> > ---
> >   tools/perf/Documentation/Makefile | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
> > index 6d148a40551c..adc5a7e44b98 100644
> > --- a/tools/perf/Documentation/Makefile
> > +++ b/tools/perf/Documentation/Makefile
> > @@ -242,7 +242,7 @@ $(OUTPUT)doc.dep : $(wildcard *.txt) build-docdep.perl
> >   	$(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
> >   	mv $@+ $@
> > --include $(OUPTUT)doc.dep
> > +-include $(OUTPUT)doc.dep
> >   _cmds_txt = cmds-ancillaryinterrogators.txt \
> >   	cmds-ancillarymanipulators.txt \

-- 

- Arnaldo
