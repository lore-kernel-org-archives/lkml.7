Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370EBC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080FA2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563554560;
	bh=69wuicQ5CsCViI+eHXKz7/ao8WiLRTmfskIHLWsEZsk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GZ7DBGuIvadogTc+TNuF6c+UYAw2zAEzO9sxjh6gK/Nc+15fvrmFREgActYYqEeUe
	 EVvwh4h9noMpVmT4864OEQxkA1zReblyKzwOIa8WCMv4zF0/he9vGgRw0us6KBRyU5
	 m5JpRCiIwi5TWJNIZLpXYyqdxm9c57cZtF8altLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbfGSQmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 12:42:39 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33720 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731328AbfGSQmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 12:42:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id h10so31408809ljg.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 09:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u0ZWCWCrD1EFOB7UnBsKGuO4b/n1G74yTuVNDwCT6vg=;
        b=J+WV1wDq179VrL+xkonxiO60FCa6W2z3DKjq0Ff8NRaL2j0yFKh1AZgX0iRccPI+tg
         KT4F608xdwGkxd3urDMUr97PcFZ8m/TTGHmjU+RV0XuJWJKVTsqNDqSHZdMzs810RaNK
         dB3FnqTeRpZT6rRj4VXBjQUavcT9dZLUFSGS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u0ZWCWCrD1EFOB7UnBsKGuO4b/n1G74yTuVNDwCT6vg=;
        b=MV3poEZPzpa591dBFqAFEuR2QSl3/uDszgm9J6AnPf+vHtYQrGP83bpInZ7N0hh56I
         rcUl34BR+GOk72DCxKR/faZaCSGS8j/3CWShcnEI8n70BvGQdUO5RS3YHNupaf3/rPO9
         AvRKuwFWc8fPro/M6gDJgiDC2pJfAJJx6D27iZMuARETr97X8fApoTnoT/i5xKIG+8hm
         7XPHEgQMbqI/+RJYjzDHE+g4NcXZW5FXnF/6phexfKQ6ofk6mmsyJ6K6SiOt8VHdi+2T
         339tGRbhSBuwJES1xYq8xS4nCHImjzJfEy+W/kh88EhjxH3vaUQtG8xgRGYUroqkfcgB
         qGGg==
X-Gm-Message-State: APjAAAVKVNy6S8HDisPe/Mf/hg4lSiDtHM70YBaOW/+vVV5j5C35e7hr
        qnfuoCZgYQDfaS8gH1KAX8y6kvksLMY=
X-Google-Smtp-Source: APXvYqxaktrp+Q9FY+vDaT/oHEQJbvTo+SpMLgzzW2bT7JsI7rZ5eORNtEOFKD2eSD0uAwpcCGw/sA==
X-Received: by 2002:a2e:8591:: with SMTP id b17mr2628607lji.71.1563554555827;
        Fri, 19 Jul 2019 09:42:35 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id t23sm5773186ljd.98.2019.07.19.09.42.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 09:42:34 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id t28so31379273lje.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 09:42:34 -0700 (PDT)
X-Received: by 2002:a2e:9b83:: with SMTP id z3mr907481lji.84.1563554554207;
 Fri, 19 Jul 2019 09:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190718225757.ndUBg%akpm@linux-foundation.org> <20190719061313.GI30461@dhcp22.suse.cz>
In-Reply-To: <20190719061313.GI30461@dhcp22.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 Jul 2019 09:42:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgtcNxV8ueTk5r9aXZFSpXjb22dMUxfDojPA=O4QtMFFQ@mail.gmail.com>
Message-ID: <CAHk-=wgtcNxV8ueTk5r9aXZFSpXjb22dMUxfDojPA=O4QtMFFQ@mail.gmail.com>
Subject: Re: [patch 23/38] mm/sparsemem: introduce struct mem_section_usage
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, toshi.kani@hpe.com,
        rppt@linux.ibm.com, richardw.yang@linux.intel.com,
        pasha.tatashin@soleen.com, osalvador@suse.de, logang@deltatee.com,
        jmoyer@redhat.com, Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, jane.chu@oracle.com,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, Qian Cai <cai@lca.pw>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        mm-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 11:13 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> Has this been properly reviewed after the last rebase and is this
> actually ready for merging? I have seen some follow up fixes
> http://lkml.kernel.org/r/20190715081549.32577-1-osalvador@suse.de
> and do not see those patches being in the pipe line. Or have they been
> merged?

It looks to me from the patches that Andrew updated them with

  https://lore.kernel.org/linux-mm/20190715081549.32577-2-osalvador@suse.de/

and

  https://lore.kernel.org/linux-mm/20190718120543.GA8500@linux/

so it looks good to me.

But that's just from reading the patches, I might have missed
something and I don't see the history.

               Linus
