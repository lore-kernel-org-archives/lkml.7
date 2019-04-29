Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1BDC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 13:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7299204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 13:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="0iR/rSpZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfD2NQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 09:16:15 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40265 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfD2NQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 09:16:15 -0400
Received: by mail-yb1-f196.google.com with SMTP id q17so3742569ybg.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 06:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dHt2S/eHnuKMaFVOCTCD+XLI8dbM2SepEcYxIoBqtOc=;
        b=0iR/rSpZK5sRoqBjH7aHCbbIDCt9slg0oI5AM5Df5HC2/gABPwKXxTURgNX2orBmXR
         TxOpGKkmFEFcceDFbpU3SH4X56cw21bnV/mSaO/lmMf/aUwWg6f7BOnDtQ7npHAapFN7
         UDRR4QOFLiZqWLEUivfv2R20kOGSGnCQE+slMOxIvnK/YPKwqPP4pEfQew3oa8l+uMmL
         jEhelsfvUO/IuMKJS6piQQw2xQccKJU4uoiVq2dCaQ+8LeP/eNwLYJKWJenKBME7GYdY
         d56hsIO08Q5cx3EGCOqLGYS0bH1JJsCdbJ5opTEKVIvC5XlgZBOQvcDMRzP6M6ccojLc
         lWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dHt2S/eHnuKMaFVOCTCD+XLI8dbM2SepEcYxIoBqtOc=;
        b=qO8c9Q70d/PPsDXNO7AhJH7w1C+dHoeoqOq6CoOCIIg7Rz5ulqE/AJWTPXU2+S+1ut
         qpSckvEfsT/WU6ZPc9RgycdbPzqQ6JaEdenI1u9v9Cwze4IRUWaLoyMtQT+Dhgsj0X+4
         X7g8zJaUmxS+2dptV1Eod1iZ8IQLa1M1EBpctzadFGHUZJWaVjQGnnUOTPyLt4NoVNb+
         kyKBpmRm3WQjmledtgNeOSMHndOFG6aKBPa/zYhJPQrSNXK+gth14932V0YFawx1p6H5
         SX+yM19eLhmEH/0py3bRveOm7LogWTKpAZ0475GCgamyceR7VlHFQ9vDwN+OiAkAixhi
         860Q==
X-Gm-Message-State: APjAAAV8yhaLB+AknYG6sJ3Iu7U5jCyiv7KhPHDFiovaodnN8KS6JYo8
        Ezmzg+f3EsxFp0gaKbjZYpWzAw==
X-Google-Smtp-Source: APXvYqzesyF93cx5B6ZeI757gP4DnjhM9xiNx+ZNqFo4+3VSkeNTngACz+MV87SdCBxZbnPhdWKotA==
X-Received: by 2002:a25:5ec5:: with SMTP id s188mr5846274ybb.500.1556543774205;
        Mon, 29 Apr 2019 06:16:14 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (adsl-173-228-226-134.prtc.net. [173.228.226.134])
        by smtp.gmail.com with ESMTPSA id b69sm649273ywh.18.2019.04.29.06.16.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 06:16:13 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id C6CBC30008B; Mon, 29 Apr 2019 16:16:12 +0300 (+03)
Date:   Mon, 29 Apr 2019 16:16:12 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, keescook@chromium.org,
        peterz@infradead.org, thgarnie@google.com,
        herbert@gondor.apana.org.au, mike.travis@hpe.com,
        frank.ramsay@hpe.com, yamada.masahiro@socionext.com
Subject: Re: [PATCH v3 RESEND 2/2] x86/mm/KASLR: Fix the size of vmemmap
 section
Message-ID: <20190429131612.y7ee2hbujeondcko@kshutemo-mobl1>
References: <20190414072804.12560-1-bhe@redhat.com>
 <20190414072804.12560-3-bhe@redhat.com>
 <20190422091045.GB3584@localhost.localdomain>
 <20190428185408.macoxstmy5awsago@kshutemo-mobl1>
 <20190429081246.GT3584@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429081246.GT3584@localhost.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 04:12:46PM +0800, Baoquan He wrote:
> > > +	 * Calculate how many TB vmemmap region needs, and aligned to
> > > +	 * 1TB boundary.
> > > +	 */
> > > +	vmemmap_size = (kaslr_regions[0].size_tb << (TB_SHIFT - PAGE_SHIFT)) *
> > > +		sizeof(struct page);
> > 
> > Hm. Don't we need to take into account alignment requirements for struct
> > page here? I'm worried about some exotic debug kernel config where
> > sizeof(struct page) doesn't satify __alignof__(struct page).
> 
> I know sizeof(struct page) has handled its own struct alignment and
> padding.

I didn't realize that. Sorry for the noise.

Acked-by: Kirill A. Shutemov <kirill@linux.intel.com>

-- 
 Kirill A. Shutemov
