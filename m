Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363EEECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7FA21D7D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="05qWHKg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbfJNNgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:36:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44230 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731743AbfJNNgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:36:48 -0400
Received: by mail-lj1-f196.google.com with SMTP id m13so16623679ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 06:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kwbPVljcr0NSCLljc0OrTvv7XNYrir6ZBXGML3SSjPU=;
        b=05qWHKg+TrOwztU4ZAot6PDVHWWpQZxid79fo7XRrrioC8Lnc3sSuSc2AYMczUkUSw
         CkbNN+k3FcFi080be2vjjn8VAsMeKfzSxNry3wbMacWHSYD0iwRiSW+AeUri83swD8Ya
         07bYiepu9TWx+9bjcdxDEYSx7lUiZXk/7r+Uk0lWt6YChTAkfWPzx4sZgPoS6PDO2CIF
         bzGesDWFfKoCqzRXCov9hjmYv210ylBItSLFgcc9qIkV9ap9/GtKMLysd6ACbBQjRD2k
         Ek0s+DYRtOUJ3qyhNrUBsKbjbqFLbc4Y9tZ7aIIEiBUKZjs91A6JWVekds0tHqWssr8T
         7c4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kwbPVljcr0NSCLljc0OrTvv7XNYrir6ZBXGML3SSjPU=;
        b=bmYN3LRACLCVeMVFJkzh9nMe4u3YkK/10hq2hSC5+SU8FIDLYLUAwiHQGT3PjYUvKg
         rMto8jDiY8ss3mU/LaO0AmMOh+HZ45FKUlB7OXOOPhFg832W/Fvuf+5pt+exi+vT4fPZ
         ECMxblJYCenXFpk85xsLBdlPHmjnw2N0m8YLDiCsRjU4IGU6FOZESKlyag5HSbUWCLUq
         //K1vj27/drkDlqFB2UflANWmU4BiyLui6X9KLHMqH9FXd0xmjke0OabyjaxN1RkcbEt
         oyEsTdac+PAT3YlKd/INqZ9g5ZdlIWdfPn7YEHgNr17co+azwi7k9ulykBjh9s+Fn8Qo
         s6oA==
X-Gm-Message-State: APjAAAVuQkiB+ofcszbgJRV6lFuXYrHo9TJk5u7cPhv7f9FFXANEuqVl
        ZqJM3TUuL9I8X7v4NyXFapPHBg==
X-Google-Smtp-Source: APXvYqyM5oyga4VW1RouFU2Br7VQCRYE/EjO/xLpNOZBGALk/H00a8Cezl8WSlGhqQd/ZpQ+hGkhyQ==
X-Received: by 2002:a2e:9d3:: with SMTP id 202mr16473401ljj.112.1571060206393;
        Mon, 14 Oct 2019 06:36:46 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t8sm4215037lfc.80.2019.10.14.06.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 06:36:45 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id BF773101288; Mon, 14 Oct 2019 16:36:44 +0300 (+03)
Date:   Mon, 14 Oct 2019 16:36:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/gup_benchmark: add a missing "w" to getopt string
Message-ID: <20191014133644.ecjlss24e5fy7tkl@box>
References: <20191013221155.382378-1-jhubbard@nvidia.com>
 <20191013221155.382378-2-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191013221155.382378-2-jhubbard@nvidia.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2019 at 03:11:54PM -0700, John Hubbard wrote:
> Even though gup_benchmark.c has code to handle the -w
> command-line option, the "w" is not part of the getopt
> string. It looks as if it has been missing the whole time.
> 
> On my machine, this leads naturally to the following
> predictable result:
> 
> $ sudo ./gup_benchmark -w
> ./gup_benchmark: invalid option -- 'w'
> 
> ...which is fixed, with this commit.
> 
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
