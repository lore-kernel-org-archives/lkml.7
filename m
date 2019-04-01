Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE317C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DBB20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732859AbfDARuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:50:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:41710 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728775AbfDARut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:50:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 10:50:48 -0700
X-IronPort-AV: E=Sophos;i="5.60,297,1549958400"; 
   d="scan'208";a="130530628"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2019 10:50:48 -0700
Message-ID: <b3540257a002b944a878096570bc927450662b9c.camel@linux.intel.com>
Subject: Re: [RFC 1/4] net/ipv4/fib: Remove run-time check in tnode_alloc()
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org
Date:   Mon, 01 Apr 2019 10:50:48 -0700
In-Reply-To: <c82b92e9-9809-87d2-85dc-67044d4e7632@gmail.com>
References: <20190326153026.24493-1-dima@arista.com>
         <20190326153026.24493-2-dima@arista.com>
         <5beb631cf0dcc03d5afad3a29671677bdbc7b931.camel@linux.intel.com>
         <c82b92e9-9809-87d2-85dc-67044d4e7632@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-04-01 at 16:55 +0100, Dmitry Safonov wrote:
> Hi Alexander,
> 
> On 4/1/19 4:40 PM, Alexander Duyck wrote:
> > > @@ -333,8 +328,7 @@ static struct tnode *tnode_alloc(int bits)
> > >  {
> > >  	size_t size;
> > >  
> > > -	/* verify bits is within bounds */
> > > -	if (bits > TNODE_VMALLOC_MAX)
> > > +	if ((BITS_PER_LONG <= KEYLENGTH) && unlikely(bits >= BITS_PER_LONG))
> > >  		return NULL;
> > >  
> > >  	/* determine size and verify it is non-zero and didn't overflow */
> > 
> > I think it would be better if we left TNODE_VMALLOC_MAX instead of
> > replacing it with BITS_PER_LONG. This way we know that we are limited
> > by the size of the node on 32b systems, and by the KEYLENGTH on 64b
> > systems. The basic idea is to maintain the logic as to why we are doing
> > it this way instead of just burying things by using built in constants
> > that are close enough to work.
> > 
> > So for example I believe TNODE_VMALLOC_MAX is 31 on a 32b system.
> 
> This is also true after the change: bits == 31 will *not* return.

Actually now that I think about it TNODE_VMALLOC_MAX is likely much
less than 31. The logic that we have to be concerned with is:
	size = TNODE_SIZE(1ul << bits);

If size is a 32b value, and the size of a pointer is 4 bytes, then our
upper limit is roughly ilog2((4G - 28) / 4), which comes out to 29.
What we are trying to avoid is overflowing the size variable, not
actually limiting the vmalloc itself.

> > The
> > main reason for that is because we have to subtract the TNODE_SIZE from
> > the upper limit for size. By replacing TNODE_VMALLOC_MAX with
> > BITS_PER_LONG that becomes abstracted away and it becomes more likely
> > that somebody will mishandle it later.
> 
> So, I wanted to remove run-time check here on x86_64..
> I could do it by adding !CONFIG_64BIT around the check.

I have no problem with that. All I am suggesting is that if at all
possible we should use TNODE_VMALLOC_MAX instead of BITS_PER_LONG.

> But, I thought about the value of the check:
> I believe it's here not to limit maximum allocated size:
> kzalloc()/vzalloc() will fail and we should be fine with that.

No, the problem is we don't want to overflow size. The allocation will
succeed, but give us a much smaller allocation then we expected.

> In my opinion it's rather to check that (1UL << bits) wouldn't result in UB.

Sort of, however we have to keep mind that 1ul << bits is an index so
it is also increased by the size of a pointer. As such the logic might
be better expressed as sizeof(void*) << bits.




