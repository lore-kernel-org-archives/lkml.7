Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13910C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65D1214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBIzRom5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbfLKNfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:35:31 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:35906 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729513AbfLKNfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:35:30 -0500
Received: by mail-vs1-f67.google.com with SMTP id m5so15757404vsj.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 05:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nut54jUOYsIhk4qViC4XVDIxlW45rlCs+EHwyAwqe40=;
        b=nBIzRom5k4Mrc6BitdE/5rfkiUZr2BujDTrgZeWAKjv+HxXsU/3Z5I5mhErQptLkc0
         24RL8ClTKKjCyzQUPBPEZ/ezvb+MBwf/c5YlY+2mHOtHQofBlzRjaCEFRvGvvJ5Zvo58
         mhX8Mj+RzyBJaCHDGbbzRy908Z4NyZ9MYqiqjyq3PnsGKbP1jbZ3FtX3hGWfqZ9YD+12
         BgnGhcezgGeOXkvEJ9qjwt5aFCTkaaFp5SEriFkpi/8xNmEqTMygIgMEp01hETmwDzmA
         wNeNT76RqNDrITQ6w0zxSQIEv9H75FifEwTt4UFzfNZKO9ztIwO/T2pSB1XBSz9Rmbpb
         KfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nut54jUOYsIhk4qViC4XVDIxlW45rlCs+EHwyAwqe40=;
        b=f0V4pUGtGlRL68iGNrKUdSVxtCD8wRs7fo0oXDrnxKeFuUZwltlvFhebtSwqBgwKmP
         6u/Ok2+S8TuZk69wAiTn5HQv6Unq+HeEk85Yz4MTuw1lENWI8A/UYnV0Egoht10JGtwb
         p1czOwTRMajJJMsvWV9baLw73MWQFsbkcK6sGKVfzll2ik81E/EMYOeyqbQ2XhAhLkOF
         qkmnW79bxHLYzi0IieqmySgXSHsdfxg7BeQN/q77ewz4D/Ba9U9Zf50bxzu1f89Apa/A
         QZOysl+2IrB66teQv8VV/Qse80+dQD9IyqqTrO6TZG68fGByOkybJD2wTZmWqC/tPfZa
         rofw==
X-Gm-Message-State: APjAAAUWCWE71rffvZPaKwbQgDjReEhJ8yuQkF3BO12WfdcnPHPCtqNF
        fndv5Nuz5LPXWKaU30glm8k=
X-Google-Smtp-Source: APXvYqxHPyqYF+xo+iYGNDO55xzNLv249CESqPnwUHXjWy6ZmTQotJluO+0dDW/LCsI3TVcvfmbUiA==
X-Received: by 2002:a67:e00d:: with SMTP id c13mr2540964vsl.57.1576071329713;
        Wed, 11 Dec 2019 05:35:29 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id l23sm1419267vkm.34.2019.12.11.05.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 05:35:28 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C39B840352; Wed, 11 Dec 2019 10:35:26 -0300 (-03)
Date:   Wed, 11 Dec 2019 10:35:26 -0300
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        haiyanx.song@intel.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86/pmu-events: Fix Kernel_Utilization metric
Message-ID: <20191211133526.GB15181@kernel.org>
References: <20191204162121.29998-1-ravi.bangoria@linux.ibm.com>
 <20191206162940.GC752382@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206162940.GC752382@tassilo.jf.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 06, 2019 at 08:29:40AM -0800, Andi Kleen escreveu:
> On Wed, Dec 04, 2019 at 09:51:21PM +0530, Ravi Bangoria wrote:
> > Kernel Utilization should divide ref cycles spent in kernel with total
> > ref cycles.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Thanks, applied to perf/urgent.

- Arnaldo
