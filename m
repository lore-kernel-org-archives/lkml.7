Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707A3C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423AA2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="QFJ7Uj5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfENNMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 09:12:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34852 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfENNMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 09:12:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id g5so8262144plt.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 06:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8j4bTePHKvxQHvdCNJpe7zeTS2p9aPCumSJI0+OPUho=;
        b=QFJ7Uj5YexuFf6uISaOzUn230iNrGfeGlc5p43zd5sz3KohEp5mu1AieK2+nd3A4Ul
         eQMY2Z8dEI6SO527Hx3lpfx+qG6PFsMPpD8t0XJPiyUJoIEBsXU5wI/dI8+2+w1/Bl+0
         F7ItnZYkgweTYUPkCBIpXzOWiI6lbAftb+paqcWaapzMQYXvfTvEEGXQMmjkEZM7EvfU
         JDy5Nb6VX3ws3gAv+5glr4Pzo4FaSnwIq6LIsjLjUDxFyWz8vLdxOval9hI5sS5ZRJpl
         bt6XDed0yt9H9K/f2WX8NStrCnX2jieuEGxGp4X4QmG0/5+qsHIdzOxikX00+d+q7typ
         qEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8j4bTePHKvxQHvdCNJpe7zeTS2p9aPCumSJI0+OPUho=;
        b=drD7mRFXr3o9B8FNuUs95yK58fQaSjX7v6pSbAqDrRELb1ssTD04yfxdoPaEHrH1cq
         CJhyAK8JiAqgCIAHcNHOduL3J93bWj8dIyP1Kgf9+MLuesandT8sDQIBqbWL97QjQmfy
         hVjFZE4VhCPtjdZlw3aou4D8XWlLcQ47fZk4bQtMDKJXJKv4v150Gy7NU5Np3gn6f1pQ
         ryCPDF39wo638+wPoNIm2BcN5ugHRDeFxE4yDL5UH0eZSHde3GUH1+S85s5J+yVFbvWZ
         MvtjnXJlbHeYzRwuKKHIwnmnzR2CZePLfdfXQpCpVlC6a4PnEBcx53j+stJ5+KCNGQfo
         OV0w==
X-Gm-Message-State: APjAAAUb8Diz10MyjF3tMXnbFv9AiQP5K6qhxVDVQ4gdjSPEpSSiQUmW
        8AwpAm9vjSyMx4Cvl1Wo82zVXA==
X-Google-Smtp-Source: APXvYqxqgfcYr8ueqlj/ULqC7UHBgssWO16AHhzumldec5lumpiBNFn6b6GYsRNopPkPY29HgGR5nw==
X-Received: by 2002:a17:902:84:: with SMTP id a4mr37940501pla.210.1557839552080;
        Tue, 14 May 2019 06:12:32 -0700 (PDT)
Received: from box.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id 5sm2405005pfh.109.2019.05.14.06.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 06:12:30 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id F2F551007C1; Wed,  8 May 2019 17:47:39 +0300 (+03)
Date:   Wed, 8 May 2019 17:47:39 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Baoquan He <bhe@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, kirill.shutemov@linux.intel.com,
        keescook@chromium.org
Subject: Re: [PATCH v4] x86/mm/KASLR: Fix the size of vmemmap section
Message-ID: <20190508144739.we4owbvjmjisium5@box>
References: <20190508080417.15074-1-bhe@redhat.com>
 <20190508082418.GC24922@MiWiFi-R3L-srv>
 <20190508090424.GA19015@zn.tnic>
 <20190508093520.GD24922@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508093520.GD24922@MiWiFi-R3L-srv>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 05:35:20PM +0800, Baoquan He wrote:
> On 05/08/19 at 11:04am, Borislav Petkov wrote:
> > On Wed, May 08, 2019 at 04:24:18PM +0800, Baoquan He wrote:
> > > I think this's worth noticing stable tree:
> > > 
> > > Cc: stable@vger.kernel.org
> > 
> > Fixes: ?
> 
> Not sure which commit validated 5-level.
> 
> Hi Kirill,
> 
> Is this commit OK?
> 
> Fiexes: eedb92abb9bb ("x86/mm: Make virtual memory layout dynamic for CONFIG_X86_5LEVEL=y")

Yep.

-- 
 Kirill A. Shutemov
