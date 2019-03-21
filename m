Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067DCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0238218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 10:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553163035;
	bh=zPBuMhBTiWCN8xcm4tLltRZrLNDT95AiZ8MJKPJAp48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kRYtf1ozjD6hO53HgKsTGYDwdzUjOFYaWFwZY2Sx+dhlsfI7uCnjPfGlobF8fdhRN
	 2jbN6AhQLIkTSKexD6uiM6gcMWMlkYcHsBhZaXXVo4lVlhLbcYw8CpjQI8I3kGq/ie
	 kNCj7vb/qqrv8P4ejWVthozpCrGnte5Zul1sg9JQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbfCUKKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 06:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728253AbfCUKKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 06:10:34 -0400
Received: from localhost (unknown [95.98.27.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C4A7218D3;
        Thu, 21 Mar 2019 10:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553163033;
        bh=zPBuMhBTiWCN8xcm4tLltRZrLNDT95AiZ8MJKPJAp48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IE16c0zRBz9CulnN7rcYEddhgzvqRcj3MHvtS9IO/TY1S15pajm6gpIzCddhq40TL
         J3545vlpnl2xTxYqQ5iTYEX4ZiI6Z0NW/6t5pBPvXjPQyLyvtAkiYXehejE5gM1pxZ
         CCs6xTNHrpXxPMKtTLDinE+K4LBbpWTzMFhyz5W0=
Date:   Thu, 21 Mar 2019 11:10:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        luto@kernel.org, Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Xu Yu <xuyu@linux.alibaba.com>, peterz@infradead.org,
        mingo@redhat.com
Subject: Re: [bug report][stable] perf probe: failed to add events
Message-ID: <20190321101029.GA3650@kroah.com>
References: <1a4240a8-288b-45d0-073d-d5cb8f0c63eb@linux.alibaba.com>
 <20190226090505.GA24409@kroah.com>
 <c7ccd9cb-3a66-98a9-faa1-7ee5ed20ff88@linux.alibaba.com>
 <20190226130802.GA10343@kroah.com>
 <20190226142009.GC26786@kernel.org>
 <3b233ff2-e87a-1c61-d516-6c4cdecb4f01@intel.com>
 <8e798942-0e71-c88f-866f-88e55177e286@linux.alibaba.com>
 <fea29ce5-b410-27cc-045e-feeecbc4a7f5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fea29ce5-b410-27cc-045e-feeecbc4a7f5@intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 09:19:08AM +0200, Adrian Hunter wrote:
> On 28/02/19 4:07 AM, Joseph Qi wrote:
> > Hi Adrian,
> > 
> > On 19/2/27 20:39, Adrian Hunter wrote:
> >> Seems to be fixed by this:
> >>
> >> From: Adrian Hunter <adrian.hunter@intel.com>
> >> Date: Wed, 27 Feb 2019 05:35:25 +0200
> >> Subject: [PATCH] perf probe: Fix getting the kernel map
> >>
> >> Since commit 4d99e4136580 ("perf machine: Workaround missing maps for x86
> >> PTI entry trampolines"), perf tools has been creating more than one kernel
> >> map, however 'perf probe' assumed there could be only one.
> >>
> >> Fix by using machine__kernel_map() to get the main kernel map.
> >>
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >> Fixes: 4d99e4136580 ("perf machine: Workaround missing maps for x86 PTI entry trampolines")
> > 
> > Below is my investigation result before, FYI.
> > the first bad commit (v4.18 ~ v4.19):
> > d83212d5dd67 kallsyms, x86: Export addresses of PTI entry trampolines
> 
> Yes we should add a fixes tag for that also.

So, what do I need to do here for the stable tree(s) to resolve this
issue?

thanks,

greg k-h
