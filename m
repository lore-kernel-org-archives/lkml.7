Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A09C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FBB21835
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="miW/7gsG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfJJOrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:47:43 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43676 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJOrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:47:42 -0400
Received: by mail-qk1-f194.google.com with SMTP id h126so5821066qke.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 07:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dY3cxBFbn5BFQR3wtmZXnj2xekyjm05rgtTqVfByDnk=;
        b=miW/7gsGehxbucNWUNf+JQQBZuBtJ2eE0qM4yM0DCDw4cxXTcso32P45cl8wkFq2aV
         QiAzEX8SfUjgqSnOp3xq9j/NJYHOlrYkv0vzUZ2SiNP/GRVGUpnKcCBh7bRerWjIlGfw
         f9hLXoCL2l9oLKJ8nNLr3d9TVtxohQRIk65qwUMO2cUWjc2AlMt4bULOYdg5daeZYvGi
         fb7rVgBALWWubKCC0Hh4ezsT0yQl2avWYlBCFlUTGabe0tkEO6snRU6NDw1vg8ebTLSO
         XqJOybJAHXF+aNu2td0emR0oOpgjJ28ENqxR8D6ivWvfSXcamA1hqcD5DogH1QcRwuhZ
         MQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dY3cxBFbn5BFQR3wtmZXnj2xekyjm05rgtTqVfByDnk=;
        b=JX0JA08MMzOB19rJK/ZHZJletCx+8exLtnxrVV6HHff7oHtCJYJj3mn71KIQWi3Khu
         m5DV/NeNh65Rh22MbmhWuhJmccembo1jYOUxfkgs6mVoph1vQ5czBqnplShUgy032dIe
         8yQMujop8z8zBeLgfWC113t/61sBvFGnDAO4SXLX9OVgQKpvi/MREJ5po15rc+AzIH9P
         fyHGQybetnt7VsTNfPnoZoVZv6DWSvxzeDA4OF97EHXMoIdU+tvK2hiIBk8Z/cb6cy+u
         HX0gXkRmjqtLvoKDu0CmoR2WQ05KiBO0zUM+rTwYfWCdPgz1TCpfxO9Vd6xY42lz9zmt
         eKkg==
X-Gm-Message-State: APjAAAUzcAeYGgk8JRjIwA9HP4SSgv1btnAxGcEkuDkwOrsRDttOYzzt
        AEjZgrgam20R7fqAAH1h3TYcsA==
X-Google-Smtp-Source: APXvYqzuGVYLmfVHrpebW8KExt+KSlXKe3bxkKadjMlG+hrolzAg5Lm0HAeVpSLnhiERXxK/ZtkJ6w==
X-Received: by 2002:a37:9847:: with SMTP id a68mr10359301qke.223.1570718861606;
        Thu, 10 Oct 2019 07:47:41 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f27sm2366449qkh.42.2019.10.10.07.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 07:47:40 -0700 (PDT)
Message-ID: <1570718858.5937.28.camel@lca.pw>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, akpm@linux-foundation.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>, david@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 10 Oct 2019 10:47:38 -0400
In-Reply-To: <20191010141820.GI18412@dhcp22.suse.cz>
References: <20191009162339.GI6681@dhcp22.suse.cz>
         <6AAB77B5-092B-43E3-9F4B-0385DE1890D9@lca.pw>
         <20191010105927.GG18412@dhcp22.suse.cz> <1570713112.5937.26.camel@lca.pw>
         <20191010141820.GI18412@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-10 at 16:18 +0200, Michal Hocko wrote:
> On Thu 10-10-19 09:11:52, Qian Cai wrote:
> > On Thu, 2019-10-10 at 12:59 +0200, Michal Hocko wrote:
> > > On Thu 10-10-19 05:01:44, Qian Cai wrote:
> > > > 
> > > > 
> > > > > On Oct 9, 2019, at 12:23 PM, Michal Hocko <mhocko@kernel.org> wrote:
> > > > > 
> > > > > If this was only about the memory offline code then I would agree. But
> > > > > we are talking about any printk from the zone->lock context and that is
> > > > > a bigger deal. Besides that it is quite natural that the printk code
> > > > > should be more universal and allow to be also called from the MM
> > > > > contexts as much as possible. If there is any really strong reason this
> > > > > is not possible then it should be documented at least.
> > > > 
> > > > Where is the best place to document this? I am thinking about under
> > > > the “struct zone” definition’s lock field in mmzone.h.
> > > 
> > > I am not sure TBH and I do not think we have reached the state where
> > > this would be the only way forward.
> > 
> > How about I revised the changelog to focus on memory offline rather than making
> > a rule that nobody should call printk() with zone->lock held?
> 
> If you are to remove the CONFIG_DEBUG_VM printk then I am all for it. I
> am still not convinced that fiddling with dump_page in the isolation
> code is justified though.

No, dump_page() there has to be fixed together for memory offline to be useful.
What's the other options it has here? By not holding zone->lock in dump_page()
from set_migratetype_isolate(), it even has a good side-effect to increase the
system throughput as dump_page() could be time-consuming. It may make the code a
bit cleaner by introducing a has_unmovable_pages_locked() version.
