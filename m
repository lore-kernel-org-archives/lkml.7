Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08B7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD12C21850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="UeOUYm2E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732151AbfB1JKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:10:07 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34023 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfB1JKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:10:06 -0500
Received: by mail-pf1-f195.google.com with SMTP id u9so9437044pfn.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 01:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OSiNA37Tf2ku65YCF81ErKBIY65FlNaIyw/AvC347Xo=;
        b=UeOUYm2EDIasSXX8n7AwcaB+Y26QXgo3ne3OzqntONrs1JkxtZgawnQj2dtYYkDHVU
         Dk9SRWhE2Zn3J37KmIh+EUhbZoF86KeaVVo9ka4Kr7bTYzrum5R/69d6qTayukOZbqNh
         g83AMKHX0koZsNFEOg8eUYBa9+WLxzSfDO8meN66lRKz1l6KYHxmIYZ8wFf4d/WvI6yY
         beCJIagJa4zUYoB0lErUaCZDjXGsVrMK5ku8BtK7eVGRS+y/04teHjn53n5WpHxS8zoj
         66QLu6CdcCpgNKB4zjxxPpR4wjv5/pQ/+51edHIN1iVBLLOJQv5mem1/0eqqIBDvvxGK
         Dqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OSiNA37Tf2ku65YCF81ErKBIY65FlNaIyw/AvC347Xo=;
        b=QAHgszsdDT5XUXZRFGPon3ZSoi7lP+nOT6HwxY0zBTH3aBfcmNNp++XHmP8nrkj3u5
         H29nOMdTlYqjewJMFpzLW5bw3/1TTg2wC0ghWSV/bZ9xRa+isbp2/762f4M03oijEgW3
         yPKTGoygCdPuyAHfKBtjnweP8W75xA5i39hLVUex+ooB4mXqWrqJbovraKhdikS2SLXc
         I2cBWhdsUDYMuV6l/3dMCe9WJ2XbAnYONelWbK1c35Rl1JWkydnYKmepDzMUuiL4OkVn
         978fmWv6K6K3GbHg6NR1R37A/YUwBAvmjdKDqpA5MUEwnhopC+ZOylONgY13hpkqjnQU
         VY5w==
X-Gm-Message-State: AHQUAuaZFHB772uP/w87aNuRqrNTcsmun88Qx+/Hel9sySan+f8bIasD
        tQD9PVBxWhhVkGxLY66FcVf9Qg==
X-Google-Smtp-Source: AHgI3IYHtjehm1QAhRvPxVr5EyR64Fp215g1nfipbbU76hd+jMINZqhs2RcqK2vqB4E0AFNpjKv0rw==
X-Received: by 2002:a65:64d9:: with SMTP id t25mr7513251pgv.244.1551345005773;
        Thu, 28 Feb 2019 01:10:05 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id s78sm10692486pfa.134.2019.02.28.01.10.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 01:10:05 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 8F1B33000E5; Thu, 28 Feb 2019 12:10:01 +0300 (+03)
Date:   Thu, 28 Feb 2019 12:10:01 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, keescook@chromium.org, thgarnie@google.com
Subject: Re: [PATCH v2 0/2] x86/mm/KASLR: Change the granularity of
 randomization to PUD size in 5-level
Message-ID: <20190228091001.5wvkwe7cqkf2euzc@kshutemo-mobl1>
References: <20190228003522.9957-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228003522.9957-1-bhe@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 08:35:20AM +0800, Baoquan He wrote:
>  arch/x86/mm/kaslr.c | 92 ++++++++++++++++++++-------------------------
>  1 file changed, 40 insertions(+), 52 deletions(-)

What tree is it against?

I cannot apply on current Linus' tree or tip/master.

-- 
 Kirill A. Shutemov
