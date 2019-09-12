Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12290C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1B6208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="VxIrmrgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbfILJkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:40:40 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45016 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730818AbfILJkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:40:37 -0400
Received: by mail-ed1-f67.google.com with SMTP id p2so22145128edx.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 02:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y6RE2XQhRzZWupLEteqsLYHDuJ01Xgu0HTXHplF3Lm0=;
        b=VxIrmrgBlvUhodILVlykpcbHTyK0rkk/gKxD4Mo/n2XpRy5Bjdyb/Xeaod3knVMBGj
         C4fP5pHsIO/ZyVSuLjMubCrm63a5mEpQ5Fa98A7/Hl8BYWR4DTEjP0l6JdqU4SFNRYlT
         uylQmJNDf032FIgFfKyBx9w+ITKf7yL4DTfq389idXvIisvG19NNalIX/JHPOKbinmTL
         +16kfCy8/2XBltprgKXqcs92CdMEg8R5q4JLCUyFBP4jIGtSSm56QyBEMVMpx2Na+yMA
         GZLdExB3U1JCUSrteUIMaqnvo1XYH6w0rmTyD3IDn2Fn+YljNIncJqaWYrJIPqlGC+zH
         JR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y6RE2XQhRzZWupLEteqsLYHDuJ01Xgu0HTXHplF3Lm0=;
        b=eN3ItfwyjDspMHGhXmn7zGRPXDzevxgJBPjzE77DOCVZwPZP4Cp4hpBghivPX0YL/v
         IwGioztPyb1/5XlqisBcAqHzT7KxntGJE4xhxHUsKflqm7ZaGFI4c3VRszsfq5AZda3Q
         awjc5IcGhA2YwIAFm4+b2mE7JQ4Z0LEtyesXsPhesn/CmabIcmJ4OwOTbFa+0Su/6UuM
         Bt0XDayYdlAEf2HwtrPuNSJBpn9NawoSt9tOq1dtjIetz0UEByguwJh8oRiD/D9nqGAS
         nEC+S+pTiClZkSRdk6PkGWntJjjTE6kp+1FLrVcyhuHe3pQCdCMOTOLYz2zJEkpZKh+5
         mJxQ==
X-Gm-Message-State: APjAAAU6lPV86rSIfs8F9/mB58ku/r822oBeGQaDa10hWLj5WCw72z1b
        GLVGceQPr0zAAdPqeiDYyn+TwA==
X-Google-Smtp-Source: APXvYqwEIAM5TzJzwqPjVyP0/PDYdmqyk2EIzasslST9N6YDcosm0gquqF+rkSnHKuztcfUwgiD+Vg==
X-Received: by 2002:a50:ed0f:: with SMTP id j15mr33181121eds.127.1568281235525;
        Thu, 12 Sep 2019 02:40:35 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id rh20sm2765695ejb.39.2019.09.12.02.40.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 02:40:34 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id BBBE7100B4A; Thu, 12 Sep 2019 12:40:35 +0300 (+03)
Date:   Thu, 12 Sep 2019 12:40:35 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] mm: correct mask size for slub page->objects
Message-ID: <20190912094035.vkqnj24bwh33yvia@box>
References: <20190912004401.jdemtajrspetk3fh@box>
 <20190912023111.219636-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190912023111.219636-1-yuzhao@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 08:31:08PM -0600, Yu Zhao wrote:
> Mask of slub objects per page shouldn't be larger than what
> page->objects can hold.
> 
> It requires more than 2^15 objects to hit the problem, and I don't
> think anybody would. It'd be nice to have the mask fixed, but not
> really worth cc'ing the stable.
> 
> Fixes: 50d5c41cd151 ("slub: Do not use frozen page flag but a bit in the page counters")
> Signed-off-by: Yu Zhao <yuzhao@google.com>

I don't think the patch fixes anything.

Yes, we have one spare bit between order and number of object that is not
used and always zero. So what?

I can imagine for some microarchitecures accessing higher 16 bits of int
is cheaper than shifting by 15.

-- 
 Kirill A. Shutemov
