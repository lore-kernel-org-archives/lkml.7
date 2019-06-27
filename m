Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3792C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF3A20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="IMj5MLbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfF0SyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 14:54:09 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33590 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfF0SyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:54:08 -0400
Received: by mail-qt1-f193.google.com with SMTP id h24so615781qto.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 11:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pzbB0dauErUy58OAB+4MrG23QuVRtPqScjaalstzwrY=;
        b=IMj5MLbFKg5nIySk6MNr7pGBSFgPun/hMMfqHAFbw+gs+sXmnZI/YJ6yx9DxrnPn/M
         QRNQbKVXiLYW9d6o+pC1IOrku5yeFSDdf0frb5Zr5hH9Td9FzgcGkll/NB8A19kxZJn3
         ktBiqfLyRIDZFPDaABir1oywPqLMKWNLpoAKHLc8PXNaqHbcj1oW8rR8KoBHLMI/wjF7
         xre+HIl9mYIV9WK6nyul/BZtwQqKQdOxwLYHQW03RnofOUscSAKVEXZFybj1+GRfcQg1
         yhJ58xE4bBrjw2uRapYqq2/Ll0SfPqtNy8LfrEwYXV7nNk9DRGU9DWYCX6O48Nf9lfIz
         po2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pzbB0dauErUy58OAB+4MrG23QuVRtPqScjaalstzwrY=;
        b=MsVC2gj5wLGwvSy4OAuWepyYnK8ZwyZSyxPpOjAMMr+luLysnq+Wb8sgK5xKnwe0Wf
         EyDInLA8PRA2Hh1OQvx1RaCdarJJY2iBE+t84ZENImBHflknudiW4BECHry7l6P7GPh9
         197Lk4kV7bdvjFnxGgWSa+DCs/C7rsvxA9QdMYz0jIsv/M+1XzfzOIhTwfSYT7UCu4AK
         UVw1rZjni7zPtNED+k7vSf8W0+ETzJGfpriJv1lI02BjXmSKpRLfX7ZV1Wg2fSUL9V9O
         j4gz6I8ae4M0LYxBl9AzQN4xXBDH7FM3ZSxVg3VDhVQyPDP59AUsUX9fdxzo6qRaE36J
         OFPA==
X-Gm-Message-State: APjAAAXSDb9m7vHifcgkK6GeiC9oB+clRcGEHkBjF5dPQ9kgv3xCbGc0
        bpCRxkYgSSLpqo+Fl6wLDqtLfA==
X-Google-Smtp-Source: APXvYqxNXDq0uMmaGEPN7R9AoWFo8lEgE/pofnzH9twSLd5sQ1GF9FdCN33tuaiRfgzCkgzDsXHjiA==
X-Received: by 2002:ac8:2b01:: with SMTP id 1mr4621099qtu.177.1561661647731;
        Thu, 27 Jun 2019 11:54:07 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id n184sm1276105qkc.114.2019.06.27.11.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 11:54:07 -0700 (PDT)
Message-ID: <1561661645.5154.89.camel@lca.pw>
Subject: Re: LTP hugemmap05 test case failure on arm64 with linux-next
 (next-20190613)
From:   Qian Cai <cai@lca.pw>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Will Deacon <will@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Thu, 27 Jun 2019 14:54:05 -0400
In-Reply-To: <15651f16-8d30-412f-8064-41ff03f3f47d@oracle.com>
References: <1560461641.5154.19.camel@lca.pw>
         <20190614102017.GC10659@fuggles.cambridge.arm.com>
         <1560514539.5154.20.camel@lca.pw>
         <054b6532-a867-ec7c-0a72-6a58d4b2723e@arm.com>
         <EC704BC3-62FF-4DCE-8127-40279ED50D65@lca.pw>
         <20190624093507.6m2quduiacuot3ne@willie-the-truck>
         <1561381129.5154.55.camel@lca.pw> <1561411839.5154.60.camel@lca.pw>
         <ed517a19-7804-c679-da94-279565001ca1@oracle.com>
         <15651f16-8d30-412f-8064-41ff03f3f47d@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-06-27 at 11:09 -0700, Mike Kravetz wrote:
> On 6/24/19 2:53 PM, Mike Kravetz wrote:
> > On 6/24/19 2:30 PM, Qian Cai wrote:
> > > So the problem is that ipcget_public() has held the semaphore "ids->rwsem" 
> > > for
> > > too long seems unnecessarily and then goes to sleep sometimes due to
> > > direct
> > > reclaim (other times LTP hugemmap05 [1] has hugetlb_file_setup() returns
> > > -ENOMEM),
> > 
> > Thanks for looking into this!  I noticed that recent kernels could take a
> > VERY long time trying to do high order allocations.  In my case it was
> > trying
> > to do dynamic hugetlb page allocations as well [1].  But, IMO this is more
> > of a general direct reclaim/compation issue than something hugetlb specific.
> > 
> 
> <snip>
> 
> > > Ideally, it seems only ipc_findkey() and newseg() in this path needs to
> > > hold the
> > > semaphore to protect concurrency access, so it could just be converted to
> > > a
> > > spinlock instead.
> > 
> > I do not have enough experience with this ipc code to comment on your
> > proposed
> > change.  But, I will look into it.
> > 
> > [1] https://lkml.org/lkml/2019/4/23/2
> 
> I only took a quick look at the ipc code, but there does not appear to be
> a quick/easy change to make.  The issue is that shared memory creation could
> take a long time.  With issue [1] above unresolved, creation of hugetlb backed
> shared memory segments could take a VERY long time.
> 
> I do not believe the test failure is arm specific.  Most likely, it is just
> because testing was done on a system with memory size to trigger this issue?

I think it is because the arm64 machine has the default hugepage size in 512M
instead of 2M on other arches, but the test case still blindly try to allocate
around 200 of hugepages which the system can't handle gracefully, i.e., return
-ENOMEM in reasonable time.

> 
> My plan is to focus on [1].  When that is resolved, this issue should go away.
