Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D06C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C6D20657
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Bdlh199t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfCHQPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:15:48 -0500
Received: from a9-30.smtp-out.amazonses.com ([54.240.9.30]:51490 "EHLO
        a9-30.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726275AbfCHQPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1552061746;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=/YhXAXDRJDXOsTejfexgfUA00S53mbAhO1iS5RDasTE=;
        b=Bdlh199ty9IN8Ej4gyzpqKaM1H1Wjn9NMIGUmZMBcAvYi7Mhl69vXni2vKVGXj25
        kqt5tnz6THVec9DymhKofVJ2KNbxRnU9nyvmBLQdw33vYJn3Y3SXYdAUgVPebRtsLSi
        eQ0kotJgYuAtoPRNARfzZuCA9l78ofUeTGLCqLtQ=
Date:   Fri, 8 Mar 2019 16:15:46 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Tycho Andersen <tycho@tycho.ws>
cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 02/15] slub: Add isolate() and migrate() methods
In-Reply-To: <20190308152820.GB373@cisco>
Message-ID: <010001695e16cdef-9831bf56-3075-4f0e-8c25-5d60103cb95f-000000@email.amazonses.com>
References: <20190308041426.16654-1-tobin@kernel.org> <20190308041426.16654-3-tobin@kernel.org> <20190308152820.GB373@cisco>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.03.08-54.240.9.30
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2019, Tycho Andersen wrote:

> On Fri, Mar 08, 2019 at 03:14:13PM +1100, Tobin C. Harding wrote:
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index f9d89c1b5977..754acdb292e4 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -298,6 +298,10 @@ int slab_unmergeable(struct kmem_cache *s)
> >  	if (!is_root_cache(s))
> >  		return 1;
> >
> > +	/*
> > +	 * s->isolate and s->migrate imply s->ctor so no need to
> > +	 * check them explicitly.
> > +	 */
>
> Shouldn't this implication go the other way, i.e.
>     s->ctor => s->isolate & s->migrate

A cache can have a constructor but the object may not be movable (I.e.
currently dentries and inodes).


