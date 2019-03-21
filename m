Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4508C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB16421917
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="ysgKI+EA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6pOTW+j0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfCUXgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:36:36 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:51367 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726555AbfCUXgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 19:36:36 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Mar 2019 19:36:35 EDT
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 65367247E5;
        Thu, 21 Mar 2019 19:29:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 21 Mar 2019 19:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=ImA9Z06R/50k8H3at+XhqlWnLjA
        GXJst6Gjj/b/gR1o=; b=ysgKI+EADcTfFJ467W1qq/1zARCrXYTw2UVuY+zsGBm
        3doT5dd8RuXrT13ufHt1V5DZAgsMMQaridkGE40WxjqchflEyRIDcgajqFzCo05a
        YJb3UHA6DGn7861V5AiZ3BSVWOrsgunpOTNLEzVhBurN08xK/HyDDkPR5L641CG0
        TX8TzqMD3DBHxNSb73MXFBrCzbnkaSulCTNJPMXrLjksgVokbCntRUb4GKwmaysZ
        aQ4BbWNqNhj2VipjO+5LjBAWfzIrAvxY9iQE6wcNnG+81tsvSWNBAeb78XOB1KIO
        CD/c0u5FBDaZW/lCDB81N3T6BLmnNqzMmf0IxonVJkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ImA9Z0
        6R/50k8H3at+XhqlWnLjAGXJst6Gjj/b/gR1o=; b=6pOTW+j0DlDfNapjvf9C/7
        OwiPss6J7BrBVescn/iRQII4WQTgyJEyJCfkYEvRB6eZZKAT/GdySp80DxcZMeWb
        mtPCGQnjTyKNOa9c3oNqLd6AQSG3lA7G2k3QFuvBbsO17Y6+SQgvTWpg5DrCRs/X
        xQntVzeIywsq9ILg9t26RYKzME2e/76+KadxX/jLvIB4vhoXIiVrSyNGBDlo1UWD
        sKnK9HWCfR7SyLhQGFwUBbjr544e5WuIubjlqIDSmamvR6ZGHdWu1tOuSdFUP290
        qI3qfeIkpJFsRnfakiOhm/vHZxlIDLwoQ/f3r17tLxdXzm9b5vZl0QQYnSN0FhZw
        ==
X-ME-Sender: <xms:cR6UXCeml4LTLJ-YcVPDA44DgM0XaSNzCm3pkB-lRrCpi3aHXyEZQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrjedtgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdduhedmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfkphepuddvgedrudejuddrfedurdduhedunecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:cR6UXIEIiiDEckKnSPtbc6OYZ4G7eTv8swrdfQHWsCiaV94uv30ezA>
    <xmx:cR6UXMWVMQXQfXRwx5kpx-39I61JAWe_foCgV1C36dVSsso4HyzZrQ>
    <xmx:cR6UXIwVEHk6v78eEee7Zm2r6jQZZX9OTSR-QTfNzBSdH11bUQir4w>
    <xmx:cx6UXM13f7YIHlwsjiX-KJ38tecQuKCyq8xCiRUXphkO7foh4GsPZw>
Received: from localhost (124-171-31-151.dyn.iinet.net.au [124.171.31.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2E384E4807;
        Thu, 21 Mar 2019 19:29:52 -0400 (EDT)
Date:   Fri, 22 Mar 2019 10:29:25 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Joe Perches <joe@perches.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH v2] docs: Clarify the usage and sign-off requirements for
 Co-developed-by
Message-ID: <20190321232925.GA17705@eros.localdomain>
References: <20190321184316.8525-1-sean.j.christopherson@intel.com>
 <20190321192341.GG6519@linux.intel.com>
 <0cc879a63943b57b62caddce6866b83a14b42c14.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cc879a63943b57b62caddce6866b83a14b42c14.camel@perches.com>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 03:47:26PM -0700, Joe Perches wrote:
> On Thu, 2019-03-21 at 12:23 -0700, Sean Christopherson wrote:
> > On Thu, Mar 21, 2019 at 11:43:16AM -0700, Sean Christopherson wrote:
> > > The documentation for Co-developed-by is a bit light on details, e.g. it
> > > doesn't explicitly state that:
> > > 
> > >   - Multiple Co-developed-by tags are perfectly acceptable
> > >   - Co-developed-by and Signed-off-by must be paired together
> > >   - SOB ordering should still follow standard sign-off procedure
> 
> While I still think co-developed-by: is unnecessary and
> almost none of the existing uses of this have this
> sequence of "Co-developed-by: <name/email>" followed directly
> by "Signed-off-by: <same name/email>", here's a possible
> checkpatch addition for it.

Tested-by: Tobin C. Harding <tobin@kernel.org>

Catches missing SOB of co-developer.

Hope this helps,
Tobin.
