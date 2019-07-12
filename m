Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98132C742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2AC2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="aotkFJFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfGLMDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:03:32 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46188 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfGLMDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:03:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id h21so7713917qtn.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 05:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ya3olqXbNYZ2YSMN5Vo2GEPYRI+CuBxMvSFn7d2uS84=;
        b=aotkFJFqvusMX1OerhuocXFj7/j+XMydcgBWATpaSaQpjePlEHXuw1+eLA3XqgzVgo
         3Uk1mq1uWIcjr/P13VqQNxLGQbZ9Le18lGea64pNkkEoS62ag3YJpvCUAZLxtXsOF2KI
         wLVUSJX9QkQNLAYnKTThOtDh2/xxmx0ryuFqTeqTP3jTt6PVz5h9isko1yzVEv6CeJWf
         PJ53HLvamfbEldE0osqQWh+20am5UjiuwTrt+NFhIr9CmjgssvNA72uAe9CbQs3OwFoa
         ksfLHaCMpnjAnzf8bCmJRSNRE1X7pAtY8pNvZbMuhFYTs6kN6ijHpb3bOnz9ru+2gwkM
         sB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ya3olqXbNYZ2YSMN5Vo2GEPYRI+CuBxMvSFn7d2uS84=;
        b=TbcSOs7ymfC+GEzJR2lNAqHzjjPBWylGeA4CFQA9e9vzw9lRdcaO1Q71+W3ceqr+D3
         IAVk7WvZzhhmsE+dGD6Nq/ZAqNEWZ+sWSlr0eIaMu9VkvwJMoAhFsfEjIJGfsVDIdik/
         Fa4MtU1p9q39ncnriZzgrRyO6owtwBdmSNpUHkRl3DcNe3+pon9DIFzG5heij13NFFIV
         pmMb01Dh3pM/yaochfUtzAWv6b+C23ec+3BwotwHu+Cq9PoLbslTVMpc2a/ixZbBqjcn
         Sr8MtbQTNs5YXyst6V6CBfStxTfMwMY7vw5PoyGK3sanN+TTudYyXV+9zOGyZLTqrGlD
         wSug==
X-Gm-Message-State: APjAAAXLrgfFu4G8Y10o9CrDAlmHHV8eSSObc71LTzPmEzH8kqFwe1PF
        3bJpALKOgGS/E+6RSWRESG6rTA==
X-Google-Smtp-Source: APXvYqxudGKXGX8PVBjgTwtRs3qNjn2Q+HrcLltih4h0otrVbHxru0sA/MmXmqlsVAjzxXP/MEWGrg==
X-Received: by 2002:ac8:7349:: with SMTP id q9mr5963086qtp.151.1562933009442;
        Fri, 12 Jul 2019 05:03:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 2sm4189831qtz.73.2019.07.12.05.03.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jul 2019 05:03:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hluGu-0007MM-MT; Fri, 12 Jul 2019 09:03:28 -0300
Date:   Fri, 12 Jul 2019 09:03:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Doug Ledford <dledford@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rdma/siw: avoid smp_store_mb() on a u64
Message-ID: <20190712120328.GB27512@ziepe.ca>
References: <20190712085212.3901785-1-arnd@arndb.de>
 <OF05C1A780.433E36D1-ON00258435.003381DA-00258435.003F847E@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF05C1A780.433E36D1-ON00258435.003381DA-00258435.003F847E@notes.na.collabserv.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 11:33:46AM +0000, Bernard Metzler wrote:
> >diff --git a/drivers/infiniband/sw/siw/siw_verbs.c
> >b/drivers/infiniband/sw/siw/siw_verbs.c
> >index 32dc79d0e898..41c5ab293fe1 100644
> >+++ b/drivers/infiniband/sw/siw/siw_verbs.c
> >@@ -1142,10 +1142,11 @@ int siw_req_notify_cq(struct ib_cq *base_cq,
> >enum ib_cq_notify_flags flags)
> > 
> > 	if ((flags & IB_CQ_SOLICITED_MASK) == IB_CQ_SOLICITED)
> > 		/* CQ event for next solicited completion */
> >-		smp_store_mb(*cq->notify, SIW_NOTIFY_SOLICITED);
> >+		WRITE_ONCE(*cq->notify, SIW_NOTIFY_SOLICITED);
> > 	else
> > 		/* CQ event for any signalled completion */
> >-		smp_store_mb(*cq->notify, SIW_NOTIFY_ALL);
> >+		WRITE_ONCE(*cq->notify, SIW_NOTIFY_ALL);
> >+	smp_wmb();
> > 
> > 	if (flags & IB_CQ_REPORT_MISSED_EVENTS)
> > 		return cq->cq_put - cq->cq_get;
> 
> 
> Hi Arnd,
> Many thanks for pointing that out! Indeed, this CQ notification
> mechanism does not take 32 bit architectures into account.
> Since we have only three flags to hold here, it's probably better
> to make it a 32bit value. That would remove the issue w/o
> introducing extra smp_wmb(). 

I also prefer not to see smp_wmb() in drivers..

> I'd prefer smp_store_mb(), since on some architectures it shall be
> more efficient.  That would also make it sufficient to use
> READ_ONCE.

The READ_ONCE is confusing to me too, if you need store_release
semantics then the reader also needs to pair with load_acquite -
otherwise it doesn't work.

Still, we need to do something rapidly to fix the i386 build, please
revise right away..

Jason
