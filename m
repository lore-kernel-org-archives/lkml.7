Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90F4C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96504270D0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 17:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="zyV8dwkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfFCRrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 13:47:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40538 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFCRrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 13:47:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id r18so27008209edo.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 10:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dXNJh93VKnrDRoV3p7QeHW/6uh2W1UxKfkBC3L76x5Y=;
        b=zyV8dwkC82UjElwqhhNjiSRV3X89XUMQWmNIMYTdd6EyIBa1IFcNKjF7ZAXDYGRZfk
         tfc5lTMfAnYU0qTOOqK9kfJovtKnJhFX6D6BX0YOHAJ3LBeVRXL7Nr1VH/QZB7Q3WCnu
         hELQcbnUz1l/ZAcBillS1G3mHzX7MYKFGj5pSWqhtBN3WDd704uw6cBBs7ftJHxd37DI
         zXkHPUwknm1r8pGxDYgOFbH9rfEgcEgRipNQqvtbA49GiP1HZ8ebvVG272SxMRQNQrM2
         2v3A3zxoOLhUdg7w9CnnbEVubXFowGKItH98uxZff6gHcM/+InqD/hvOwkaTGOoN8Iql
         HxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dXNJh93VKnrDRoV3p7QeHW/6uh2W1UxKfkBC3L76x5Y=;
        b=Go3/ZcRZ6hpTVB+EoHhrKtEnV3j9bhiD4/wYCKhuKdVBFuZoMN2I8BWaAr/Ay8tG5u
         Fc07IEmY9yxRzxbDods7JESnNU/TZNttCIMS99WaMFurXyHMKGVYxX4TaJhCs8Ubqx6l
         pYx9bLSdWufZJmnGg9XyRuwDoElhNTSv7RSq9iv5ecdWtPBT2yPG2VxX4/I/Pozvedbf
         MHOnt7Jle/b+NlXb7xb0n6RkqUIt4RR2Nn/ZiK2U2fPOwE/dycI3h5cWtEKr81YLXiCW
         pdgYDt7c/js25u13yTMVqXsmZUDPhxGHr9EFO3XOGJlXRdKnTf4rn9o4ez452w6qxwho
         /DzQ==
X-Gm-Message-State: APjAAAWdF0r8hbVrYJ3baEFRXqbCaWlD9V32FhLJNZgWmTQfXfJTQeS/
        TF50JeNKnDvi+nNxV6AHkHEHeg==
X-Google-Smtp-Source: APXvYqzchOzG2a90eyb97gNmeNZ+rcpDZlbNkRv/65YitVUDISDtqqNHz7rRPcSXIJV7hRryVBAxnw==
X-Received: by 2002:a17:906:63c1:: with SMTP id u1mr24787573ejk.173.1559584027481;
        Mon, 03 Jun 2019 10:47:07 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id d20sm2697588ejr.21.2019.06.03.10.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 10:47:06 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 0E37C10406D; Mon,  3 Jun 2019 20:47:06 +0300 (+03)
Date:   Mon, 3 Jun 2019 20:47:06 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        mhocko@suse.com, keith.busch@intel.com,
        kirill.shutemov@linux.intel.com, alexander.h.duyck@linux.intel.com,
        ira.weiny@intel.com, andreyknvl@google.com, arunks@codeaurora.org,
        vbabka@suse.cz, cl@linux.com, riel@surriel.com,
        keescook@chromium.org, hannes@cmpxchg.org, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, shakeelb@google.com, guro@fb.com,
        aarcange@redhat.com, hughd@google.com, jglisse@redhat.com,
        mgorman@techsingularity.net, daniel.m.jordan@oracle.com,
        jannh@google.com, kilobyte@angband.pl, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/7] mm: process_vm_mmap() -- syscall for duplication
 a process mapping
Message-ID: <20190603174706.t4cby7f5ni4gvvom@box>
References: <155836064844.2441.10911127801797083064.stgit@localhost.localdomain>
 <20190522152254.5cyxhjizuwuojlix@box>
 <4228b541-d31c-b76a-2570-1924df0d4724@virtuozzo.com>
 <5ae7e3c1-3875-ea1e-54b3-ac3c493a11f0@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ae7e3c1-3875-ea1e-54b3-ac3c493a11f0@virtuozzo.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 05:56:32PM +0300, Kirill Tkhai wrote:
> On 03.06.2019 17:38, Kirill Tkhai wrote:
> > On 22.05.2019 18:22, Kirill A. Shutemov wrote:
> >> On Mon, May 20, 2019 at 05:00:01PM +0300, Kirill Tkhai wrote:
> >>> This patchset adds a new syscall, which makes possible
> >>> to clone a VMA from a process to current process.
> >>> The syscall supplements the functionality provided
> >>> by process_vm_writev() and process_vm_readv() syscalls,
> >>> and it may be useful in many situation.
> >>
> >> Kirill, could you explain how the change affects rmap and how it is safe.
> >>
> >> My concern is that the patchset allows to map the same page multiple times
> >> within one process or even map page allocated by child to the parrent.
> > 
> > Speaking honestly, we already support this model, since ZERO_PAGE() may
> > be mapped multiply times in any number of mappings.
> 
> Picking of huge_zero_page and mremapping its VMA to unaligned address also gives
> the case, when the same huge page is mapped as huge page and as set of ordinary
> pages in the same process.
> 
> Summing up two above cases, is there really a fundamental problem with
> the functionality the patch set introduces? It looks like we already have
> these cases in stable kernel supported.

It *might* work. But it requires a lot of audit to prove that it actually
*does* work.

For instance, are you sure it will not break KSM? What does it mean for
memory accounting? memcg?

My point is that you breaking long standing invariant in Linux MM and it
has to be properly justified.

I would expect to see some strange deadlocks or permanent trylock failure
as result of such change.

-- 
 Kirill A. Shutemov
