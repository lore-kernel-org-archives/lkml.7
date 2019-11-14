Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281D2C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 22:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE8B206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 22:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bn+ZUJ5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfKNWnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 17:43:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36216 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfKNWnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 17:43:45 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so8736021wrx.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 14:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UDHR/+KevxJlFcmst+Pmd+nQiCGSFhO8L4Lzn91tvGg=;
        b=bn+ZUJ5GmPLiPQggNIIqXnhPeXj4mVf9SAjKkPoTt+r7Ar3YwGQuksZUNajmA+E1Xy
         fUWqKI+uH8uVIwCRUyCdypvJzCUGQquy3jzlrr7j5xDcHvRKI4y3QKq+cqwteRKkvHz0
         cbI1NCi2amNscfMql+pN1n6OR3mSFKqsxLPVSe7+xG40y64XLuSlrM/YMGtSkFvrQKFO
         DK4F8yJsrDM35pcxf/nBCVg6Q4BnxbeOf2sPN9/0tzvIe2jGxjU8g+eafqygY0XbJ6zr
         T9WYN1RDljhJHqFVZaGnCPqtp8ONjPkDL30ylBbXkE2RkcKVDTYapwcbnjWg2EtRSQ8P
         Fsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UDHR/+KevxJlFcmst+Pmd+nQiCGSFhO8L4Lzn91tvGg=;
        b=kLsW+yX1Es4Px1mX0BEXsHCGFjGuwefY/rpb0mkpBsxOlfRHwvo4dKY4bRxSp44QBI
         SeQgiVAkhSwQ/6zKkpWhBkzqt7vnHCGop1P1eNIktGHNqyh0tuvuG1LwEd5SxSqhTYB6
         pkaWCaDKgb9EooNpdlhxU9BpOAB1b+rmdX3Qb9R9bnhRPHMR+BJEU+UpR5aTLSwpRvnY
         V+r/s8YUQrsjyWy2wHh4xAeoynbn4mT+qj+OWXB493B4FlWZ0mVvWnpoj6CHgh9uAf7l
         9xv5bargCE5PsEX1AqfNyoW+l4qm/gn7fRLNZM8GHYDIezDt/toe5DaCfKeASVPj81dl
         WgRw==
X-Gm-Message-State: APjAAAVL3uXSCFkREWUVYe8KPp3proPoG6mzkH0CxA92QWrctOadSaLJ
        Ni5//0sJ7RuTCyJpfCXbnx0qRRuMKU/Jd2PgJ0Uwwg==
X-Google-Smtp-Source: APXvYqzwZih4JKmBS4N9a+zK31EzesAhn/+42beU2GBDQKw1b3VfwZNdbrasCFJQCrDah7nbIbzzOW+cNuwL+u8kQDA=
X-Received: by 2002:adf:db92:: with SMTP id u18mr11041793wri.1.1573771423328;
 Thu, 14 Nov 2019 14:43:43 -0800 (PST)
MIME-Version: 1.0
References: <20191114190844.42484-1-jacobraz@google.com> <20191114214301.GA159315@google.com>
In-Reply-To: <20191114214301.GA159315@google.com>
From:   Jacob Rasmussen <jacobraz@google.com>
Date:   Thu, 14 Nov 2019 15:43:32 -0700
Message-ID: <CAPZ+yN+EP=ffzWDz4hWZ3W=usDoYt7VFKaoMAgzvjo7WL_jW=g@mail.gmail.com>
Subject: Re: [PATCH] ASoC: rt5645: Fixed typo for buddy jack support.
To:     Ross Zwisler <zwisler@google.com>
Cc:     Jacob Rasmussen <jacobraz@chromium.org>,
        linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 2:43 PM Ross Zwisler <zwisler@google.com> wrote:
>
> On Thu, Nov 14, 2019 at 12:08:44PM -0700, Jacob Rasmussen wrote:
> > Had a typo in e7cfd867fd98 that resulted in buddy jack support not being
> > fixed.
> >
> > Fixes: e7cfd867fd98 ("ASoC: rt5645: Fixed buddy jack support.")
> > Cc: <zwisler@google.com>
> > Cc: <jacobraz@google.com>
> > CC: stable@vger.kernel.org
>
> Need to add your signed-off-by.  With that added you can add:
>
> Reviewed-by: Ross Zwisler <zwisler@google.com>
Signed-off-by: Jacob Rasmussen <jacobraz@google.com>
