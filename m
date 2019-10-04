Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24252C4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF06F207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="e8IRDuL5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388433AbfJDNap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:30:45 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33402 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387917AbfJDNao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:30:44 -0400
Received: by mail-qt1-f194.google.com with SMTP id r5so8581111qtd.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 06:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B5vnSSCIcbplBcWNA19HtmeOraO3xHVwUmiEjyji+dc=;
        b=e8IRDuL5YyKeZPPnATe7X4oE8SALc3CKjZg+DyKSbhJqyrlr+9MFiRisQJfTHCFGUN
         I1v3KWVu3KlqiHLDMEgkPLKD7QK7oWnmxeciqctHX3o80NnUmRSbjoP/M5GZ+a3r/v4w
         0qpwZGqBg2SqYUYhO+S6AqTU4vMxa9zfsBzjRH8i3sRB2gw747U5qDthrVlBCGck6c09
         rAr8Xx2waDW6mV+hJs5aJvyEjUK2dpAkyz5rtJXkuCs5PVJndm9xm8HQ9TYQgp9ImdtL
         JTNezfq/awagUkCVuzXYghiyNmwjngYkcfH7Dsp7ZVo3JVY41hIPxnzaLxJQYpBFS1fH
         aNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B5vnSSCIcbplBcWNA19HtmeOraO3xHVwUmiEjyji+dc=;
        b=PRRFULch4qa9e5i8M613V2yid3RWW2k9Q0YEkRxAEmjN8ePpYQGaz19+A1EwnkD3yd
         cuFkKf7wrivvbvnktgW/IFVfgy+NKL/KkK7SEgk65JvBJ3WFUwuHKVC4Cu1qSjyvO8nM
         cl9dynnsseLzrh+pRwpFlHOpgmzXNbwW9zD8A8PXYAeKg3MYmc5fTHbYtXK9fD8u4ACD
         i0dF6VKEdtpzh233O4F+PWupbfN1AwYaVuSKy3q20rhN2U1NP70ErlOuAFGJg1cMfFe3
         DZwdYUP5/iSWUWcBXC8+vTBaV8faA3q0+QM6kuzVmBPVqrdwBNs9QrS/GwOhbrpOVirU
         p8Ug==
X-Gm-Message-State: APjAAAXp51CGFruu93Q1INMmKd+3T8OJFCxr6q15lR/gDmctEW7oBnSR
        I6R7PIa44HFFePWK6DrTB9R5Aw==
X-Google-Smtp-Source: APXvYqyifeRTX7SmGTGjjWVD0NCxVG8ZiHqtUI/fVbaztaXVCrdZ2DBwCZvtleHH5tDQUjLVjdAEtw==
X-Received: by 2002:a0c:f3c1:: with SMTP id f1mr1163664qvm.165.1570195842396;
        Fri, 04 Oct 2019 06:30:42 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i66sm3176454qkb.105.2019.10.04.06.30.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 06:30:41 -0700 (PDT)
Message-ID: <1570195839.5576.273.camel@lca.pw>
Subject: Re: [PATCH] mm/page_alloc: Add a reason for reserved pages in
 has_unmovable_pages()
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 04 Oct 2019 09:30:39 -0400
In-Reply-To: <20191004130713.GK9578@dhcp22.suse.cz>
References: <1570090257-25001-1-git-send-email-anshuman.khandual@arm.com>
         <20191004105824.GD9578@dhcp22.suse.cz>
         <91128b73-9a47-100b-d3de-e83f0b941e9f@arm.com>
         <1570193776.5576.270.camel@lca.pw> <20191004130713.GK9578@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-04 at 15:07 +0200, Michal Hocko wrote:
> On Fri 04-10-19 08:56:16, Qian Cai wrote:
> [...]
> > It might be a good time to rethink if it is really a good idea to dump_page()
> > at all inside has_unmovable_pages(). As it is right now, it is a a potential
> > deadlock between console vs memory offline. More details are in this thread,
> > 
> > https://lore.kernel.org/lkml/1568817579.5576.172.camel@lca.pw/
> 
> Huh. That would imply we cannot do any printk from that path, no?

Yes, or use something like printk_deferred() or it needs to rework of the
current console locking which I have no clue yet.
