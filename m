Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BEDC10F06
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB6821734
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="U20wl/Gn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5q3b5ahU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfCLBVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 21:21:02 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:52583 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726697AbfCLBVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 21:21:01 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 69B7621AB4;
        Mon, 11 Mar 2019 21:21:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 11 Mar 2019 21:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=MzFQnSxojSJGZnBAYbVx8/TBuxA
        bv7N2dzpm+iEloDA=; b=U20wl/GnbA+DhRERfEIX4096EPnBKloNeqVtrO48olZ
        MbqVUB/YytCjDkBfCEKqtBMREYEk8O01IqANpQ3Dvh7am/UJJLc5WAzpR9Xggd0Z
        TnnWq/kgZIRotlotQU/V0dQbxk8FAtyT6dVSsF0b/Ftyr1DKt++vIfFzHiYGyRMf
        K6w5qAWO/b7c4fnsrKAiKMDJNLsSryrOto5WKWM12o1FYP0X/kzuutNDcD9GXtWd
        2lMUsvMdfpZObH+4Nq3WqrdR60VVkBKrRcIEPvyZK79B8DGaY/6ZZ1Bc+5F0i4Nn
        wcqxAzm/OgMDsMcRKWH51oDH1NQpUF91uRJ8wBtPQXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=MzFQnS
        xojSJGZnBAYbVx8/TBuxAbv7N2dzpm+iEloDA=; b=5q3b5ahUh6DllulQ4lEnhD
        Zp2k6NkYEMX2Mn4XdBaGtwk8OszHvQ8+FlXGcblL0JuQRmk2L+fEP5g0Ce8vyG0k
        NLX9z2S/r6Ir/JhImqb3/LATFF9kBv4uGweDQuL2+qstAVleME1FhN5Yt3C0ytI7
        n8xAlEj1IIqu/y6DV9VA5mc1pz4PB5DY+xVM8leBHcVQDDwFRsQttn2QJuynGCYR
        CqXz1FDufVl2Il2RPvx2/yH7Ye+VKhc7Arkve4kC6vUvtmm+bFjbFymnhhin0l+0
        bUNqvQrsG5G9xNcbxqOniPnt6PlH0O9kNRxLIQqlzx4lFizPwY63VVdEAsfXGO2A
        ==
X-ME-Sender: <xms:ewmHXPMt3jy3UszpPEjEQFQn3CbvWS0vIwf9eOtXaTC9gxT4FZn_AQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrgeejgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdeftddmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfkphepuddvgedrudeiledrvdefrddukeegnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgepud
X-ME-Proxy: <xmx:ewmHXLf-rF9x3iJDM2deh-RVk40rbloi68FzLuoNeR-zHSIZ5XYtmQ>
    <xmx:ewmHXG5sTWH6Uj8DD3AZTRzK_ns0_0Ll4T7Xb0QAMihAsifrvkVPqA>
    <xmx:ewmHXFsRI5x3Zjl3mjARThPpRz4ibOnsaJNhTIWucJr7oJVZ2aUlWw>
    <xmx:fAmHXGpfKmltBDQgAEj666WwjVPqRw_xYBTKlk1eJ-sytniLh7QaCg>
Received: from localhost (124-169-23-184.dyn.iinet.net.au [124.169.23.184])
        by mail.messagingengine.com (Postfix) with ESMTPA id 46AD2E456D;
        Mon, 11 Mar 2019 21:20:58 -0400 (EDT)
Date:   Tue, 12 Mar 2019 12:20:36 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Roman Gushchin <guro@fb.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christopher Lameter <cl@linux.com>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        Matthew Wilcox <willy@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 03/15] tools/vm/slabinfo: Add support for -C and -F options
Message-ID: <20190312012036.GE9362@eros.localdomain>
References: <20190308041426.16654-1-tobin@kernel.org>
 <20190308041426.16654-4-tobin@kernel.org>
 <20190311215413.GB7915@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311215413.GB7915@tower.DHCP.thefacebook.com>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 09:54:17PM +0000, Roman Gushchin wrote:
> On Fri, Mar 08, 2019 at 03:14:14PM +1100, Tobin C. Harding wrote:
> > -F lists caches that support object migration.
> 
> Maybe -M?

Seems reasonable, will use in v2, thanks.

	Tobin.
