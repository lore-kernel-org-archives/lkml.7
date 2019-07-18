Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC270C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C9D2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 19:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563477667;
	bh=IiRKmbjEHWcc/pwAuBR4Iq4lrU44n+nMPUEDKr9b4C8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Vz2CS7W4HQwPR6lkfSM2Va0yM/dZ4Fjm9aJIMcvtN6gKDrUJy2PMFOUcKlUkTBSv4
	 pVbE0WsjGaUyCkqheLP1iS9JwGkKsn8WGTZ1ghza5+asJMwqt2QXkKUB5iiuWPp8k5
	 cMnDoG2rAgEqQXmFWi0D+/inrx+yBwWrPKOr1Ob8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391198AbfGRTVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 15:21:06 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41313 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728056AbfGRTVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 15:21:06 -0400
Received: by mail-lf1-f68.google.com with SMTP id 62so15135224lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 12:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4QeLxoUR5GC1fzJgrY/Gaoy4CZQkO1wAQY98S4S8www=;
        b=cyqlQbtJUC7/p88rbuEotI6/eTfK5dLXe4zZS8O2ZXbmEaicecY/DV60M4A6OrWJ8c
         vOxVRcku82bI48nOdc26GqnfX6RtFPKBo7yv+U6ypPNtYeUvdRbFY+PXtztECWFbCuTl
         vjkzxvhNQQ5nKt2KoanJkzCK78Ma03YSQ8hpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4QeLxoUR5GC1fzJgrY/Gaoy4CZQkO1wAQY98S4S8www=;
        b=se9pYHdrfo1WP5dozJ7uxJDnmFegldYz0l0SJ6Gwnvi5rN11DEEOwJdOp2hRczN7E2
         ta52VvCoM2cuHYPt+0Ptup/fahcOFoSnfHT30ayr9+kYl1EMlSKzJTX9YHHu8nvCFKrw
         tNg7GBg4UspM6tUYiM5ppmftPG0tv07Bn50BUCy7Rf6DIC9fYuQQ81C/8IdomeI/qMB5
         7TmlAinWdYrNKslXTowi7BtSjaE01j0db69D/uqcTkcXHyL8sCqnGKxfCF2bs19ph+Wj
         5+P09MSPMM7AcH04YvnbVitb2p0+cCyQPtjfP+yASJV7jFvDRhTAu4Wq6KRgQA5hyUTe
         Ya8w==
X-Gm-Message-State: APjAAAW6F1krxeVw7/OxTvXl9tyG+RYrTTsVBYq0vEFn6vd3Y0FQWDC7
        5Kdhn4mbqVy1DVYT1xSnw0l+PIm0UbM=
X-Google-Smtp-Source: APXvYqwzHl88sIWPBHrOFNBbrh8jZLEEeY8wBem16iZDEtcxcVT8+3V+2fIPEyRksKZSzUt8MkRRCQ==
X-Received: by 2002:a19:c887:: with SMTP id y129mr22149394lff.73.1563477663976;
        Thu, 18 Jul 2019 12:21:03 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id j7sm5787540lji.27.2019.07.18.12.21.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 12:21:02 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id z15so15735259lfh.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 12:21:02 -0700 (PDT)
X-Received: by 2002:ac2:4839:: with SMTP id 25mr21914065lft.79.1563477662485;
 Thu, 18 Jul 2019 12:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190718113346.GA19574@linux-8ccs>
In-Reply-To: <20190718113346.GA19574@linux-8ccs>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 18 Jul 2019 12:20:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=whjTFKB3TPPkgCvMX9P+C=hy2ZjhQy7C5reTQKV6MtuOw@mail.gmail.com>
Message-ID: <CAHk-=whjTFKB3TPPkgCvMX9P+C=hy2ZjhQy7C5reTQKV6MtuOw@mail.gmail.com>
Subject: Re: [GIT PULL] Modules updates for v5.3
To:     Jessica Yu <jeyu@kernel.org>, Prarit Bhargava <prarit@redhat.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 4:33 AM Jessica Yu <jeyu@kernel.org> wrote:
>
> Modules updates for v5.3
>
> - Fix bug where -EEXIST was being returned for going modules

Hmm.

I have pulled this, but this change makes me a bit nervous.

I have this dim memory of us having deadlocks in module loading
because module loading triggered other modules to be loaded, and we
had circular dependencies..

This is from years and years ago (that whole state check is not
recent), so my memory may simply be wrong, but I thought I'd mention
it...

                   Linus
