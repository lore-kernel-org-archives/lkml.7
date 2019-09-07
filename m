Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8393AC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 22:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B58820693
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 22:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395254AbfIGWAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 18:00:32 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:33018 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728155AbfIGWAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 18:00:32 -0400
Received: from mr4.cc.vt.edu (mr4.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x87M0UdC028728
        for <linux-kernel@vger.kernel.org>; Sat, 7 Sep 2019 18:00:30 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x87M0PlP021097
        for <linux-kernel@vger.kernel.org>; Sat, 7 Sep 2019 18:00:30 -0400
Received: by mail-qk1-f198.google.com with SMTP id 11so11296233qkh.15
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 15:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=d5RC79Buy5HMk4tZvkA/Hlr/NOCgip4Ja28CcC6gZL0=;
        b=uGz/qWusjqikKO6PTwGMZ9KYigC9p0gvRARThsO5bsf+AFyFeLFhi2g8LwVBdCFUbV
         9Ilj83om9oZMbcQCWoyPwc6Eo7NV0tnWRtA6HYYp9AuuHgBlPFmgAmam/mRJ+tSduLCJ
         EjuGYsHAeggvsM9C7QfApdDbVh/UzfnPQZzXZjyGBqb2yGsYYubOwFI6IXb+Y7BQ5/x4
         iI/XNJyAs1Y+okT0ULIPcjjToANDUdAhd6ye4strJc+QIhsMSessmzF/goLtOwwrTiu9
         jrOYpZke+Cfs+BYhEqTl1HKCMss10DeTWhdo5Q+CiZeDQymoBiqeEN1xRIkBZxwRFfi7
         NnvA==
X-Gm-Message-State: APjAAAWb/vNNjXy5hvXMWZhHdEtAojd8mP+0rj14jAlkP0YFGdC4Ix96
        OTrquVAI/F1rrTcSKG98u+5NsbP7D27P0e5chIJz3KN7Sl2xezvYfhDb5S0OIqi4bZG11wXE6Ew
        p5EUNxPun/JTDJtgdmHcPycGpImjDHTl3mIo=
X-Received: by 2002:ac8:4787:: with SMTP id k7mr15943212qtq.58.1567893625332;
        Sat, 07 Sep 2019 15:00:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz6L5IMHBnhHbnmSs5yG97dUOtsTFLjPBVLfrc+3iUsFrpar4JJxW1ohr/+/X7T10ZBULYWSQ==
X-Received: by 2002:ac8:4787:: with SMTP id k7mr15943194qtq.58.1567893625099;
        Sat, 07 Sep 2019 15:00:25 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id t32sm4064196qtb.64.2019.09.07.15.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 15:00:23 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Theodore Dubois <tbodt@google.com>
Cc:     a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
Subject: Re: perf_event wakeup_events = 0
In-Reply-To: <123C743E-C322-45DB-8796-BF6B6EE9CA80@google.com>
References: <CAN3rvwA+Dnqj4O79f6rNfO50VjbAC3YwJ7CW2ze2aBLzkSJRgQ@mail.gmail.com> <943813.1567863629@turing-police>
 <123C743E-C322-45DB-8796-BF6B6EE9CA80@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1567893622_4251P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sat, 07 Sep 2019 18:00:22 -0400
Message-ID: <970896.1567893622@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1567893622_4251P
Content-Type: text/plain; charset=us-ascii

On Sat, 07 Sep 2019 09:14:49 -0700, Theodore Dubois said:

> If I’m reading this right, this is a sampling event which overflows 4000
> times a second. But perf then does a poll call which wakes up on this FD with
> POLLIN after 1.637 seconds, instead of 0.00025 seconds.

No, it *takes a sample* 4,000 times a second.  For instance, number of cache line
misses since the last sample.  You get an overflow when the counter wraps because
there have been more than 2^32 events since you read the counter.

At least that's my understanding of it.

--==_Exmh_1567893622_4251P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXXQodQdmEQWDXROgAQJ+QA//Y7bnaoeVIZUihrGcDtSkFVLns70+qzqW
VaXsX9cgCMTTJqYPRSaIN4+9nmtpQgHJ5eLHgDSg8rL4A8dbEp3hsjIADB4hF8fv
bkzmM/6WPQ/CWIaXr5kDNCE39LO6iYIIGx9YNc6xoomGocLXGZ/KSpoUUhrumFmP
s5H7NHk3IbsSTrua2iz5N74WTeLEiKbeQplG/l6VVkCH0FpWNRepzxAuRieThBkN
qoVMXmxxAdv9J1xcH7NIfLWSfRe5wLelBO8vMTg3FjgJGF9NrNXWfYBMaqj5/6Bx
FtQfOSpP6Uv1ndlZvoHdmSDPVdvgNdsmFVlm+pKVSfkJYRGHkb7UydVht7mZfUAS
cHNWYYe66vWTJtV6e2za/FmtWkkYcc9zYvjmPuDRHJ/SWM3z0s6JbmHRdRaUgWoU
UTkPGbR4arxxdElV6BslNg0ingBz5oTOqbiJNcxh8SbLlyBC/IlLA2w7NSdfuchW
WTjljZfBaGSk7Aj4b1DDKuZxnJsqGL4rTz63qbGFUOyDB8DirxOH51gNcxe64rBz
87k5lI8Z9X4jp7sExqZ3GtHj+0MnnZWPXemIOdWzZaO3x95hKjCNNLN7PRuZkUGx
5a4AgX4VnQPF72KNEsiArKdjT5XE4vOVwkc4Nb8fhhpzGXumFwPEPk40mF+crSm6
toSJHUUPC3o=
=5Lt7
-----END PGP SIGNATURE-----

--==_Exmh_1567893622_4251P--
