Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C9FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E86204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxI6Tu8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbfC0NrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:47:20 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38776 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728434AbfC0NrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:47:19 -0400
Received: by mail-qt1-f193.google.com with SMTP id d13so14148827qth.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 06:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UU25fZPADWzH963ZW2Q43ijgx73Fww93/Ir6e6HZgvg=;
        b=nxI6Tu8dPk0bHpWE0yd5ooKjpfFzbYxMT+PKZre0S9cqOXgm/eB66Z9wEE8lb4jk1j
         HnelPB+ep9OfmmbTBEYAkIu3czUR9AceQqutZXH9qptbQcG9ehPRt+Q6F2NUB/+rnxMk
         18Vod9c0qLTJoU8gr5FaRR4EpnxCS+8GW2zE1i8HOtCv87hIqzL77HYGuV52CSRY1tN6
         4M+ftShKv3YY1Of+IN6ZklSe9gu6GIn9mGDn2JqL/DmbaBTcBF6LOdsmIOldxymiHEBC
         MwhGvjWiVn1ACbWRdA9BQKviniDwDsfb9hdpwPx+7XpyVkCfPXePL7nQ3CSSXTKr5ocq
         jOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UU25fZPADWzH963ZW2Q43ijgx73Fww93/Ir6e6HZgvg=;
        b=FvyM6uTR+7jtJY2+h4vo/1O+FnNnEx8fS5/+yka7USRCtx8sUW7O3lsh/8FRPOiStk
         041y4FfostjN7qAWMxioZNtliKJnPjDtPc1LN12u4zYCg4eGY8nqyFuE4lL4/NIRGTAn
         7HmVrKO/l1bmFA3211Y4jR8uD1ZVRzsdA93IT6t+vc2Rc1Pz0SiH1vfIVwhRykhbwqk5
         tVFuVru672OrXKGWjZBRCFPFOUUA430FOB2mOoQalfBDGtGZoAjHwgqIb1b+Yzdo95Pe
         /uYHtenizoC5SfoOk9mkwIEk+Nx+irFyY5Ijtf6Liqv3AOvxQu+ck762o2+uniQQx9MJ
         2dEw==
X-Gm-Message-State: APjAAAWXky3Pf0WuWLZ22IeGF3h18MGvvHBqijAdknSbMzmlHa8tywR8
        7pCu58ajSAFVNoJBPGYSshOB+kqd
X-Google-Smtp-Source: APXvYqxK4qx7aGtFpU6Cf2xOaHh0FtxnEuAh7/HeUuih0JnL4bjX7XwMHKX23utwPzWO2R6g2U/4kg==
X-Received: by 2002:a0c:895a:: with SMTP id 26mr30739187qvq.4.1553694438167;
        Wed, 27 Mar 2019 06:47:18 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([2804:14d:1283:9770::1001])
        by smtp.gmail.com with ESMTPSA id b9sm5547260qkk.41.2019.03.27.06.47.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 06:47:18 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 649864039C; Wed, 27 Mar 2019 10:47:13 -0300 (-03)
Date:   Wed, 27 Mar 2019 10:47:13 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf scripts python: exported-sql-viewer.py: Fix
 python3 support
Message-ID: <20190327134713.GB9932@kernel.org>
References: <20190327072826.19168-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327072826.19168-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 27, 2019 at 09:28:24AM +0200, Adrian Hunter escreveu:
> Hi
> 
> Here are a couple for fixes.

Thanks, applied to perf/urgent.

- Arnaldo
 
> 
> Adrian Hunter (2):
>       perf scripts python: exported-sql-viewer.py: Fix never-ending loop
>       perf scripts python: exported-sql-viewer.py: Fix python3 support
> 
>  tools/perf/scripts/python/exported-sql-viewer.py | 77 +++++++++++++++++++-----
>  1 file changed, 63 insertions(+), 14 deletions(-)
> 
> 
> Regards
> Adrian

-- 

- Arnaldo
