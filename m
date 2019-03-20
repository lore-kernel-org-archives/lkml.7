Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0C3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 02:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF592183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 02:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5dheTyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfCTCbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 22:31:02 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37199 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfCTCbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 22:31:02 -0400
Received: by mail-qt1-f194.google.com with SMTP id z17so856755qtn.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 19:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z4P9JaRSt8xPt7JdkSd0fTgJ95kf7fCY0+tUGcSiO/E=;
        b=K5dheTyc62Z6K7G/0k8yU35QfeISyhxCYf+S9G1tdzbExuxFmwgHiv7VW8HItM1ABK
         ibnGYWu5q1BHdCaUkKXsbADos0YUWACekVb3F4hHUr9dJaLlBeQbhznjcGScWa1yLoUn
         7uqmR6+qK62U+GcI3NdCN9jjND5lXoe+NNpmas3o8Ehjibr81oV+saD3kRqGCl278ubx
         0V8nkFaK5XDgfImRgqdPvl3/pPrp2cRtTcXMGLXtn7fDoJLrKuVqDJbl2SzFvsZ1jh4q
         9WAzvEMidx2TS0dDkUMhu2GEzBERQBw6KKnPO/LeI+Ljh051xDgHfGs3tCTlW62fspsE
         fhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z4P9JaRSt8xPt7JdkSd0fTgJ95kf7fCY0+tUGcSiO/E=;
        b=WtYAOa1HdJpUJ/k/17B4CVmurYMk7NZm0NK0AfHSC+gkBDmXAquRlP7aXv5K8fs5U9
         RrojPmpxncncY77yR1da0himAnEWs+No28xrE/qoglnwGHwBVI25E5JpVLf2uD+ep43b
         I5pzAM2NBiSsgypCr+0epjyMNnGwzQVco6UgmoGpeqPM23ATUh1tcNGTOwGLmBBRehJS
         wGy7K6o8ScBcaKrg4eZPAY8egplH1nqay2C/qp93YNP9lYH6B3bW4ocnyZw/rRAeK4D2
         qsjxzcPohfxyo8av6OmxpqY23dh5IS/0zmaSXj4jHgZZO3CVkyiH82pdJY/L3hP3niHl
         vqQQ==
X-Gm-Message-State: APjAAAVILL5wgg6PoJ1l1i8CUlFi9F3/XftvRyrtHdmEl3tq+QWDoKDC
        qcUiryDEZabgXP7MFsKNp3pYWz+fIJL+JMDxN2o=
X-Google-Smtp-Source: APXvYqy15oS71M/HOpKpclUTi2gaBJkGclp3ThgWnsi6fjlb8mZ/E/3NsXhf3R9wA2DqTigi7MjPscW0LaKHqKIxIww=
X-Received: by 2002:a0c:ba9d:: with SMTP id x29mr4467745qvf.112.1553049061443;
 Tue, 19 Mar 2019 19:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190318085733.3143-1-duyuyang@gmail.com> <20190318085733.3143-16-duyuyang@gmail.com>
 <1553014484.65329.10.camel@acm.org>
In-Reply-To: <1553014484.65329.10.camel@acm.org>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Wed, 20 Mar 2019 10:30:50 +0800
Message-ID: <CAHttsravNVDC882277Vwqif3oicHUnixj7NuTjNE2AL0V5cpwA@mail.gmail.com>
Subject: Re: [PATCH v2 15/19] locking/lockdep: Remove __cq_empty()
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org,
        ming.lei@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for review.

On Wed, 20 Mar 2019 at 00:54, Bart Van Assche <bvanassche@acm.org> wrote:
>
> This is the most important change in this patch. Using the title "Remove __cq_empty()"
> for this patch is misleading because the above patch does something else, namely changing
> the return type of __cq_dequeue() from int into a pointer. Should this patch perhaps be
> split or should the __cq_empty() removal be left out from this patch?

I actually hesitated whether _cq_full() should be inlined as well.
Having said that, let me keep both of them and just change the return
type of __cq_dequeue().

Thanks,
Yuyang
