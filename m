Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA18C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83CC20722
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHPKKvkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbfKZOdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:33:24 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43445 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbfKZOdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 09:33:24 -0500
Received: by mail-qk1-f193.google.com with SMTP id p14so16242644qkm.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 06:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DjnyXfd1sXqy76Rl/2RI6nQAzOQl8OUc6HlCs+augLw=;
        b=oHPKKvkKVSmxQfinMzMb/jmZs40ROg9NeyjOuhqcq/rUzUOlE+EkGLCJkepiPnfyaO
         c3C2TlvFA6RfZ5gj7QGUaLQSS6N2qt2vN5HeHVbo68NHnxkGGC5kIVZlsklLBa/rn2ug
         rJSqzldezGu0VQvCqad3UaJyktyRF4dDhj06AHvRNKBIU3ZCDNnmkx8o/pWgmaBULysM
         3AMXgaOTHFzMFmF8/VcvbeyiXTLJXS1ugk2/I5P9zN8QCbxBCoGyoXQ0MUp7OzfVcwws
         DYzHGGIO6Tb5sr1SsoRD+7J/YJB3ZNcsX8S3ozmPy+U7vlBNaCAihblIEynWCyJnmW33
         QGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DjnyXfd1sXqy76Rl/2RI6nQAzOQl8OUc6HlCs+augLw=;
        b=nPgUcYEBjvl2JSQZAzA45osB47a2js9MGgD4uCIDfc97Nsoi5lIzgqiqPmOHAnuR2r
         ghm3oPFSmwl3akBZbJYzqVKkUmoADMPfm7pC5FRbzVWWv2QN7pkbdbu4joiAknxKbqtV
         Y/CFQPMBagliqded8NyekI7juEy6cgpQCj12uYxo9JvvYmQs+sC3AnEYLt6M5u3xwejj
         z4l6iIuGgkVU0vZvpUfX1RwGT5rHx775ePlhueUPvdDw5kOW0GDLPHuBDPk38xyeI1Iz
         w9qjGaDHxCHuJyATXdw+0mWBlpLjZOIC/2oWf5f28ZXGtNVu1BmgY/lMonLIMl6EvO5N
         nfhg==
X-Gm-Message-State: APjAAAWb1b9eQXoT1vjNM8ODI9TiohC0zO7LmiaqJhqIHxLEmraHavyr
        P1uxMIr/aKCrL0G6Ma37NdaeOJ2FFyUOK7tVIVCwIXIr
X-Google-Smtp-Source: APXvYqzQydA1nBxmTnlE8Tl07A2lWJFWOnZxLriEvtWkXodkE5i5/U9SzP2Ak3CfGGV2exb9K6rHd4zV1D/pvAo0Vfo=
X-Received: by 2002:a37:7305:: with SMTP id o5mr24672397qkc.120.1574778803438;
 Tue, 26 Nov 2019 06:33:23 -0800 (PST)
MIME-Version: 1.0
References: <20191125145320.GA21484@haolee.github.io> <bbc278b2-d897-5a43-befd-7be8dacd8495@redhat.com>
In-Reply-To: <bbc278b2-d897-5a43-befd-7be8dacd8495@redhat.com>
From:   Hao Lee <haolee.swjtu@gmail.com>
Date:   Tue, 26 Nov 2019 22:33:10 +0800
Message-ID: <CA+PpKPkW-BAdct2M+HsnM=SR3CNdiFkBP1ROokSJyY6=HvjWuA@mail.gmail.com>
Subject: Re: [PATCH] mm: use the existing variable instead of a duplicate statement
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, Mel Gorman <mgorman@suse.de>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019 at 20:13, David Hildenbrand <david@redhat.com> wrote:
>
> On 25.11.19 15:53, Hao Lee wrote:
> > The address of zone has been stored in variable 'zone', so there is no need
> > to get it again with a duplicate statement.
> >
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -363,22 +363,21 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
> >       for (zid = zone_idx + 1; zid < MAX_NR_ZONES; zid++) {
> >               struct zone *zone = &lruvec_pgdat(lruvec)->node_zones[zid];
> >               unsigned long size;
> >
> >               if (!managed_zone(zone))
> >                       continue;
> >
> >               if (!mem_cgroup_disabled())
> >                       size = mem_cgroup_get_zone_lru_size(lruvec, lru, zid);
> >               else
> > -                     size = zone_page_state(&lruvec_pgdat(lruvec)->node_zones[zid],
> > -                                    NR_ZONE_LRU_BASE + lru);
> > +                     size = zone_page_state(zone, NR_ZONE_LRU_BASE + lru);
> >               lru_size -= min(size, lru_size);
> >       }
> >
> >       return lru_size;
> >
> >  }
>
> Maybe tweak the subject to something meaningful:
>
> "mm/vmscan: reuse stored zone in lruvec_lru_size()"
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
>
Thanks. I get it!

Regards,
Hao Lee
