Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5411C43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 15:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768C9206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 15:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ZrdWTpIg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfEDP4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 11:56:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39010 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfEDP4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 11:56:03 -0400
Received: by mail-ed1-f68.google.com with SMTP id e24so9800417edq.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 08:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D/xUA4we+CfWIBMstY2ZZGUlR8dNMfA/8aG9kri4RSo=;
        b=ZrdWTpIgvvrF424jIp+wrwRFjns9Vws1VhvhVyeQLQ8yUB0K/RtorMBF6hIJ8qdZr/
         EMNY9XodjCnuUSks5vvIic5f25dogm0UqOVLHW1qPGEa5AIPjIUxhdJ6vyyG+zQwjSVb
         Es6EOhcjogmP+jv9TmQXzop3fT6A5kIYR4QdSUVCyYBPBKteqVQv+Mr+7uyZmdwuPuLX
         0XuWwnIzEw5utfKyj4eEzEOCUe+bSQvYbR0zp66AsLiLTgD/1mSrqF+0Fi72jzDJxuSU
         jUBy/A5BIp4B5w1mm3m2TYLN7uiDehFBdz/RSQ6Qku4HP2JVpf746kbtSaqqIkqt/mKN
         QUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D/xUA4we+CfWIBMstY2ZZGUlR8dNMfA/8aG9kri4RSo=;
        b=Ey21+H2MH96GY7pgMQeTRcddpTbXVjFcxGjU8UQV8hy8N18N0BBDFzC+FMqLW6Pupy
         w7h39EVYXrJXj+Irc8TQCgBK/002Iqlv+D+Cr2tNWz/j9R1K6kxJXkn1PgE7mSBeYhN9
         92ERYAMYBVpoFP6i+ridfsVGhtZm5KgU1QCGUhryiU+bVinNxZPjIp3LZE7SQQ2utiEZ
         nnFfhCVBBs2JXQ41TATYHw8EzIXxiWFPt65GtzTyHM+WX79mp18RFQy8HEjNrGBgZ0Fn
         PqKdz7e1ahPf4exM8VH5ZYmyA8Z1wfH1HzO7YFLwcsNAb0mJoeYJyDEZ+9vNE9wXGGjp
         Ac5g==
X-Gm-Message-State: APjAAAWXehnVuim4+ziGNUNRWyM34UTtzw1rxdejdMD4fFt3CGYUrd6k
        zp8XqLutMLCTzL7HyTfQTYON8b/JR7ECElzmBKiITw==
X-Google-Smtp-Source: APXvYqwL1+OT6I7xDELCdfNz+oPiiC/N2OEv5oobeObUVGp+lISzqLMPEiMy5oB5eqPGvxPFUEwyNJ8Pi/qnMyQIUAw=
X-Received: by 2002:a17:906:3fca:: with SMTP id k10mr11517604ejj.126.1556985361722;
 Sat, 04 May 2019 08:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552634075.2015392.3371070426600230054.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190501232517.crbmgcuk7u4gvujr@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
 <CAPcyv4hxy86gWN3ncTQmHi8DT31k8YzsweMfGHgCh=sORMQQcg@mail.gmail.com> <CAPcyv4hAh-Joe3Pt0r5CPSaWpZ4YoNF2jNDcvbMF2fsQm7Hetg@mail.gmail.com>
In-Reply-To: <CAPcyv4hAh-Joe3Pt0r5CPSaWpZ4YoNF2jNDcvbMF2fsQm7Hetg@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Sat, 4 May 2019 11:55:50 -0400
Message-ID: <CA+CK2bCVAuYFFee+P09H_5fN4w2BHXUS1ZeSVN7hxcCTwgobqA@mail.gmail.com>
Subject: Re: [PATCH v6 01/12] mm/sparsemem: Introduce struct mem_section_usage
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Logan Gunthorpe <logang@deltatee.com>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'm ok with it being 16M for now unless it causes a problem in
> > practice, i.e. something like the minimum hardware mapping alignment
> > for physical memory being less than 16M.
>
> On second thought, arbitrary differences across architectures is a bit
> sad. The most common nvdimm namespace alignment granularity is
> PMD_SIZE, so perhaps the default sub-section size should try to match
> that default.

I think that even if you keep it 16M for now, at very least you should
make the map_active bitmap scalable so it will be possible to change
as required later without revisiting all functions that use it. Making
it a static array won't slowdown x86, as it will be still a single
64-bit word on x86.

Pasha
