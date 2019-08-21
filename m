Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90516C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D94B22DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 19:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F/+Oa6Al"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbfHUTuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:50:44 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32979 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730100AbfHUTuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 15:50:44 -0400
Received: by mail-io1-f65.google.com with SMTP id z3so7161664iog.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 12:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rtFGKBgCd1TZut+zMz8eGkPWN4Ft5SXhOxAqFSaWHTk=;
        b=F/+Oa6AljcaGT7AZMMaoHJd1qxFfBdS3akg968hI3bNA0qDODwf2moe703nCp58sD9
         AsUfjNQWG3JzM1GSV8TwP4ChDRj059cD/M8lD7yx7gc6b2moS2fpfnICTM95WgLIU2XN
         OyHZwVpyXcyie/YXvBzvU6Cvsy5XSJ0UZXIe1zter7TbnV0oGW+Pw/zCVmW8HOEuKYxh
         Xh4q+kxb4qJE8HkhdsSDBhyNo/91Ezp5TcOrJW6XTU2QnL3NnzCLzlW7nq+C6MfkwY6+
         g4Kq9MJnldm2UxtK4H/fQGbxJwnYB5ePs3sUTZ9KfjValH9wVqiFQrvND1KNTKPBq4oS
         PREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rtFGKBgCd1TZut+zMz8eGkPWN4Ft5SXhOxAqFSaWHTk=;
        b=MpA0ovuDvvCHx0DnKQOS2aP9QwV9mRAmtXs4mFsiDQ6t4cHR/QYsCQLHhZi1bPAdao
         9QCQZGOXoDJ0dyyEU5PdNXgFoguzrOvSIF6dFFl2rhgYMfZyI2MroaEzG/fG+Bh/mE1z
         tcwGBfm0dCK9dSj+KRYxAQBP9fm+tB+ANbkONQqBvMaEPFJatYGRYLD5DQeu4Hg1KRze
         dmjhokOZbHd4eoICkwjzmkqSsAIOd8MP/nsm4+IZGQLtBj+fG5Gy37a1jn955GDRGnXX
         SPUztw2AfeMZRJUxw5xnpPThFAwCKb5aystHdsgAlXH+k53cyVHl5LSC437bqsI3d2lY
         NMKw==
X-Gm-Message-State: APjAAAU4OZ7qGJEGkiG5+qpww3n+xO2uegU60oEFzWAIdvIeCKwgq3R6
        GiFz8OQlLt547PWI5hmml6+T/DC58d9GoJCNaPPcWA==
X-Google-Smtp-Source: APXvYqzpUITfJ3aXOdZQ9dZBQM356Go1zU9atNXqTDKkgL8ORnAumj05GaV1+zfZR91j+q9m67jjAOrHiu07IPGUEsk=
X-Received: by 2002:a5e:c911:: with SMTP id z17mr11100339iol.119.1566417043038;
 Wed, 21 Aug 2019 12:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <1566315384-34848-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566315384-34848-1-git-send-email-pbonzini@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 21 Aug 2019 12:50:32 -0700
Message-ID: <CALMp9eSVyTY5k3r-KAAVa4Wft=ruzvJV6F3PkEDvYiYPYEZyJA@mail.gmail.com>
Subject: Re: [PATCH] selftests: kvm: fix state save/load on processors without XSAVE
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 8:36 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> state_test and smm_test are failing on older processors that do not
> have xcr0.  This is because on those processor KVM does provide
> support for KVM_GET/SET_XSAVE (to avoid having to rely on the older
> KVM_GET/SET_FPU) but not for KVM_GET/SET_XCRS.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
