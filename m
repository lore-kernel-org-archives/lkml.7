Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32658C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053522173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555520967;
	bh=2cOCdzG0SDy+DeXwUTlQ+NowWIIegqUtx60BFoyA8ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yClY2cMdYUJBoLyaYi3/IuEOXvo7K8Hiu7RxMQgBpIaQ95Qv7prwH4ZFAO+Z3Pe/D
	 DUeG2tSmot1RlVgNxpj4mrWJd99HXm+oZDAz8vx3MPLFZE3jh0Q7PooFgl3RU0hXWn
	 /yEjTFYtfRJpx1aRDJrfM7Q4Hp/MiALGlXoy4NRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732936AbfDQRJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:09:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34585 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfDQRJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:09:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id w16so2975554wrl.1;
        Wed, 17 Apr 2019 10:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uI0ONQRkWQ/et5lZr2E50Xppi+adE17aj2er9uc38Ro=;
        b=vQKDMpKZs+jpCV0AtFjtb+IzANhqz3dew5Sd4gG7ITDXSrt8OYeyxzo5885noBmd/k
         M7Y511AnmRuFNpPrRUcL0fx4VCDHC5HbpoQL157ReLzEY+ATmvDFca5O27ddKmW8+E5U
         SWwgB4fqBVviw9oEx6R3qe3lIZgRJYJXc6M3U+vQZTc8SCcbn5I1BqHYSYodcHy/K7y2
         owHfWC5l9Z1dd3sc9ZHcDGWk/J7z+eM+/y7DQCfdM2D1aY4WwXTWnRz28CERITWBN3RI
         OdgGC3tyQYESSIRNzNO6ctsaUz9bT+jioxPBGx1xhp3GL49llo+vdJv4lTzb9yvWN35X
         0F5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uI0ONQRkWQ/et5lZr2E50Xppi+adE17aj2er9uc38Ro=;
        b=NHQ/p5kSoYO4qoGi9jmIHZ6XtLTr8SMtEAkZEkvCTvCY/pJTNGN0ek9uQiwaNaXmiP
         +bSk8fqiAuZVhR/L9XZ/CfIfRXgHb2tKDmXMOlqECtmew1BTq4m2wLmG8sDTKYEwQ8su
         PJkwgbfsf1BV0dDoSwP/TwBhcruS3QWqrEscoCi3Kgd4L0ZALHBUZ7jk9XIG4LH0NOfc
         /HGY3ckI6ATaw+6oxDQhNrIuh89bRjJwZ4YmQXm9kRk79TPll++URksCFZRSCYckohxW
         69sLlwhPYxvs/6EZ/5kXPfNrHD3ULDE9NwOT3IsIR5Y+ddUNhsK2fRQG4NfFkCZ2PRN7
         hJuw==
X-Gm-Message-State: APjAAAU6ueq/1QC1nAXHIg6eaRMx5f977q5CRX2bbiX2jgKTtyVGWZn6
        yVoCUIwD7EDsu3YLCMFNrZA=
X-Google-Smtp-Source: APXvYqwzLRhrBX+v0nCWIiRZo+Ww+BhgVCQVN/Z3qzTyGEskFIzDNjOb+l7u4co7KExCIwSw9l38CA==
X-Received: by 2002:adf:f8d0:: with SMTP id f16mr2701431wrq.198.1555520962630;
        Wed, 17 Apr 2019 10:09:22 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 67sm2676425wmz.41.2019.04.17.10.09.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 10:09:21 -0700 (PDT)
Date:   Wed, 17 Apr 2019 19:09:18 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de,
        keescook@google.com, konrad.wilk@oracle.com,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        deepa.srinivasan@oracle.com, chris.hyser@oracle.com,
        tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, iommu@lists.linux-foundation.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        Khalid Aziz <khalid@gonehiking.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Dave Hansen <dave@sr71.net>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arjan van de Ven <arjan@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
 Ownership (XPFO)
Message-ID: <20190417170918.GA68678@gmail.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
 <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
 <20190417161042.GA43453@gmail.com>
 <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Khalid Aziz <khalid.aziz@oracle.com> wrote:

> > I.e. the original motivation of the XPFO patches was to prevent execution 
> > of direct kernel mappings. Is this motivation still present if those 
> > mappings are non-executable?
> > 
> > (Sorry if this has been asked and answered in previous discussions.)
> 
> Hi Ingo,
> 
> That is a good question. Because of the cost of XPFO, we have to be very
> sure we need this protection. The paper from Vasileios, Michalis and
> Angelos - <http://www.cs.columbia.edu/~vpk/papers/ret2dir.sec14.pdf>,
> does go into how ret2dir attacks can bypass SMAP/SMEP in sections 6.1
> and 6.2.

So it would be nice if you could generally summarize external arguments 
when defending a patchset, instead of me having to dig through a PDF 
which not only causes me to spend time that you probably already spent 
reading that PDF, but I might also interpret it incorrectly. ;-)

The PDF you cited says this:

  "Unfortunately, as shown in Table 1, the W^X prop-erty is not enforced 
   in many platforms, including x86-64.  In our example, the content of 
   user address 0xBEEF000 is also accessible through kernel address 
   0xFFFF87FF9F080000 as plain, executable code."

Is this actually true of modern x86-64 kernels? We've locked down W^X 
protections in general.

I.e. this conclusion:

  "Therefore, by simply overwriting kfptr with 0xFFFF87FF9F080000 and 
   triggering the kernel to dereference it, an attacker can directly 
   execute shell code with kernel privileges."

... appears to be predicated on imperfect W^X protections on the x86-64 
kernel.

Do such holes exist on the latest x86-64 kernel? If yes, is there a 
reason to believe that these W^X holes cannot be fixed, or that any fix 
would be more expensive than XPFO?

Thanks,

	Ingo
