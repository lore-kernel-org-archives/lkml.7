Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F27C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8340421773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMbCFC+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731888AbfDQLge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:36:34 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35164 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfDQLgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:36:33 -0400
Received: by mail-ed1-f65.google.com with SMTP id y67so7399021ede.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 04:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eKzmZNT13+qker03LiNcwHRJhLqfn2RV0qJqGvu7EY4=;
        b=kMbCFC+eUYXJoI5dYtIWxJ5wK3/tha36syWzU3Rv+YAe3oJ6BkXSk74Q3VESpj80dR
         rwS4k7J7wGEez1GYJIQtaNJcA8/AIEyQMKWheQtXWv5ow8aDkodVTPmMYIqKlv61FFQX
         80PmR/Yoddis22cMFJor3N49+ErK3zzL18v3JifdHl06pgVZv3Y90lMwQoeR8omnz3rO
         63/jkMGT/TOAn2CeUmPSyGR5c8Sf+pqUna0EBTsd6UTaaYJTkMFUPTXvAnBkqOkUTsIN
         kXFV1i0kj/vB5ViXpaDufDydMr9N3On2/0gLJCPdeQCZDh3O70/pzzX8ZENA0CXK+mzl
         rwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eKzmZNT13+qker03LiNcwHRJhLqfn2RV0qJqGvu7EY4=;
        b=aP8ckk0HGO++KKws3OoHf0uMSr19aflA8pgoxtLbLUzc4PbeQaPLnGkRxPfcJTiu+3
         ebpb1M2IAvsSAae5Lqv5wKWVfoUhlORfQdezsp3jmPG0VSFwamR+HlicPikOgPwH57E0
         /r+Lnohz6OoO77Kl6zsm4FzlEk/PoKl2TVrbixnn3EEUpnZa7aYXWYtU6AhJTAZbQQ45
         8Z5tOuPmGLiMMK4oRih/rqw+9Ut4/G/sdIgmVKBORQN0jjUuV1/nuqPUnlFH4mRlr4Vq
         oK17BWNxRznl4dgx/PkC35pbzsT/KjzQOQHwixpH98hD7ajBu6PRELUogoTythGt9WY0
         QDrQ==
X-Gm-Message-State: APjAAAXI2oEjeEfSuwyHPDuP97i+P0MmzVv5OSe/eopc+Z3vbJymY0cv
        Hddc9YClTEXYGnvtC5nQcVSpT+KnOQRwj6JvvWM=
X-Google-Smtp-Source: APXvYqyM0mpjUAGmFS7Qeq6tF9uIsM7K3XKsvzCmSbrsHUAUkohN+1Lb9WVOy6rYXPhbo36xcd4zlVfyWMp5FotVF6A=
X-Received: by 2002:a50:ac2b:: with SMTP id v40mr19049674edc.54.1555500991965;
 Wed, 17 Apr 2019 04:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <1555487246-15764-1-git-send-email-huangzhaoyang@gmail.com>
 <CAGWkznFCy-Fm1WObEk77shPGALWhn5dWS3ZLXY77+q_4Yp6bAQ@mail.gmail.com>
 <CAGWkznEzRB2RPQEK5+4EYB73UYGMRbNNmMH-FyQqT2_en_q1+g@mail.gmail.com> <20190417110615.GC5878@dhcp22.suse.cz>
In-Reply-To: <20190417110615.GC5878@dhcp22.suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Wed, 17 Apr 2019 19:36:21 +0800
Message-ID: <CAGWkznH6MjCkKeAO_1jJ07Ze2E3KHem0aNZ_Vwf080Yg-4Ujbw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/workingset : judge file page activity via timestamp
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Roman Gushchin <guro@fb.com>, Jeff Layton <jlayton@redhat.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry for the confusion. What I mean is the basic idea doesn't change
as replacing the refault criteria from refault_distance to timestamp.
But the detailed implementation changed a lot, including fix bugs,
update the way of packing the timestamp, 32bit/64bit differentiation
etc. So it makes sense for starting a new context.

On Wed, Apr 17, 2019 at 7:06 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Wed 17-04-19 18:55:15, Zhaoyang Huang wrote:
> > fix one mailbox and update for some information
> >
> > Comparing to http://lkml.kernel.org/r/1554348617-12897-1-git-send-email-huangzhaoyang@gmail.com,
> > this commit fix the packing order error and add trace_printk for
> > reference debug information.
> >
> > For johannes's comments, please find bellowing for my feedback.
>
> OK, this suggests there is no strong reason to poset a new version of
> the patch then. Please do not fragment discussion and continue
> discussing in the original email thread until there is some conclusion
> reached.
>
> Thanks!
> --
> Michal Hocko
> SUSE Labs
