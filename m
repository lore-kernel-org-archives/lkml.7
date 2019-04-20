Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029C9C282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 16:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC73208C0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 16:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="M1iwu9ox"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfDTQa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 12:30:28 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:45427 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfDTQa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 12:30:27 -0400
Received: by mail-ed1-f41.google.com with SMTP id k92so6575578edc.12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 09:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RZD2TOJdguYske3XdmnLmIq3XfcXZwBSYG0QJWjhaWk=;
        b=M1iwu9oxwvEKXc+QWcLRm6hRiQ5kUxXpfVx34XcRBUZhoRcClhsh0JUyIwC1Ht03If
         8a3G+pXgKZ9eavm0LjqGnf1JevmNy/hEoTi1kNvr/hT7CU/N9lh/wstJca1903j3q879
         zWvJI/IPpJUKqLRCxvH5qRHYbnBDUKQy+AlS8GyhCyUN0nTH4Fd/1S7KmPnCYG9mSn28
         2gQna42o0dUnhv0WrZf4ZmljAB7Iz/0ANS5d32EYaSbcFqdniC2v+w89Yc+/qAuk6ELQ
         gBYuclDgpS0azcJCu6eTr5cKRx2t41QOMFBfPxhgW4g9bkAA2N/pCgS01Ui1P8Lw52Gu
         bixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RZD2TOJdguYske3XdmnLmIq3XfcXZwBSYG0QJWjhaWk=;
        b=m99m062szSt/zhytmPzBQhKk+XKDpKaNUB3nYW+PGR5DSyjlTS2qhGDZaDCOkxYmgI
         pTUVtc+iwIL7a/38ecNo+o+Z/dyjHdc2FW7a4MYYUGC6/rwG0Zt56uZ6oX3/8Sr8dqK/
         n9UuJJmmXqmM4Kj3DaXhFPo2M8U4zdzaawbaG2ErCwD+OkKRGlqhndD/k3cQoB38bhaQ
         sVa+vsjHdHP1OwAzHKhESRyyXo4CKPremixSjGyZRY7rTGoLgwRW2HiXr2P/aqApvUPU
         XbphFR7lPigFzNagRNc8i+3jjabrznCq0HMMTdBIukiW/xVkmi0i52ovLO7Czw2LzGGI
         BwZg==
X-Gm-Message-State: APjAAAV+CD248nqZhOTJpn3R5qLydypzuf8C7kXwIuC8FoQp9rem/yHp
        GoQLwe1jE34tU8n83iluu5wtUHZEkXnIijqg2UoJrg==
X-Google-Smtp-Source: APXvYqyvovu6cFSV63PCP8G4i0thnTzgWZNHajiZGvrLh8glESaAwS8yzV/gVTNrN+wbgH9aZrQzqv2Ey0SevBe6Nm8=
X-Received: by 2002:a50:a4e4:: with SMTP id x33mr6290803edb.61.1555777825844;
 Sat, 20 Apr 2019 09:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190420153148.21548-1-pasha.tatashin@soleen.com>
 <20190420153148.21548-3-pasha.tatashin@soleen.com> <CAPcyv4j9sG6Wy3EfTuPb0uZ2qp=gr9UgUhpnXQA_g6Ko9KFmLA@mail.gmail.com>
In-Reply-To: <CAPcyv4j9sG6Wy3EfTuPb0uZ2qp=gr9UgUhpnXQA_g6Ko9KFmLA@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Sat, 20 Apr 2019 12:30:14 -0400
Message-ID: <CA+CK2bA2QTzZtFvGRMaG10_TretDr6CGgZc4Hyi_1pku4ECqXw@mail.gmail.com>
Subject: Re: [v1 2/2] device-dax: "Hotremove" persistent memory that is used
 like normal RAM
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Takashi Iwai <tiwai@suse.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +
> > +       /* Walk and offline every singe memory_block of the dax region. */
> > +       lock_device_hotplug();
> > +       rc = walk_memory_range(start_pfn, end_pfn, dev, offline_memblock_cb);
> > +       unlock_device_hotplug();
> > +       if (rc)
> > +               return rc;
>
> This potential early return is the reason why memory hotremove is not
> reliable vs the driver-core. If this walk fails to offline the memory
> it will still be online, but the driver-core has no consideration for
> device-unbind failing. The ubind will proceed while the memory stays
> pinned.

Hi Dan,

Thank you for looking at this.  Are you saying, that if drv.remove()
returns a failure it is simply ignored, and unbind proceeds?

Pasha
