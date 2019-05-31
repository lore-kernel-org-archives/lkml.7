Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EA7C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D4E726C61
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdqWRPp6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbfEaQp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 12:45:56 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35548 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfEaQp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 12:45:56 -0400
Received: by mail-qt1-f195.google.com with SMTP id d23so1677931qto.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 09:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KDk+BjAitXrbvXHzovb9PwGUp2CoC3CSWvkw/pVSbdw=;
        b=EdqWRPp6EuVh/ogn1cEDxCKNcxzhLkW2GqElnn0fTJdGoGYWqNOBLq/+3XOZktb+6e
         mUFhXSKRz0Lnm3eKyjb+6u5ogNLyLYD9ZiFbqp2HvihWjrq4m0RvCC/ATz8xcdsxi701
         4t8l190vdDUEoEJ1KfI6BQdiy0FtejFnr/veB+iV8jRUSgMhXNAdi5HU7CELw32HK9qu
         EjrjB+baPgS4MzPOHD5Kl9AvQQu+1Z4O/KkNhVSN99pRJHnUe7LhPEY44w+oXNoJyRq8
         eHkyejl8pUiZSItong1/Dd5fZRYh5z8hUR6PDG6pscgX1AYjE4je2jdJfs2W4Nwm+JZE
         yJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KDk+BjAitXrbvXHzovb9PwGUp2CoC3CSWvkw/pVSbdw=;
        b=rEYzkP/mGldPqqiJcycKEBvn87DEYWaxtIJM0vVyvKiRv4+BTk3KQiwdyHEF8jtfAq
         8IojH972V/bwIurgzahDgehZX9Tv4wSkclKUYraEWn2ff+kHYisVUBO55CE5gwyW/ROM
         98/lqhQkWwzbRB1eRi4oDf9E67Zz1cRM47OP4E/myPl2cjw7cuiIj1PsURRsEJvKDhNV
         KRLZ2OTYboX18Te6P9Sfi8DVxTduYbr/NfhmOpPkJAtO5xw/A4XJmqUvfcoyx9mb0G6r
         u+FswVzt77rzkzcQyNofF9/mgO1P/obpO/AuKBnXxZIxjyqLuNN4lqH3sCsP2IiiCPZZ
         8m1w==
X-Gm-Message-State: APjAAAXf5F1Mw3rjf/cSWMVNqfR92KI3SaqdWst41N+bBmMqL5PhyaRw
        uHmD3jeykE3cAVLJlEMbHwAGj5oz
X-Google-Smtp-Source: APXvYqyas23pOZWUBQVxe1wB//swa13JWR6u+Iv2Eknv6QIHk4OlfGnzWwj7JccRCTjPtRyBud2ZMQ==
X-Received: by 2002:ac8:39a2:: with SMTP id v31mr7231284qte.390.1559321155659;
        Fri, 31 May 2019 09:45:55 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id h63sm3247302qkf.4.2019.05.31.09.45.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 09:45:55 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AC94441149; Fri, 31 May 2019 13:45:47 -0300 (-03)
Date:   Fri, 31 May 2019 13:45:47 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/22] perf intel-pt: Fix itrace defaults for perf script
Message-ID: <20190531164547.GC20408@kernel.org>
References: <20190520113728.14389-1-adrian.hunter@intel.com>
 <20190520113728.14389-2-adrian.hunter@intel.com>
 <20190520144516.GL8945@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520144516.GL8945@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 20, 2019 at 11:45:16AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, May 20, 2019 at 02:37:07PM +0300, Adrian Hunter escreveu:
> > Commit 4eb068157121 ("perf script: Make itrace script default to all
> > calls") does not work because 'use_browser' is being used to determine
> > whether to default to periodic sampling (i.e. better for perf report).
> > The result is that nothing but CBR events display for perf script
> > when no --itrace option is specified.
> > 
> > Fix by using 'default_no_sample' and 'inject' instead.
> 
> Applied 1-3 for now, concentrating on fixes, will process 4-22 later.

Tested the ones that affect sqlite databases an the GUI, all look good,
added committer notes and text screenshots as committer notes, thanks!

- Arnaldo
