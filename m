Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A899EC10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7615F2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xjf8FyZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbfC2QAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:00:46 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36965 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbfC2QAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:00:45 -0400
Received: by mail-yw1-f68.google.com with SMTP id w66so848745ywd.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 09:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4V5sQShKmoDEmjjbDrynbQSxEwhXjukz0aLZkhIYYv4=;
        b=Xjf8FyZoJnfK7UXhcyUKPo5VUYyrf3DnYUcJ9U4X70Yu5KAwlKJi6rPsLNlKoQ33rs
         f6pyWEKkSMuVDklPNlOxdZVssB1gIRQD03r7NTChqQcWnGDlT7qfeH8N0241cOGU4WLp
         pADXJEs74am39QIE6iXUA39pxOTEhwWUZXyxScjNFiwgY2NpexJjYbFPfQd8USWYx471
         dJ2AmaH6qlepKzm3z81T2HrDO9pArk7R2TAEcLRnID0DVQe0VrCGeOfZ3iFxAjcQofqc
         nQIc52uk+tb/ZCLLDRpyUo378xFHEO6oOoZ7b0kW6MaBVkeR/5/+FkZnfqnL52qLl5PP
         iKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4V5sQShKmoDEmjjbDrynbQSxEwhXjukz0aLZkhIYYv4=;
        b=TDQ5qeGY/tYz544TzZ2cgoiQtRlKEH7P8Hbma2FNk+MA239E3MQPLk3I/ovE62131v
         /j4jwn+Prebx5bPJL/ObhOhN796rUChEAwpxkxB55AgLwT8AjH6LkN1CSBC+/btzLM0y
         mK/blxmsWIjS9BUbZNfN4/l/aFFosBZYcGTHcCGCArj09zT5DDcWU2swPBM2/00IlYLq
         GGoxz5Hne2M2P8/6GQAdjAN7+dnUYEW30kz/SLMPI2AEMf2L1a+/drp0Dmgwh9yogD1Y
         yvqurivMfPn6c2TvZPJxDE4Gue67xcoqkrS042pAMQFdNdjQQJM3/6D85N4uu/SXCoAH
         OkpQ==
X-Gm-Message-State: APjAAAVAaQxxTWW3N6vBzrMhSJpBNIlLfDo3acheX2RA/IdCZ9lPSAlN
        DneI8JUayoROYlPR7NXFyPfr5+ZzylOYHbsJFCWsvQ==
X-Google-Smtp-Source: APXvYqyAhuC4YfxtINnB6mmpwBdddcY+Smqv25npb0ZUAJEjPO5XDmEj7HCfZV3EjUUEQPhPztXoy47rSpSBvJlSixA=
X-Received: by 2002:a0d:e6c9:: with SMTP id p192mr7150620ywe.255.1553875244213;
 Fri, 29 Mar 2019 09:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190329012836.47013-1-shakeelb@google.com> <20190329075206.GA28616@dhcp22.suse.cz>
In-Reply-To: <20190329075206.GA28616@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 29 Mar 2019 09:00:32 -0700
Message-ID: <CALvZod5foPZvaD5jTBH9a7bdtMys6MdDLV=D-BLcUMU1Q7EZPw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm, kvm: account kvm_vcpu_mmap to kmemcg
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ben Gardon <bgardon@google.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Linux MM <linux-mm@kvack.org>, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 12:52 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 28-03-19 18:28:36, Shakeel Butt wrote:
> > A VCPU of a VM can allocate upto three pages which can be mmap'ed by the
> > user space application. At the moment this memory is not charged. On a
> > large machine running large number of VMs (or small number of VMs having
> > large number of VCPUs), this unaccounted memory can be very significant.
>
> Is this really the case. How many machines are we talking about? Say I
> have a virtual machines with 1K cpus, this will result in 12MB. Is this
> significant to the overal size of the virtual machine to even care?
>

Think of having ~1K VMs having 100s of vcpus and the page size can be
larger than 4k. This is not something happening now but we are moving
in that direction. Also

> > So, this memory should be charged to a kmemcg. However that is not
> > possible as these pages are mmapped to the userspace and PageKmemcg()
> > was designed with the assumption that such pages will never be mmapped
> > to the userspace.
> >
> > One way to solve this problem is by introducing an additional memcg
> > charging API similar to mem_cgroup_[un]charge_skmem(). However skmem
> > charging API usage is contained and shared and no new users are
> > expected but the pages which can be mmapped and should be charged to
> > kmemcg can and will increase. So, requiring the usage for such API will
> > increase the maintenance burden. The simplest solution is to remove the
> > assumption of no mmapping PageKmemcg() pages to user space.
>
> IIRC the only purpose of PageKmemcg is to keep accounting in the legacy
> memcg right. Spending a page flag for that is just no-go.

PgaeKmemcg is used for both v1 and v2.

> If PageKmemcg
> cannot reuse mapping then we have to find a better place for it (e.g.
> bottom bit in the page->memcg pointer or rethink the whole PageKmemcg.
>

Johannes have proposal, I will look more into those.

Shakeel
