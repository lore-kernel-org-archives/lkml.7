Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C63C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1264A206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9d7t4et"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbfDYVkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:40:25 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41709 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfDYVkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:40:25 -0400
Received: by mail-ot1-f66.google.com with SMTP id g8so869119otk.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 14:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T3Zz6mDPnR46C9BMzEfeIlakECldI0iBP/1d7FI3PMY=;
        b=o9d7t4etY1KG3UkAblMqBvKDJBJAc0h3iycX7qdU5kMSw4i5FUK+jYK17My2TBW9uV
         /FVZXYhyx3iNfbn87+krYIgDhLbxZKryS3pRCgeq+fy8/43jKhWjjQMcp6yNFLnt293M
         bziz2YQk1pUpsX3b7Ujii7qb15RSPlagNEj0bi9+H3wmpK8hVOX+E+pn6UnzdaCHjOW7
         OdntSg3cVvJUqibIMQdgz3nQqAKong4ZyCzJP8KRT2E8orZVmRDEmHYSjOrr7yRs7Ag2
         hjmewxLq3q5Eonv6SNAAjZycKQ5CPSnbK/0oK2QVyH3JrcL365/rBJ1dZ9HPisj/EHku
         UBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T3Zz6mDPnR46C9BMzEfeIlakECldI0iBP/1d7FI3PMY=;
        b=ddsOmIH2U3cjnKzv+zdbAtsACp5KO6hNdYBAhFVLhTN6JwdBPh6hjuZDzxaEEuJzHE
         Y3D61+1+qelC2MgrEo55aGezn3zeN14Xeb2O5c8oWyaBqZ9mJA92ZnLaBcxjq0ponhcB
         IvMbuAp5wy6CCiLPJN9/HVKyzo7QucyqSV/hqUH6cWaypYdJWNv8+fMy1TAFbqsyEx6l
         /i92r1NNXW73hZuTIPh4jkB6GSRtyt53e7KMQDKZqDFblt1ZFvFkd4mFPOREc0bC3NPS
         3fYpDoLQIS2Dt2ggD/t/ybuBg6lr5XetTHBBSc03Dn/KoSc6af9m0NI3H7XQnyzysY9z
         CrxA==
X-Gm-Message-State: APjAAAUwPhKJl6uZUzUVIh1tkZiVPVIvWeVJBSqInevFi5nnG1H4BudI
        SF7U2DvqI8OzvnpjcVPxajNxsfZ4kQOwP+/NnHw=
X-Google-Smtp-Source: APXvYqwUTtESYatQ2RROIhv8yEV9MNytmxeV0DcTgvs3ks9NH7Row3zdhFKpW66+/AMEHxWtFx+C0BPFjDAt0PjhZds=
X-Received: by 2002:a9d:6191:: with SMTP id g17mr25180056otk.291.1556228424324;
 Thu, 25 Apr 2019 14:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190201203959.10050-1-albertvaka@gmail.com> <20190425130657.ba16b6a3f704cd724f670622@linux-foundation.org>
In-Reply-To: <20190425130657.ba16b6a3f704cd724f670622@linux-foundation.org>
From:   Albert Vaca Cintora <albertvaka@gmail.com>
Date:   Thu, 25 Apr 2019 23:39:58 +0200
Message-ID: <CAAQViEsaKd3FV+gMP92Qx+1DxRw0z-1r+jRUkezVB6QrJTRukw@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/ucounts: expose count of inotify watches in use
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     rdunlap@infradead.org, mingo@kernel.org, Jan Kara <jack@suse.cz>,
        ebiederm@xmission.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 10:07 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Fri,  1 Feb 2019 21:39:59 +0100 Albert Vaca Cintora <albertvaka@gmail.com> wrote:
>
> > Adds a readonly 'current_inotify_watches' entry to the user sysctl table.
> > The handler for this entry is a custom function that ends up calling
> > proc_dointvec. Said sysctl table already contains 'max_inotify_watches'
> > and it gets mounted under /proc/sys/user/.
> >
> > Inotify watches are a finite resource, in a similar way to available file
> > descriptors. The motivation for this patch is to be able to set up
> > monitoring and alerting before an application starts failing because
> > it runs out of inotify watches.
>
> Matthias said "Albert found this problem while working on montitoring
> software, so it fixes a real problem out there", so please include full
> details of the problem which you encountered so that we are better able
> to understand the value of the patch.
>

This is an important metric to track as a sysadmin. Currently,
monitoring software have to workaround the lack of a single metric by
iterating all the file descriptors for all processes and checking
which ones are inotify watches [1].

If this seems enough justification to you, please say so and I will
submit a patch v3 with the requested implementation changes.

[1] https://github.com/prometheus/node_exporter/blob/master/text_collector_examples/inotify-instances

Albert
