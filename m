Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F25C04A6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 00:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5A0208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 00:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCaYi6iH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfEIAup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 20:50:45 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43041 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfEIAuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 20:50:44 -0400
Received: by mail-qt1-f193.google.com with SMTP id r3so615050qtp.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 17:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lKvoil9HNmhPTazHRMwHsi/uN0UT2qVv1DkSDyE5wNI=;
        b=nCaYi6iHEA7hQ1jIirrfxGV70xswo9YyTlLCCgAFsuHfLf508F5YXDdbB9sIgejKev
         7veAZxRHNO9B90/XpblNZSADBG/QxxHHZpq4RC5bQ5QM6/dsHKUtjIVHDf4GqAXqxfKn
         t/JhZqVwkgX+pqxg6IVCeym11pNYAYyn/l2fOs4Mj7KYoQWsrKirufk1pNRNQLl1jE0A
         LEHdGg0oiRIiV7M6Z2a8i5xFLz6Y7geqSUmlqXd4lercuVt4eTnbVZP69w0wwGBVYvr8
         OWowW79Y60AHoJxj4flsDRDrgvHa1Tgo+7jlAriOkhzpPPtRlb1xeeRYqFteelzufNU2
         L6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lKvoil9HNmhPTazHRMwHsi/uN0UT2qVv1DkSDyE5wNI=;
        b=h/+yMTN5PhGw9DITiMCW3eudUVkMG9TVW0oEnyJUd7gnWqJwr0TFApbp+GRuB+UWlO
         8gyvFGpoBeCN0JYVE7/4asvT4J8huLINq5G8ehMmprOLEh7lsX9n3cbXv/vjF0QAfuDH
         J8G0X4qekHl95z0COWbo4U7UAzRhxpYr68dfIruhHqyx5ZzCDkjLle5U+Xhs+iwhilF9
         RyZ0rnqHMAc4ecTgUzC8YJpDz5U5zJbDmqEXp+iLr+rILAN1RwzAmcWim8INhN4kbVt3
         pMLdjUH6IFQmZL7TLbpyvLWJ30KtD2iTlt6zwKwRw1Un5heF6nMzRXDvUr0q4AJUnBak
         pXnw==
X-Gm-Message-State: APjAAAWLrdXRKl2hInIpmiI0BQpTikEmAD+FHu14qs6OirmqS/h/oM0j
        bGwpis/S40UKI39EP7LwttdZTE2yjVXLI8gkHDw=
X-Google-Smtp-Source: APXvYqxTwsZy+bJni+WylRu8HA3AbMT28j61hBkmVSyWhZAw6QgZwsR168c/rxJwU/kb6sFEQtKl+D4GY2n7S3xKi1k=
X-Received: by 2002:a0c:8832:: with SMTP id 47mr1062767qvl.88.1557363044051;
 Wed, 08 May 2019 17:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190506081939.74287-1-duyuyang@gmail.com> <20190508085548.GA2606@hirez.programming.kicks-ass.net>
In-Reply-To: <20190508085548.GA2606@hirez.programming.kicks-ass.net>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Thu, 9 May 2019 08:50:30 +0800
Message-ID: <CAHttsrbJ_jHdQnWESXBf6V-fzrUA6WKAKRcdoLOgLsw+qarvig@mail.gmail.com>
Subject: Re: [PATCH v2 00/23] locking/lockdep: Small improvements
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will.deacon@arm.com, Ingo Molnar <mingo@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>, ming.lei@redhat.com,
        Frederic Weisbecker <frederic@kernel.org>, tglx@linutronix.de,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you so much.

On Wed, 8 May 2019 at 16:56, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, May 06, 2019 at 04:19:16PM +0800, Yuyang Du wrote:
> > Hi Peter,
> >
> > Let me post these small bits first while waiting for Frederic's patches
> > to be merged.
> >
>
> They apply nicely and should show up in tip after the merge window
> closes or thereabout.
>
> Thanks!
