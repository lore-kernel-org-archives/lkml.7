Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92501C48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 03:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6256321855
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 03:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9gmGEgl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfF0DLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 23:11:48 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33063 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfF0DLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 23:11:48 -0400
Received: by mail-io1-f65.google.com with SMTP id u13so1542606iop.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 20:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q96TkVsJnfnxVeWX/AdudLxYyvC01VLk3tE7qk29U9Q=;
        b=H9gmGEglIn+LAw9pG4lAyeC7GhEDYFCJpfJVAp3JJqXANo/tVpzC+GJcFcrlYpvbj6
         LZm186SGKl9CFSNXORhYuyjBdwTM7KPKNscLWSd/EYAmijYajHPGFqMTpy6Xc+zbvw4w
         WT0h/+6gaQSq8OTkWhmAo0q/9hftwqjfoS6CsX9FhxyKJ3Q2XoH+taa414Ic5ZbhK78f
         tWqXR+NYSVL0F6zfy5hSTKhH36gP6+7ucDnu/+JHvNsS7N/AOiKsC/zSHcLai4NHKWwo
         FtO3VNKdyMpuxkCe5bQ22L7C4c+1kD34uaGMmJTJ/wb7S7XIjPi3FJOJ4YCXzjgh7f+k
         GaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q96TkVsJnfnxVeWX/AdudLxYyvC01VLk3tE7qk29U9Q=;
        b=REpkPZkUpK14t+PkEBe0LolRNCD8gr7k0fcKyXJxO++drJAg4lt7OxBcCVJK9u2Wue
         pyCPsK8NIq/e8Yx7ro+c+qlIKMs024Mlw5qzRATkTo3LXt7ZCRQZK6LwGTU3h+oPcx+g
         RFC6E2FCIsrHweYm6N1Bx3EFBF+g7lZMLDXfLtlI1VQT0+LlIrTkAqnsao5xgKhj1PaA
         ESy8fNPBYysd/EJjtzYhHRipXChf+y1HbOqGY0V0J62H719wefCkSfJaNkKLqbJ8JzO9
         fBl8pFHXRkjJr/ikgh8Q04bTKIP7p2+Fnj9/8ZHgG1UfWUGZUzjSKIF1QM4mwNf0bH6F
         zfQA==
X-Gm-Message-State: APjAAAVXLIE3hSgR/VBkzpWqWh7zax/hOD+yjcH/JTI+HW/JFgHZz50D
        hgV4OOSmwRAb4ldNjkNA9wnv3628+Os6OI50Dg==
X-Google-Smtp-Source: APXvYqwtgBUKznYI9WKiA96o5xUtUGO2BS1tjRoGjRXP0Akltu+m1KJzetXfkm3GRRcNfMOyaUKPCNxgs3JB/FHiGWo=
X-Received: by 2002:a02:a384:: with SMTP id y4mr1716711jak.77.1561605107707;
 Wed, 26 Jun 2019 20:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190512054829.11899-1-cai@lca.pw> <20190513124112.GH24036@dhcp22.suse.cz>
 <1561123078.5154.41.camel@lca.pw> <20190621135507.GE3429@dhcp22.suse.cz>
 <CAFgQCTvSJjzFGGyt_VOvyB46yy6452wach7UmmuY5ZJZ3YZzcg@mail.gmail.com> <20190626135744.GX17798@dhcp22.suse.cz>
In-Reply-To: <20190626135744.GX17798@dhcp22.suse.cz>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 27 Jun 2019 11:11:36 +0800
Message-ID: <CAFgQCTvAaWvnZYYeg-TqCMtYdgGu-r29iGu4igoQ-RRkRkYmVw@mail.gmail.com>
Subject: Re: [PATCH -next v2] mm/hotplug: fix a null-ptr-deref during NUMA boot
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Barret Rhoden <brho@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@elte.hu>,
        Oscar Salvador <osalvador@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 9:57 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 24-06-19 16:42:20, Pingfan Liu wrote:
> > Hi Michal,
> >
> > What about dropping the change of the online definition of your patch,
> > just do the following?
>
> I am sorry but I am unlikely to find some more time to look into this. I
> am willing to help reviewing but I will not find enough time to focus on
> this to fix up the patch. Are you willing to work on this and finish the
> patch? It is a very tricky area with side effects really hard to see in
> advance but going with a robust fix is definitely worth the effort.
Yeah, the bug is a little trivial but hard to fix bug, and take a lot
of time. It is hard to meet your original design target, based on
current situation. I will have a try limited to this bug.

Thanks,
  Pingfan
>
> Thanks!
> --
> Michal Hocko
> SUSE Labs
