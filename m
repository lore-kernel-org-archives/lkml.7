Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE70EC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 09:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7380A206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 09:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="SmOp2/8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbfIPJBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 05:01:00 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44868 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729814AbfIPJBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 05:01:00 -0400
Received: by mail-ed1-f67.google.com with SMTP id p2so31147956edx.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 02:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=er96rzJy8m0L95tTuXzi8WIH2vptqn2ETGcCC1nz+wA=;
        b=SmOp2/8iZnr3/Cv1M5RU79r1a8co1YuZyfIxr2vztk8sViEsofpCUzNrAFRmK4y/YY
         6BXSKgjYWflM3cC+0ruQl7x1+6faJZOqZjDmN7j/6LF88bp+8IQyKFFz6qqUBJxUaFjz
         RPm0SOMWO8IaZNPufEO/w9mcl74GFe2sCuZ48MYtS0Sdv3wtyTXzt0OvvijIpY4JSPIg
         /oo2DSvVR1ogiI0UiW6fBRPxEbvGCrWJnQwzgMI5KyvnnF1h1v/ALIFRCYjmDSB0f1VM
         yJNfwGEMnvIPo52sIP348e7nvQzaaKH5Y3lF6/MfM2LbPwygjqvKlLaiDAH+vLch0XVj
         JFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=er96rzJy8m0L95tTuXzi8WIH2vptqn2ETGcCC1nz+wA=;
        b=s0jVGf6LKG1BEIvnuLsBuLeCJFOEltBvCvmOpp9G1iyjcCvoyTh2keS0lA5RDClZRr
         oxwhkoMOYrcm3Zr3ivkoXVD7sEOBv6i/fLnCL4yr1trg1GR15fpr8XW9Q8Kd0diKvhma
         qiv6B8LnO5wqOB4Mm+qDxknSqvY/pI6STy/kA+nzH4fQE/NK1/Y2jdwFiCnv5XhgrSQr
         q6bDetHCYUfFynHy1TFAs2KA9rSXp2VQE9WqFV9DhMUwscb4Dqa4RWw2XX6uZutNbJZF
         xW339RAT0uXU1kzVci7OOGSI/LV6pyOGE8e36osBxzmGmKp94U4DQGctDZU5KPYnnhJ8
         SS9g==
X-Gm-Message-State: APjAAAUZXfiJsTJ5zabV+sLIGrMoe9Wl9njfh7xnr85y/K3J5oh6TKP6
        LG/bG5nucsOtWu9VsYATnF//QA==
X-Google-Smtp-Source: APXvYqyd3BFzlQo/i4y4BcklCS002d0M9G7bdkAQxQCDctsdI5FGhFvAACXa7Nts8EQrvUrJhkjXJA==
X-Received: by 2002:a17:906:308d:: with SMTP id 13mr30829774ejv.207.1568624457492;
        Mon, 16 Sep 2019 02:00:57 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id oh24sm4220165ejb.79.2019.09.16.02.00.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 02:00:56 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 970C8104174; Mon, 16 Sep 2019 12:00:58 +0300 (+03)
Date:   Mon, 16 Sep 2019 12:00:58 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Jordan Borgner <mail@jordan-borgner.de>,
        Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org,
        Baoquan He <bhe@redhat.com>, russ.anderson@hpe.com,
        dimitri.sivanich@hpe.com, mike.travis@hpe.com
Subject: Re: [PATCH] x86/boot/64: Make level2_kernel_pgt pages invalid
 outside kernel area.
Message-ID: <20190916090058.mteofmkkl37ob47k@box.shutemov.name>
References: <20190906212950.GA7792@swahl-linux>
 <20190909081414.5e3q47fzzruesscx@box>
 <20190910142810.GA7834@swahl-linux>
 <20190911002856.mx44pmswcjfpfjsb@box.shutemov.name>
 <20190911200835.GD7834@swahl-linux>
 <20190912101917.mbobjvkxhfttxddd@box>
 <20190913151415.GG7834@swahl-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913151415.GG7834@swahl-linux>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 10:14:15AM -0500, Steve Wahl wrote:
> On Thu, Sep 12, 2019 at 01:19:17PM +0300, Kirill A. Shutemov wrote:
> > On Wed, Sep 11, 2019 at 03:08:35PM -0500, Steve Wahl wrote:
> > > Thank you for your time looking into this with me!
> > 
> > With all this explanation the original patch looks sane to me.
> > 
> > But I would like to see more information from this thread in the commit
> > message and some comments in the code on why it's crucial not to map more
> > than needed.
> 
> I am working on this.
> 
> > I think we also need to make it clear that this is workaround for a broken
> > hardware: speculative execution must not trigger a halt.
> 
> I think the word broken is a bit loaded here.  According to the UEFI
> spec (version 2.8, page 167), "Regions that are backed by the physical
> hardware, but are not supposed to be accessed by the OS, must be
> returned as EfiReservedMemoryType."  Our interpretation is that
> includes speculative accesses.

+Dave.

I don't think it is. Speculative access is done by hardware, not OS.

BTW, isn't it a BIOS issue?

I believe it should have a way to hide a range of physical address space
from OS or force a caching mode on to exclude it from speculative
execution. Like setup MTRRs or something.

> I'd lean more toward "tightening of adherence to the spec required by
> some particular hardware."  Does that work for you?

Not really, no. I still believe it's issue of the platform, not OS.

-- 
 Kirill A. Shutemov
