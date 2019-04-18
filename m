Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7CDC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C41E2183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0GVjvEhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388216AbfDRHyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 03:54:22 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37080 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfDRHyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 03:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kDr3b0NpE/8L98IMcQ3iMZCfHHX2cZQlRKBZ0T+dq1U=; b=0GVjvEhITMcih+OgrzFavZrWR
        Oay8fNfHXbECBNgS1n/wpstHf4NgjEpqOnvc/4WXOD9Xfc0sSWjbUH3IBd07V3RN51xViq8cQyqu3
        Pg1FsP5Pf49TJ8CaMNWe60rQbYeRkHdL+t5vNsbJQx+xJissAmSnrw3QGL6XviuyVAII2RQD8aNGN
        /sSc7r2hf/D54TGdBosxHFNpJCc62gfKypMah/GhrSdqOuXHVIqlJ15uaSdgWYzKmLr0p4LH4tcS/
        rPIq87QyuL/nMtWh5NpqF005LpMnfgj80QunJulTmrYGNg6zZiWH7yzG8UFWGPon5h5RnIa/iH/RC
        gLAbbkYrQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hH1s6-0000T7-94; Thu, 18 Apr 2019 07:54:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 00B1929BA67E2; Thu, 18 Apr 2019 09:54:12 +0200 (CEST)
Date:   Thu, 18 Apr 2019 09:54:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kairui Song <kasong@redhat.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>
Subject: Re: [RFC PATCH v2] perf/x86: make perf callchain work without
 CONFIG_FRAME_POINTER
Message-ID: <20190418075412.GO12232@hirez.programming.kicks-ass.net>
References: <20190408165942.23640-1-kasong@redhat.com>
 <20190415153622.GG12232@hirez.programming.kicks-ass.net>
 <20190415165859.ul7i2w3lai3umgik@treble>
 <CACPcB9f8OJmk++54YwW3yhrnohj31+oJcxfesJbNbNSGk9WUQQ@mail.gmail.com>
 <CACPcB9f0D4SdJLAtUs4vYwduBiPYDpa-y8r7jracYy=sAJmo5g@mail.gmail.com>
 <20190416201559.d267liiwpjvo3wet@treble>
 <CACPcB9cuvNt-+gw8_LzqDLZ-nZ+G_zLcSv6nftNONrYxVRx=wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPcB9cuvNt-+gw8_LzqDLZ-nZ+G_zLcSv6nftNONrYxVRx=wg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 10:44:33PM +0800, Kairui Song wrote:
> Despite it's hacky, it seems not necessary to dump every register. And
> is there a straight way to get caller's regs in the trace point? It
> seems more trouble some. Or if we just use the regs inside the
> tracepoint, but it would need even more workaround (eg. unwind one
> frame before do anything).

Sure, and the current code doesn't fill out every reg either, but given
SAMPLE_REGS_INTR I think we should at least clear the entire regs before
passing it on, or otherwise make sure SAMPLE_REGS_INTR isn't allowed on
these events.
