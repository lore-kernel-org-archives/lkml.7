Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AEDC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 21:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85278206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 21:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577136522;
	bh=FwprHTWA3e+j5M0+cUZLFur2Eu/PTjbpCi3IFtAYlmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k3aemb9cXXHzmJS7WZqFPIwGjXxlgDX9v4s3cyij6wx4s9UxBK1hYhjjvTDHcGIg1
	 z8vRSwvl8HEH4lWh0vyIt4MHToy4rjs4XzjM3O/Nrkj+ROkOcEfdnSPAGPLDewwgL1
	 mSBGWBvxDhdeuLobKOBtWP7ERdDXuFmGBnXiMH5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfLWV2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 16:28:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35023 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfLWV2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 16:28:41 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so18028956wro.2;
        Mon, 23 Dec 2019 13:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KuknNIl0qwZ9lDW18Ad2e/waouhfPLOqjnWfPl4Ddrc=;
        b=XRkWpLa+lChkTAnsXRGCu/afS6BM6UtEYQcfs8TpKsOCPjKy+O+iYZxur+QwkIYte5
         xlpbn2MsQb1EC4fG2IrG6h+APBtEuFu5G6hT1M1Ge57yYxtTR5zEhMWN7ZcGgxzOepke
         sAUeCI+EJYHTBpmQnmjZ/Kky5UImvgOaaaVltOrQ25SbOtsn+NwzL1VI0T/M8LHPqdeI
         lAUtDn6bdm7M4RHjo5rRI7YKwX4AtCnzKEooE3sNrDtd8b3Okdj0V7/euxeWnB6kOidl
         tSeb+t8qoPYIOfHTPb8fQ56LnB+0vjr82rqJITLeXLdr4Ov3eACcqVAJm0ZP/46Q47dB
         weNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KuknNIl0qwZ9lDW18Ad2e/waouhfPLOqjnWfPl4Ddrc=;
        b=QIgNIr3aWisLCgup9ILT4CXTlhmnEvlEoweMkeDXLzJTLauzw5pJfYBSUeW2x0/89y
         skX2ygrCqbKE3KlcxuZ8Ichn1J6uDkEFW2U4b0Ufo5UN9sj16W5AhJb6z7lnM5ADnpzU
         foFaUMBc3HP3OMuXTPUJdVF06W/oCxpPhmKY7Iey0TTLIuoQXHYrv5xD0XW8xRUudxCP
         8aoD2ASPBPLD8SGsjRuxn+QcMAFnnrzJcSmoFqY6JmAWhLQd6jaTRpcpirDU85MIPG9e
         m+gUl2JOqcUaoEinebivNhFxBa5nvjcPZgOC6TuRxsRmi6agW3Uv9TCabKVE0tq78lf/
         +t0Q==
X-Gm-Message-State: APjAAAVh1HvQolbgH9b630DoPLENg67S57s6iAgPZnalEXBoofI15CJQ
        LhyAJG33hHHzDwxGQd9RgsU=
X-Google-Smtp-Source: APXvYqyzP5CE4TBl1khzfYh6SxC1lMftduSoggfM75zkHmVzZEUCiahRTgGYkTdaT0TKEF4tjV+6YA==
X-Received: by 2002:adf:a285:: with SMTP id s5mr31386252wra.118.1577136518962;
        Mon, 23 Dec 2019 13:28:38 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id u8sm598572wmm.15.2019.12.23.13.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 13:28:38 -0800 (PST)
Date:   Mon, 23 Dec 2019 22:28:36 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Hewenliang <hewenliang4@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Yuya Fujita <fujita.yuya@fujitsu.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/urgent improvements and fixes
Message-ID: <20191223212836.GA24434@gmail.com>
References: <20191223133241.8578-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223133241.8578-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo/Thomas,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 9f0bff1180efc9ea988fed3fd93da7647151ac8b:
> 
>   perf/core: Add SRCU annotation for pmus list walk (2019-12-17 13:32:46 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.5-20191223
> 
> for you to fetch changes up to 55347ec340af401437680fd0e88df6739a967f9f:
> 
>   perf hists: Fix variable name's inconsistency in hists__for_each() macro (2019-12-20 18:58:13 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> perf report/top:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Fix popup menu for entries in main kernel maps other than the main one,
>     e.g. ".init.text", where a non-initialized pointer was causing segfaults.
> 
>   Jin Yao:
> 
>   - Fix incorrectly added dimensions when switching perf.data file to another
>     via the popup menu.
> 
> libtraceevent:
> 
>   Hewenliang:
> 
>   - Fix memory leakage in filter_event().
> 
> perf hists:
> 
>   Yuya Fujita:
> 
>   - Fix variable name's inconsistency in hists__for_each() macro.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (1):
>       perf map: Set kmap->kmaps backpointer for main kernel map chunks
> 
> Hewenliang (1):
>       tools lib traceevent: Fix memory leakage in filter_event
> 
> Jin Yao (1):
>       perf report: Fix incorrectly added dimensions as switch perf data file
> 
> Yuya Fujita (1):
>       perf hists: Fix variable name's inconsistency in hists__for_each() macro
> 
>  tools/lib/traceevent/parse-filter.c | 4 +++-
>  tools/perf/builtin-report.c         | 5 ++++-
>  tools/perf/util/hist.h              | 4 ++--
>  tools/perf/util/symbol-elf.c        | 3 +++
>  4 files changed, 12 insertions(+), 4 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
