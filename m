Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735F3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458B120675
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="es4z+Xbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfCDSOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:14:51 -0500
Received: from one.firstfloor.org ([193.170.194.197]:51714 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfCDSOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:14:49 -0500
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 44D6186862; Mon,  4 Mar 2019 19:14:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1551723288;
        bh=En25mHiy37yuHednDGPhpoa0IwCcj2T12xmdYSdz5R0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=es4z+XbfozD6iEYzm1Sn8stByTh3GZUVEcalhgHhrDkOwL8dPm1peu1JX18to8mbv
         zixzy9RlfNSZXwk9AGKarhldWzYPHe4AxgSNdLB8jHaDr6Kb14jWdxFrw7A1WIUA9x
         6SRfQQiMuMzj9h9Y1iLlWqjk9Sk1dq9XYfBao0fc=
Date:   Mon, 4 Mar 2019 10:14:48 -0800
From:   Andi Kleen <andi@firstfloor.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 02/11] perf tools script: Support insn output for
 normal samples
Message-ID: <20190304181448.bnuwf2gvtxdgs7tg@two.firstfloor.org>
References: <20190228183550.14126-1-andi@firstfloor.org>
 <20190228183550.14126-3-andi@firstfloor.org>
 <20190304144832.GI30476@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304144832.GI30476@krava>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +	uname(&uts);
> > +	if (!strcmp(uts.machine, session->header.env.arch) ||
> > +		(!strcmp(uts.machine, "x86_64") &&
> > +		 !strcmp(session->header.env.arch, "i386")))
> 
> why is this check and native_arch bool necessary?
> i386 data will be overed by arch/x86

This is so that e.g. if someone displays an ARM perf.data
on x86 it won't try to decode the ARM instructions as x86
instructions.

It also assumes that noone parses 64bit x86 on 32bit,
but I guess that's ok.

-Andi
