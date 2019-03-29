Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF8BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DA8218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbfC2Qvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:51:32 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42785 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728977AbfC2Qvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:51:31 -0400
Received: by mail-qt1-f196.google.com with SMTP id p20so3079934qtc.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 09:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JnQtOm1yPrnbkzP6/W9hj/ZhgDKVeNsjW2OawjBvYTY=;
        b=nBEHDhoD08nlLWK/EJbqEXMpMkCU6h1s5jnkbCJ9YtqzSLyPNEdxTt13plB+7EByhk
         Q5+4I1+4r2Y9lbQelEjMLhZ4xGAH16T+xIgrh6nhuRQzf1SQ9aop3Y2BHRZUks9OyYl7
         5dNsupFzTfIwkydFMIX982dOcAkgCdUsLo/c5Im2UFUWn523XTxYq8rT9dmzuw6AIDxs
         wDvWIitK2MS+COgWBBoduvqnlq30Gh93zuTSiybn5sOp/ZS+TXY6Jp7bPQVuScxZr4tc
         7ohGpNbzUZATmSpp2okYikxa8dBk6pScA1XgUnWN8pBEscRXwaW4xVpVpJ4rd9hBiOeN
         D6Jg==
X-Gm-Message-State: APjAAAU37TMELFNKAaDszFM1fgkXVAph+HZgxs0AfzCUI+Yksr5oKbzB
        wJKIiIn1nhP+3t4SfIChavTKgw==
X-Google-Smtp-Source: APXvYqxBgfBkI11ElcG4ShAYKMBjANr6IPgccDr6/JrHGDJDvwRxxD++gvYrD29fhyrttrIle3nwrw==
X-Received: by 2002:a0c:a424:: with SMTP id w33mr41335410qvw.5.1553878290672;
        Fri, 29 Mar 2019 09:51:30 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id x201sm1403846qkb.92.2019.03.29.09.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 09:51:29 -0700 (PDT)
Date:   Fri, 29 Mar 2019 12:51:26 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        pbonzini@redhat.com, lcapitulino@redhat.com, pagupta@redhat.com,
        wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com,
        dodgen@google.com, konrad.wilk@oracle.com, dhildenb@redhat.com,
        aarcange@redhat.com, alexander.duyck@gmail.com
Subject: Re: On guest free page hinting and OOM
Message-ID: <20190329125034-mutt-send-email-mst@kernel.org>
References: <20190329084058-mutt-send-email-mst@kernel.org>
 <f6332928-d6a4-7a75-245d-2c534cf6e710@redhat.com>
 <20190329104311-mutt-send-email-mst@kernel.org>
 <7a3baa90-5963-e6e2-c862-9cd9cc1b5f60@redhat.com>
 <f0ee075d-3e99-efd5-8c82-98d53b9f204f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0ee075d-3e99-efd5-8c82-98d53b9f204f@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 04:45:58PM +0100, David Hildenbrand wrote:
> On 29.03.19 16:37, David Hildenbrand wrote:
> > On 29.03.19 16:08, Michael S. Tsirkin wrote:
> >> On Fri, Mar 29, 2019 at 03:24:24PM +0100, David Hildenbrand wrote:
> >>>
> >>> We had a very simple idea in mind: As long as a hinting request is
> >>> pending, don't actually trigger any OOM activity, but wait for it to be
> >>> processed. Can be done using simple atomic variable.
> >>>
> >>> This is a scenario that will only pop up when already pretty low on
> >>> memory. And the main difference to ballooning is that we *know* we will
> >>> get more memory soon.
> >>
> >> No we don't.  If we keep polling we are quite possibly keeping the CPU
> >> busy so delaying the hint request processing.  Again the issue it's a
> > 
> > You can always yield. But that's a different topic.
> > 
> >> tradeoff. One performance for the other. Very hard to know which path do
> >> you hit in advance, and in the real world no one has the time to profile
> >> and tune things. By comparison trading memory for performance is well
> >> understood.
> >>
> >>
> >>> "appended to guest memory", "global list of memory", malicious guests
> >>> always using that memory like what about NUMA?
> >>
> >> This can be up to the guest. A good approach would be to take
> >> a chunk out of each node and add to the hints buffer.
> > 
> > This might lead to you not using the buffer efficiently. But also,
> > different topic.
> > 
> >>
> >>> What about different page
> >>> granularity?
> >>
> >> Seems like an orthogonal issue to me.
> > 
> > It is similar, yes. But if you support multiple granularities (e.g.
> > MAX_ORDER - 1, MAX_ORDER - 2 ...) you might have to implement some sort
> > of buddy for the buffer. This is different than just a list for each node.

Right but we don't plan to do it yet.

> Oh, and before I forget, different zones might of course also be a problem.

I would just split the hint buffer evenly between zones.

> 
> -- 
> 
> Thanks,
> 
> David / dhildenb
