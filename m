Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3BBC282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 22:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0042173C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 22:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3TAcSM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbfEVWwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 18:52:19 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:33469 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbfEVWwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 18:52:18 -0400
Received: by mail-it1-f196.google.com with SMTP id j17so6695427itk.0;
        Wed, 22 May 2019 15:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HWRXO+edmhSom/gacoPKkE1g/E36lS3QYMoiSV/+smA=;
        b=N3TAcSM7SiptL6E2SpY6CNVVfh0UKXMcbqLjx9uyZbqsLzAXlXzIw4pG7+IRVUlyu/
         rnf1eqzZuDVLHAjTNDrN/n9Mwe4jvqUXZvuc32062sb6vlqUfryK6Y6lUTuHl4kjwiIx
         7xPmzAoKwCv9929NQCCLoDfkfXlx4FVB1SdOHxSvEWRyYRVJomHwUB89NSpG/Xkli4bV
         n/SHezDeA2bj806k3LyjwH85p2tNOk3q0yXDISrFmkNjm+si0G+J06iz8tA9Gj0jlTxm
         B7hbMFRZsI5wegx8aNy51mnQ/7oP0cVlk5r2gyIczutHFeENqTgmpCBJ74wO8BCPtn/b
         Y7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HWRXO+edmhSom/gacoPKkE1g/E36lS3QYMoiSV/+smA=;
        b=dBlTph+za0Qqn53OwFXbOcA/f0vbx3b40bZDahujeGPLIVPz/H0qMZGIR4MifPcI8O
         Uj0E2GFQToitZppOgqWWTQ037hbhaTzYAjtn8zbziES6+8SFKhAjnEo5BvEqzZxyDzt1
         SoGVKbY4XRpl/Yj+onLmr0nAQoSbDnSHaN1WV1Pn5c7hb/h2higZXfFgZFDHnaLwFdGK
         bEQBz13pw2ra2TyG3VOEoyraFCccV1OLr+LqYE2dXt6mNJvOeKnueTdZqjyc+nadgYwi
         vS7MUSRfF+2DTFOWtjZN8gvZOvwoSnum+cPjzahHuQ789seyZHYOBfyEQvt4M/Wh3Vkq
         fzQA==
X-Gm-Message-State: APjAAAWemybtKnkVyf17dDQ4nffQckL4QDtSYEBbIVsaBE/Cxf9U4EqS
        rFLtj/ZYpZYrbx+PJmVFZa7IQ5TqzD9ogKzAVsA=
X-Google-Smtp-Source: APXvYqyjZ+tS45v8lDkdTg2/u2uz1fwRnLzCmsw1ZYvEykv/LDAKd+suzQDe/uZURzEU5Cb78LN9rF9D+ofHWhSGNCw=
X-Received: by 2002:a24:e084:: with SMTP id c126mr10298082ith.124.1558565537779;
 Wed, 22 May 2019 15:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190522032144.10995-1-deepa.kernel@gmail.com> <20190522221805.GA30062@chrisdown.name>
In-Reply-To: <20190522221805.GA30062@chrisdown.name>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Wed, 22 May 2019 15:52:03 -0700
Message-ID: <CABeXuvo25MXCxhfMZNgnMaWRXMktQJ7ZKqm-7M70GaGM_54+0g@mail.gmail.com>
Subject: Re: [PATCH v2] signal: Adjust error codes according to restore_user_sigmask()
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, axboe@kernel.dk,
        Davidlohr Bueso <dave@stgolabs.net>, dbueso@suse.de,
        Eric Wong <e@80x24.org>, Jason Baron <jbaron@akamai.com>,
        linux-aio <linux-aio@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Omar Kilani <omar.kilani@gmail.com>, stable@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 3:18 PM Chris Down <chris@chrisdown.name> wrote:
>
> +Cc: linux-mm, since this broke mmots tree and has been applied there
>
> This patch is missing a definition for signal_detected in io_cqring_wait, which
> breaks the build.

This patch does not break the build.
The patch the breaks the build was the v2 of this patch since there
was an accidental deletion.
That's what the v3 fixed. I think v3 got picked up today morning into
the mm tree


-Deepa
