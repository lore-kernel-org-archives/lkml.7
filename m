Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23956C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB882166E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390484AbfHHWEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 18:04:44 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:53466 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728020AbfHHWEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 18:04:44 -0400
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x78M4gtQ010196
        for <linux-kernel@vger.kernel.org>; Thu, 8 Aug 2019 18:04:42 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x78M4bL7032145
        for <linux-kernel@vger.kernel.org>; Thu, 8 Aug 2019 18:04:42 -0400
Received: by mail-qt1-f198.google.com with SMTP id e22so21205292qtp.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 15:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=TuPUW4uauKZvKtW12t0EYu+Ky+eWDM1YUZMuhx8X6Sc=;
        b=ff1SvV6kSiFgFTbKE/+xhyrwe0QcqJwTPPdrDZ+jxi7kALlJtF9DwT6c+gIcxKaksX
         LuXyhO9spFECeJvqXx7yilBcXpdT7gfDdG8j6ZYPt89lY7bs3sXj5IVGqLJu0lhUq7oe
         OfoESIY0hbc+It2OJqZxHJEBHulNokIwJETXjFujGHGM0UlpgfCzKppz/RvxI1pgLBzx
         LqsNXnC8mee/PBpsqVlQBn3/nJlNHfyo8+qCpfnA28LMdAceS1hfY5cs71uAKv5huLb5
         TwSiRF9OhSLyD2hV/ZLiXmxPH8CHhQ1o5uxmNg2YRxtO1gNJeoR7i9gb3Fnql3Y51juI
         lnFg==
X-Gm-Message-State: APjAAAVZi98Si14m4IFMX2ahLp579zV/6y6SOKnICGWNGWleIUYHip8K
        QmVtpZpcV/Oyt+d/9rMC5hgpkVUxm/3gOsTi/e6ukPSCRD9dUZm1JCHKqN2D4o9v3clZrqLtDzF
        UBZB9TrREXQpOVXSmJSqFLmVtntL+21AJhsw=
X-Received: by 2002:a37:a744:: with SMTP id q65mr15514314qke.151.1565301877416;
        Thu, 08 Aug 2019 15:04:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqylW9odmQuabnL8zaJIVyfwISfEf8nn6NAGHAnPJMhlOL+krnoyx+GmOVKUb8WJfz1a8+/paw==
X-Received: by 2002:a37:a744:: with SMTP id q65mr15514293qke.151.1565301877198;
        Thu, 08 Aug 2019 15:04:37 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::359])
        by smtp.gmail.com with ESMTPSA id j66sm40204505qkf.86.2019.08.08.15.04.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 15:04:35 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH] arch/x86/kernel/cpu/umwait.c - remove unused variable
In-Reply-To: <alpine.DEB.2.21.1908082229010.2882@nanos.tec.linutronix.de>
References: <79734.1565272329@turing-police> <alpine.DEB.2.21.1908082158580.2882@nanos.tec.linutronix.de> <141835.1565295884@turing-police>
 <alpine.DEB.2.21.1908082229010.2882@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1565301874_4269P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 08 Aug 2019 18:04:34 -0400
Message-ID: <147298.1565301874@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1565301874_4269P
Content-Type: text/plain; charset=us-ascii

On Thu, 08 Aug 2019 22:32:38 +0200, Thomas Gleixner said:

> Care to resend the last few with fixed subject lines, so I don't have to
> clean them up?

Will do that later this evening...

> The right thing to do is to have a cpu_offline callback which clears the
> umwait MSR. That covers also the failure in the cpu hotplug setup. Then
> handling an error return makes sense and keeps everything in a workable
> shape.

OK, in that case, toss the umwait patch for now....

--==_Exmh_1565301874_4269P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXUyccgdmEQWDXROgAQKy0A//XOZgqtQLKHSpYvU3JNwuVsNWXXY2YDGE
fz4Hz4jh0McUtMvQxB/CucNnu0k4fxNt317OrpUyi05/BHzeJ9sVwDbFAKUArzCB
4PRL1ZR38FK7S0YQtGIOlFEu9SwpQVGd3gb0y/hR5AzFHwizGK134mvLMHHj5r3E
00I1bmzlkFJ1TLuYEzsYQvfg6ybwZE6l5pXku7hhdEN0efr01Af5vfed8t8ZZZF+
QTVTtlrgOHhUrVJhN8r1RZejB4KLMwpiqnRTMxb4sZwKxUkU+kLGnJ4F4yVQmS0l
QubnTFujqlnHp/59CBmj3lzHAxrcoka5Il2WxtPC6CyAal31MYlb/IkuHAS/a3Ck
/euRxdnxfr05xxtnBaBLGu/3yL0F9b8faH4t+tmGQbFVF98SbeAHd7H51tqfTv4k
nrFH0nN0Dz/qgpbI27Bhey4ASeP5EOABPeTx1xv5v4E9DUoRuI78/GyzO3UjIQgx
clveWJsQ4eooZ1z0NvvWY+O9FjJnsyGJfA8KD/M5a64QJdWuO7CgK/04zXk+4cI7
O9p7Qf3SOofxuXC1sdH2RBnd1ntEPrr1dORLchYzYG0kNyem+07CqXwec92XN+Bv
kp70QgGrFnd3HmB9/mqsWiV1DjvchJkWoW3cFCVRR91P1RS9iZ0GetAa3WK6lYEh
77swpa305J0=
=5blX
-----END PGP SIGNATURE-----

--==_Exmh_1565301874_4269P--
