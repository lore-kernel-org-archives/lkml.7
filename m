Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1A9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9093A2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="lR+XvUt+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfCLJuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:50:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36209 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfCLJub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:50:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id r124so1419236pgr.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 02:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0D7OV4c9X2n8zGW+F3FNLmEy0PklCf74U0Xfmop9WTA=;
        b=lR+XvUt+gcXKVe8QBPRWg8Xb9Ed2cVDz/e31b9tyoQwvtD0m3/VNtF3Cd2uHIvwr+R
         tLLF5VnRypSgc63GHOFaJ0GIjna+48sSZF7Z5sa2xcAixy1lYyvGFdz8s41YGNnEy7b3
         h+rUTKbvgR51gL7G7Cg2zB9oN1rQ7FJuzijlbzbJgId6SmfHEduoMz6eum5OHWcbGzP4
         7g5mXVMvGAhP5C46A743XzmewtyxV+3X+HsP9j87sdDCf/L7F1LTx88S/DHb3HjJQk6C
         RHJ57oztHbo2o8OM+bqQQrXmlA52qdcvzoqv8AgTVfFl/S2PgLi4Kb7+vr8mDZ9syZE/
         PXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0D7OV4c9X2n8zGW+F3FNLmEy0PklCf74U0Xfmop9WTA=;
        b=CoAGzEuw39jrorLslOKOls1yoxUxaqjzMXvvPB+R1ctTozu+JzH8x+weP2mXXdeNR4
         YwazQwBPbi+VIlT7PQ6ranurhXMqoXEUJwdtAQJXl7Tl8b7jj3p612XFZWvwWRs/jpAN
         CbXr4dja+F0jdDSbrs/sY9IIP9yFfaarlznnVGgYl4b0ev4CGEPNQNswAHitcQ/mLD0o
         8uUtkbnMhDDSXK7rGSwijHQYWHezNLzEgRFrCLUrHSKr3nyX9HcwYMlxeZgRqV+W7ldn
         SRRUi9YEd3NilrsbWzoskWAU030B4g1STIeS/kWfy8P/YTE8l90W8qcPZXCWtWW20t08
         4wsw==
X-Gm-Message-State: APjAAAWfqbUWWuJdiseGfX9T09nUqG475jgtGDD780Kd9HLs3pHZjGIy
        JxZuyArq2wmX5wL1kbz7r202jA==
X-Google-Smtp-Source: APXvYqwhfJMt98l24I+WTmfn1qKL/4YmqMUyy+I46z3j5ZJdq1ROCg5WEq5aqTqy5DT0GU0fuDtgtQ==
X-Received: by 2002:a62:41cc:: with SMTP id g73mr36985243pfd.145.1552384229725;
        Tue, 12 Mar 2019 02:50:29 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id a7sm12907564pff.54.2019.03.12.02.50.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 02:50:29 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 8856B3011CA; Tue, 12 Mar 2019 12:50:26 +0300 (+03)
Date:   Tue, 12 Mar 2019 12:50:26 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     hpa@zytor.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Pitam Mitra <pitamm@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bockjoo Kim <bockjoo@phys.ufl.edu>, bp@alien8.de
Subject: Re: [PATCH 5.0 30/46] x86/boot/compressed/64: Do not read legacy ROM
 on EFI system
Message-ID: <20190312095026.obzxv65roj3fcu32@kshutemo-mobl1>
References: <20190308124902.257040783@linuxfoundation.org>
 <20190308124904.216497374@linuxfoundation.org>
 <CED6E6E5-00E5-4FFD-A8C9-254EA3A5288E@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CED6E6E5-00E5-4FFD-A8C9-254EA3A5288E@zytor.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 09, 2019 at 10:10:19PM -0800, hpa@zytor.com wrote:
> >@@ -47,8 +50,18 @@ static unsigned long find_trampoline_pla
> > 	 * This code is based on reserve_bios_regions().
> > 	 */
> > 
> >-	ebda_start = *(unsigned short *)0x40e << 4;
> >-	bios_start = *(unsigned short *)0x413 << 10;
> >+	/*
> >+	 * EFI systems may not provide legacy ROM. The memory may not be
> >mapped
> >+	 * at all.
> >+	 *
> >+	 * Only look for values in the legacy ROM for non-EFI system.
> >+	 */
> >+	signature = (char *)&boot_params->efi_info.efi_loader_signature;
> >+	if (strncmp(signature, EFI32_LOADER_SIGNATURE, 4) &&
> >+	    strncmp(signature, EFI64_LOADER_SIGNATURE, 4)) {
> >+		ebda_start = *(unsigned short *)0x40e << 4;
> >+		bios_start = *(unsigned short *)0x413 << 10;
> >+	}
> > 
> > 	if (bios_start < BIOS_START_MIN || bios_start > BIOS_START_MAX)
> > 		bios_start = BIOS_START_MAX;
> 
> Only one objection: the explanation is nonsensical. 

Well, that's the best explanation I've come up with :/

I would be glad for any insight here.

-- 
 Kirill A. Shutemov
