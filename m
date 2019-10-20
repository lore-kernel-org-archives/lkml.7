Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85FECA9EA0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 19:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D99218BA
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 19:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfJTTke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 15:40:34 -0400
Received: from smtprelay0015.hostedemail.com ([216.40.44.15]:55989 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725818AbfJTTkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 15:40:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 427531803521A;
        Sun, 20 Oct 2019 19:40:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: match22_3ec1646977b17
X-Filterd-Recvd-Size: 2851
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Sun, 20 Oct 2019 19:40:31 +0000 (UTC)
Message-ID: <0f7518736a2508371fecf91db6e28d50494360b3.camel@perches.com>
Subject: Re: byteorder: cpu_to_le32_array vs cpu_to_be32_array function API
 differences
From:   Joe Perches <joe@perches.com>
To:     Anatol Belski <weltling@outlook.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sun, 20 Oct 2019 12:40:30 -0700
In-Reply-To: <AM0PR0502MB3668C7B77C05918FF96EF10DBA6E0@AM0PR0502MB3668.eurprd05.prod.outlook.com>
References: <2acb30fb3c9a86ac8cc882fb787cd04e5864224b.camel@perches.com>
         <AM0PR0502MB3668C7B77C05918FF96EF10DBA6E0@AM0PR0502MB3668.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-10-20 at 19:28 +0000, Anatol Belski wrote:
> Hi,

Hello.

> On Sun, 2019-10-20 at 12:02 -0700, Joe Perches wrote:
> > There's an argument inconsistency between these 4 functions
> > in include/linux/byteorder/generic.h
> > 
> > It'd be more a consistent API with one form and not two.
> > 
> >    static inline void le32_to_cpu_array(u32 *buf, unsigned int words)
> >    {
> >    	while (words--) {
> >    		__le32_to_cpus(buf);
> >    		buf++;
> >    	}
> >    }
> > 
> >    static inline void cpu_to_le32_array(u32 *buf, unsigned int words)
> >    {
> >    	while (words--) {
> >    		__cpu_to_le32s(buf);
> >    		buf++;
> >    	}
> >    }
> > 
> > vs
> > 
> >    static inline void cpu_to_be32_array(__be32 *dst, const u32 *src,
> > size_t len)
> >    {
> >    	int i;
> > 
> >    	for (i = 0; i < len; i++)
> >    		dst[i] = cpu_to_be32(src[i]);
> >    }
> > 
> >    static inline void be32_to_cpu_array(u32 *dst, const __be32 *src,
> > size_t len)
> >    {
> >    	int i;
> > 
> >    	for (i = 0; i < len; i++)
> >    		dst[i] = be32_to_cpu(src[i]);
> >    }
> > 
> > 
> 
> size_t is the right choice for this, as it'll generate more correct
> binary depending on 32/64 bit. I've sent a patch in
> 'include/linux/byteorder/generic.h: fix signed/unsigned warnings'
> before, but only touched the place where i've seen warnings. My very
> bet is, that changing between size_t/unsigned, while it would be
> consistent, wouldn't change the functionality. It'd probably make sense
> to extend the aforementioned patch to move unsigned -> size_t.

True, but my point was the le versions have 2 arguments and
convert the buf input, and the be versions have 3 arguments
and convert src to dst.

cheers, Joe

