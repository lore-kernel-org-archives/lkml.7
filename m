Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56E3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8125C2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 19:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="aaZrnCaY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfCLTbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 15:31:05 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40597 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfCLTbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 15:31:04 -0400
Received: by mail-ot1-f66.google.com with SMTP id x8so714523otg.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 12:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XCKuaXasInyZl5GiIGw6+ShoAqb+pDeTDo/258O+J+s=;
        b=aaZrnCaYTLt0RYKeA1mT2jq147TnGieDsKfSmCOabF+ag/V9zZu3Z9rjPtFQMkyL3m
         vGIPOx57IKwa+mguf5PHR07VjGyGKP7v/3U50kc4lLbWIZTosS27nPntElu5mQS1nd/0
         RXfjGLJXEDOPudFPjRs8Dv8mhDYZGeGOl9jhwfqSJ4QWvCMAkBu4/mSu24ke4TLlSSyj
         Yvz69kUbofBql3NvNhgV4mYDA6PsaZGC3ZNK+VVinqKd2nBuMFtV2xSqU94sbksdIHRA
         OYbBzWZbAJDsUA4kQ9iQtE8uWmVSEj+7pemmLPq33j2Ryd7j8ewfgurW+6L12BJWIeXe
         YVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XCKuaXasInyZl5GiIGw6+ShoAqb+pDeTDo/258O+J+s=;
        b=cVb+xp4lmeV0AGVdciL6fkI09SKrPRzgM46hEVPnqIGNVFPVq8mzJUMBU9qx33od9A
         5GgF3egcFud6UNQSGJUQS5aLEkyARJ1MKM1qtDVuHl9lh21dduKAplHKs06uwtJBese5
         fWYgWR1OL57WUtvimLj/S4NGmfeTAtJIXFkblZ7lQ9bHmv6yNhmKJG24ySFIrC+H4GLI
         lo5MyZ7LJ7Nhigj/7rRQv/XUpoCh7brt1dpggzKIbjsEA56X2dNyz/K5dsE2X9znZIpF
         nDOTW4Sl8sTiTujKUeNl4MCBbIx+0Ap14zaWBMI1jVcpFeCP5hDwuMzl6+O7CBeXE8oZ
         JJew==
X-Gm-Message-State: APjAAAVbd5j8VJT+Ed/s5nJPIweQMxIwnZ1PCZJT9yrHvjyBjzkv9Yy5
        CYas/I7KIjnS4eFLhT8KPjvCa6DSmwMVlbGU7awChg==
X-Google-Smtp-Source: APXvYqzaZ0pn7vQLeSVVuC+Fghss0kQfa8oYKwGYgI34ZBSi0MNQyvFY/HbJN2QTk5CdoNqtXzHYu2TUgGa5wlhBDQA=
X-Received: by 2002:a9d:760a:: with SMTP id k10mr918574otl.367.1552419063760;
 Tue, 12 Mar 2019 12:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4hB4p6po1+-hJ4Podxoan35w+T6uZJzqbw=zvj5XdeNVQ@mail.gmail.com>
 <20190131041641.GK5061@redhat.com> <CAPcyv4gb+r==riKFXkVZ7gGdnKe62yBmZ7xOa4uBBByhnK9Tzg@mail.gmail.com>
 <20190305141635.8134e310ba7187bc39532cd3@linux-foundation.org>
 <CAA9_cmd2Z62Z5CSXvne4rj3aPSpNhS0Gxt+kZytz0bVEuzvc=A@mail.gmail.com>
 <20190307094654.35391e0066396b204d133927@linux-foundation.org>
 <20190307185623.GD3835@redhat.com> <CAPcyv4gkxmmkB0nofVOvkmV7HcuBDb+1VLR9CSsp+m-QLX_mxA@mail.gmail.com>
 <20190312152551.GA3233@redhat.com> <CAPcyv4iYzTVpP+4iezH1BekawwPwJYiMvk2GZDzfzFLUnO+RgA@mail.gmail.com>
 <20190312190606.GA15675@redhat.com>
In-Reply-To: <20190312190606.GA15675@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 12 Mar 2019 12:30:52 -0700
Message-ID: <CAPcyv4g-z8nkM1B65oR-3PT_RFQbmQMsM-J-P0-nzyvvJ8gVog@mail.gmail.com>
Subject: Re: [PATCH 09/10] mm/hmm: allow to mirror vma of a file on a DAX
 backed filesystem
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 12:06 PM Jerome Glisse <jglisse@redhat.com> wrote:
> On Tue, Mar 12, 2019 at 09:06:12AM -0700, Dan Williams wrote:
> > On Tue, Mar 12, 2019 at 8:26 AM Jerome Glisse <jglisse@redhat.com> wrote:
[..]
> > > Spirit of the rule is better than blind application of rule.
> >
> > Again, I fail to see why HMM is suddenly unable to make forward
> > progress when the infrastructure that came before it was merged with
> > consumers in the same development cycle.
> >
> > A gate to upstream merge is about the only lever a reviewer has to
> > push for change, and these requests to uncouple the consumer only
> > serve to weaken that review tool in my mind.
>
> Well let just agree to disagree and leave it at that and stop
> wasting each other time

I'm fine to continue this discussion if you are. Please be specific
about where we disagree and what aspect of the proposed rules about
merge staging are either acceptable, painful-but-doable, or
show-stoppers. Do you agree that HMM is doing something novel with
merge staging, am I off base there? I expect I can find folks that
would balk with even a one cycle deferment of consumers, but can we
start with that concession and see how it goes? I'm missing where I've
proposed something that is untenable for the future of HMM which is
addressing some real needs in gaps in the kernel's support for new
hardware.
