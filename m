Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C264C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 13:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE19206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 13:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LERbCEOA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfLWNCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 08:02:07 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41421 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfLWNCG (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 08:02:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id w62so9155220pfw.8
        for <Linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 05:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GaISKcfuoZ8Txmn3wakJNX/get7WYsJOfMPMfdR40RY=;
        b=LERbCEOAkIEthwjWP+Vsyw1dmE3eaR2gTE7akomPqnb/XUN1ur5E7ZTI2YIR5IWxU5
         WpHPajckSqfU7dXoWamIf638DS1phLksJCseehpWOaSIPHFi6JTa55NVe32rfnYBlXhT
         mqlvyeF1OFVWR7o3G0MkgoEq3UnMG10OZPXXG2F7QG+pGNRy5ZjY+3og6aMTmAbnomMH
         Z4D/6bs7dIu8vqx1WX56SKanP5AvYhkpz2dVaX3yf6SLcGPm9cJXJGflAOotIZNqFZBq
         JCTiMjlHNMa1m6vyhacHpbtf0jjvY8FJtiRoB6FWGluuoSRRG6o93ic3JF5vdGK4R8wU
         E/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GaISKcfuoZ8Txmn3wakJNX/get7WYsJOfMPMfdR40RY=;
        b=alnlEdu7/auahjKHxbVDUHOsVxaGI3i98bO4ZkOo9SuyNNkHC3yJkEbolL5WvljxhN
         EjsiVsdQcD4Sc+uxNUw5fOlxmYWhILpCUN66rYVw39f94RnvozLOAVhRvn6UuMjQYbI9
         yPz2ZW8BaeubZTRmZ7ahmKrnJtCITsNNk3MSpe5JbdtdWq5ru8HCMFIdILRywb41rwOW
         qHXgSxrg9tvpl2HhqmPQ9iSCpvfLPcB/O1PYE/wX6qSqFt2EUi0Ouk1v48B8KGUahZ34
         A1g89sC5LBo2kp2x0+wUXTRabDOiRbUInkv+mH1WWZGccpXepo4e8ZXUjKEGIRiEfGaY
         ZPcA==
X-Gm-Message-State: APjAAAX9VP6RqP250ELUc5wTP+TdKwQsGhs5giWXkSXL1YZ6gGUy7UFC
        pCH8vtErsGq86R90okazyFU=
X-Google-Smtp-Source: APXvYqxP1quNjXArzs/y0tnN7oQqj0eiuS513JKrpPHfKWs5hNK3C30CT1KF+4W298YeBHH8fJP+3A==
X-Received: by 2002:a62:e40e:: with SMTP id r14mr31917469pfh.115.1577106126199;
        Mon, 23 Dec 2019 05:02:06 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id f8sm20820787pjg.28.2019.12.23.05.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 05:02:05 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7CB1440CB9; Mon, 23 Dec 2019 10:02:02 -0300 (-03)
Date:   Mon, 23 Dec 2019 10:02:02 -0300
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v6 1/4] perf report: Fix incorrectly added dimensions as
 switch perf data file
Message-ID: <20191223130202.GD9076@kernel.org>
References: <20191220013722.20592-1-yao.jin@linux.intel.com>
 <20191220163438.GA18798@kernel.org>
 <7d517778-3edc-eeab-587a-ad09db978647@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d517778-3edc-eeab-587a-ad09db978647@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 23, 2019 at 08:55:00AM +0800, Jin, Yao escreveu:
> 
> 
> On 12/21/2019 12:34 AM, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Dec 20, 2019 at 09:37:19AM +0800, Jin Yao escreveu:
> > > We observed an issue that was some extra columns displayed after switching
> > > perf data file in browser. The steps to reproduce:
> > > 
> > > 1. perf record -a -e cycles,instructions -- sleep 3
> > > 2. perf report --group
> > > 3. In browser, we use hotkey 's' to switch to another perf.data
> > > 4. Now in browser, the extra columns 'Self' and 'Children' are displayed.
> > > 
> > > The issue is setup_sorting() executed again after repeat path, so dimensions
> > > are added again.
> > > 
> > > This patch checks the last key returned from __cmd_report(). If it's
> > > K_SWITCH_INPUT_DATA, skips the setup_sorting().
> > 
> > you forgot to add this right?
> > 
> > Cc: Feng Tang <feng.tang@intel.com>
> > Fixes: ad0de0971b7f ("perf report: Enable the runtime switching of perf data file")
> 
> Yes, I should add this in patch description. Thanks for reminding
> 
> Do you need me to resend this patch-set (v7)?

Nope, I added it myself, thanks.

- Arnaldo
 
> Thanks
> Jin Yao
> 
> > >   v6:
> > >   ---
> > >   No change.
> > > 
> > >   v5:
> > >   ---
> > >   New patch in v5.
> > > 
> > > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > > ---
> > >   tools/perf/builtin-report.c | 5 ++++-
> > >   1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > > index 387311c67264..de988589d99b 100644
> > > --- a/tools/perf/builtin-report.c
> > > +++ b/tools/perf/builtin-report.c
> > > @@ -1076,6 +1076,7 @@ int cmd_report(int argc, const char **argv)
> > >   	struct stat st;
> > >   	bool has_br_stack = false;
> > >   	int branch_mode = -1;
> > > +	int last_key = 0;
> > >   	bool branch_call_mode = false;
> > >   #define CALLCHAIN_DEFAULT_OPT  "graph,0.5,caller,function,percent"
> > >   	static const char report_callchain_help[] = "Display call graph (stack chain/backtrace):\n\n"
> > > @@ -1450,7 +1451,8 @@ int cmd_report(int argc, const char **argv)
> > >   		sort_order = sort_tmp;
> > >   	}
> > > -	if (setup_sorting(session->evlist) < 0) {
> > > +	if ((last_key != K_SWITCH_INPUT_DATA) &&
> > > +	    (setup_sorting(session->evlist) < 0)) {
> > >   		if (sort_order)
> > >   			parse_options_usage(report_usage, options, "s", 1);
> > >   		if (field_order)
> > > @@ -1530,6 +1532,7 @@ int cmd_report(int argc, const char **argv)
> > >   	ret = __cmd_report(&report);
> > >   	if (ret == K_SWITCH_INPUT_DATA) {
> > >   		perf_session__delete(session);
> > > +		last_key = K_SWITCH_INPUT_DATA;
> > >   		goto repeat;
> > >   	} else
> > >   		ret = 0;
> > > -- 
> > > 2.17.1
> > 

-- 

- Arnaldo
