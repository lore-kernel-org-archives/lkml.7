Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1622DC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CCC2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 11:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfD2LT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 07:19:28 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:60420 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbfD2LT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 07:19:28 -0400
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 6D33D5C0B38; Mon, 29 Apr 2019 13:18:36 +0200 (CEST)
Date:   Mon, 29 Apr 2019 13:18:36 +0200
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Edward Cree <ecree@solarflare.com>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rds: ib: force endiannes annotation
Message-ID: <20190429111836.GA17830@osadl.at>
References: <1556518178-13786-1-git-send-email-hofrat@osadl.org>
 <20443fd3-bd1e-9472-8ca3-e3014e59f249@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20443fd3-bd1e-9472-8ca3-e3014e59f249@solarflare.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 12:00:06PM +0100, Edward Cree wrote:
> On 29/04/2019 07:09, Nicholas Mc Guire wrote:
> > diff --git a/net/rds/ib_recv.c b/net/rds/ib_recv.c
> > index 7055985..a070a2d 100644
> > --- a/net/rds/ib_recv.c
> > +++ b/net/rds/ib_recv.c
> > @@ -824,7 +824,7 @@ static void rds_ib_cong_recv(struct rds_connection *conn,
> >  	}
> >  
> >  	/* the congestion map is in little endian order */
> > -	uncongested = le64_to_cpu(uncongested);
> > +	uncongested = le64_to_cpu((__force __le64)uncongested);
> >  
> >  	rds_cong_map_updated(map, uncongested);
> >  }
> Again, a __force cast doesn't seem necessary here.  It looks like the
>  code is just using the wrong types; if all of src, dst and uncongested
>  were __le64 instead of uint64_t, and the last two lines replaced with
>  rds_cong_map_updated(map, le64_to_cpu(uncongested)); then the semantics
>  would be kept with neither sparse errors nor __force.
> 
> __force is almost never necessary and mostly just masks other bugs or
>  endianness confusion in the surrounding code.  Instead of adding a
>  __force, either fix the code to be sparse-clean or leave the sparse
>  warning in place so that future developers know there's something not
>  right.
>
changing uncongested to __le64 is not an option here - it would only move
the sparse warnings to those other locatoins where the ports that 
became uncongested are being or'ed into uncongested.

I'm not using __force as the prime way to silence sparse - I try to find
an alternative first - the problem is in line 805
                for (k = 0; k < to_copy; k += 8) {
                        /* Record ports that became uncongested, ie
                         * bits that changed from 0 to 1. */
                        uncongested |= ~(*src) & *dst;
                        *dst++ = *src++;
                }
And in this case the endianness handling does seem right.

But ok with me to leave it in as it is - if you think that the __force
here is not justified.

thanks for your comments and notably the explainations !

thx!
hofrat
alternative 
 
