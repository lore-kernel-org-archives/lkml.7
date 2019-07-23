Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552B9C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DB0218F0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kl/aEFfn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733013AbfGWPRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:17:07 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:44437 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfGWPRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:17:06 -0400
Received: by mail-qt1-f174.google.com with SMTP id 44so11273969qtg.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 08:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I2AwJ8y+pZph/vCLaCeuPDunR8vxlIs6nTXakQYneRY=;
        b=kl/aEFfnnLfxx2j7Jbx6USZ5alpNgcU+bpYEspSnr8UdEal9SuZ9MsOOZPZb7gfqKp
         Ek9Lhs45DX11V65WexDENltrzryHLLePKS1Koi7cb7gjo1mNOA7VNOXaZaWwE3Hj1i2g
         4Ch5N42nzznmt30c8yx8jG7BbcfiecGRRbSC04wjX1Up0AzhGH604Xw05tx6VnHu1bDb
         tYjc+fiEr2mUK9fpM0Tn4PuOEGUvPRQtAD65dPdKAem5A20FNrQb2cDYpd6bWFpROixi
         MAPqyM3onHhZLCprjWhVwaXDMM+WlnyggDm3+k3XyV0zGOIYv/GGa+fCkQHeZBE+otPc
         Q1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I2AwJ8y+pZph/vCLaCeuPDunR8vxlIs6nTXakQYneRY=;
        b=tW4BPY8RJzqh3hkpkS9qK+32/aFIVOUWlirvgvYHbBo7Dmhd0EqDpA+ayoioWJUwgE
         xhxtSg16i9mpNiqksLcGZd2mXTSHFzx6WBXAkA3LWJ2JtUgdFEhucZ2CmkzsHR4JNz3Y
         0HGlaUR68Z/dElkylroLZ5+AOuKJB+5499FFQEwXXpBz1koAil40LFNKsDAGGrOMuHdU
         zCD3AQ0Xeq3iN2rRt97n+ZeLXOY5SvTRaTulwgo+HHft5bmh0I6Hk0aEPnXTgeL+0MOi
         9ziP0/nm+iu3dNc2O5LJ7EeCveugsAjkeKzdmlnD6ICgzeQ0NRKvSTE+qNR9dyAx3/Ao
         9ZaA==
X-Gm-Message-State: APjAAAXeTsFmzIr5hhcoh0bN5WQdu770AayyOWUDelV0QDjiioBcsMFm
        RBfp001Hz9LEw8s+dWDPgBg=
X-Google-Smtp-Source: APXvYqw1iEcAIMelwupx09TFjVrlCj7+zKVOLA9NZ7t/jY4K5mR6K46JJRW22mfZVOu66bCDn1tShA==
X-Received: by 2002:a0c:ad7a:: with SMTP id v55mr53810661qvc.130.1563895025505;
        Tue, 23 Jul 2019 08:17:05 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id z18sm18311078qki.110.2019.07.23.08.17.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 08:17:04 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 84E3340340; Tue, 23 Jul 2019 12:17:02 -0300 (-03)
Date:   Tue, 23 Jul 2019 12:17:02 -0300
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [patch] perf tool divide by zero error if f_header.attr_size==0
Message-ID: <20190723151702.GA8129@kernel.org>
References: <alpine.DEB.2.21.1907231100440.14532@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907231100440.14532@macbook-air>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 23, 2019 at 11:06:01AM -0400, Vince Weaver escreveu:
> Hello
> 
> so I have been having lots of trouble with hand-crafted perf.data files 
> causing segfaults and the like, so I have started fuzzing the perf tool.
> 
> First issue found:
> 
> If f_header.attr_size is 0 in the perf.data file, then perf will crash
> with a divide-by-zero error.

Thanks for the patch, will be in my next perf/urgent pull req.

- Arnaldo
 
> Signed-off-by: Vince Weaver <vincent.weaver@maine.edu>
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index c24db7f4909c..26df60ee9460 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -3559,6 +3559,10 @@ int perf_session__read_header(struct perf_session *session)
>  			   data->file.path);
>  	}
>  
> +	if (f_header.attr_size == 0) {
> +		return -EINVAL;
> +	}
> +
>  	nr_attrs = f_header.attrs.size / f_header.attr_size;
>  	lseek(fd, f_header.attrs.offset, SEEK_SET);









