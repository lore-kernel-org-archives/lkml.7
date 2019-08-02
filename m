Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D89C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C433220679
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="H58UyApo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392898AbfHBM6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 08:58:21 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33564 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfHBM6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 08:58:20 -0400
Received: by mail-ed1-f67.google.com with SMTP id i11so8808900edq.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 05:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NIGJpky/M+tWccJyj0jIuvGwfPnnsOj0qW0qoHvQA1M=;
        b=H58UyApoDTDV5XzamdCHn+2haTE0m4o9CWA/XI7+Uxm05zztDbmHLEhVU8W7eDiyLC
         MZiMM72lRUCaNiUk5F6gHpLGvHSf6lIJVBGhpuGMLTccIdbtEYWuPENmy27Cg7+SwhmQ
         Tyf5h8MEbh0dZVudwS0LPwls17pDN6hZuyyp/HGTDbrlUXgXT2t7UK4L0iY/FuDFcabu
         iDjghe+aAJ22Z+KZAa/bL3DmE1u102lTuH25YQIJSjYe8djw/Wyk+ONiEY0vjH6aQyf/
         dZRQO+TGq2Opkx9hG/jC40qAXB2dqwKVyVL8VbnVg/DEqEcjlpr2EV6si728kHOazzu4
         tJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NIGJpky/M+tWccJyj0jIuvGwfPnnsOj0qW0qoHvQA1M=;
        b=DlzFZykLADRBNq7TMnr6TQ0bOGhqL2z41q+sHIzjVgc7X0nnS9Qi/fFrIPJHeho7kS
         Cvc9rRxJL71Zj+e3zxrX7an+m9Hr5P8g5XhKhTCTwl9C27QLM2J5SqpWpsFJJSNY/S9Q
         zy7GF0kdrFhpOhWzTp9uCqE9FynlVcwrqQWUrg67IFGEg0tSgAtZyLDNXmyAAZUc7Ehh
         pUgO6Y7l+KCkqs5aqkaKgnBz6lsGRrbkb5JjEBMrJKdGWld78cFYAfOJiq5TON42F6vj
         5BZqxib3rOxIkyvj/qxMaFzx8rkkBnVI6qWetm7r00QePtoee02jj+5zV/gsRj5BN3sI
         dcYg==
X-Gm-Message-State: APjAAAWsR/L4YHfePSMI73J8sv4fi3ky9a02Vu1xxcsqbJTBaH3dfk8d
        pjyhQHZ4S73uKx1t33jjVOGLTgFv
X-Google-Smtp-Source: APXvYqwSy3cSUIHLuy3erwZOnfhrO5DrTb9cHYBuTqm2WGXAIGyJNktV8t2xfIFCNEOSrC7RDMLDuA==
X-Received: by 2002:a50:fa42:: with SMTP id c2mr120512049edq.48.1564750698659;
        Fri, 02 Aug 2019 05:58:18 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w6sm9863714edq.81.2019.08.02.05.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 05:58:17 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 8000B101F60; Fri,  2 Aug 2019 15:58:18 +0300 (+03)
Date:   Fri, 2 Aug 2019 15:58:18 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        jing.lin@intel.com, bp@alien8.de, x86@kernel.org
Subject: Re: [PATCH] x86/asm: Add support for MOVDIR64B instruction
Message-ID: <20190802125818.wvyqsrcfm562bdpp@box>
References: <20190801194348.GA6059@avx2>
 <20190801194947.GA12033@agluck-desk2.amr.corp.intel.com>
 <20190802081533.GE2332@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802081533.GE2332@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 10:15:33AM +0200, Peter Zijlstra wrote:
> On Thu, Aug 01, 2019 at 12:49:48PM -0700, Luck, Tony wrote:
> > On Thu, Aug 01, 2019 at 10:43:48PM +0300, Alexey Dobriyan wrote:
> > > > +static inline void movdir64b(void *dst, const void *src)
> > > > +{
> > > > +	/* movdir64b [rdx], rax */
> > > > +	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
> > > > +			: "=m" (*(char *)dst)
> > >                                ^^^^^^^^^^
> > > 
> > > > +			: "d" (src), "a" (dst));
> > > > +}
> > > 
> > > Probably needs fake 64-byte type, so that compiler knows what is dirty.
> > 
> > Would that be something like this?
> > 
> > static inline void movdir64b(void *dst, const void *src)
> > {
> > 	struct dstbytes {
> > 		char pad[64];
> > 	};
> > 
> > 	/* movdir64b [rdx], rax */
> > 	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
> > 		     : "=m" (*(struct dstbytes *)dst)
> > 		     : "d" (src), "a" (dst));
> > }
> 
> Can the source and destination overlap? The SDM doesn't seem to mention
> this.

Good question. I'll ask to clarify this.

-- 
 Kirill A. Shutemov
