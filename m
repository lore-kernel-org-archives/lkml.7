Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA73DC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6B620872
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="JCXAHKAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504676AbfIXLXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 07:23:21 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41224 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504665AbfIXLXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 07:23:18 -0400
Received: by mail-ed1-f65.google.com with SMTP id f20so1459838edv.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 04:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fFhYFHjSj9wjqVDmFbFCUMCJqMZEDHU2eHaDtmiFh4I=;
        b=JCXAHKAebzdQwVmC1FyCywlDLC88/J/Z1kX31UlH8sfmMA2gtp9eRIpcR7dbjuiwW/
         YExJfiY5ffHOsVxqyUOyNkbc8ZD/gqEl6S5cwCbK5JNzw2Ddl3RCOW2dB6tEYXh6sUgb
         7OeQ5jUODU8+uf+zlPjCMPoU/f01+hx7J1JBCHmbRHHdXwKW617OyjxXJgoIBxBmgHvE
         VoUKiBVjV2fQkRTRPfoFg3qYZ6/fRrom7xTHTjUNMLUClf37y9Enx6+uw5CEKaSTpNrG
         uZEfYhf+6xQyzj54Ryu9uA298TUxAJnNNsOgHiCfZ4fdGB7C0Wtr4v/w5n4Eo1LqgG4I
         7bsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fFhYFHjSj9wjqVDmFbFCUMCJqMZEDHU2eHaDtmiFh4I=;
        b=FM7rhxA9J0dCetRRwUindT0BJiv5yFJmqnz9Fwnt7jidLy7nH3JgPaUi6/RlbXk64U
         yK+QmA8I6J0+IRL4u5EjM3HnMI0h0pIWd20b8U57eBJ8p6pWNLUXCNYXQLiitsk0Rm3s
         6woz+5+5sMOD+ZZWlfFbwvJcHir1iiXdTIdLu49NLESCUMsPNAYhr52RMtbxpgmQYrOx
         HbTd1d7PN8h55DCK8TLzFy8JfKrs6AZ5/q0Jio/vLvk+cfAhOPCWOk+O31vuNRUsxqw7
         2OQzeqsPoesQozbdoq+DSrwIbLXjvo4CcvVUoa6pwEqNm9IGZd6TOm8YXvnIX7qRIuJn
         NqgQ==
X-Gm-Message-State: APjAAAUIqi7m0YSOdN1E8o6VFNWag182W4IfxLJg5mOhv26mP/wIuZZi
        Ek/T4IqPq0lI+gzs7yxcNiSAGg==
X-Google-Smtp-Source: APXvYqxaVwPqLRqZKj5sACDWXnix2WMaV/zu2ASKpiJMYUq4PJAoMrx4s2S39weu5gA5h2BCBLcW0Q==
X-Received: by 2002:a17:906:af57:: with SMTP id ly23mr1895280ejb.269.1569324196369;
        Tue, 24 Sep 2019 04:23:16 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z20sm314027edb.3.2019.09.24.04.23.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 04:23:15 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id C849D1022A6; Tue, 24 Sep 2019 14:23:16 +0300 (+03)
Date:   Tue, 24 Sep 2019 14:23:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Lance Roy <ldr709@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Airlie <airlied@redhat.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Jan Kara <jack@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Huang Ying <ying.huang@intel.com>,
        Aaron Lu <ziqian.lzq@antfin.com>,
        Omar Sandoval <osandov@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: don't expose page to fast gup prematurely
Message-ID: <20190924112316.324l7gqpdzhpiliq@box>
References: <20190514230751.GA70050@google.com>
 <20190914070518.112954-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190914070518.112954-1-yuzhao@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2019 at 01:05:18AM -0600, Yu Zhao wrote:
> We don't want to expose page to fast gup running on a remote CPU
> before all local non-atomic ops on page flags are visible first.
> 
> For anon page that isn't in swap cache, we need to make sure all
> prior non-atomic ops, especially __SetPageSwapBacked() in
> page_add_new_anon_rmap(), are order before set_pte_at() to prevent
> the following race:
> 
> 	CPU 1				CPU1
> set_pte_at()			get_user_pages_fast()
> page_add_new_anon_rmap()		gup_pte_range()
> 	__SetPageSwapBacked()			SetPageReferenced()

Is there a particular codepath that has what you listed for CPU?
After quick look, I only saw that we page_add_new_anon_rmap() called
before set_pte_at().

-- 
 Kirill A. Shutemov
