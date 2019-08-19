Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7276C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82CC22CE9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566234150;
	bh=X1SmKw8+Qs82soC95f0giRHZ3qgpvQWn1B0nZevQGCw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XBRTWz6NsOXLFcVQx5J7UWtLLKrN92x3mrEI0FW9pb/6RToLefDjIXpZ8nfsI/OFQ
	 QW4sKkjEH4dmiyBhB5xiTwJCIXDhniEvCfn5TKtO4dFu6tg82s/y3t6EeA42m0V0P7
	 k3cO8nF+FFvAQcRiClYnC5O4P5zdpFxtxE8VDfds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfHSRC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 13:02:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbfHSRC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 13:02:29 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32BA022CE9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 17:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566234148;
        bh=X1SmKw8+Qs82soC95f0giRHZ3qgpvQWn1B0nZevQGCw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jhhx8s4L2e65Oshpsk6mO5CmzknalE1g0DQzH/FgoJHwUR2tHIQ7w13sMBZoFeaio
         8QeKVxDc3AkLVjzBMdHu5j5//Y20mAFIv7tRRAI0BxzwdM4lRd0PGC0xfaRvXTsvP4
         iSfPHpwPY1OdCVaLcsEkbPXai6Vnbmgd6PAktpdk=
Received: by mail-qt1-f169.google.com with SMTP id y26so2679269qto.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 10:02:28 -0700 (PDT)
X-Gm-Message-State: APjAAAVOwbJDXuzewKK7lME9QtiK0qiewIgfXGkii5ENE+JLf1cI0ZwF
        6kdM2Mo3xKgESnXt3UECOJ/uihQghQMc3i7P0A==
X-Google-Smtp-Source: APXvYqwJ8ryHfu9hmBUKB5hLCX6oXg+u5UMk97nhD4HDUL+olcKLxhNC30uWHgMMnDNUHn04GooRYy7hDYnJ4qdUE7g=
X-Received: by 2002:a0c:9782:: with SMTP id l2mr11504993qvd.72.1566234147247;
 Mon, 19 Aug 2019 10:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190816093107.30518-2-steven.price@arm.com> <CAL_JsqJKm7n=SuQrPTxfWR=Cgqn-gR-bgOrOdTVyR_XCae0FQg@mail.gmail.com>
In-Reply-To: <CAL_JsqJKm7n=SuQrPTxfWR=Cgqn-gR-bgOrOdTVyR_XCae0FQg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 19 Aug 2019 12:02:16 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL2oeKDKqv0DSQkMmM_=0sN0eY37xi4Y4oComX_v4U9oQ@mail.gmail.com>
Message-ID: <CAL_JsqL2oeKDKqv0DSQkMmM_=0sN0eY37xi4Y4oComX_v4U9oQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: Queue jobs on the hardware
To:     Steven Price <steven.price@arm.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 11:58 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Aug 16, 2019 at 4:31 AM Steven Price <steven.price@arm.com> wrote:
> >
> > The hardware has a set of '_NEXT' registers that can hold a second job
> > while the first is executing. Make use of these registers to enqueue a
> > second job per slot.
> >
> > Signed-off-by: Steven Price <steven.price@arm.com>
> > ---
> > Note that this is based on top of Rob Herring's "per FD address space"
> > patch[1].
> >
> > [1] https://marc.info/?i=20190813150115.30338-1-robh%20()%20kernel%20!%20org
> >
> >  drivers/gpu/drm/panfrost/panfrost_device.h |  4 +-
> >  drivers/gpu/drm/panfrost/panfrost_job.c    | 76 ++++++++++++++++++----
> >  drivers/gpu/drm/panfrost/panfrost_mmu.c    |  2 +-
> >  3 files changed, 67 insertions(+), 15 deletions(-)
>
> LGTM, but I'll give Tomeu a chance to comment.

Though checkpatch reports some style nits:

-:46: CHECK:COMPARISON_TO_NULL: Comparison to NULL could be written
"!pfdev->jobs[slot][0]"
#46: FILE: drivers/gpu/drm/panfrost/panfrost_job.c:143:
+       if (pfdev->jobs[slot][0] == NULL)

-:48: CHECK:COMPARISON_TO_NULL: Comparison to NULL could be written
"!pfdev->jobs[slot][1]"
#48: FILE: drivers/gpu/drm/panfrost/panfrost_job.c:145:
+       if (pfdev->jobs[slot][1] == NULL)

-:53: CHECK:OPEN_ENDED_LINE: Lines should not end with a '('
#53: FILE: drivers/gpu/drm/panfrost/panfrost_job.c:150:
+static struct panfrost_job *panfrost_dequeue_job(

-:67: CHECK:COMPARISON_TO_NULL: Comparison to NULL could be written
"!pfdev->jobs[slot][0]"
#67: FILE: drivers/gpu/drm/panfrost/panfrost_job.c:164:
+       if (pfdev->jobs[slot][0] == NULL) {

-:71: CHECK:COMPARISON_TO_NULL: Comparison to NULL could be written
"pfdev->jobs[slot][1]"
#71: FILE: drivers/gpu/drm/panfrost/panfrost_job.c:168:
+       WARN_ON(pfdev->jobs[slot][1] != NULL);

-:160: ERROR:SPACING: space prohibited before that '--' (ctx:WxO)
#160: FILE: drivers/gpu/drm/panfrost/panfrost_job.c:497:
+                       jobs --;
                             ^

-:165: ERROR:SPACING: space required one side of that '--' (ctx:WxW)
#165: FILE: drivers/gpu/drm/panfrost/panfrost_job.c:500:
+               while (jobs -- > active) {
                            ^

-:204: CHECK:SPACING: spaces preferred around that '*' (ctx:VxV)
#204: FILE: drivers/gpu/drm/panfrost/panfrost_mmu.c:150:
+               WARN_ON(en >= NUM_JOB_SLOTS*2);
                                           ^
