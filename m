Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273ECC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7DE2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K4xDAq9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfCRL5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:57:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33178 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfCRL5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JAz+Eu34UwsmzIzg1ee3czANBIDalcEvehwlmxNHZZ4=; b=K4xDAq9i1XlK0BR03pv2D4au+F
        fC1v6Ffc9q1M4k9lN2Fgc7gr19Gk5Mmi6/t0Tj0GZNZKA1MUz3s5a+ay1Rpz6PH9PL7VSp8Ft2Nda
        DJobNWPhrwalFpJvlUyVpR/OLwYBQnViwvu6KJUUVwrBcLX15jDUw7a7ekzSFJFgg2wnRWkR2i+Op
        6yKGHzsRZTMEvyqA2i/7Na0dGRmWjSCDs/srHyyVGo8I2ISA66Ez49jmZXN8btA1U46qKFafaTYt/
        9KBcKwVQ5llWVbyVrPQBTR82sFe0VyjUTc9Al0s/XgQZgTWby3LCVAwPopk7r10vnA19by8ChjSGn
        4Le3Ga9w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h5qtX-0008Ka-IP; Mon, 18 Mar 2019 11:57:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DD84F202194F4; Mon, 18 Mar 2019 12:57:28 +0100 (CET)
Date:   Mon, 18 Mar 2019 12:57:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas =?iso-8859-1?Q?M=FCller?= <thomas@mathtm.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: disabling secondary CPU hangs / system fails to suspend with
 kernel 4.19+
Message-ID: <20190318115728.GP6058@hirez.programming.kicks-ass.net>
References: <5c48095e-028a-404f-aaa1-964f83c83817@mathtm.de>
 <20190315090950.GT5996@hirez.programming.kicks-ass.net>
 <cbaafd35-a17d-8331-4cef-281a562b91b5@mathtm.de>
 <20190315121541.GD6058@hirez.programming.kicks-ass.net>
 <2b1c85d3-d94b-1593-e30a-a32d97043579@mathtm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b1c85d3-d94b-1593-e30a-a32d97043579@mathtm.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 09:21:02PM +0100, Thomas Müller wrote:
> I've just re-tested with runlevel 3.
> Not a real VGA console, but at least no Wayland or Gnome to interfere...
> 
> `echo 0 > /sys/...` just blocks and no message whatsoever is visible in dmesg.
> 
> I've executed `echo 0 > ...` in the background to keep my console functional and I can e.g. echo
> something to /dev/kmsg and it shows up, so reading/updating the log buffer appears to be working
> just fine.

Damn.. Thanks for trying. I'll see if I can come up with something, but
I'm out of idea for now :/
