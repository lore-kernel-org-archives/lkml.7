Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05539C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA80C20685
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="sd6erl5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfCSReK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:34:10 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37736 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCSReJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:34:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id c16so7098285otn.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 10:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z8tMgR2jQ7qbI4Vk8rLBRaN7IkiS+UfqkL6XnvCw5WA=;
        b=sd6erl5p90ODa4X9rLL5PNnefwn2xpM5rzFHYDKW1il9SN+IjS81qvSWCiqL2a5zsG
         e6/jqjSFEdTp8yJcUzeafS4mbluGKJ4a2IEWQLXByCp6ERcA/W36tCuRJ+bO4jSRRVHG
         bYGgHwt85rtSYnJCptdiIpLo8DyJdLTM+daZgZOPO76M1mdIgUnPenogjSrtepNx9zXD
         BrgRfsSSEqFrGZ8DgZzweqxKmbP0iE4cXKRoW88XW0rlbWBXBp+SKGA/Ja2UsxehsCg/
         6CAHyNXw+DiwWe5PE1T/se5S+4uD2ijnKv0u1xqCInsGYhemYbH2NfHic9scwW78vL5i
         BK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z8tMgR2jQ7qbI4Vk8rLBRaN7IkiS+UfqkL6XnvCw5WA=;
        b=Cx/q6o7nOxAE2Zz3AJS7z+3mVQ3kUjjCYBPvoiP9fL5ICoWcqVIhhHJ5EhAhyqR5n/
         2yVpxgfzSYZQh2lre3o7tPt/7Eo2KQLfylSK2CLyp0356XxfXPFTaS7wzYTx5OwF+6FE
         cLz9B1g5jq0IeFlc0TC1pCZa4JTeKVrtUJN0D3QynahyLnN0ucKiyG9eOQAKXQCS0LFu
         4okm8amv1HP/WKyfg2/R0WHyOYKvk+nWi46DRrBkp6LgbExpl8bLJ+BnwXYX/Dl/9Sua
         U1KqfA3fgzfkYkjkrCTwSZMcMzJyTrWoRh1vrDIH92vs0w8nBojemn3xwAHjAULigCBf
         yxNw==
X-Gm-Message-State: APjAAAXLJhGBFoLMb4fqkorXt5xUXJUx4jSECDjXimxsQCuezW8aDBPF
        32YctaT8Kmz3KFmhxm/WDkHI1DL8RvKpjN3Z2Nl0NA==
X-Google-Smtp-Source: APXvYqwzgOn/nZ0ayGb5IqIAEXhqaIOpkNKvk+7zxMCPkmOTNxfkdseeIENR3VAu8FM7ml93AzeEPa6VcEXGk835FT4=
X-Received: by 2002:a9d:2c23:: with SMTP id f32mr2407745otb.353.1553016848952;
 Tue, 19 Mar 2019 10:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190129165428.3931-1-jglisse@redhat.com> <20190313012706.GB3402@redhat.com>
 <20190313091004.b748502871ba0aa839b924e9@linux-foundation.org>
 <20190318170404.GA6786@redhat.com> <20190319094007.a47ce9222b5faacec3e96da4@linux-foundation.org>
 <20190319165802.GA3656@redhat.com> <20190319101249.d2076f4bacbef948055ae758@linux-foundation.org>
 <20190319171847.GC3656@redhat.com>
In-Reply-To: <20190319171847.GC3656@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 19 Mar 2019 10:33:57 -0700
Message-ID: <CAPcyv4iesGET_PV-QcdBbxJGgmJ_HhoGczyvb=0+SnLkFDhRuQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] HMM updates for 5.1
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 10:19 AM Jerome Glisse <jglisse@redhat.com> wrote:
>
> On Tue, Mar 19, 2019 at 10:12:49AM -0700, Andrew Morton wrote:
> > On Tue, 19 Mar 2019 12:58:02 -0400 Jerome Glisse <jglisse@redhat.com> wrote:
[..]
> > Also, the discussion regarding [07/10] is substantial and is ongoing so
> > please let's push along wth that.
>
> I can move it as last patch in the serie but it is needed for ODP RDMA
> convertion too. Otherwise i will just move that code into the ODP RDMA
> code and will have to move it again into HMM code once i am done with
> the nouveau changes and in the meantime i expect other driver will want
> to use this 2 helpers too.

I still hold out hope that we can find a way to have productive
discussions about the implementation of this infrastructure.
Threatening to move the code elsewhere to bypass the feedback is not
productive.

>
> >
> > What is the review/discussion status of "[PATCH 09/10] mm/hmm: allow to
> > mirror vma of a file on a DAX backed filesystem"?
>
> I explained that this is needed for the ODP RDMA convertion as ODP RDMA
> does supported DAX today and thus i can not push that convertion without
> that support as otherwise i would regress RDMA ODP.
>
> Also this is to be use by nouveau which is upstream and there is no
> reasons to not support vma that happens to be mmap of a file on a file-
> system that is using a DAX block device.
>
> I do not think Dan had any comment code wise, i think he was complaining
> about the wording of the commit not being clear and i proposed an updated
> wording that he seemed to like.

Yes, please resend with the updated changelog and I'll ack.
