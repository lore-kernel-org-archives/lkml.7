Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C44C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907A2204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 14:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JH5PlAW1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407048AbfHIO0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 10:26:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51728 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfHIO0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 10:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EaBoxEWlwr4zZ1rJszejMFTUZoMex/Sf4azgLrG5t04=; b=JH5PlAW1P2xfQ+UotOi2WPcif
        C19dMDk6AncmpZY3SMLP16T8M5SGZUNI02MGYfsWwHSsQxhnYdPMXDE/rLpAP+7lCYOyADYpGM0z7
        gtGfOgSE7pZzBwYe+vjSFFHzHmuJDIsqXYQL3ViPGaBxFATmoPqv3oK1UJBO9sAZ02mPwUw29Najp
        nWDEyZSTpAapVfw0ofuowNHThlH+U7ZlvyQyETUpS2WbUhnYzz9F7kwdt5498KBCoEACm6R+Y6j7q
        pZa5eIT2eGWi3ZBnt4MBZ2NR5uL/1SxETSyrY8IFjGvtEQ73OpE+b1AxiX4A/ilb/+hcfrlkKqrEv
        VYTD+LGxg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hw5qT-0007Je-Q0; Fri, 09 Aug 2019 14:26:17 +0000
Date:   Fri, 9 Aug 2019 07:26:17 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com, "Tobin C . Harding" <me@tobin.cc>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH v2] mm: slub: print kernel addresses in slub debug
 messages
Message-ID: <20190809142617.GO5482@bombadil.infradead.org>
References: <20190809010837.24166-1-miles.chen@mediatek.com>
 <20190809024644.GL5482@bombadil.infradead.org>
 <1565359918.12824.20.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565359918.12824.20.camel@mtkswgap22>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 10:11:58PM +0800, Miles Chen wrote:
> On Thu, 2019-08-08 at 19:46 -0700, Matthew Wilcox wrote:
> > On Fri, Aug 09, 2019 at 09:08:37AM +0800, miles.chen@mediatek.com wrote:
> > > INFO: Slab 0x(____ptrval____) objects=25 used=10 fp=0x(____ptrval____)
> > 
> > ... you don't have any randomness on your platform?
> 
> We have randomized base on our platforms.

Look at initialize_ptr_random().  If you have randomness, then you
get a siphash_1u32() of the address.  With no randomness, you get this
___ptrval___ string instead.

