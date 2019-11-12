Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5BDC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A625A21925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="ZQNd+lcn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfKLSAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 13:00:23 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46679 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbfKLSAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:00:22 -0500
Received: by mail-qk1-f196.google.com with SMTP id h15so15223453qka.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 10:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=06+tOajz4B6gePUoYXEIPar3gvZ/gJqmbgnyOgTIPAU=;
        b=ZQNd+lcnkEIXb4CIVCUUvF0shtw2ailj89aCGb0NVz9uUKnnUYfYju6n2m5EPh9upa
         xxaH1JcRBZS05oi4qgAdE9Vtn1wbsYAsKC91Sa6KV3uU4jVyzCQ3msh6LHd8K20oyOX0
         b17taRXMabKP1dKvpzPw8zj8rrahWqzoza8Hhs5SxQ9/qffyLciJXEv3mXIZGv7LIsyy
         4ZR8FFIzTj7jW98nE7yYeYihDbvKD1xx5IxxVB2F/h2kqtc+KomQ916B3tFlQqQWbqF6
         4k2QurV0KK7G4oJIbvG/LBxRoivl/07+p7Hc0GGnYJ5zip5Xet/r7DWNRmncK6lJF+MA
         WGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=06+tOajz4B6gePUoYXEIPar3gvZ/gJqmbgnyOgTIPAU=;
        b=pxzu1M6qh0ko/1EGEavFvJ+u+W/yGI/VqcWr0pyKQbkNkPjZk+4gF9Vjv4tGj2ZOBE
         5VPOg4HXdQizsrPDuQCQkKC+7KfEIQlLbT3HCdzIiMjGm06ro6WhNGFsjRGiY8C4B+kh
         pITZM4YPeBXAFKzfZFhKScmbxeSYTG3sB9mbeI6UkKMBL/XILYCXY94qhT/yDfx0NpEK
         JfmenX9cUm+t7wrfXFRI52mEYbTAUCi4+M4LvOp20NDS7LylBDJ5jqUdg7YZdzdn8uFK
         Yq4vMXjv3w59z+dHR9s4f66YFJzKm5uESl47Y10gsopdoHqT6GBb94qKL0CEfxcrd+Mh
         5IDQ==
X-Gm-Message-State: APjAAAXklDjdlm4HQcNhpvXKviXhXcM8gf/ohpqn4t986+GETycYR8oN
        Knu6jzTIOn585DXRoiGpOml0Ew==
X-Google-Smtp-Source: APXvYqxiYDIXtP651b4dXQUD1iQi7esDhbrkhOiZeP1WHRH8UaDSfzUtY9f7q2nHOmwq7dnCKDPp9Q==
X-Received: by 2002:a37:a54c:: with SMTP id o73mr17251660qke.164.1573581621282;
        Tue, 12 Nov 2019 10:00:21 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::aa8c])
        by smtp.gmail.com with ESMTPSA id u22sm9769196qtb.59.2019.11.12.10.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 10:00:20 -0800 (PST)
Date:   Tue, 12 Nov 2019 13:00:19 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH 3/3] mm: vmscan: enforce inactive:active ratio at the
 reclaim root
Message-ID: <20191112180019.GB178331@cmpxchg.org>
References: <20191107205334.158354-1-hannes@cmpxchg.org>
 <20191107205334.158354-4-hannes@cmpxchg.org>
 <CAJuCfpHSTr8Vt+Tj-Hj4OBYHq1ucw7_B1VoVWKEHQVPHaMhUdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHSTr8Vt+Tj-Hj4OBYHq1ucw7_B1VoVWKEHQVPHaMhUdA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 06:15:50PM -0800, Suren Baghdasaryan wrote:
> On Thu, Nov 7, 2019 at 12:53 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > @@ -2758,7 +2775,17 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >                         total_high_wmark += high_wmark_pages(zone);
> >                 }
> >
> > -               sc->file_is_tiny = file + free <= total_high_wmark;
> > +               /*
> > +                * Consider anon: if that's low too, this isn't a
> > +                * runaway file reclaim problem, but rather just
> > +                * extreme pressure. Reclaim as per usual then.
> > +                */
> > +               anon = node_page_state(pgdat, NR_INACTIVE_ANON);
> > +
> > +               sc->file_is_tiny =
> > +                       file + free <= total_high_wmark &&
> > +                       !(sc->may_deactivate & DEACTIVATE_ANON) &&
> > +                       anon >> sc->priority;
> 
> The name of file_is_tiny flag seems to not correspond with its actual
> semantics anymore. Maybe rename it into "skip_file"?

I'm not a fan of file_is_tiny, but I also don't like skip_file. IMO
it's better to have it describe a situation instead of an action, in
case we later want to take additional action for that situation.

Any other ideas? ;)

> I'm confused about why !(sc->may_deactivate & DEACTIVATE_ANON) should
> be a prerequisite for skipping file LRU reclaim. IIUC this means we
> will skip reclaiming from file LRU only when anonymous page
> deactivation is not allowed. Could you please add a comment explaining
> this?

The comment above this check tries to explain it: the definition of
file being "tiny" is dependent on the availability of anon. It's a
relative comparison.

If file only has a few pages, and anon is easily reclaimable (does not
require deactivation to reclaim pages), then file is "tiny" and we
should go after the more plentiful anon pages.

If anon is under duress, too, this preference doesn't make sense and
we should just reclaim both lists equally, as per usual.

Note that I'm not introducing this constraint, I'm just changing how
it's implemented. From the patch:

> >         /*
> >          * If the system is almost out of file pages, force-scan anon.
> > -        * But only if there are enough inactive anonymous pages on
> > -        * the LRU. Otherwise, the small LRU gets thrashed.
> >          */
> > -       if (sc->file_is_tiny &&
> > -           !inactive_list_is_low(lruvec, false, sc, false) &&
> > -           lruvec_lru_size(lruvec, LRU_INACTIVE_ANON,
> > -                           sc->reclaim_idx) >> sc->priority) {
> > +       if (sc->file_is_tiny) {
> >                 scan_balance = SCAN_ANON;
> >                 goto out;
> >         }

So it's always been checking whether reclaim would deactivate anon,
and whether inactive_anon has sufficient pages for this priority.
