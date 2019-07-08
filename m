Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEF4C606D1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D0C216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 22:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCLXtcdz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405410AbfGHWBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 18:01:01 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34824 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732609AbfGHWBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 18:01:01 -0400
Received: by mail-qk1-f193.google.com with SMTP id r21so14260663qke.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 15:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LaAaRIuh++1YFOtbWXkDlSuvjQyQrNcGGJms2xiGjro=;
        b=PCLXtcdzz9cOxvIz0XJXnZXqK0DNnOdsr/J46Pbd0l2pm8M5ztXIIxkanK/i3ClyGX
         E/CjZB5qu3mbJQKJEdsHP2mHz/YRCx0PdVrzQ1gItOCsHN1xNtiuVLccmTyzJwdl3HMH
         hjGJc46ECw5C/rVZcylVCFk8sg+Hn1I8phMPii+8tcNXLTR41tGWI4Ee7RKGkipZ8Cez
         dRpZw0dJDyZwiaVB9c1t4Vav6/bE8y0xoDvYmdTCIW5OOVZt1vyLIF8NaNOJiCWZVyrZ
         BFroidBlMthhTaIngC/nnIFKehB6AybR/B5J7lYvYkkq4o1Z0i4lF1L674ydUvmOk1NG
         5Urw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LaAaRIuh++1YFOtbWXkDlSuvjQyQrNcGGJms2xiGjro=;
        b=CWrugqsWv+8CL5nFO5wyorYktGn3ToVHl6BJCUlPN3vr+DS/f2jKccMLcDAOA6rb96
         zZGOEFM48UmgfUI4E6miX1dlOUTbn91UWZfodbUL5duRjpYWCuqGM76Vnv25JIaGGo0g
         iy0QxTf3U6mrsSgvELIjG5338g3ZRLzmP/47BoQ7EeueBDmdx+cAh3YQqE51ZJmhT0Zl
         s/ojZ+U0AUcuYalH5y1zrhUjhzaMsLx8P04I9XWQ/B5ik8RbY2Hlk6MUPeKKDzslv+gg
         Yn42UW+Vn/mvFhVNgVXfL766ObsF1CRf+xaejIwNFJEmfgPLnsS81MX3xqS32J/hyB3t
         Z+8w==
X-Gm-Message-State: APjAAAVqTrPM7+UTh3uOVTbySrHmZOZdukOP8ynb7Os+L7vcDFDyPrmG
        jOlARGWpLDObVMgUo4hIgAY=
X-Google-Smtp-Source: APXvYqy0+zuoNqHeZ85/BP8yQ7uYO1mItL5nDqy7tA5yj6/6aoQG7/wcrTPW1RXtuXHIBnJtLBHU4g==
X-Received: by 2002:a05:620a:1448:: with SMTP id i8mr16052994qkl.73.1562623259853;
        Mon, 08 Jul 2019 15:00:59 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id o21sm7664374qtq.16.2019.07.08.15.00.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 15:00:59 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5AF8840340; Mon,  8 Jul 2019 19:00:57 -0300 (-03)
Date:   Mon, 8 Jul 2019 19:00:57 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf scripts python: export-to-postgresql/sqlite.py:
 Fix DROP VIEW power_events_view
Message-ID: <20190708220057.GE7455@kernel.org>
References: <20190708055232.5032-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708055232.5032-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 08, 2019 at 08:52:30AM +0300, Adrian Hunter escreveu:
> Hi
> 
> Here is a small fix to the export-to-postgresql.py script.
> The export-to-sqlite.py script had the same issue but SQLite did not seem
> to mind. However I made the fix anyway for good measure.
> 
> 
> Adrian Hunter (2):
>       perf scripts python: export-to-postgresql.py: Fix DROP VIEW power_events_view
>       perf scripts python: export-to-sqlite.py: Fix DROP VIEW power_events_view
> 
>  tools/perf/scripts/python/export-to-postgresql.py | 2 +-
>  tools/perf/scripts/python/export-to-sqlite.py     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Thanks, applied.

- Arnaldo
