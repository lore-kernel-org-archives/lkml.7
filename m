Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B8ACA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DDF21783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 14:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCRaElP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388416AbfJVOLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 10:11:40 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:33168 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388082AbfJVOLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 10:11:39 -0400
Received: by mail-qt1-f170.google.com with SMTP id r5so27012644qtd.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 07:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=arduzF1kaBslJXI74pdz56xr6dr059GQhC1NJB2xSFE=;
        b=YCRaElP+gpxetCfMZggzVtUoHeeRk/Y7ygsovmdgMmP64xp3sTxvdrpZi18emZf2ui
         xWc9o/M4dKzJSzHpvCM0GPbxXJemh0YK9VMOFedXtk/DurHXz4dwKJse/oSLmhapxSbl
         ltCseOCjeskQ/zAO91IPgsDctagYTrUbjU4Mi1KkNCuZ252lRnEb3VqcCLLSmuHdjCtZ
         LdtUCI5RgBfqOm3l9R8+SDfaI5er3O7178hMb887dwzS0QKvv+E52by6YUBsnUZh5gq2
         WybRH9AXOK1vKq4gZxwTk+vqi5JGOjqt6JzHdjOa5U0fPbNOjOZzYn7HsxBxbG9efKmR
         /8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=arduzF1kaBslJXI74pdz56xr6dr059GQhC1NJB2xSFE=;
        b=GrijKycXUjKve/qCjREW/wYuRFvyrO8oVAvv2Ucb3g2jBXG0jPCgh1QkBE7lCntTjW
         WlQwxnq7q0Oh9yYGOZu3ujNc72CnbxkK2gX+Q3Ki5CfLxvP2yIvYGfXe5UKFToAjUSY9
         zL7wPphIPLoh0txGeEiuigvGe/FxvrNXqpmgq2SwcyonZ39Cabpc7Ha1LZl1xxPQu1iW
         BaPnLODh7/LcsMaUsZqrgduEYWHNTjT/iqNpR2VFfyljxMQ0Z/q6mebYM08+IE4sul0f
         pyBDhYJAC8DIA7x/JoJfTHF+qlztMYMPgIzmEJtLygRF5Sr/1U35Znx62YM0GgL4ESPO
         cwfA==
X-Gm-Message-State: APjAAAWC0NKhm/y27WZjJoD/vN+PRlLSbnM6i6qmyLDcG0toGtMgqltt
        4oWTzT9aGPXh3tonRCBzOYw=
X-Google-Smtp-Source: APXvYqzDq98FByN5Brr9w4Gosxnz3h5L5txtj/t2DITW+xXqpB516Vf6ckAqK1gPYKz+D81TjtbrGg==
X-Received: by 2002:ac8:5387:: with SMTP id x7mr3501726qtp.367.1571753498547;
        Tue, 22 Oct 2019 07:11:38 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id z141sm10038341qka.126.2019.10.22.07.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 07:11:37 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 81A6E4035B; Tue, 22 Oct 2019 11:11:35 -0300 (-03)
Date:   Tue, 22 Oct 2019 11:11:35 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, eranian@google.com, kan.liang@linux.intel.com,
        peterz@infradead.org
Subject: Re: Optimize perf stat for large number of events/cpus v2
Message-ID: <20191022141135.GO1797@kernel.org>
References: <20191020175202.32456-1-andi@firstfloor.org>
 <20191022080223.GC28177@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022080223.GC28177@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 22, 2019 at 10:02:23AM +0200, Jiri Olsa escreveu:
> On Sun, Oct 20, 2019 at 10:51:53AM -0700, Andi Kleen wrote:
> > v1: Initial post.
> > v2: Rebase. Fix some minor issues.
 
> looks really helpful, I ack-ed 1st 2 patches,
> I'll need more time for the rest

Thanks, applied the first two, will go thru the others.

- Arnaldo
