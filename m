Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635DEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8F220657
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="yFQTERBa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gaSlVRNH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfCLBRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 21:17:18 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:34717 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725932AbfCLBRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 21:17:17 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8B1B721F83;
        Mon, 11 Mar 2019 21:17:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 11 Mar 2019 21:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=mFeJ0sVhv8hsKz3mq6pT95u7bL3
        p+KNXZeOuRgJHu2U=; b=yFQTERBali8gZIhOwyeVFR2ETEMoMxoZ76UImjh8rN2
        Q2M0MW3u0sNaAxpMfPZHEaeW8s6euwP3220gy5tHwDyM0u1SuFWsBJfOCjAhCufa
        0DlQEreMtNRVlVWr9t7DX5PkKhcJLaqOdYvkX2byGwkdik2Sp1bPdHrf3RT06w4u
        3L/ifh1iMaaeeFajUSkSRddfDG1885EhSAsR1IAW7UGpOyBwaq9AYC2pXFBDFnfn
        L51W3rs40xuRxFiJip69JBY8xRuaufCylyOVd+7UDHY684tMpNfuCM/lUF42Dy0r
        mdggstQ1NHXllOnMcX23ykAYkCvQwiCLLxemxbr1wLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=mFeJ0s
        Vhv8hsKz3mq6pT95u7bL3p+KNXZeOuRgJHu2U=; b=gaSlVRNH3+fb414avRhcNW
        jFoNGf2eiueImUGOCb/aB9HrVzjlrlN+W47GtTr+R+2zxX87XWnKAbm1P++EFdsD
        y5aih/kCfL3mEr/3A+QyJK6155CJt3q4N0+vu6DVy06vWc8f1s+EyaOqmI/BJDYj
        rDdGlv5yM8h0Z02v+rG+ZLIT0SifDhxHAguqRvxG3AfhhUWqcEW2yDvhWoPbT9O4
        C9+xRhfF/fXSvnLH0+4X5P7FmJGgFluA7PF6bWlLv2LTrlExXHyDr1B/87JW7lg3
        xFqOSKea/Hf9rjMoeAYSzIopMnuYGd6MAuqA55IES5gPhgTX/toBBKoEvpdRlU3Q
        ==
X-ME-Sender: <xms:mwiHXFfk9FoIq-SSgNBtRd7d7TPZs6UXRW62mSi9RdCb7TdT5nXh_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrgeejgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculddutddmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfkphepuddvgedrudeiledrvdefrddukeegnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:mwiHXGbAcs5UTKbPKLCZvPXy4vL0dTQVpavxEtuczVRF4IKK12xbxw>
    <xmx:mwiHXFWl7EoHRTwcqtDII1xaWWTkX3JcO7RFNAw6vgTy8LioBPMYBw>
    <xmx:mwiHXEDgOUEfgQFkRo1B8EJO86rhYNwJ3OIYORT8ET_IUV5WY06iYg>
    <xmx:nAiHXNsmF1B7qWpn_Fj39INpzOnDlS3iYcCJjXy4NW96prreUG0UBA>
Received: from localhost (124-169-23-184.dyn.iinet.net.au [124.169.23.184])
        by mail.messagingengine.com (Postfix) with ESMTPA id BE7DA10310;
        Mon, 11 Mar 2019 21:17:14 -0400 (EDT)
Date:   Tue, 12 Mar 2019 12:16:54 +1100
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
Subject: Re: [RFC 01/15] slub: Create sysfs field /sys/slab/<cache>/ops
Message-ID: <20190312011654.GD9362@eros.localdomain>
References: <20190308041426.16654-1-tobin@kernel.org>
 <20190308041426.16654-2-tobin@kernel.org>
 <20190311212316.GA4581@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311212316.GA4581@tower.DHCP.thefacebook.com>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 09:23:27PM +0000, Roman Gushchin wrote:
> On Fri, Mar 08, 2019 at 03:14:12PM +1100, Tobin C. Harding wrote:
> > Create an ops field in /sys/slab/*/ops to contain all the callback
> > operations defined for a slab cache. This will be used to display
> > the additional callbacks that will be defined soon to enable movable
> > objects.
> > 
> > Display the existing ctor callback in the ops fields contents.
> > 
> > Co-developed-by: Christoph Lameter <cl@linux.com>
> > Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> 
> Hi Tobin!
> 
> > ---
> >  mm/slub.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index dc777761b6b7..69164aa7cbbf 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -5009,13 +5009,18 @@ static ssize_t cpu_partial_store(struct kmem_cache *s, const char *buf,
> >  }
> >  SLAB_ATTR(cpu_partial);
> >  
> > -static ssize_t ctor_show(struct kmem_cache *s, char *buf)
> > +static ssize_t ops_show(struct kmem_cache *s, char *buf)
> >  {
> > +	int x = 0;
> > +
> >  	if (!s->ctor)
> >  		return 0;
>         ^^^^^^^^^^^^^^^^^
> You can drop this part, can't you?
> 
> Also, it's not clear (without looking into following patches) why do you
> make this refactoring. So, please, add a note, or move this change into
> the patch 3.

No worries, thanks for looking at this.  Will amend the commit message
and drop the constructor check.

thanks,
Tobin
