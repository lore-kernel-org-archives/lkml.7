Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DC1ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A966214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 12:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="RBVtVI19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfJKMKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 08:10:45 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38591 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbfJKMKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 08:10:45 -0400
Received: by mail-ot1-f67.google.com with SMTP id e11so7738793otl.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 05:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L/oMH+7veCm4nS+KWwbQY7jv6vTOaNO0ytE/eqsALps=;
        b=RBVtVI19z8Zy2JrzO1/T/UqZVcHmsQ95BkRqtxA77t2yQcPyRs51igsn3V+++MEvW/
         Yz8R6PBMdUJGQ4Hoo4Egj+Sf2Y6d0XyP5sHrU63lYoHWKi+0qXE3ZvN7LPGrq5pxx2mw
         3xYMtBNP4ZMBuNmL4uKPLArzfUN3yLyMqmOLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L/oMH+7veCm4nS+KWwbQY7jv6vTOaNO0ytE/eqsALps=;
        b=YGwAszSIOVlZDMt4iykWs+bDabwXNuhcxlJd2lwNInE3/yvIi2QXhu9kNHj4797k+0
         uQAu5mqHr7u3Pay3GjjKwwFaTS5IPzLpgEvZoJEVLhr5nLAymKHhZ6Z9Hr60bdK6FuLY
         iATArhX+sCwy9Clob/tSIT/KXtdGG3fneKCZI91Ve4V9JQvkzEr7McIqAHG0SwXUfPOI
         eN6zoSMkUh8Osf/HPHBh7lK1Vc0lRs9Lse1p4YhQINsOiw0UqodkuF50yXsfxy6cid2U
         CO85pWE4t8lXdZeEsGhaAiR0wv4QDimlZ37xEtF/e09iGpbXuUFB/4c5ysMv2ZtsbVJ5
         wd2w==
X-Gm-Message-State: APjAAAU+lYb9KrTgtdO7iWNsfE0tqoD469cNzJMABsDTf6aw0Hh26oEI
        TP/etv0d4Eea6n85M3BdNGBWEClUicCos0jRp7CXxw==
X-Google-Smtp-Source: APXvYqz5vscWegd3VfwRR3YpCn5eOWtYe+NMn9vThiq0DZbf5RJI92cNbfdC+/hB2ZeWW/KfaSZKQLQZTdJ6PU4STzo=
X-Received: by 2002:a05:6830:22f6:: with SMTP id t22mr35902otc.237.1570795841923;
 Fri, 11 Oct 2019 05:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190911140204.GA52872@aaronlu> <7b001860-05b4-4308-df0e-8b60037b8000@linux.intel.com>
 <CANaguZCH-jjHrWwycU3vz6RfNkW9xN+DoRkHnL3n8-DneNV3FQ@mail.gmail.com>
 <20190912123532.GB16200@aaronlu> <CANaguZBTiLQiRQU9MJR2Qys8S2S=-PTe66_ZPi5DVzpPbJ93zw@mail.gmail.com>
 <CANaguZDOb+rVcDPMS+SR1DKc73fnctkBK0EbfBrf90dztr8t=Q@mail.gmail.com>
 <20191010135436.GA67897@aaronlu> <CANaguZDCtmXpm_rpTkjsfPPBscHCwz4u1OHwUt3XztzgLJa_jA@mail.gmail.com>
 <20191011073338.GA125778@aaronlu> <CANaguZCkKQTmgye+9nQhzQqYBrsnCmcjA46TPmLwN60vvMQ_7w@mail.gmail.com>
 <20191011114851.GA8750@aaronlu>
In-Reply-To: <20191011114851.GA8750@aaronlu>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Fri, 11 Oct 2019 08:10:30 -0400
Message-ID: <CANaguZBgv5N2Spv-Ldio5Umn6qU7dC0Px66sL9s11W7SK3f4Hg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for the clarification.
>
> Yes, this is the initialization issue I mentioned before when core
> scheduling is initially enabled. rq1's vruntime is bumped the first time
> update_core_cfs_rq_min_vruntime() is called and if there are already
> some tasks queued, new tasks queued on rq1 will be starved to some extent.
>
> Agree that this needs fix. But we shouldn't need do this afterwards.
>
> So do I understand correctly that patch1 is meant to solve the
> initialization issue?

I think we need this update logic even after initialization. I mean, core
runqueue's min_vruntime can get updated every time when the core
runqueue's min_vruntime changes with respect to the sibling's min_vruntime.
So, whenever this update happens, we would need to propagate the changes
down the tree right? Please let me know if I am visualizing it wrong.

Thanks,
Vineeth
