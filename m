Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57696C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 20:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7702081C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 20:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="a3XgxIYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfECUiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 16:38:54 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:36240 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfECUix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 16:38:53 -0400
Received: by mail-qt1-f174.google.com with SMTP id c35so8290623qtk.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 13:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8tPVzyCxevz7vaRRVLlXkojOrnYFDky2SPWQCyXh6gU=;
        b=a3XgxIYysWPc+FKMoGx5n77e17z5A4FMicm3QGWq3xjBavCSL1JHFd85wIDXzfLuBH
         O7nQ7tq/1uXTTssayyLdOS5GOHmlmlYZdRPmbNeFfYuSLB+8Welisfdrj8HiKryNWj7B
         3qjreLTmdkndMxaau6B/9GcSyphKYdAU79ibyUDM/Kpm6pmU80ygIvAN1t5axlToP3OJ
         35LYp/Njg8r36vpKiFdM7JfJlSObpM5E8Q+/satWf+ax2HcSTWoRfGUcb7M7TUdD8Bwe
         /jPqO6FI/K4Ei5jEZtKnGNzskiMWoozXIEGukaxZpEjS9Wi5FLqFKfMzX60jCk3PpfMU
         2qTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8tPVzyCxevz7vaRRVLlXkojOrnYFDky2SPWQCyXh6gU=;
        b=N1Xx9c9AXkN0r0sbsKlmMbCGBvUXEKdtbsYlaBPHVs0PsNAm1iDMzX6X/89ODVl6pd
         jUcF7APKA/JexhjmYpivwDLTOnAsU2gs35c1DgiTE2wamdt+UhF2eYBz23Cg30tRmLbw
         3UOt4iK884q+uPsseWyveqPTHcg20E6QRwSnU/Tq2sg+2ZPFUZmaos6BfjHS6CMZI15p
         SjkltbDRBl0NSw7euOhs6KbAolASGm49chxzM7PBPcv6UR6QWJomdtk8+3XEkiPRv0bk
         yOy5y9oKEk6yR2PSMUDq3oG7D03N7ka1dO5fQ5VJNaHPU5mPbhXpdhaotRp/Ycu1eCTE
         Yz7A==
X-Gm-Message-State: APjAAAUWmZlKqgjG0rgz9HRcbzfPdTb01cscocDAKiWhHt2+F/vSXr+1
        iA2jMT8TpM6fFLKJIBhxcY3e2w==
X-Google-Smtp-Source: APXvYqygYpFaSjaM6wxI+nnmZguKF7zaKCDNH9I92+y5gfIS3DPW0JLU1WkfEzNGOFrd46iUbfkPLQ==
X-Received: by 2002:a0c:994a:: with SMTP id i10mr8618712qvd.48.1556915932314;
        Fri, 03 May 2019 13:38:52 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 46sm2028708qto.57.2019.05.03.13.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 13:38:51 -0700 (PDT)
Message-ID: <1556915930.6132.16.camel@lca.pw>
Subject: Re: "iommu/amd: Set exclusion range correctly" causes smartpqi
 offline
From:   Qian Cai <cai@lca.pw>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     iommu@lists.linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 03 May 2019 16:38:50 -0400
In-Reply-To: <20190429142326.GA4678@suse.de>
References: <1556290348.6132.6.camel@lca.pw> <20190426152632.GC3173@suse.de>
         <1556294112.6132.7.camel@lca.pw> <20190429142326.GA4678@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-04-29 at 16:23 +0200, Joerg Roedel wrote:
> On Fri, Apr 26, 2019 at 11:55:12AM -0400, Qian Cai wrote:
> > https://git.sr.ht/~cai/linux-debug/blob/master/dmesg
> 
> Thanks, I can't see any definitions for unity ranges or exclusion ranges
> in the IVRS table dump, which makes it even more weird.
> 
> Can you please send me the output of
> 
> 	for f in `ls -1 /sys/kernel/iommu_groups/*/reserved_regions`; do echo "-
> --$f"; cat $f;done
> 
> to double-check?

https://git.sr.ht/~cai/linux-debug/blob/master/iommu
