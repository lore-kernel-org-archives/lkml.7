Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97211C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 19:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6518820881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 19:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OE6zYhP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbfEOTbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 15:31:12 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35150 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfEOTa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 15:30:57 -0400
Received: by mail-qt1-f193.google.com with SMTP id a39so1119401qtk.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 12:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8i34PFO8890f2DOSMIKiAp2ts8+TxOyU8H3VqXgs+U0=;
        b=OE6zYhP57X1qHRwZD8QXzWlD6mYEAYk6nn7C/ILMT+/KpUqmtcVd/J68w+g2rsDnch
         ZVFSNAJ4QhyVX0qX8LujWxvvD7s/s6dYO3bGQozXXFtiglUJI0/dCGSYNjx9xWJqVseX
         L7tIAC0fBA6w2mN8q/Ylrsa6w+H69N4kNhb4K+avmkNEQ6293tjhIjasi3QqScqrGw7w
         fJ9tOQmzdjFU1BQ1HvLoVHdelcit0WQxG2824WFZUIWAiNCgttlfsCnzgilbrFkIoogN
         lOc30i8Pcz0wcdX5GX6MHZN1FcNhmz0iSzg50x1syEYnTSOTsE8tty0OEWPdg46WDyrd
         DXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8i34PFO8890f2DOSMIKiAp2ts8+TxOyU8H3VqXgs+U0=;
        b=Qs9Aw/5Jb/h68jHOBcd0aDWHSPDQT6MpZPt8p9AbArGYCEJIP9oimmL4qOBCWMUbfq
         NPigA/ewP38B3+c0D/HsY0ZVQetfVEMiX04MkPauqN2TSP5x5q5bmVinfzvp1HKi6kBG
         NcQsNZwEPf/HbQp9Kb7pggkFYEDMhxndYkkUWwrXID0NYM2fRso0Chwb7PagWjR1s5JZ
         bS4bwgY2tFJupq8xlRUWTJILYWrTbCOVkZ2v2rMj9dH2+kqRmzLyyrVfTuelke8HxpCE
         CJyW0xxL/t6sx1OOyo/fIFYou2wxINJuBkO3Fggny/0L/3cIWiTEmnC1pKXbzpuaArzT
         m01Q==
X-Gm-Message-State: APjAAAWIz2Z/VEVi71YuIgGhOf+00NYqT3FiTmvzaiCkOMVkE2PDJOUf
        d6dFaPcqcDCh+S9057M71vnscauT
X-Google-Smtp-Source: APXvYqwUR9N72T9FplreY0Q5d54UdKkdVUt8LgiMArzd489UIsTJvP4O6uZIy8Z/4oMC1SDQUxXaPA==
X-Received: by 2002:ac8:17eb:: with SMTP id r40mr22840243qtk.140.1557948656101;
        Wed, 15 May 2019 12:30:56 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id 65sm948542qkd.1.2019.05.15.12.30.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 12:30:55 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 74F65404A1; Wed, 15 May 2019 16:30:45 -0300 (-03)
Date:   Wed, 15 May 2019 16:30:45 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] perf intel-pt: Intel PT fixes
Message-ID: <20190515193045.GF23162@kernel.org>
References: <20190510124143.27054-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510124143.27054-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 10, 2019 at 03:41:40PM +0300, Adrian Hunter escreveu:
> Hi
> 
> Here are 3 non-urgent fixes for Intel PT.

Thanks, applied.

- Arnaldo
 
> 
> Adrian Hunter (3):
>       perf intel-pt: Fix instructions sampling rate
>       perf intel-pt: Fix improved sample timestamp
>       perf intel-pt: Fix sample timestamp wrt non-taken branches
> 
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 31 +++++++++++++++++-----
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> 
> Regards
> Adrian

-- 

- Arnaldo
