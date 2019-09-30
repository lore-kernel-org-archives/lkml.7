Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44040C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1642E21855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 14:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="TJ/QYoNN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbfI3OgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:36:15 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41984 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730809AbfI3OgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 10:36:15 -0400
Received: by mail-ot1-f68.google.com with SMTP id c10so8488993otd.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RRmAIt8Bb7hxPg1Z/NX9GRGwvPP3410MbXYQc+FgXoM=;
        b=TJ/QYoNNELeDyFXlkdZI7w+5tyl1AhAET7lb7WvOvrCWjdFE8a0pq1eUfcN97AWOsb
         /aagxcGmIvRinHIeY335E9ZxUdfg4Ezn8CcSA8D4tMAW8NQy/bOZPee8/kbIVpTi3Bsh
         4kwg0W6GL/z411qlIjGYNE5OxmcxnBuCoo77A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RRmAIt8Bb7hxPg1Z/NX9GRGwvPP3410MbXYQc+FgXoM=;
        b=euT2MYagj6lz0Ed6H9BbmzDqDlWEs9EyS0UCjng+pDg4lyJHByTiDXHRbd1CctS1fK
         LkRzGqKrZtTvioJ9VP13iF2QA+5b+ITeL4PzhicUYxf6Us3jSzQTiwvjINcY0rv2gUDO
         vU39gVTlOtUzofH5KoaXU1kdmhIUDVdL6EdXje8ljL0a++vXuYy9ML5cWmSOiQY2Ywdu
         JFY1ovehU7uKI5ZcYex5mm4b9JqjSgIOu9MSArKTktvuWbpsBx6p1GzggkP9iVAVtDe4
         iBA+AXQYMQvLwQVt/8jZ1TfzGmg1nAPOQAL+qSmtAwJbmnQ/kznCJsPRLFTLInnwtPF7
         guiw==
X-Gm-Message-State: APjAAAXP4bHSp6/BLRUd/wO2YX+rJgM6Oaf/tQSpli10l6C3nn/3RpY/
        dQH+7rk/BLOwk0bFJdIUmSKkZXxY9GWfhZo9R6Qcbg==
X-Google-Smtp-Source: APXvYqyiMFZO7bG7Q699PZEtKotl908L9Y0kiFSAkokDSu2kpp5UuGPDZ/fvq9aR+4FK4VUX5subFkoXCD88ILhU48E=
X-Received: by 2002:a9d:19cf:: with SMTP id k73mr13760457otk.237.1569854173938;
 Mon, 30 Sep 2019 07:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190726152101.GA27884@sinkpad> <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
 <20190802153715.GA18075@sinkpad> <eec72c2d533b7600c63de3c8001cc6ab9e915afe.camel@suse.com>
 <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com> <fab8eabb-1cfa-9bf6-02af-3afdff3f955d@linux.intel.com>
 <20190911140204.GA52872@aaronlu> <7b001860-05b4-4308-df0e-8b60037b8000@linux.intel.com>
 <20190912120400.GA16200@aaronlu> <CAERHkrsrszO4hJqVy=g7P74h9d_YJzW7GY4ptPKykTX-mc9Mdg@mail.gmail.com>
 <20190915141402.GA1349@aaronlu> <CAERHkrs9u24NrcNUwHq8mTW922Ffhy9rPkBGVN_afm1RBhabsQ@mail.gmail.com>
 <ade66e6d-cc52-4575-2f8f-e4d96c07a33c@linux.intel.com> <CAERHkrsW8conSUNbbmAD7AHyRTGy=80QUiJAsx_LaJDNQoZ35g@mail.gmail.com>
In-Reply-To: <CAERHkrsW8conSUNbbmAD7AHyRTGy=80QUiJAsx_LaJDNQoZ35g@mail.gmail.com>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Mon, 30 Sep 2019 10:36:03 -0400
Message-ID: <CANaguZDLa4C4z+y=K7=mD6m5C0J2fVqt-DSde_WCrWnMnk4dGw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
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

On Wed, Sep 18, 2019 at 6:16 PM Aubrey Li <aubrey.intel@gmail.com> wrote:
>
> On Thu, Sep 19, 2019 at 4:41 AM Tim Chen <tim.c.chen@linux.intel.com> wrote:
> >
> > On 9/17/19 6:33 PM, Aubrey Li wrote:
> > > On Sun, Sep 15, 2019 at 10:14 PM Aaron Lu <aaron.lu@linux.alibaba.com> wrote:
> >
> > >>
> > >> And I have pushed Tim's branch to:
> > >> https://github.com/aaronlu/linux coresched-v3-v5.1.5-test-tim
> > >>
> > >> Mine:
> > >> https://github.com/aaronlu/linux coresched-v3-v5.1.5-test-core_vruntime
> >
> >
> > Aubrey,
> >
> > Thanks for testing with your set up.
> >
> > I think the test that's of interest is to see my load balancing added on top
> > of Aaron's fairness patch, instead of using my previous version of
> > forced idle approach in coresched-v3-v5.1.5-test-tim branch.
> >
>
> I'm trying to figure out a way to solve fairness only(not include task
> placement),
> So @Vineeth - if everyone is okay with Aaron's fairness patch, maybe
> we should have a v4?
>
Yes, I think we can move to v4 with Aaron's fairness fix and potentially
Tim's load balancing fixes. I am working on some improvements to Aaron's
fixes and shall post the changes after some testing. Basically, what I am
trying to do is to propagate the min_vruntime change down to all the cf_rq
and individual se when we update the cfs_rq(rq->core)->min_vrutime. So,
we can make sure that the rq stays in sync and starvation do not happen.

If everything goes well, we shall also post the v4 towards the end of this
week. We would be testing Tim's load balancing patches in an
over-committed VM scenario to observe the effect of the fix.

Thanks,
Vineeth
