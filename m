Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226C7C04AAA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA152053B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 20:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="QZVO0YSd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfEBUhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 16:37:23 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33707 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfEBUhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 16:37:23 -0400
Received: by mail-ed1-f68.google.com with SMTP id n17so3409143edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 13:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gz5D/2IZBhXJoQXag9Fc8P8nFKA7bPD957oNqAWGLnI=;
        b=QZVO0YSdzfzmNkr8hsoJiK5rKpblzW2amWDf3n87XB8fhXoSn/0aPPhTGprY8sH432
         Z9X7TBXWCAenJ7hQ8icWnharyhUwgZ07H/pYlQ9TRdzVVXoWeYT8vhGH/fpmW48/UU1w
         fo/fFr2FjArozB9eIWYNn6qqw7kSEo5ExaZZTLUjW52JRwMc/0f2sCATYTBnkzex1s1m
         wNvW5yhMCcea5C0W1TxWewa5XQh2j91YM+6UmdwPmCFYonn26TtLe9INPuxY0Ofo/Wyb
         +B/lwdxoIwUp9M3BAOpE1x2CBVcQRXItCPqMojFeHF6BT1OS8dSHKenLwEW1jW/5Y8XA
         NsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gz5D/2IZBhXJoQXag9Fc8P8nFKA7bPD957oNqAWGLnI=;
        b=J7AG/761RgoHiRuPGHJgYRvRxUNd4bgpg6ka8pY5wfxMYBaR5SycVmAsA42qZCCj9j
         4Am2h6KOxF2F/HG41TOzkMvyllMRqbhXlbqtC74+sYQR/id4+EbP+otqvIIxgU+p5WnS
         WeMfd3VACyoqVkQUbE/yO6TknebBnfkKWQfAElEkkkRMLG5xgXIPZw3gkAtbcf5ZyR5N
         kAPtd+IA7GimYyg8YMq9Iaot65fazW37FVmg2pjARGxS8bhDWkiOi63BJf+P4J4PQ9k2
         t9rw7zKzYAl6c4xduk+3tHPNcdYo8m7+n2F+A5FGUQhttWiFREpO94Hy2Ckq2Yj/eQ/Q
         dInA==
X-Gm-Message-State: APjAAAU//YzLZX8hl9A7SyOxbbuMI4Iw0g3zDmitPyjNDhIiyMY/D8DT
        LAOvoVwxfc3bzPZPSpXrrixoYJmSpn09wOlCmpMs1g==
X-Google-Smtp-Source: APXvYqxm66I1vthEPriE60HFHxcqTEq91Ksjm4zQsKZ0Wv4hwE8siQJ3nxYgBpV3fsWjIk682fpK9nZBMPnTkHm0aS0=
X-Received: by 2002:a50:a951:: with SMTP id m17mr3830583edc.79.1556829441732;
 Thu, 02 May 2019 13:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155552637207.2015392.16917498971420465931.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155552637207.2015392.16917498971420465931.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 2 May 2019 16:37:11 -0400
Message-ID: <CA+CK2bCq1KvdqZA6=_=F4CAem0aPCLYWFvrMavjm5F1+h7MA+A@mail.gmail.com>
Subject: Re: [PATCH v6 07/12] mm: Kill is_dev_zone() helper
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 2:53 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Given there are no more usages of is_dev_zone() outside of 'ifdef
> CONFIG_ZONE_DEVICE' protection, kill off the compilation helper.
>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
