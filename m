Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E866BC47404
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 11:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B560B2081B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 11:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568289586;
	bh=dxkQWDJSBkKUuSDMNmAkBHOy5rcu4ao+BACwOEmd2fM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=c1b2owt69/2PnkqYu3leaMCQpwQysVyhpUIct4sH0LfJ3X1IwZpHgNpuNUAjrgq/i
	 DFweacHTJkv7tr10YZZVqgVH0gEHgg0U8k9nguwcrJc7aJUNrEneqBwXdcxpK3ffqW
	 +rXh+yhJukFI9+HMMMzN9z5WptBDxqWXbv9dCQ/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731544AbfILL7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 07:59:46 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:44656 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731483AbfILL7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 07:59:45 -0400
Received: by mail-lf1-f47.google.com with SMTP id q11so4174139lfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 04:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FYtDp2gQu85OzThc5ikz2A0+zoE1rUIOtPZpolymb7k=;
        b=LLpYNGLWO+FOw9m0V2uY2cWrgwX2O+ZH+hY2GxqW7nLiXxw6ee3Ik7+QES/hMd+qb8
         2x3Frma/RnZ2/wtXERUJiZagrYagqPoKxFlYUzMKqK3e8vRhNqLRhufV+rTV7H4gg9gy
         D9Cua/F/D39AXmf2DrMb8Hit7DqqxEheHEYOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FYtDp2gQu85OzThc5ikz2A0+zoE1rUIOtPZpolymb7k=;
        b=C7HO/bWOTVGjwOHZi+fT49x2a55+PasGe/+fC5WZDR9LPYB+mugy2l3kcuTakk05mA
         dGbcgo7cnpgYfLzVBC5jilLtr0pktZZtIHvxeGISA8Kx8F0wwVmN8VZbrmDAwCzdnhre
         zmlkhF0yixFDA0CQt+850eXBYPBPIUT+NfnOjbmTm0bot3IPHUarGReLEKxRgzKP3oGs
         Ohq+MsOWaXSud1E8+V1ptj/+sHHUKNoWV3UU0tdXQ0g0dyKbADdZUEG8wkVaK/JSzx0B
         ElQOH0/Wgt4XVXF0Yicko1bJh2irtFyvhT6euU8ME657UCT6RFsHTUplJQbBoRjv4voG
         hYGw==
X-Gm-Message-State: APjAAAXPVJ7Tfjum3fucOqgbBKSLGYYnR74f/Y2Ddi7bz33AxtPSQLZz
        mLoy7c5tjcR+L8HhYvjPjZsyV09FdKyLaA==
X-Google-Smtp-Source: APXvYqw59LXQThOFufBkkdhrH1z8Cm5VxMwkHxtB8xFo9RGQTIKC3hvJtIEYMJlfXF3FKS0NH8kBhw==
X-Received: by 2002:ac2:4ad9:: with SMTP id m25mr668198lfp.89.1568289582995;
        Thu, 12 Sep 2019 04:59:42 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id j7sm6323984lfc.16.2019.09.12.04.59.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2019 04:59:42 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id q11so4174035lfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 04:59:41 -0700 (PDT)
X-Received: by 2002:a19:741a:: with SMTP id v26mr27747225lfe.79.1568289581382;
 Thu, 12 Sep 2019 04:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <ad70d1985e8d0227dc55fedeec769de166e63ae0.camel@suse.com>
 <156535522344.29541.9312856809559678262@skylake-alporthouse-com>
 <20190910142047.GB3029@papaya> <3dcff41048621ff440687dd6691aae31a8647a1e.camel@suse.com>
In-Reply-To: <3dcff41048621ff440687dd6691aae31a8647a1e.camel@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Sep 2019 12:59:25 +0100
X-Gmail-Original-Message-ID: <CAHk-=wjKv_Zw2zGHduyrQH_VQzxXYzwKdwwzzpsdnsdx=EK30Q@mail.gmail.com>
Message-ID: <CAHk-=wjKv_Zw2zGHduyrQH_VQzxXYzwKdwwzzpsdnsdx=EK30Q@mail.gmail.com>
Subject: Re: 5.3-rc3: Frozen graphics with kcompactd migrating i915 pages
To:     Martin Wilck <Martin.Wilck@suse.com>
Cc:     "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>,
        Michal Koutny <MKoutny@suse.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "leho@kraav.com" <leho@kraav.com>, "tiwai@suse.de" <tiwai@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 12:51 PM Martin Wilck <Martin.Wilck@suse.com> wrote:
>
> Is there an alternative to reverting aa56a292ce62 ("drm/i915/userptr:
> Acquire the page lock around set_page_dirty()")? And if we do, what
> would be the consequences? Would other patches need to be reverted,
> too?

Looking at that commit, and the backtrace of the lockup, I think that
reverting it is the correct thing to do.

You can't take the page lock in invalidate_range(), since it's called
from try_to_unmap(), which is called with the page lock already held.

So commit aa56a292ce62 is just fundamentally completely wrong and
should be reverted.

               Linus
