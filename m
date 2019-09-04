Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F6FC3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD9421726
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="V7EVPD+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbfIDVLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 17:11:18 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39509 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730257AbfIDVLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 17:11:17 -0400
Received: by mail-ot1-f67.google.com with SMTP id n7so14741786otk.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 14:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DOJXX029rLk7A9iwm08b8/Tl49pqEw9N8S7iikumjN8=;
        b=V7EVPD+fthp2Q80ZJwJy+hxX6duKEdu7/VTcx6YCk7q0HWNV0qSkz0sS9fajCv9YLt
         kZ7Fmdk++yNzXS4WboBmvS9IZXHfPN+px0XZmekfpGt0/v+IMmaJXO3lW9jhZA9ffiyC
         MPCKZ1ratNZUFYN5RMYbhqOF5wbt25Pw2FFNks7TFpiuxNqkYnlebEOfluG1zKezJgib
         35GgMnC6P6PF2XOMZp8gk//4CUwUh0NXqzem0UlUM6zKjJEuBAaF0TdbOoTqwGnUr4OX
         hYqx6+7zIYDjo/zUUndobyd6up0UDtz1acNvOWuwmD906+9+y6Y7iiFn576BF/OZAfMP
         457A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DOJXX029rLk7A9iwm08b8/Tl49pqEw9N8S7iikumjN8=;
        b=bySXdx8qmoxAEYhJjabIYEB0ciN4bHPvZFGSXFWxa6wA++Y50AhNuMTWmkA9PzaRT+
         vzNmW08jrxwjbdViXNeO2Pr6SGT22y7w1z8JCdHzsdpmHHVe9h0ouNF21vMcDw5ioLEq
         bWzwxhxXGqTXWWnnXbHguIV7cNK1415Qqf5PRE3hIS3dnekqfyU3DpHEER57BkheXkcw
         FaCnGleBSN0pkl0TqJ1JMZxZMy6DQSiEcOKT7pXwRwD1k0rKKiYbkDOFZgxp7IaSOa5E
         hsqzBkTT3ODa9OC2ZgH+eQdAg0jTEfUVfB4FXoFOO0/gXd587JHDHYyE+VhiEbO3RO47
         EEgg==
X-Gm-Message-State: APjAAAW/fG5yhFtT9QLBKcy3qcWcp7DosFQ6S2aMokYS3Ee4PhV+340l
        6S1P83dCPoy5xyirz+UYNz8mB3VzEUnq3KPjxy5fWA==
X-Google-Smtp-Source: APXvYqx9jKkBHnd+DQIWXHwkuc52sRnnbaAsQKgvUKsZGTAH48zPPbXcKFWapnRn7Rw3Hu49a3/TdCstzgRe3NrlpAw=
X-Received: by 2002:a9d:2642:: with SMTP id a60mr9252305otb.247.1567631476902;
 Wed, 04 Sep 2019 14:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190904150920.13848.32271.stgit@localhost.localdomain> <20190904151036.13848.36062.stgit@localhost.localdomain>
In-Reply-To: <20190904151036.13848.36062.stgit@localhost.localdomain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 4 Sep 2019 14:11:06 -0700
Message-ID: <CAPcyv4hHdRbb2pLgeAYep8fXRxYwG3QixFBVfsO9FNtAzvo6mg@mail.gmail.com>
Subject: Re: [PATCH v7 2/6] mm: Move set/get_pcppage_migratetype to mmzone.h
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     nitesh@redhat.com, KVM list <kvm@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        virtio-dev@lists.oasis-open.org,
        Oscar Salvador <osalvador@suse.de>, yang.zhang.wz@gmail.com,
        Pankaj Gupta <pagupta@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        lcapitulino@redhat.com, "Wang, Wei W" <wei.w.wang@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 8:11 AM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>
> In order to support page reporting it will be necessary to store and
> retrieve the migratetype of a page. To enable that I am moving the set and
> get operations for pcppage_migratetype into the mm/internal.h header so
> that they can be used outside of the page_alloc.c file.
>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
