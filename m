Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0ACC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F42206E1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 18:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEZwRf7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfKMSLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 13:11:05 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37860 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfKMSLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 13:11:04 -0500
Received: by mail-pg1-f196.google.com with SMTP id z24so1862427pgu.4;
        Wed, 13 Nov 2019 10:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tGvQd5G0SntDT8HkYM+TSejmQNivNQ7SWZ4INNCNjjw=;
        b=EEZwRf7busU0um8mSGmdA1Nl6LjcjETlyx6ouiZkotB+x2genOAnVYJpzhoxCvc0+T
         2u0LgB9O901AeWkBQ64kvQTVi1szA/cINnCP/9F1jQifiQWWOKh7XySjcpiBXTwJA2GC
         esovxJBtuN7S95Hz5rmaiK4Lxozaz65Nh6t33RxH0Qf/IspnL0lu/BJrjrAycOz/J3Bg
         gh+0ut6ua2dMAj325DKLi0vUb3fN02M+TSRt9x70E253TJ47Q3Hr9KrHT6wDIrzJTvgg
         R9HtOdjDX/7xJJtD2Fq84E50OC/c8S3eyDtHXfiegOin60MkfI/ve/4sEHPMGG1UaBDN
         dVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tGvQd5G0SntDT8HkYM+TSejmQNivNQ7SWZ4INNCNjjw=;
        b=LvNBSv36+k6GXoVACKSOrVk4YE0KHXxZJYLfSBD4MHw7ly6perGOczjVNAZIKk7L2r
         X+gNCN8Xmmppv7+PeRgmF190l4cyjruQkm+IezpR0wft2IMGto8GjpTslcUguul53zLe
         PmyNfWB6DT9t/PwmSmqg7RTOEGURybujY8DneGyIRc4+RNcFnFuhLRQZXhHDL6o5QBb+
         okRLfKrdslGfATdmVJxYTdKc7eRQqndm6U+TgAR8JeMhhvYyMw3qlRqHM7768QmOHzYc
         Abwz62fIlxxjKx38f4dQFtW7P2rTQLNKqHPkrtqJ/OSH1CYUnaDDi1vQnSM6IuMN2zOH
         V/Bg==
X-Gm-Message-State: APjAAAWwB3EOiVaOE0RrVnPdqeCFkkXX4IsvElXtVuiInukPtLjX1CEt
        holtUz3/aWXQwWm9dUZMrZkh48ZvWIs=
X-Google-Smtp-Source: APXvYqzNBXBcf0glrFbmi2UZpMekxq9W1smDcK0LKBPS+yMxOpPtUAWSzrnyZRukyAXMThapoLY+nw==
X-Received: by 2002:a63:154e:: with SMTP id 14mr5127316pgv.182.1573668661869;
        Wed, 13 Nov 2019 10:11:01 -0800 (PST)
Received: from [10.2.144.69] ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id q185sm4877110pfc.153.2019.11.13.10.11.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 10:11:01 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [FYI PATCH 0/7] Mitigation for CVE-2018-12207
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <1573593697-25061-1-git-send-email-pbonzini@redhat.com>
Date:   Wed, 13 Nov 2019 10:10:59 -0800
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DEF550EE-F476-48FB-A226-66D34503CF70@gmail.com>
References: <1573593697-25061-1-git-send-email-pbonzini@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Nov 12, 2019, at 1:21 PM, Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>=20
> CVE-2018-12207 is a microarchitectural implementation issue
> that could allow an unprivileged local attacker to cause system wide
> denial-of-service condition.
>=20
> Privileged software may change the page size (ex. 4KB, 2MB, 1GB) in =
the
> paging structures, without following such paging structure changes =
with
> invalidation of the TLB entries corresponding to the changed pages. In
> this case, the attacker could invoke instruction fetch, which will =
result
> in the processor hitting multiple TLB entries, reporting a machine =
check
> error exception, and ultimately hanging the system.
>=20
> The attached patches mitigate the vulnerability by making huge pages
> non-executable. The processor will not be able to execute an =
instruction
> residing in a large page (ie. 2MB, 1GB, etc.) without causing a trap =
into
> the host kernel/hypervisor; KVM will then break the large page into =
4KB
> pages and gives executable permission to 4KB pages.

It sounds that this mitigation will trigger the =E2=80=9Cpage =
fracturing=E2=80=9D problem
I once encountered [1], causing frequent full TLB flushes when invlpg
runs. I wonder if VMs would benefit in performance from changing
/sys/kernel/debug/x86/tlb_single_page_flush_ceiling to zero.

On a different note - I am not sure I fully understand the exact =
scenario.
Any chance of getting a kvm-unit-test for this case?

[1] https://patchwork.kernel.org/patch/9099311/=
