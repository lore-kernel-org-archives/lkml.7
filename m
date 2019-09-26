Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7D5C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 14:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48BA222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 14:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="n+alj0kI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfIZONa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 10:13:30 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33850 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfIZONa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 10:13:30 -0400
Received: by mail-ed1-f66.google.com with SMTP id p10so2202310edq.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 07:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vn4RSijfnGv66ggFJIHwXLRfY5IYfYHE5mOxifctFWA=;
        b=n+alj0kI2bszwuP5vu089IXNWt6SHf9p9y/PJMEnOWrhUKD8kNwTwBQKaK5fJrBgJ0
         DLsEATPCu1u9frWLnWJWIySO/950XmCObL/Gfy3oUgeip9+24O/Kevhp2faieQm133hZ
         YNw7dsu929RVaHOXq2074z0GHJoqrzEhOU8oVre8VqrLoYIcYnj3Kquy6QY0DEGvbJF9
         Cjk2YXPboM8tV/rsJgR9z+EOCVi7mr401yopZh6xAVGwMCEjPBtSxnVsvXTKt/kPHWgz
         TIAvcTtaVXlXpExw64irCGAccUumoMGTA2pPYZd3HRp5N5Um9cWtUtTivWxdg7tYW/ay
         Zt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vn4RSijfnGv66ggFJIHwXLRfY5IYfYHE5mOxifctFWA=;
        b=hYpTEQ6CAQATqdaE3BHr+p9cuAG26K+TBV//unmvTyD3LwBr0HZ8ujxuq3IuHG5WHe
         gYpA/d5z0F8sTUdjjb71+jmSqZ7pNTijW3nl9D//YaQyOL5GnBl4qHubfDSO2rFCVEN4
         FWpaorEwdC2T6wdTicoh0N+K5/pdv1p/tMGFRTXOi2DWrFHEJnIvlUHVJC3Y9/mSaj2Z
         gEb7UncbCyxTsqGAv6TWv4mRwKhkTpZuVKdEH7ZZYp7Y8IbRS+bZESawrxxherFVVaNY
         sOWeVL8VPgcsrBOrr8H+KBc5Y2CpubftHHgiuIZ+MviTCYJkNdujLxpkmJg0lEO3dGdq
         j5rA==
X-Gm-Message-State: APjAAAW2ecwS/cZUjk6EGhgtjGeUvqlgJNfCdHcPoLAJP182jd3Cveun
        7D0W5Nsbvj49ssxrhFyB9WdANg==
X-Google-Smtp-Source: APXvYqzrQUqueSPMkuBVzXfwe7X+tnL71qVwO3XqRk0vg77XaF7BwKOfcf2zASWGr4wwQG+MuAQ8nA==
X-Received: by 2002:a17:906:1d03:: with SMTP id n3mr3296087ejh.287.1569507206884;
        Thu, 26 Sep 2019 07:13:26 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id bq13sm252145ejb.25.2019.09.26.07.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 07:13:26 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 4A304101CFB; Thu, 26 Sep 2019 17:13:29 +0300 (+03)
Date:   Thu, 26 Sep 2019 17:13:29 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/15] mm: Make prep_transhuge_page tail-callable
Message-ID: <20190926141329.zumbhytzrpx4ekmq@box>
References: <20190925005214.27240-1-willy@infradead.org>
 <20190925005214.27240-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925005214.27240-8-willy@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 05:52:06PM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> By permitting NULL or order-0 pages as an argument, and returning the
> argument, callers can write:
> 
> 	return prep_transhuge_page(alloc_pages(...));
> 
> instead of assigning the result to a temporary variable and conditionally
> passing that to prep_transhuge_page().

Patch makes sense, "tail-callable" made me think you want it to be able
accept tail pages. Can we re-phrase this?
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
