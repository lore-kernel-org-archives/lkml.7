Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6F0C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D5D420844
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PVaDn1Ye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfHMQsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 12:48:46 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42906 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfHMQsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 12:48:46 -0400
Received: by mail-ot1-f66.google.com with SMTP id j7so30294943ota.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=wWYXt7jx7G31cd0rE9luks4j70Eji+/vHa4Z1GbiX1s=;
        b=PVaDn1YePRT9j9KWakxbJ5aZbPHOe1J33ryNWuvT223ufkBNGNMfeasLJ4OrxmwPQZ
         zC9YYVf5EuudnD8g2gF+COcciyXunWMzIWBn3kPO03qtPucFcPSAcXnoBJ6kR8EpWhD1
         n2kN9d52DP0eEmM3jbQMP5LVdVgEvBpuKKVeVwA4eSx6BVuM8ibVKAoD7BR6I9ULnXs5
         FAoNg0DL0iJBEqca3QwrsWRVpN2G6Rn3ar6llSZc784HZGsYUJgp2ajlMF+fYDPicuzH
         95qrxSmcS0SEyuOAfEnmAETTEAs+VX2awtZGt/ux0Jucg+YEytTtvv1a97y1iTAEt4ja
         F88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=wWYXt7jx7G31cd0rE9luks4j70Eji+/vHa4Z1GbiX1s=;
        b=N3upIU1OULUHruXflvxxi+Heh+lbmzxeteNaR7svuQrjsR5YIPKx+JIOlxlWUKjWEA
         GXzkYHYmlY267SQSZyvfPTDGqhkweIPDJUSizQ3J8kNwd2oYt60yomVNcmg+1TMXPEZk
         Cbilyu0zr2mHzF65bPiMLzl74j0d5AeRJfzS2FnjDJWZWnlJWaPb8affcxs5bDGyy0Ay
         a0Sc7BedOp6QQRfOu0tYWj9UISnwEuoLt72WpIH04OFIt4e+k3HVfrL2VTIGe3L0RRYH
         GAC77GcpKzoCdx+5jZtuW5rFxTkLm/JYSxtnp21Uzx3PoDERkxOfwqinpqhfv4rTZrda
         ccLg==
X-Gm-Message-State: APjAAAVcOiatYwUB9qrGKNuRHLxGMaS6x0JKEzRslcqO0TrNsoCqIJFc
        8v9bHt//nI5KYbfayiJ8qgvaIxOmKQI=
X-Google-Smtp-Source: APXvYqxPVuDBsGAd9o9o1k5X+B5nMlPiCHWLeDxvNl/FUOtJzCoioboXTdGD/sGypvrgZDoyB/qP5A==
X-Received: by 2002:a5d:8497:: with SMTP id t23mr39094733iom.298.1565714925017;
        Tue, 13 Aug 2019 09:48:45 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id t19sm91323213iog.41.2019.08.13.09.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 09:48:44 -0700 (PDT)
Date:   Tue, 13 Aug 2019 09:48:43 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Logan Gunthorpe <logang@deltatee.com>
cc:     Greentime Hu <green.hu@gmail.com>, Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Waterman <andrew@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Bates <sbates@raithlin.com>,
        Olof Johansson <olof@lixom.net>, greentime.hu@sifive.com,
        linux-riscv@lists.infradead.org,
        Michael Clark <michaeljclark@mac.com>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org
Subject: Re: [PATCH v4 2/2] RISC-V: Implement sparsemem
In-Reply-To: <alpine.DEB.2.21.9999.1908130921170.30024@viisi.sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1908130947130.30024@viisi.sifive.com>
References: <20190109203911.7887-1-logang@deltatee.com> <20190109203911.7887-3-logang@deltatee.com> <CAEbi=3d0RNVKbDUwRL-o70O12XBV7q6n_UT-pLqFoh9omYJZKQ@mail.gmail.com> <c4298fdd-6fd6-fa7f-73f7-5ff016788e49@deltatee.com> <CAEbi=3cn4+7zk2DU1iRa45CDwTsJYfkAV8jXHf-S7Jz63eYy-A@mail.gmail.com>
 <CAEbi=3eZcgWevpX9VO9ohgxVDFVprk_t52Xbs3-TdtZ+js3NVA@mail.gmail.com> <0926a261-520e-4c40-f926-ddd40bb8ce44@deltatee.com> <CAEbi=3ebNM-t_vA4OA7KCvQUF08o6VmL1j=kMojVnYsYsN_fBw@mail.gmail.com> <e2603558-7b2c-2e5f-e28c-f01782dc4e66@deltatee.com>
 <CAEbi=3d7_xefYaVXEnMJW49Bzdbbmc2+UOwXWrCiBo7YkTAihg@mail.gmail.com> <96156909-1453-d487-ff66-a041d67c74d6@deltatee.com> <CAEbi=3dC86dhGdwdarS_x+6-5=WPydUBKjo613qRZxKLDAqU_g@mail.gmail.com> <5506c875-9387-acc9-a7fe-5b7c10036c40@deltatee.com>
 <alpine.DEB.2.21.9999.1908130921170.30024@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2019, Paul Walmsley wrote:

> On Tue, 13 Aug 2019, Logan Gunthorpe wrote:
> 
> > On 2019-08-13 12:04 a.m., Greentime Hu wrote:
> > 
> > > Every architecture with mmu defines their own pfn_valid().
> > 
> > Not true. Arm64, for example just uses the generic implementation in
> > mmzone.h. 
> 
> arm64 seems to define their own:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/Kconfig#n899
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/mm/init.c#n235
> 
> While there are many architectures which have their own pfn_valid(); 
> oddly, almost none of them set HAVE_ARCH_PFN_VALID ?

(fixed the linux-mm@ address)


- Paul
