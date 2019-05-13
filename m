Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA875C46470
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB7120989
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbfEMMGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 08:06:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44203 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfEMMGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 08:06:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id c5so14928713wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 05:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=biNvHQKs15xbQFoeFpqb5Q0+JlVOB2+nGH0+sYLUzJo=;
        b=GD+S7ka0kM15Ze/fuUhtbYZbv0JFfri7oLAk5pZCXzns9Bwxsn/t2h/1/Fbt+Q3YY1
         0/DNoqUxRfSdlipIEd5oBi300jSle3tRttS6T9CghwBdO9tpHfvH8/bz6Kh+eFtT235q
         7PoNxRU9lVrkPZuSBL7eEGzWrIlY18ST45jToFNyP168v6wlHIs92/oRBawvQzG/Cqzd
         bylqSHNC6NFQvrVtSLZvEQ2twGOFZywut5ZMalZxeM4jHj0JKAGAwdpaLSm5jKERCNa8
         PAgvTWQJcfOtDk7Ec7EEjTBrBeOqjY8WKCuFrEjr9RGWpzbZ/GyznD6zcRbvjHTjaI9K
         UJDw==
X-Gm-Message-State: APjAAAUx68hFZouESmUqFWOhJycF0P3/6Q7dwamLSFdKtUJWP/s6zwoN
        BMfBmiHgMNzodMGNrbkun1i9NA==
X-Google-Smtp-Source: APXvYqzR54BPsEiJ8auTB6b64uU/gwBWlUPQ8ai+VlYRzE6qMlhJjD4AcuX7KIg5zrVoiA8EDFzDrQ==
X-Received: by 2002:adf:d089:: with SMTP id y9mr5913422wrh.239.1557749192996;
        Mon, 13 May 2019 05:06:32 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o4sm12500619wmc.38.2019.05.13.05.06.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 05:06:31 -0700 (PDT)
Date:   Mon, 13 May 2019 14:06:31 +0200
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Timofey Titovets <nefelim4ag@gmail.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Aaron Tomlin <atomlin@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH RFC 0/4] mm/ksm: add option to automerge VMAs
Message-ID: <20190513120631.cm2mc5grkofvloyk@butterfly.localdomain>
References: <20190510072125.18059-1-oleksandr@redhat.com>
 <36a71f93-5a32-b154-b01d-2a420bca2679@virtuozzo.com>
 <20190513113314.lddxv4kv5ajjldae@butterfly.localdomain>
 <CAGqmi744Vef7iF0tuBO3uBtXbNCKYxBV_c-T_Eg3LKPY0rKcWA@mail.gmail.com>
 <20190513120117.aeiij4v2ncu43yxt@butterfly.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513120117.aeiij4v2ncu43yxt@butterfly.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 02:01:17PM +0200, Oleksandr Natalenko wrote:
> On Mon, May 13, 2019 at 02:48:29PM +0300, Timofey Titovets wrote:
> > > Also, just for the sake of another piece of stats here:
> > >
> > > $ echo "$(cat /sys/kernel/mm/ksm/pages_sharing) * 4 / 1024" | bc
> > > 526
> > 
> > IIRC, for calculate saving you must use (pages_shared - pages_sharing)
> 
> Based on Documentation/ABI/testing/sysfs-kernel-mm-ksm:
> 
> 	pages_shared: how many shared pages are being used.
> 
> 	pages_sharing: how many more sites are sharing them i.e. how
> 	much saved.
> 
> and unless I'm missing something, this must be already accounted:
> 
> [~]$ echo "$(cat /sys/kernel/mm/ksm/pages_shared) * 4 / 1024" | bc
> 69
> 
> [~]$ echo "$(cat /sys/kernel/mm/ksm/pages_sharing) * 4 / 1024" | bc
> 563

Yup. To expand on this,

 246 /* The number of nodes in the stable tree */
 247 static unsigned long ksm_pages_shared;
 248 
 249 /* The number of page slots additionally sharing those nodes */
 250 static unsigned long ksm_pages_sharing;

2037     if (rmap_item->hlist.next)
2038         ksm_pages_sharing++;
2039     else
2040         ksm_pages_shared++;

IOW, first item is accounter in "shared", the rest will go to "sharing".

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer
