Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5FBC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83AC2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570547792;
	bh=HBPyM3fbQmTRXscejMZaaT3oltRHFHQ/AKn9AwmsNPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O33D0nScmEgDT4cdrVgx3d+vD8zPM7c6oSTVvUKGvay1CL9ZKN5rQ+3pdjBJvnJyh
	 386LRUoEqoG2Q5c/kH59GiJ1HJztYZUvUQvK5ewB6JEONoAQfbgtXjbrFS4DdrhmVW
	 d/QY5LNaxqitBmlshMi2K39p97O+nB2lCMyy3uNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfJHPQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:16:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:47048 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfJHPQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:16:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id b8so4058768pgm.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 08:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HBPyM3fbQmTRXscejMZaaT3oltRHFHQ/AKn9AwmsNPM=;
        b=RDQDDpTGcJ+CU5oG20pFY3+f/912vgZHPuOBlJgUk1GvQDsUpfZWJBhtrPPKHGfKin
         c5AdPIUJyuSFtv4Ck3+oddWe8kHzE2HPZDNDS+7KJmU8uLuldtt7ZDdvCtovD0E8VbrN
         btPCwrL3cx9q+KOhIImmLCHtb+dFYgRngz/lyeNtpz0fdmTtEbdk7+Fz3SCLciVUP8iF
         FOMIIRUR+k/RWlUzyE/tzCGnpQtp9VJl/Vx/3M0b8oGasvTFtiehokX7qML5vIXF4rc5
         4aa50AzB2ptrVVEy6mvF0FrXSQg268RXPTed+3GNECqZM2flg+XDeq16K0Nqpm/XlsWf
         +KjA==
X-Gm-Message-State: APjAAAX0c8biphVW0Rpa9j8l9hLOVy4CF9wLPEdY5faNGKTGRdUzdxhd
        Sgx+OpiwKwkjVNPpXDxeu6lpbGmmIKg=
X-Google-Smtp-Source: APXvYqxL4tqZxI7W5Qba4JPc57Aq4UBeRh411inoIg4ZNNcMTEOzHxTu5bSzWPdCj/QC8rP4guJXAg==
X-Received: by 2002:a17:90a:8001:: with SMTP id b1mr6336570pjn.10.1570547790809;
        Tue, 08 Oct 2019 08:16:30 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id e21sm13287017pgk.57.2019.10.08.08.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 08:16:29 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id D3FE140255; Tue,  8 Oct 2019 15:16:28 +0000 (UTC)
Date:   Tue, 8 Oct 2019 15:16:28 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tuowen Zhao <ztuowen@gmail.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        acelan.kao@canonical.com, bhelgaas@google.com,
        kai.heng.feng@canonical.com
Subject: Re: [PATCH v2] mfd: intel-lpss: use devm_ioremap_uc for MMIO
Message-ID: <20191008151628.GA16384@42.do-not-panic.com>
References: <20191007184231.13256-1-ztuowen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007184231.13256-1-ztuowen@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 12:42:31PM -0600, Tuowen Zhao wrote:
> +EXPORT_SYMBOL(devm_ioremap_uc);

EXPORT_SYMBOL_GPL() would be my preference.

 Luis
