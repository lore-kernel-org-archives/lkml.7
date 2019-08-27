Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5232BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29EBC2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c7Qmh9V0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbfH0QK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:10:58 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38469 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfH0QK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:10:57 -0400
Received: by mail-io1-f67.google.com with SMTP id p12so47639303iog.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 09:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wAZSFhrkNg8EdOkX7+bIojO3qOZTJEurdw0nzGyP6oc=;
        b=c7Qmh9V0mJfsmJ0EtwOBmGCFdov/0upZx5p7QsvvjmGhxRJqV+e8Z3ZHDER41CuEts
         K9cPQ1cOAheQbiqZ2SmTXQ1ZGiBiSjya9NaJFFWjm/BXZM++XyBrYhgHB5v1k5v2rd8e
         EAgsk1PetLvEQljYTJ1wKgeWp/Rr+wCQvCS20bG9aYWDplPJq+R6g3sqy/l0AmyBoSso
         f5VcH+pNgnuxyy9+HJXmprUUDNDHbFzyQ3WeemOF5F5fYMTMwHeB/sbcNgkq6WDiCtf+
         yWdYD1L2ttJF8xjf2NNWIWCP/dzG/kIBLeUXWrR/aCXcTjQDkKfJ1eSIKLOvamky62TS
         rvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wAZSFhrkNg8EdOkX7+bIojO3qOZTJEurdw0nzGyP6oc=;
        b=J1bnYPNaonLbUXOfrXNhwMTJIUQO7UQT59kwPIj0hB7cDCKtJsMIIQxs9kCNJPXkmK
         iL0pi+TS+d+kJ6zDmBBDLJ2ExHNhsu29W/RULmeD58KMPeq8EqeAVCh0qAjs0bnNoqYs
         EAiGvQzgVK97q9LpsQDmTkEceoQd6t6+zUWvRl/TUzM19YYjmR2PnC/HTtXnTQaIJ4+G
         4Cc1XdSCO3YcpIf52aIpMHJiZw0ty+7IBrr+BblEKmfVP9Zq8O8bVQ7yPRhpdYvMTF4h
         SZHi3gM1H91TIW9xHk5ot7D+Upf8pnjtix6v5RyJU7i5AjCAkQdiQeoGdCE+qv8i7t/p
         gv2Q==
X-Gm-Message-State: APjAAAV4x7L/bT19UA/YDi0sZtIxvf9xPRf96cu1nHOnaIL5jDzCrhw5
        BsX4p+GnJdR3N/P3dBm+AurAfMo8S7ql1MAv8AW+Wg==
X-Google-Smtp-Source: APXvYqwQmXQ63LGIFbQMm/5m/D+YgrCWN32dRNivv1cpTg5pdioaBPmvKsRxmwCw4WeZ2O8Zi4kZOW+1RuNO/TuK42M=
X-Received: by 2002:a02:cc8f:: with SMTP id s15mr23773601jap.53.1566922256653;
 Tue, 27 Aug 2019 09:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190826081752.57258-1-kkamagui@gmail.com> <CACdnJutomLNthYDzEc0wFBcBHK5iqnk0p-hkAkp57zQZ38oGPA@mail.gmail.com>
 <CAHjaAcSFhQsDYL2iRwwhyvxh9mH4DhxZ__DNzhtk=iiZZ5JdbA@mail.gmail.com>
In-Reply-To: <CAHjaAcSFhQsDYL2iRwwhyvxh9mH4DhxZ__DNzhtk=iiZZ5JdbA@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 27 Aug 2019 09:10:45 -0700
Message-ID: <CACdnJutfR2X-5ksXw4PNUdyH2MJs_mExNCcYPp8NLcPW2EDrYQ@mail.gmail.com>
Subject: Re: [PATCH] x86: tpm: Remove a busy bit of the NVS area for
 supporting AMD's fTPM
To:     Seunghun Han <kkamagui@gmail.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 1:23 AM Seunghun Han <kkamagui@gmail.com> wrote:
> If the regions allocated in the NVS region need to be handled by a
> driver, the callback mechanism is good for it. However, this case
> doesn't need it because the regions allocated in NVS are just I/O
> regions.
>
> In my opinion, if the driver wants to handle the region in the NVS
> while suspending or hibernating, it has to use register_pm_notifier()
> function and handle the event. We already had the mechanism that could
> ensure that the cases you worried about would be handled, so it seems
> to me that removing the busy bit from the NVS region is fine.

No. The NVS regions are regions that need to be saved and restored
over hibernation, but which aren't otherwise handled by a driver -
that's why the NVS code exists. If drivers are allowed to bind to NVS
regions without explicit handling, they risk conflicting with that.
