Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96380C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECCC20684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="p34Wd6Th";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dNnI+ALy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfCHE5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 23:57:45 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:39607 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726250AbfCHE5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 23:57:44 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 890B2369B;
        Thu,  7 Mar 2019 23:57:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 07 Mar 2019 23:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=o2MepDzSP35m0IiRL/9IyDqlu2i
        fmBOioFrdhQpCCc8=; b=p34Wd6ThiD7bDjxFY+xZ0ykeyvQbBHAGizyfm4/5p23
        FPq+C9zaUqKTg8TMgXYugJb93HwXchptCg5SFgO5l0uuPEGJsWu+44h6vc4oSFfn
        +Ld5ne/OlBkGrYcfuQgr7SpcTq1jdaDpRJ01ghYfJLtjeBeSx7tSh31BkhhhuTlC
        cglx9CbdsZ9xTWQUKWPdvudXy+LaF9iRHWgH7Ass5ntNnHQf5Q8jWkKbALlhdj37
        SGZtFQfSbX7duajz4Ueed56dGtRDuKXeKhZgBgA/1vkHGPY0bPoy4MZo1aFfz4IB
        GyU93vRjiLU0lLIS5LMIwR7VhO9SP0YEF8dM6RB/UCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=o2MepD
        zSP35m0IiRL/9IyDqlu2ifmBOioFrdhQpCCc8=; b=dNnI+ALy0gyMsbBt/1GHRs
        nNM9ujddCChzZouf2dmBWohvKcryzfAvS4ScFS1U8rVh1LWEs6DfJzra55G0ckxF
        aZ6xyQICU5bG78aFprQ+yqdrr5xb2XbR0taI0f5DLyvnpQScmy38raQi7wcb9unj
        2whGpvbX/rQG96Dr2Pu6BaM1Wm3tpkS2TQurwt7Egz7zMbDTdura3rls4zfA2bCz
        WKZDWYK+CTz8wpkHMdDIjQncpNLMIeO4Aa9DZwVlxfZ+ClBJj62T9l/AhZvWmp4M
        UJkEPDEHcL9ZV3MdC4MH5JVPOxKoRKsgKLQqjwfcM9a10Q3iqfW+gKJkffp/CvEw
        ==
X-ME-Sender: <xms:RvaBXKmfh0aBEtfFzD7myewcupgvIpFdo4o2BaQbDobdbD82_730KA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeelgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdduhedmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfkphepuddvgedrudeiledrhedrudehkeenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:RvaBXJvbp7lW87E_cwBy1w6C-YuSIZiKnXKj5GpYfWkoZMe6PCoKKw>
    <xmx:RvaBXIAiXWy7Y3HqmJuRXsRmT3qQHXStHEjcEITdcHBRkQ5XyB19UA>
    <xmx:RvaBXGU4-LLoAbcCL6gsssQZtQNVW_9weDby6yQjhWDDN9kmSO8LwQ>
    <xmx:R_aBXE8DALOEnvjci6K_e6fsmXEXncoquILxhbQ6wow715S-fVapQQ>
Received: from localhost (124-169-5-158.dyn.iinet.net.au [124.169.5.158])
        by mail.messagingengine.com (Postfix) with ESMTPA id B9AA91030F;
        Thu,  7 Mar 2019 23:57:41 -0500 (EST)
Date:   Fri, 8 Mar 2019 15:57:14 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] docs: Fix Title underline too short warning
Message-ID: <20190308045714.GA17221@eros.localdomain>
References: <20190307211153.28400-1-tobin@kernel.org>
 <20190307211153.28400-9-tobin@kernel.org>
 <a195b380-4be4-512d-0a24-9f83082b9d83@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a195b380-4be4-512d-0a24-9f83082b9d83@infradead.org>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 07:42:03PM -0800, Randy Dunlap wrote:
> On 3/7/19 1:11 PM, Tobin C. Harding wrote:
> > Sphinx emits a bunch of 'Title underline too short' warnings.  We can
> > fix these by using the correct length underlines.
> > 
> > Fix Title underline too short warning by amending heading underline.
> > 
> > Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> > ---
> >  Documentation/filesystems/path-lookup.rst | 24 +++++-----
> >  Documentation/networking/snmp_counter.rst | 58 +++++++++++------------
> >  2 files changed, 41 insertions(+), 41 deletions(-)
> 
> Hi,
> 
> These are already fixed.  Did you try the pending docs tree
> (for which a pull request was sent a few hours ago)?

Oh man, - face palm.  I've been hacking on mm lately and they use
mainline, thanks for response.

	  Tobin
