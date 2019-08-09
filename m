Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12F6C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 17:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF5C2070D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 17:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVFI3JOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437123AbfHIREs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 13:04:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34072 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437086AbfHIREs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 13:04:48 -0400
Received: by mail-ed1-f66.google.com with SMTP id s49so60860079edb.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 10:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SVm+IxX6yGNetZ1noaOGvk3cck8u8/5E12taR+hrzuY=;
        b=eVFI3JOH5DluCznSfwkv+tvmdDi7A08we5AJVmkQ5ei6VmnaURk3d65Wft9KmpteKx
         TcORgXt18VKv1O0PIZmsknj/A16wO3RINuCPiqUeKYBGi2ynlI5/wsiySsjMfnwtj4KI
         HfwO/tIsTVZwDvjVfpHj97G0WB76mlWM/DGFM9jjak2x0l0TPjDyHXnS6n9UB0E1kHvk
         Cn+OUDO7/XsyxQ0ChaoVGrkpjF3aAMuQ48RbRW86R5W2qpcZIhvno5FOKuor7XK2l8n+
         CdHtml7t3Xw+dOTWEF8tSMovQmD+0wsA/nwjqLecI1dKB0/M1UTMFEP4ih2g/jXpSm7g
         0+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SVm+IxX6yGNetZ1noaOGvk3cck8u8/5E12taR+hrzuY=;
        b=C/xKWmscVq8a8GsDs9TjKZg1u35ZeMS1bJ+sYFK0xgUudRug18uRjabZsFH96i4buZ
         ZUBQ7hRQo/fi7cDXUGAIi4egnAnmWtEXltl2I2dQxM7fX5Qunv49T1I/mGGqV3FujVYU
         QKFUCQOCjiWDhT4NczLvRPJJ+D19odEzJNMpTcMrSz6H0Lj30+DKe77G5kAyBtvMuAAo
         PCMnXl9VV7JAq/foUiccel1wr11kB94U1KIbMigQPAfX8R+yIdlY7eSKEDGEiCIg17E7
         gZA3flC04zZd0//xGNWqHWfGXmoeBJ1eMRVZWt8/+23CcWvNd8FFEvEbWeO2KQUkzXOM
         ZLCA==
X-Gm-Message-State: APjAAAUrwFtbXHksy5xJ5J7z9kmwRX2+UYuOFlUnOhiv6KFQjpTSJXRX
        ciEK5w5ILCx1qp4DZaym3OUmxomt393PRC2yqKo=
X-Google-Smtp-Source: APXvYqwyAO3PHh8CsDP/fgKOS5XeSiKM21hhrMAiXJHObVwafrosM1WwbUVs2nV7MshcFxRnNZXx7jRoEr2WYPYpVHs=
X-Received: by 2002:aa7:ca54:: with SMTP id j20mr23149212edt.50.1565370286475;
 Fri, 09 Aug 2019 10:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190809071051.17387-1-hslester96@gmail.com> <e10b37c6-25fa-e584-b943-07aa32725198@arm.com>
In-Reply-To: <e10b37c6-25fa-e584-b943-07aa32725198@arm.com>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Sat, 10 Aug 2019 01:04:35 +0800
Message-ID: <CANhBUQ1LaEKDBrUWZZ_+SUWDTx9u6bTi0vaK-C4aLMFN3dUD=Q@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] sched: Replace strncmp with str_has_prefix
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 7:31 PM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 09/08/2019 08:10, Chuhong Yuan wrote:
> > strncmp(str, const, len) is error-prone because len
> > is easy to have typo.
> > The example is the hard-coded len has counting error
> > or sizeof(const) forgets - 1.
> > So we prefer using newly introduced str_has_prefix()
> > to substitute such strncmp to make code better.
> >
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
>
> I tried to have a look at the series as a whole but it's not properly
> threaded (or at least doesn't appear as such on lore), which makes it
> unnecessarily annoying to review.
>
> Please make sure to use git-send-email, which should properly thread all
> patches (IOW make them in-reply-to the cover letter).
>

I have used git-send-email to send the series with a cover letter.
The cover letter is here:
https://lkml.org/lkml/2019/8/9/108

Indeed I find the series are not in the same thread, I am not sure
what is wrong with them.

>
> Other than that, I stared at it and it seems fine. It's not that helpful
> here since I doubt any of these prefixes will change in the near feature,
> but hey, why not.
>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
>
> > ---
> > Changes in v4:
> >   - Eliminate assignments in if conditions.
> >
> >  kernel/sched/debug.c     |  6 ++++--
> >  kernel/sched/isolation.c | 11 +++++++----
> >  2 files changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> > index f7e4579e746c..a03900523e5d 100644
> > --- a/kernel/sched/debug.c
> > +++ b/kernel/sched/debug.c
> > @@ -102,10 +102,12 @@ static int sched_feat_set(char *cmp)
> >  {
> >       int i;
> >       int neg = 0;
> > +     size_t len;
> >
> > -     if (strncmp(cmp, "NO_", 3) == 0) {
> > +     len = str_has_prefix(cmp, "NO_");
> > +     if (len) {
> >               neg = 1;
> > -             cmp += 3;
> > +             cmp += len;
> >       }
> >
> >       i = match_string(sched_feat_names, __SCHED_FEAT_NR, cmp);
> > diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> > index ccb28085b114..ea2ead4b1906 100644
> > --- a/kernel/sched/isolation.c
> > +++ b/kernel/sched/isolation.c
> > @@ -141,16 +141,19 @@ __setup("nohz_full=", housekeeping_nohz_full_setup);
> >  static int __init housekeeping_isolcpus_setup(char *str)
> >  {
> >       unsigned int flags = 0;
> > +     size_t len;
> >
> >       while (isalpha(*str)) {
> > -             if (!strncmp(str, "nohz,", 5)) {
> > -                     str += 5;
> > +             len = str_has_prefix(str, "nohz,");
> > +             if (len) {
> > +                     str += len;
> >                       flags |= HK_FLAG_TICK;
> >                       continue;
> >               }
> >
> > -             if (!strncmp(str, "domain,", 7)) {
> > -                     str += 7;
> > +             len = str_has_prefix(str, "domain,");
> > +             if (len) {
> > +                     str += len;
> >                       flags |= HK_FLAG_DOMAIN;
> >                       continue;
> >               }
> >
