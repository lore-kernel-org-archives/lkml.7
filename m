Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D23C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5FFF20844
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwfYN35Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbfHMOXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 10:23:38 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37285 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbfHMOXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:23:38 -0400
Received: by mail-qt1-f195.google.com with SMTP id y26so106521992qto.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 07:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y1ZEdaOi94u94z+ebuqvGlapSogYpo4cbHAgruEQQ4U=;
        b=ZwfYN35YX8mhQPQt5FZI9cTGY2XJPexvicmwAb0R96q1jswLieAfDhHUf0QRWTSw7D
         584cBpiDhyJJDaJ1OrlpX4cuI+tGNmJZqthdp821BKzrY7NqRvw3DwUg+IGW5QUlAiLI
         xSV8hl6oOSiBTYTR+rn1rzHCAw4Ij5z4Bwloris3UF+2Ty50XsRjfoyxhe0Ppx/sWlyW
         QVNRF/tJGb7nK9gsDR7fyDkz2zX+uQfwsz/Uecv/1G7C1Z8RU2k1MgxUu6J6YyAYUBEM
         FMrpDsIU5RGCPbPwpFataD3+hxuAQIif3ZHGXVOjr8KyxiUNNQapLtSyCmByZ25vaCJ0
         aP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y1ZEdaOi94u94z+ebuqvGlapSogYpo4cbHAgruEQQ4U=;
        b=VwGNFGaTyid7VTAsQElXmx2FezjXm9v4VEbRrkbbP5moJvWsz0nznEOWijzOEfeIVM
         VZuDevPN2IlVZWjTPHW3JU2x13GJFFi/+fC9QI6vWIgsRwGLEXrnSHjwldQvEk3fpteN
         Qp2LYG2nocQMvp8E96Kc0icxteMlLh0BQgtKcYXprvDX/afNEveY+ofgV/TRxsR8AD21
         3ucYX/kAXm9LngoTGsLRthty4uOTtK27UWOhsXwsPCXV9J2zcKyg71NHWX9aaCi0Td/w
         MmOZ2y3yjeuQNb6DGAgwK1VjqVBl19prWR74lFWu6fjyc27IYRt3lRiuNGB72aKwMwGE
         IFJg==
X-Gm-Message-State: APjAAAUamxPTKz8LVpKaRfJ0DXVSXIjZIXI0jSs5/t7furFFkLircz01
        lArZBYo9KX/KQr4TLbql+mI=
X-Google-Smtp-Source: APXvYqwYnUzFg0eKUYnOygTHC8dz6Jqi5NcJkttA4X9QYORBsBQO6e2yUiUBj30VabYZO64G2YewjQ==
X-Received: by 2002:ac8:670a:: with SMTP id e10mr5673620qtp.244.1565706217217;
        Tue, 13 Aug 2019 07:23:37 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id p59sm48730550qtd.75.2019.08.13.07.23.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 07:23:36 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1E1A840340; Tue, 13 Aug 2019 11:23:34 -0300 (-03)
Date:   Tue, 13 Aug 2019 11:23:34 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Tan Xiaojun <tanxiaojun@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, songliubraving@fb.com, rostedt@goodmis.org,
        kan.liang@linux.intel.com, tz.stoyanov@gmail.com,
        alexey.budankov@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf record: Support aarch64 random socket_id assignment
Message-ID: <20190813142334.GE12299@kernel.org>
References: <1564717737-21602-1-git-send-email-tanxiaojun@huawei.com>
 <20190802130926.GB27223@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802130926.GB27223@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 02, 2019 at 03:09:26PM +0200, Jiri Olsa escreveu:
> On Fri, Aug 02, 2019 at 11:48:57AM +0800, Tan Xiaojun wrote:
> > Same as the commit 01766229533f ("perf record: Support s390 random
> > socket_id assignment"), aarch64 also have this problem.
> > 
> > Without this fix:
> >   [root@localhost perf]# ./perf report --header -I -v
> >   ...
> >   socket_id number is too big.You may need to upgrade the perf tool.
> > 
> >   # ========
> >   # captured on    : Thu Aug  1 22:58:38 2019
> >   # header version : 1
> >   ...
> >   # Core ID and Socket ID information is not available
> >   ...
> > 
> > With this fix:
> >   [root@localhost perf]# ./perf report --header -I -v

Thanks, applied.

- Arnaldo
