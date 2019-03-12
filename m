Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D87C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AAA52147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="blbB8jjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfCLHj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:39:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33402 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfCLHj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:39:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id h11so1197125pgl.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 00:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dtBQTLJH4XIW9A5l2bEldda5MgmOrBYw4b20dV2Mnts=;
        b=blbB8jjfvMX3sbrmLAM0lEzjlSCbPqSLKmLnv/Hc7fwRGI5Gps89s9513PxB71vvoE
         BMbSnXnW9aOW3qVWIBipRnWJlHO7QRqPxIWEt4TfnithpRrK94xlFHdfodP+8TXNj7vM
         GYNl3I89uoj0ilGyUB7q6UC9EZ5s3mb7bDFJee4p8H5rnjAxfaIY5LLzEZEntMzDucvd
         9J4lufapufePN7HpkYUMsLb8njjdMUZ912+1+z5EY/ZW1Kv5Pz7XK8IT2IWU+NfToR5v
         JCY+4nXw//aVuv42S55N1uKFnP7HrySVb7A/hki2lc/z5xknI5AxSSMiJt+B+qy1hJYU
         jWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dtBQTLJH4XIW9A5l2bEldda5MgmOrBYw4b20dV2Mnts=;
        b=scAhSF+rFYgZSvropftiK1t1orXaGaFeN8uitGT1AV/vj9qZ5rX5xJghibz9FxLnZs
         AkGOBYiBBKRh1UwrRcEeF8EB/4dJ9Kk9um8f6qnp2vS7tgJcQy3MYONTMe2qut/mFQbA
         rNzixd7PaaEIz8EeVqNYDA2j4Z56wotLnby+Dkz4joLF02AUtVwrB72jb9baIvdHLf7R
         72McfvJlcmfbmMu8iZ8cpWJMbblhvmD1uGYpJajxldQeghhqxYbl9HkWUMy3Qly8Kt+w
         WN+Z8+qogGQuqzNz0rEEqnsi7nM3C8wuiUMF3xiGA3OfiOmtZgUjsp0Nz4lXkBeQSmXA
         66WQ==
X-Gm-Message-State: APjAAAVXm0a0MGPoiKj/7bff0haCdsO916nCsYCPhr7mvGc65DYgCnfr
        cRj+g/21sJYdfUaK17Cm3GNpBw==
X-Google-Smtp-Source: APXvYqwHnyb8CrmuFZI1pS9+dmo/Ml+MMKdG9jq8uB1XjKOynpwD2wD4JPuJABXXwZi2H3dgFfET+g==
X-Received: by 2002:a62:ae0b:: with SMTP id q11mr37351335pff.199.1552376396008;
        Tue, 12 Mar 2019 00:39:56 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain (fmdmzpr04-ext.fm.intel.com. [192.55.54.39])
        by smtp.gmail.com with ESMTPSA id m3sm9319299pgp.85.2019.03.12.00.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 00:39:55 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 1D70E3011CA; Tue, 12 Mar 2019 10:39:53 +0300 (+03)
Date:   Tue, 12 Mar 2019 10:39:53 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, keescook@chromium.org, thgarnie@google.com
Subject: Re: [PATCH v3 2/2] x86/mm/KASLR: Change the granularity of
 randomization to PUD size in 5-level
Message-ID: <20190312073953.zctjqb425e355ktz@kshutemo-mobl1>
References: <20190308025616.21440-1-bhe@redhat.com>
 <20190308025616.21440-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308025616.21440-3-bhe@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 10:56:16AM +0800, Baoquan He wrote:
> The current randomization granularity of 5-level is 512 GB. Improve
> it to 1 GB. This can add more randomness to memory region KASLR in
> 5-level paging mode
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
