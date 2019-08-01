Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D611EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 20:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4107206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 20:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="1TlEkQQ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbfHAU2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 16:28:11 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44148 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfHAU2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 16:28:10 -0400
Received: by mail-ed1-f65.google.com with SMTP id k8so70325363edr.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 13:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EyX9EFwIjSNs/L9jeoLUxg4MBQl3gMhjFOA92CpxgIk=;
        b=1TlEkQQ07BEhmHaxTfa8X1o0kMCXLraP6UlA4zQ0zbo7ky9Q0uNUZ2tzRUHtqQclY3
         tTxWI6ciU1OV9m3Bbt7Tx8JrtI0kGM45xqSLRBR6Sv1zDztXoK64YSFQGkb39+HZoF+M
         HMBqc8TlBquEzyLM0HjgK+VbSRsKRvUSVVGh7pDeGuUnNPGsSlIj1rvVZhnxH0RA+mi3
         /440NwR1o522lhSvM4WNqnBSQmw+F9fqcd5vtxZUu9AiEHIYgLYHOn+Y/OViDqVQ8fsz
         f+S7KyKfpoApkFPoS2Ipe0Xw2rxg5Vp6jaWIOo3oCKQnOO4jSflQSTd3zmS9+hzB8MsG
         GaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EyX9EFwIjSNs/L9jeoLUxg4MBQl3gMhjFOA92CpxgIk=;
        b=NJrlThRSRq/rs/2zXyl7Yc6F1uOoKTHmnx91SgH1ZSPeRTiNMgX/6laEHXooljpCWa
         pK9g7UigJXlqn8G/49qemmzjhYoIWxvPx03P/iiUWasmkFPH0dXRQtPgzn0zeUXcJHgp
         PPuIHYL0L6YdW76d7dvp0b9c2jIfOqkg5EXWzoy8Gi6nhJQ44YS+BcrKw/SG0hBgizL6
         3Vf5O9dZzqObvnvn7LmsWQzYPj8P7kvICd1dkYAilbrVfdugiiAMZBfbi07EALGKaQLv
         cEjL2kqCs7TOzp+iEXcP+yI5msfmcKCF7aEkSNeRuVllZ16f+C2b4D8bpIrWFxhDECmk
         MdrQ==
X-Gm-Message-State: APjAAAX/SReb1WAj8F6LyFt1dgPmydsUgnJHXF1piBt1xSJqEj7U8C86
        rIPqMlJb8LgliRVYU78FTzs=
X-Google-Smtp-Source: APXvYqxiT/kNS9lw/exw00+jJ7Ebx8DmRLkCplcE6qGNeWckLguo/Z43gLS3K58VN3UPfm62smb1cQ==
X-Received: by 2002:a17:906:684e:: with SMTP id a14mr103351903ejs.156.1564691289052;
        Thu, 01 Aug 2019 13:28:09 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u8sm17208881edo.78.2019.08.01.13.28.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2019 13:28:08 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 4F06F101E94; Thu,  1 Aug 2019 23:28:08 +0300 (+03)
Date:   Thu, 1 Aug 2019 23:28:08 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        jing.lin@intel.com, bp@alien8.de, x86@kernel.org
Subject: Re: [PATCH] x86/asm: Add support for MOVDIR64B instruction
Message-ID: <20190801202808.e2cqlqetixie4gcu@box>
References: <20190801194348.GA6059@avx2>
 <20190801194947.GA12033@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801194947.GA12033@agluck-desk2.amr.corp.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 12:49:48PM -0700, Luck, Tony wrote:
> On Thu, Aug 01, 2019 at 10:43:48PM +0300, Alexey Dobriyan wrote:
> > > +static inline void movdir64b(void *dst, const void *src)
> > > +{
> > > +	/* movdir64b [rdx], rax */
> > > +	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
> > > +			: "=m" (*(char *)dst)
> >                                ^^^^^^^^^^
> > 
> > > +			: "d" (src), "a" (dst));
> > > +}
> > 
> > Probably needs fake 64-byte type, so that compiler knows what is dirty.
> 
> Would that be something like this?
> 
> static inline void movdir64b(void *dst, const void *src)
> {
> 	struct dstbytes {
> 		char pad[64];
> 	};
> 
> 	/* movdir64b [rdx], rax */
> 	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
> 		     : "=m" (*(struct dstbytes *)dst)
> 		     : "d" (src), "a" (dst));
> }
> 
> Or did you have something else in mind?

Or should we add "memory" clobber instead, like we do for string
operations?

static inline void movdir64b(void *dst, const void *src)
{
	/* movdir64b [rdx], rax */
	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
			: : "d" (src), "a" (dst) : "memory");
}

-- 
 Kirill A. Shutemov
