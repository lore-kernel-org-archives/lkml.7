Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8011C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982F420B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oZXsDC13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfE1Ib0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 04:31:26 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:41520 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfE1IbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:31:25 -0400
Received: by mail-vs1-f54.google.com with SMTP id w19so12239156vsw.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 01:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nDpCbodGGyTl/G0ilhTF0HY0iZvF6dtHic3QCj90ipM=;
        b=oZXsDC139BFCteWhHBnBHACBOyQMeYRAOrZf/VJ9wS/tQrz+S5esMvP0w8pm449GB0
         cmPfZW9ULRdT8n87/iMLMqbXXoNT2419ayfmemKqxIJh/KqXliDTTIoDy/JJkTCzYryx
         iIlEjh1oNEoJ4CStLL3ikYedgGLSj31O/YU1e5WlFayKAu5dl4Cfe9sAOMTSo6ok56dv
         SscPem+FZ6pZKojuqiPTl9gCzY8bvmH3jPqX75TAYNEMn8ednqktRfMImHunEbKtoRUv
         Lf1i1JxgNOSbcFvnNzWMo0/z3X2u7Op2IXl1Rdo2AYwyzRhLvuUtMZjXo6ABqCq7Hxjt
         u1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nDpCbodGGyTl/G0ilhTF0HY0iZvF6dtHic3QCj90ipM=;
        b=NyuGtkO4Lo7EHo1DvDTsmw5+A2VtsgbZ9LG3bsJuouD+YfIfbjtuWR9HowzXyM9FCN
         v322aWF823HnhtYbvLQX5vVOFm6bpIIfeCaImkugHEq+d2vMUvERpXhil5NP6SATLJoa
         rpGaXG4rNFL19RATnjTHC5DJyAS01xZiLiP1TOiOlUsmk35b0nsEVqLMWlYwToeYrOFv
         nKGMnSofOulUCAyxJV3yj6WRk0FBYnTm87pjjKIcgkB5pG+kng9UR7ew8MSLXn5+1/Lp
         yzKiwgXEJzKfUgXZXtfRK/NOAs7npLFio9s23NicQkYlQrnmWU7bJsv5HsV6CVcl4GqD
         gNOA==
X-Gm-Message-State: APjAAAXBLF8Gh0hBmwrT2zAGKkXcFyz5xdsJmzk0tT6e/wbGB6X6zkEB
        zLjtrp+eWSDHoeBAfqwoh8hGBN7lKpzZeex7FOeKzA==
X-Google-Smtp-Source: APXvYqzE8QewMLUeXU4DZglD7H5qffJkLV6mdCsxLIk1a1dGSRHlmjrRoO/5otC9dc45/lQq+x8myk+C/2zbJELkiOo=
X-Received: by 2002:a67:e1d3:: with SMTP id p19mr60303726vsl.183.1559032284339;
 Tue, 28 May 2019 01:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190520035254.57579-1-minchan@kernel.org> <20190520035254.57579-8-minchan@kernel.org>
 <20190520092801.GA6836@dhcp22.suse.cz> <20190521025533.GH10039@google.com>
 <20190521062628.GE32329@dhcp22.suse.cz> <20190527075811.GC6879@google.com>
 <20190527124411.GC1658@dhcp22.suse.cz> <20190528032632.GF6879@google.com>
 <20190528062947.GL1658@dhcp22.suse.cz> <20190528081351.GA159710@google.com>
In-Reply-To: <20190528081351.GA159710@google.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 28 May 2019 01:31:13 -0700
Message-ID: <CAKOZuesnS6kBFX-PKJ3gvpkv8i-ysDOT2HE2Z12=vnnHQv0FDA@mail.gmail.com>
Subject: Re: [RFC 7/7] mm: madvise support MADV_ANONYMOUS_FILTER and MADV_FILE_FILTER
To:     Minchan Kim <minchan@kernel.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 1:14 AM Minchan Kim <minchan@kernel.org> wrote:
> if we went with the per vma fd approach then you would get this
> > feature automatically because map_files would refer to file backed
> > mappings while map_anon could refer only to anonymous mappings.
>
> The reason to add such filter option is to avoid the parsing overhead
> so map_anon wouldn't be helpful.

Without chiming on whether the filter option is a good idea, I'd like
to suggest that providing an efficient binary interfaces for pulling
memory map information out of processes.  Some single-system-call
method for retrieving a binary snapshot of a process's address space
complete with attributes (selectable, like statx?) for each VMA would
reduce complexity and increase performance in a variety of areas,
e.g., Android memory map debugging commands.
