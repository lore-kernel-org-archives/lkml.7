Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1788CC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D620E20644
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfD3Qa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 12:30:29 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35313 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfD3Qa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 12:30:27 -0400
Received: by mail-lf1-f68.google.com with SMTP id j20so11390998lfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 09:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YfLhavdIeR7HTTj2ugiDjMzdIxNt+XkZkSlpB23S0bo=;
        b=pk2jrSJCxibbTmfMLFbb4qZCmE1f20iXCJ0kzhoQzJql0mVYKc6zjDrY/mLf3WZVQr
         8n9pb67a3GGHv1keIdx89fEVdIdG8kBNjOTo45MYRjiKYOF8Q/6UmQYpuQWtpA+BXf/4
         HEkD2gPODQPrSR67r1rQMfwPaZ7Rdwe6EXQYo8mIJin9VNfmWwQfQOKM6K/Nj0+f9ptl
         wauijFvVXNOsNvNCUy3m+x5uany9kQR2H4D9NF8jEIqR8KgLYkrGGZ2ZtRuwqMMU4y2g
         7M85VTs/QgfnLawQ+8OOqfrOdVNvJqbNcSP1fPj0SvuBTGjva4yiv4Yu8iWXS5o5/p4x
         2kpQ==
X-Gm-Message-State: APjAAAWh1pnZLxz77gB6OvHlhn6sM3ejZIBgo623vPLts3M7K3/YIgTk
        iPEMPhr5kjMihzCgcG0OkR3PNCzkrVwg/07Ct6Tb3w==
X-Google-Smtp-Source: APXvYqya+AxBDyt1yN7Ph2OqZxOECVOXX8/Y3g29YvyTdBMp/HR/PVrs+s2FTZ6J+KDGYR344vrxq41Br3fskMcaBOU=
X-Received: by 2002:a19:a417:: with SMTP id q23mr35897943lfc.110.1556641826091;
 Tue, 30 Apr 2019 09:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190429222613.13345-1-mcroce@redhat.com> <CAGnkfhzkju6LXwHAVCHxCmMvAa1MLQGRY1czE1Boqz2OcEq39Q@mail.gmail.com>
 <CAGXu5j+qejH0c9fG=TwmSyK0FkaiNidgqYZrqgKPf4D_=u2k8A@mail.gmail.com> <20190430160813.GI13796@bombadil.infradead.org>
In-Reply-To: <20190430160813.GI13796@bombadil.infradead.org>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Tue, 30 Apr 2019 18:29:49 +0200
Message-ID: <CAGnkfhxhZ7WELD-w_KA+yKogyyJ=y_=8w+HdpYoiWDbCsQi+zw@mail.gmail.com>
Subject: Re: [PATCH v4] proc/sysctl: add shared variables for range check
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 6:08 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Apr 30, 2019 at 08:42:42AM -0700, Kees Cook wrote:
> > On Tue, Apr 30, 2019 at 3:47 AM Matteo Croce <mcroce@redhat.com> wrote:
> > > On Tue, Apr 30, 2019 at 12:26 AM Matteo Croce <mcroce@redhat.com> wrote:
> > > >
> > > > Add a const int array containing the most commonly used values,
> > > > some macros to refer more easily to the correct array member,
> > > > and use them instead of creating a local one for every object file.
> > > >
> > >
> > > Ok it seems that this simply can't be done, because there are at least
> > > two points where extra1,2 are set to a non const struct:
> > > in ip_vs_control_net_init_sysctl() it's assigned to struct netns_ipvs,
> > > while in mpls_dev_sysctl_register() it's assigned to a struct mpls_dev
> > > and a struct net.
> >
> > Why can't these be converted to const also? I don't see the pointer
> > changing anywhere. They're created in one place and never changed.
>
> That's not true; I thought the same thing, but you need to see how
> they're used in the functions they're called.
>
> proc_do_defense_mode(struct ctl_table *table, int write,
>         struct netns_ipvs *ipvs = table->extra2;
>                         update_defense_level(ipvs);
> static void update_defense_level(struct netns_ipvs *ipvs)
>         spin_lock(&ipvs->dropentry_lock);

Indeed. I followed the same code path until I found this:

 167                        ipvs->drop_rate = 0;
 168                        ipvs->sysctl_drop_packet = 1;

so I think that this can't be done like this.

Mind if I send a v5 without the const qualifier? At least to know the
kbuildbot opinion.

Regards,
-- 
Matteo Croce
per aspera ad upstream
