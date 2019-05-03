Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57A9C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 01:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD642075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 01:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="e3nVxBov";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KnDdNtxq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfECB0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 21:26:12 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40971 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbfECB0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 21:26:12 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D91A121E92;
        Thu,  2 May 2019 21:26:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 02 May 2019 21:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=D2oLVdQYiql0cUyr/54+TM5XSJv
        4u98j3rVtHpPPqXs=; b=e3nVxBovcJhMTPbEmnf9VUK8pydq4McsVaOjVV+shbm
        6uRVU5cQBQHlSBvJpmccfgFREkmIPZjZZP2GidVQBcwsYNrDzZkLdsX2UKlAwCEo
        bpK/Zoqy6UzZHPJxIDGGQA1VA5AejmzHXHzGw59mD/8HueYyN6D8Q8IyMWi7Bnfs
        EZLrVZCut12+RzE8CTQ+0gKTdRDb09T3JecE5UZ6lzTXqJ0uLKZzjncWEQrYBkB+
        ZFyFThMAjvvDvA7fx41HP08NWyr5atPHYNjjPiwEDASNLAvpy0DbPuttiQyKnlE3
        tkIXzBooZOIyyEyJp4450MiBXHKOiaHTA5oshRH1dag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=D2oLVd
        QYiql0cUyr/54+TM5XSJv4u98j3rVtHpPPqXs=; b=KnDdNtxqGRpTEw0hmPecEr
        eKvhJNu1ck4EPpyV/VkGrPcd+rb+/lf3RbSh6d8kqaBmq9F9+IIr+4XRfV6jCN5G
        jzZlvhUyfqhe83is+g/fbEADbxLtjonAjf6D+rOk1kHLACERfjMCLsbQSGJBg0IO
        qlmDqOajGFmONbK1SrItl+Zi3jBf6TrrpXo0d8BxLheEOCvnHP0pArRSoK2RXJOX
        /xWWhqmp3j3matstpktdWv4TIcQjC/z474FmUti+6VkdeKtlqu7N3hxphEBwmlwv
        isUbEPq02d54sCJt7eVTyL2l1/P57vPQ9t6reHK90Mx49eCbyBP+0/WzZ75RGXng
        ==
X-ME-Sender: <xms:spjLXJY8BrrjDLXpKguwRGY5U3ft1RrZk0IAyM2VM6TuosxjVPH6ig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrjedtgdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdduhedmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfkphepuddvuddrgeegrddvtdegrddvfeehnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:spjLXEqFg1591WsQ6fw-4A3DwI40MmOoCakG80wAkL6xttBkraFTRQ>
    <xmx:spjLXG8pozUPTwbSWjsa0YItVmM6dS5x6ZCWoS9QU5_mSEjUdSzSzA>
    <xmx:spjLXL9nBfFdG-Yv8_5fHHiQs8xdrnw5y9Ra23iY-f47EA7BMEfF9A>
    <xmx:spjLXJ76OWolid_OFTKaBTXmY8bkThUqpP5k04QVN1_QMD49G179TA>
Received: from localhost (ppp121-44-204-235.bras1.syd2.internode.on.net [121.44.204.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7224510369;
        Thu,  2 May 2019 21:26:09 -0400 (EDT)
Date:   Fri, 3 May 2019 11:25:29 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, cl@linux.com,
        tycho@tycho.ws, willy@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kobject: clean up the kobject add documentation a bit
 more
Message-ID: <20190503012529.GB7416@eros.localdomain>
References: <20190427081330.GA26788@eros.localdomain>
 <20190427192809.GA8454@kroah.com>
 <20190501215616.GD18827@eros.localdomain>
 <20190502071742.GC16247@kroah.com>
 <20190502072808.GA14064@kroah.com>
 <20190502081918.GA18363@eros.localdomain>
 <20190502102224.GA15012@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502102224.GA15012@kroah.com>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 12:22:24PM +0200, Greg Kroah-Hartman wrote:
> Commit 1fd7c3b438a2 ("kobject: Improve doc clarity kobject_init_and_add()")
> tried to provide more clarity, but the reference to kobject_del() was
> incorrect.  Fix that up by removing that line, and hopefully be more explicit
> as to exactly what needs to happen here once you register a kobject with the
> kobject core.
> 
> Cc: Tobin C. Harding <tobin@kernel.org>
> Fixes: 1fd7c3b438a2 ("kobject: Improve doc clarity kobject_init_and_add()")
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> diff --git a/lib/kobject.c b/lib/kobject.c
> index 3f4b7e95b0c2..f2ccdbac8ed9 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -416,8 +416,12 @@ static __printf(3, 0) int kobject_add_varg(struct kobject *kobj,
>   *         to this function be directly freed with a call to kfree(),
>   *         that can leak memory.
>   *
> - *         If this call returns successfully and you later need to unwind
> - *         kobject_add() for the error path you should call kobject_del().
> + *         If this function returns success, kobject_put() must also be called
> + *         in order to properly clean up the memory associated with the object.
> + *
> + *         In short, once this function is called, kobject_put() MUST be called
> + *         when the use of the object is finished in order to properly free
> + *         everything.
>   */
>  int kobject_add(struct kobject *kobj, struct kobject *parent,
>  		const char *fmt, ...)

Ack! (Do I get to do those :)

I'm not convinced we have the docs for kobject clear enough for a
kobject noob to read but this patch defiantly fixes the error I
introduced.

thanks,
Tobin.
