Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E45CC43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 00:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D503620705
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 00:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyfN7qf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfLCAzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 19:55:05 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:41516 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfLCAzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 19:55:05 -0500
Received: by mail-qt1-f172.google.com with SMTP id v2so1919538qtv.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 16:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1mRpxlmsoKNTfeehFvIb6MBE5e9wkuGe6hyqrX+ecrI=;
        b=ZyfN7qf/sihxxevvTNan+cC10AdbI0ju7pbqc9B8T7cBUaxAdjMBHj//JhwZe2c3A7
         LeF5d3KwBkjvDPdmBVanhzJ47bAuxC24yRbkXRCd7IAcAwkgz9CgLWBS6npgK07beeqX
         vhGNNiJ/zQgaDnTvDf3ZEVlmvyp7q+0X3dw4VtTpxPmlJeYeApBRNa5mHWsNu9eQGkVs
         4wAtBa3vz5jqe7jZqqt6dwOKoQ/7SEnBZjZSOlzX+veNV1rYLiH0wCdh8nP8IzFi0mwe
         yg96gPBU30VWkppn7kQ+W8PlVsSL/2YcIJxJvhKMAMixzwBTRwTIxNyCoxeFKw9Wtmha
         S7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1mRpxlmsoKNTfeehFvIb6MBE5e9wkuGe6hyqrX+ecrI=;
        b=L6v7WSqP8bCW06Y6EygL3AO9cmC9AT/sdmnR21o53xXAwOCQSmPEjHUfEo4OQlodFT
         VRy6cSZzjcL37XBmSpWuF7O2ZvMU8YCwC3Jj1XkjWmJrJMXE4uxAroOpmZr/nsMZM36w
         X59fWYfhNnrY4yVdyKigeWTXRowLjyJ/wg0BXUtutfszN0bWCxRyNJXqOiTLvFtvahMc
         xgBXF++4Id4Pd8BIWrBBNLAIENHY2M/jGAGjJXkhLNwhfS+vIBKS1IPZzr3YxLqxTBz8
         BRs3uVkeUaeIYvyhCGilKjdDvbCmydru26zqjb2S3PyBR9XHusaStwg7CFgz78zdIpqK
         S/Kw==
X-Gm-Message-State: APjAAAWtJYkt7gFuze/Vdn39tk8LHHabJzH3fc1DfBiqtHQW9yysT8UA
        IEhTBB+Ro5ybHsn2D+U9V9Q=
X-Google-Smtp-Source: APXvYqxCx0qexFateEqmFNEC92dFPhvfHbT7Zi7vrTQXoGZ7r/aWj9MhGDun1uAuD29t8osmekc9ZQ==
X-Received: by 2002:ac8:6f73:: with SMTP id u19mr2633079qtv.326.1575334504455;
        Mon, 02 Dec 2019 16:55:04 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id x1sm712903qtf.81.2019.12.02.16.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 16:55:03 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7A541405B6; Mon,  2 Dec 2019 21:55:00 -0300 (-03)
Date:   Mon, 2 Dec 2019 21:55:00 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf probe -d failing to delete probes
Message-ID: <20191203005500.GA3247@kernel.org>
References: <20191129151324.GA26963@kernel.org>
 <20191202185958.GH4063@kernel.org>
 <20191202190452.GI4063@kernel.org>
 <20191203071854.37e20e0455626f5c388b3cf3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203071854.37e20e0455626f5c388b3cf3@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 03, 2019 at 07:18:54AM +0900, Masami Hiramatsu escreveu:
> Hi Arnaldo,
> 
> On Mon, 2 Dec 2019 16:04:52 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > Em Mon, Dec 02, 2019 at 03:59:58PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Fri, Nov 29, 2019 at 12:13:24PM -0300, Arnaldo Carvalho de Melo escreveu:
> > A workaround, now to find out why 'perf probe -d '*:*' and the other
 
> Thank you for pointing it out. You can use '*' instead of '*:*' to list them all.

It didn't work with either '*' or '*:*' or any other variant.

> Anyway, there seems an inssue when I introduced multiprobe support.
> I'll fix it soon.

Thanks!

- Arnaldo
