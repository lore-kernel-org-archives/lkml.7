Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A141C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F8A20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QgjtEf1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbfDCKCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:02:11 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37896 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfDCKCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:02:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id 10so7905409pfo.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 03:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jXXMRViE7HfgxXDCHpZSJCDXHIFj5f0y8nGmi0ABAOg=;
        b=QgjtEf1PSS3mrBFCgcF2bveEKxAOWn8plhxriVQEPrmlVZhY0Nce8fl3okYEIJJEvw
         HnBg2utE3hv2+IMN9z+IRWLO8TU+4mNBA1AqYxtg4W4fifycLDxSrs93VO425HFtLqxG
         8bI8DgTZqtkXy3QAMPvD+tWq++X5UiJRsQbjiKHSVLct7za/ehWMgSwJKDqvAwCpHqpt
         KOZ7b8hL/oULpBfxDwhs1GQu5IBOXfCHH4lFY5IMxjx+NxgmseIZiO+YxduyM2v06PJV
         qyN6ghrgLSXSc0xUM/50eEtTY1NLGONlGAqsDf3jUixHgintSnNzfR4NtZLQEVB5CqbN
         IYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jXXMRViE7HfgxXDCHpZSJCDXHIFj5f0y8nGmi0ABAOg=;
        b=R4xElezrHZ+dbSHkPTapBSeHAWLy79bZQeqq9tDVn8XfdNYrgENYZIN/UZm1UYsNs7
         59Jl3Jl2NImcgxIjpcxaj82ATHSxLWq6sF+0XC27Bw9dbrg6VvXf79UB/TZ4w9Y5mLZd
         kUGxpzB+DY5NohONwurhhqlPpONATibmY/o3ZXJfEDInwctC9qNSn2UZfYisKDWpq/TN
         EKmggyNTmQ30kk6g24PgWOGSofoKmH2td3TFWuSyGQWQh6SLtvcQCTSe74kk/nb6Q+zz
         Bc5musGPzUObhYueTQxMVgEZnTXEzdNilDXEN9spyR73TnQs+LI4/ChsLdJSr268wMRa
         ITAw==
X-Gm-Message-State: APjAAAVobbCVyM4ye6ycS1qF1py2SCSF1gJXdxk0FMFaw86OYkuOB34P
        qVDN1k1evnEPZiZM6EapJAmtHQ==
X-Google-Smtp-Source: APXvYqz4h4EIpIiLz5HoM/VMfFYuz80OVG5ghqCOJusp5mZd5/PA/KM4dNnH21YtKBNhn7Akc1xsjg==
X-Received: by 2002:a62:292:: with SMTP id 140mr41910042pfc.206.1554285729686;
        Wed, 03 Apr 2019 03:02:09 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id u62sm29492181pfa.124.2019.04.03.03.02.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 03:02:08 -0700 (PDT)
Date:   Wed, 3 Apr 2019 11:02:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: linux-next: Tree for Mar 27 (sunxi clk & mfd)
Message-ID: <20190403100204.GL11301@dell>
References: <20190327145020.2fff97b8@canb.auug.org.au>
 <641a04ec-e2e6-4263-e77e-d272058c18c9@infradead.org>
 <20190328095036.734adbba@canb.auug.org.au>
 <20190401102732.GD4187@dell>
 <20190401223624.6b4f8c42@canb.auug.org.au>
 <20190401123337.2nhppxyl5nzyofub@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190401123337.2nhppxyl5nzyofub@flea>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Apr 2019, Maxime Ripard wrote:

> On Mon, Apr 01, 2019 at 10:36:24PM +1100, Stephen Rothwell wrote:
> > Hi Lee,
> >
> > On Mon, 1 Apr 2019 11:27:32 +0100 Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Thu, 28 Mar 2019, Stephen Rothwell wrote:
> > >
> > > > I reported that a while ago (x86_64 allmodconfig after the merge of the
> > > > sunxi tree).  Apparently there is a fix out there but it hasn't been
> > > > applied yet.
> > >
> > > Where is the fix to be applied?  SUNXI or MFD?
> >
> > Well, I only see the problem after applying the sunxi tree (which
> > happens before I merge the mfd tree).
> >
> > Maxime said:
> >
> > > I've just sent a patch fixing this:
> > > https://lore.kernel.org/lkml/20190322091650.5189-1-maxime.ripard@bootlin.com/
> >
> > So maybe if you (Lee) acked it, Maxime could apply it to the sunxi
> > tree, so we keep the breakage and fix together?  Assuming that the fix
> > is acceptable (and works :-)).
> 
> That works for me

That patch has been applied in my -fixes branch, so should be repaired
before it breaks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
