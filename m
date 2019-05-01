Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5D2C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 14:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CF621743
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 14:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeYsxGTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfEAOaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 10:30:18 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42715 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfEAOaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 10:30:18 -0400
Received: by mail-ot1-f65.google.com with SMTP id f23so14876774otl.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 07:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cifjmdVuek90Eb9d8NwHoWeg6/t7bpNo+ZBi6uHa05U=;
        b=FeYsxGTo5CIOsG4xy2ONV0j0r43VcHxWOO3nSxXbuk4KY6WsizcIXGQMGrK/i8wRw9
         5ZKphp7F09P+EA2c2nhUW3C//JDPS3E5Thsa+ul9MehqLJ4G+UsQNfWLJL9x1SRR5GXp
         CNO/mcqSVnRLQakQG16Cav3fU8I4KIG8TSfEayFh0T7+eVSrpN4sSQrfW3s3IVcRYyV0
         UfG6KorNZBiG6cYnHAfBDQOWX2TyIz/tVxt9X3nmTXbnbLzLu+sTPKyGlslfwMtAsntH
         6JkDTUbiBFXcj3FO0qpdxWG6yuSR/U/E8ug7NbkMw5NmYJwz6UgC9YubVouIBMcQRTCq
         sIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cifjmdVuek90Eb9d8NwHoWeg6/t7bpNo+ZBi6uHa05U=;
        b=TycAbQaPX1drEv29/twCtwYYfTJI29yig3sUnbBx1ZUZHLqM/yAdrWp5H2daxziDll
         BZBiX4Tpijxk6Eboy3UrzewtKauX5hEqUt/ZvF2BBj1QG4vtIMOxfqAuWY9XSELxUNjw
         Buwx7owyN6ko1cI0b+5FSmm0nB7TzmNuJgdWc6HA2DKQUtx/9Pd4Fgc1nisvUemqY52T
         Q3IG0uWWyVCPVKaC7yP6DG8bEs5k92Rf6bUwNx/0fP+vm5d1tU9m5CFHnhgldHF3MI8U
         Hf1F0ewxZfEhjX058/9WCo9ERlKlPuqWV4NdSvURM5HphOrFoZXk4QIswDMWOQCbRDsm
         NSzg==
X-Gm-Message-State: APjAAAVOIjU/7i7lRCEHI7vKKebjx39VdWimhlY2fmuo5R9pual3ymmJ
        VkWC45ZUEo1sUBQJROK9Pjbdynr1CErFHi5hYZSIaA==
X-Google-Smtp-Source: APXvYqzhx8fmXwpBkzIUzk0BEAStWDINK7JA0bM+9KhN81HQMs98IYIVPUY8tJMaMy1QE1Zkz9OkOoXQdQQd3RfVppY=
X-Received: by 2002:a9d:6318:: with SMTP id q24mr6218422otk.95.1556721017492;
 Wed, 01 May 2019 07:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190501140624.6931-1-TheSven73@gmail.com> <20190501142332.GA13008@kroah.com>
 <20190501142412.GB13008@kroah.com>
In-Reply-To: <20190501142412.GB13008@kroah.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 1 May 2019 10:30:06 -0400
Message-ID: <CAGngYiVznEOQk-Tbyh6km+=+70gJebBEATxN5A8OE6iEzrHXqA@mail.gmail.com>
Subject: Re: [GIT PULL] staging/fieldbus-dev for 5.2
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 1, 2019 at 10:24 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> And as this is just a single patch, handling them as patches is much
> easier anyway.  Only when you get into the 20+ at a time does pull
> requests help.
>

Patches are much easier for me too, but I assumed this had to be done via a
pull request.

How do you distinguish between a patch that's still spinning on the
mailing list,
and one coming from my next tree? The Reviewed-by or Acked-by tag?

Patch coming up, thanks :)
