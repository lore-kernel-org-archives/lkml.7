Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D5CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8FB20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="lkM2guKl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RDzUfSnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfDDGaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 02:30:15 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56585 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbfDDGaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 02:30:15 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D184221D13;
        Thu,  4 Apr 2019 02:30:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 04 Apr 2019 02:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        kfjYFgGufWc1zpGD9UIRLmTspSPrlbpE+zkk/TTwrE4=; b=lkM2guKlLqZXRrdP
        udqqHdEOip3ijfNWQc1OiulB7wdF6xh0+Jq2MloFS2RYIAnIomlE8qc6HbMdk+gS
        /p1M79k6Ih9HFt1p8TL5mXQIdKQndV9bnTy0N6u4j6N8K5XnfJEBpB+N7Gip1NOG
        zZ3S1UUVBwLGDQFXqpnvxCbawR20/L/1bnK59cFFy4WfzWr349o2NQb7JM0k13ib
        MHt+00uoM9KCQh8H1dKW1W5Z2TjC8ahp63s3nN46y2bizIEiLZxSy3Dk6+LynZ/Y
        MvIvQh90nrg3vn5CbmLrwsJWQko7Cf9wpxUKHgvuGtlvKgLmzn6Lp6z9qVLbABZK
        jRBS0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=kfjYFgGufWc1zpGD9UIRLmTspSPrlbpE+zkk/TTwr
        E4=; b=RDzUfSnbSCF5+/4jSDF9lJQ6Kpynrjbu1GUe3J5cc7s3OMK5zCI85JE4E
        YN1FHbNZfajtdrZYuu/D7d4KI67h+fca/dPj4AfWFTQ1Ux4+F+rP4qu1m7yvGOgA
        /MnE6VJWmdoR66iEAQ0S/TNfQtKq+e26aIRyT+isJZHxbFDEy+YxdUo8Aven+of0
        yy+ccpblpvoUMcjWhEiUXwXIqs9GAPTrGkbDi5U9NRVAXqSDLkMGVRRC7TfaVI5P
        12WdS801rpLr/nKVEvS8IZEJbLHF4HbGED/sIPMbiA8Bc7zvyY3Dx9wsMy50irOd
        Ds+gyVfR3n9JOTCW3mP93xFkSUnTw==
X-ME-Sender: <xms:dKSlXGSvpeqXcKPQYsDoQqKBM9TKfs7-ALx_XS_C8yz502EZhrBsAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtdeggddutdehucdltddurdeguddtrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkffuhffvffgjfhgtofgggfesthejredtredt
    jeenucfhrhhomhepkfgrnhcumfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqe
    enucfkphepuddukedrvddtkedrieefrddvfedvnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehrrghvvghnsehthhgvmhgrfidrnhgvthenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:dKSlXHkNoUDokqbVDI7tnAPJ9Oxo6IsDvBr4Potszrl9GvzVdRdh8g>
    <xmx:dKSlXJWwv28XTWmawBpQCvVf_RxtOYl61xGDkpNCreU7WQJbVq8nAQ>
    <xmx:dKSlXEcpnEImL7FpaxCCOGDiM12oNBlWzrWSgNtD_eSOErQzty9jWQ>
    <xmx:daSlXA8_XaBgMKvBeYIuEZaiVMC4NKnPWL_FO2VkbW4vqtW5VkmvtA>
Received: from pluto.themaw.net (unknown [118.208.63.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id B59DBE452B;
        Thu,  4 Apr 2019 02:30:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by pluto.themaw.net (Postfix) with ESMTP id E8FDD1C0165;
        Thu,  4 Apr 2019 14:30:07 +0800 (AWST)
Message-ID: <152693a75ada9f5eb3242f1b15694556078d352f.camel@themaw.net>
Subject: Re: [PATCH v3 00/24] Convert vfs.txt to vfs.rst
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@zeniv.linux.org.uk>, NeilBrown <neilb@suse.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 04 Apr 2019 14:30:07 +0800
In-Reply-To: <20190403193523.GX2217@ZenIV.linux.org.uk>
References: <20190327051717.23225-1-tobin@kernel.org>
         <20190402094934.5b242dc0@lwn.net>
         <20190402164824.GK2217@ZenIV.linux.org.uk>
         <20190402175401.GL2217@ZenIV.linux.org.uk>
         <20190402190811.GM2217@ZenIV.linux.org.uk>
         <5c5e02f8b8add4aa2fc24ba2a0880652529588af.camel@themaw.net>
         <87ftqz29i2.fsf@notabene.neil.brown.name>
         <20190403193523.GX2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-03 at 20:35 +0100, Al Viro wrote:
> On Wed, Apr 03, 2019 at 11:55:01AM +1100, NeilBrown wrote:
> 
> > It seems very likely that this was just a subtlety that I missed.
> > I doesn't help that "ino" isn't actually and inode and isn't freed like
> > an inode, but that is no excuse.
> > 
> > When we add the rcu_head linkage to 'struct autofs_info', we might as
> > well remove the 'struct inode' from there - it doesn't seem to have been
> > used for years.
> 
> Umm...  I can do that, but then we get greater potential for conflicts
> and the whole thing might be better off in autofs tree.  Ian, up to you -
> I can throw both into a never-rebased branch, so you could merge it
> into your tree; the first one is -stable fodder, though...

Ha, as unlikely as that usually is, given the low churn in the autofs
code, conflicts might be a problem.

I'm likely to change the autofs info flags field to unsigned as part
of implementing a suggestion from Neil (quite some time ago now) to
fix the AT_NO_AUTOMOUNT handling.

So I'll hold onto the patch to remove the inode field, include it as
part of that change, and forward it as low priority via Andrew.

I'll send your rcu free patch back to you (with an added comment in
the description) as a higher priority change.

Ian

