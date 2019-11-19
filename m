Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4031C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C144F223CA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 22:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtfBjceW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfKSWhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 17:37:40 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35955 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfKSWhk (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 17:37:40 -0500
Received: by mail-qk1-f196.google.com with SMTP id d13so19487705qko.3
        for <Linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 14:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZEOOoFMFSjHOIZGiBUfdMLMJjq1LDc/7KLjrRN/WD68=;
        b=RtfBjceWARXurVIXkpT5H7OOXLnZqZ3arZOikAYSTaYAhDDnN78Ijj2p/70Qybzc/Z
         QZ12kTGqs4Mi0KO+vaGvjZICHSHxFkwbjCg9Z5AliTBYcnkWQLXF7ayxjukapGstnGwQ
         u8xFmeDqQVJiSFUvUMBTvPpkYCsONo2cg0AqE68GA17Lfa2iwI8TpXKylqFLwGMrtTcD
         us7fxZ76LZTVzItxrNBCCEMdQK+b2blydutm3nzyfhbp1Cc8ghx5NmSnCoZIxz6Y441I
         7rbIhIK8JXXSTpMmyknTHANc9FCmwe9axGAZO33ULuitxfCCdy76SQFOlw4/sQdNvKI2
         xcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZEOOoFMFSjHOIZGiBUfdMLMJjq1LDc/7KLjrRN/WD68=;
        b=D1PbHYlujsOp26f2X9eLDupmgF8gjxyjzPQ7/+uu7A3uqSuG10e47ZcqSQWWXfGtZm
         ixQvLklvC+wGWzOn8IaP+211OjsNgV4BP/HH7M4ZM2P+oFbtN6AxONSE64PzlXXdnsfj
         WeMTLE9JxQ75T1Ku0lC6M2o/E8FZsz38a5/EjdLtru1u/YLo2ERVTpJMc6O/mWaUX7PY
         AbtWat9j86yEST8Sk2y551NFQkVzoiu0cY11cot9K4hqoTSZhprxh2bsCFCOnksdNLC4
         yzDpxjqMxYZf5JF1lmG31BZqT47UjguvNDQcpkxSuuomP7sSQR8w5l24b9LfIvnR8YDT
         YbGA==
X-Gm-Message-State: APjAAAUa2L//Bkix5o96pykTAR+Hta6dVRMQhVCU0TztZJaIyJDO/ReL
        kwa0Ph3ldGjNrwLf7ZUqoJU=
X-Google-Smtp-Source: APXvYqyYdpmBsd80CknCNGxfnoEqjc4+AHvbeXc2pdVwiW/sPzs/a1tHJysMm1MK5E6qivBKIrvMgQ==
X-Received: by 2002:a05:620a:3dd:: with SMTP id r29mr10377qkm.370.1574203057588;
        Tue, 19 Nov 2019 14:37:37 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id r126sm10899922qke.98.2019.11.19.14.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 14:37:36 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 38F4B40D3E; Tue, 19 Nov 2019 19:37:34 -0300 (-03)
Date:   Tue, 19 Nov 2019 19:37:34 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 1/2] perf util: Move block tui function to ui browsers
Message-ID: <20191119223734.GE24290@kernel.org>
References: <20191118140849.20714-1-yao.jin@linux.intel.com>
 <20191119200927.GB7364@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119200927.GB7364@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 19, 2019 at 09:09:27PM +0100, Jiri Olsa escreveu:
> On Mon, Nov 18, 2019 at 10:08:48PM +0800, Jin Yao wrote:
> > It would be nice if we could jump to the assembler/source view
> > (like the normal perf report) from total cycles view.
> > 
> > This patch moves the block_hists_tui_browse from block-info.c
> > to ui/browsers/hists.c in order to reuse some browser codes
> > (i.e do_annotate) for implementing new annotation view.
> > 
> >  v2:
> >  ---
> >  Fix the 'make NO_SLANG=1' error. (Change 'int block_hists_tui_browse()'
> >  to 'static inline int block_hists_tui_browse()')
> > 
> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> 
> for both patches
> 
> Acked-by:  Olsa <jolsa@redhat.com>

Thanks, tested and applied.

- Arnaldo
