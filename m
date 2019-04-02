Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E39C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31DF20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554232364;
	bh=GTAmIx7Fqd8J9j1uyss78mDruKvZEEOHquz2Xpjh03I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1F8bKlUe9uLn85vLEmLbCPjnrdIbYiIdOHndB2dVxWjLKLEVKD0mB/lb1t9h99Sct
	 b7QyDKqBuyXZe81hm8lujWcNYBU/PFqQChfkKVcy0Dy6bwlUSsO2C7W7g/mkoGvjWp
	 E5Ub25JMzb1qhNr1eY8T6aK/8lxuG35woT9w2j+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbfDBTMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:12:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41702 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDBTMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:12:42 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BA461E93;
        Tue,  2 Apr 2019 19:12:40 +0000 (UTC)
Date:   Tue, 2 Apr 2019 12:12:39 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     "Tobin C. Harding" <tobin@kernel.org>, LKP <lkp@01.org>,
        Roman Gushchin <guro@fb.com>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/1] slob: Only use list functions when safe to do so
Message-Id: <20190402121239.76d64e3c262dcb24ebcee058@linux-foundation.org>
In-Reply-To: <20190402190538.GA5084@eros.localdomain>
References: <20190402032957.26249-1-tobin@kernel.org>
        <20190402032957.26249-2-tobin@kernel.org>
        <20190401214128.c671d1126b14745a43937969@linux-foundation.org>
        <20190402190538.GA5084@eros.localdomain>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2019 06:05:38 +1100 "Tobin C. Harding" <me@tobin.cc> wrote:

> > It's regrettable that this fixes
> > slob-respect-list_head-abstraction-layer.patch but doesn't apply to
> > that patch - slob-use-slab_list-instead-of-lru.patch gets in the way. 
> > So we end up with a patch series which introduces a bug and later
> > fixes it.
> 
> Yes I thought that also.  Do you rebase the mm tree?  Did you apply this
> right after slob-use-slab_list-instead-of-lru or to the current tip?

After slob-use-slab_list-instead-of-lru.patch

>  If
> it is applied to the tip does this effect the ability to later bisect in
> between these two commits (if the need arises for some unrelated reason)?

There is a bisection hole but it is short and the bug is hardish to
hit.

> > I guess we can live with that but if the need comes to respin this
> > series, please do simply fix
> > slob-respect-list_head-abstraction-layer.patch so we get a clean
> > series.
> 
> If its not too much work for you to apply the new series I'll do another
> version just to get this right.

I guess that would be best, thanks.
