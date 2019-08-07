Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F5AC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A7821E6E
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 17:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389254AbfHGRmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 13:42:32 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36702 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388363AbfHGRmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 13:42:32 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so41877311plt.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 10:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=/uiebD3btGZbv4vhWYrLmVJnJacov4IOPhmk60kkajg=;
        b=HNcBAXnJzE6uUB8tIAUYgqvuEp7OTTfPSHB8SoTsSj6TdMtwzvLu6bF8L1r/I1gEhw
         PWb2b7yxTVPfJVq+rS+uQK5zsO9WyKeBxjQdTp9SwMZwnR5yGKd/r/RnMiEPaGGFC+b6
         WQizhkiuM9fEcEe13nigY5hBl9/ThWE3hi41FeycrwJya/FujyAUKhkIdjFb8uDrCsmO
         6lo+s0+P+6dqdS3xRO8/cVA4Mina6J6ULuE869rGnqjw1aMnjGB8B+6g4PyiE6GXuAaC
         Cn7o4VVpZAEGqmxHdE+XP4qHy+qrwEktYkEbxgFwb3y7HBV0nKIdYpRMpZzB+OGrq/oD
         M+Xg==
X-Gm-Message-State: APjAAAViB37ApGBWruUSZrjJ9bINiRvBW8OlCzcWuow6REdUjb/GFtD0
        EwyG41o9ugcSpAk11YS4PG26czuhRQmtvw==
X-Google-Smtp-Source: APXvYqw1JEMLevhf1LxZ3JskWiL2HpnAPmkA0NRBmwn1FJZT+5YEh83ZyPicXC8jCeVqb1RmwoO2Tw==
X-Received: by 2002:a17:90a:2190:: with SMTP id q16mr989287pjc.23.1565199750802;
        Wed, 07 Aug 2019 10:42:30 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id p187sm146508645pfg.89.2019.08.07.10.42.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 10:42:30 -0700 (PDT)
Date:   Wed, 07 Aug 2019 10:42:30 -0700 (PDT)
X-Google-Original-Date: Wed, 07 Aug 2019 10:42:28 PDT (-0700)
Subject:     Re: [PATCH v3 3/5] RISC-V: Fix unsupported isa string info.
In-Reply-To: <a2795337bd86ff22ae9618d7ccae22e7482be332.camel@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, info@metux.net,
        allison@lohutok.net, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        Anup Patel <Anup.Patel@wdc.com>, mark.rutland@arm.com,
        johan@kernel.org, robh+dt@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, tiny.windzz@gmail.com,
        gary@garyguo.net, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-5befbd83-7239-4ee0-8c03-06e377e53f72@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Aug 2019 10:31:51 PDT (-0700), Atish Patra wrote:
> On Tue, 2019-08-06 at 18:26 -0700, Paul Walmsley wrote:
>> On Wed, 7 Aug 2019, Atish Patra wrote:
>> 
>> > On Tue, 2019-08-06 at 16:27 -0700, Paul Walmsley wrote:
>> > 
>> > > Seems like the "su" should be dropped from mandatory_ext.  What
>> > > do you 
>> > > think?
>> > > 
>> > 
>> > Yup. As DT binding only mention imafdc, mandatory extensions should
>> > contain only that and just consider "su" extensions are considered
>> > as
>> > implicit as we are running Linux. 
>> 
>> Discussing this with Andrew and Palmer, it looks like "su" is
>> currently 
>> non-compliant.  Section 22.6 of the user-level specification states
>> that 
>> the "s" character indicates that a longer standard supervisor
>> extension 
>> name will follow.  So far I don't think any of these have been
>> defined.
>> 
>> > Do you think QEMU DT should be updated to reflect that ?
>> 
>> Yes.
>> 
>> > > There's no Kconfig option by this name, and we're requiring
>> > > compressed 
>> > 
>> > Sorry. This was a typo. It should have been CONFIG_RISCV_ISA_C.
>> > 
>> > > instruction support as part of the RISC-V Linux baseline.  Could
>> > > you 
>> > > share the rationale behind this?
>> > 
>> > I think I added this check at the config file. Looking at the
>> > Kconfig,
>> > RISCV_ISA_C is always enabled. So we can drop this.
>> 
>> OK great.  Do you want to resend an updated patch, or would you like
>> me to 
>> fix it up here?
>> 
> 
> I am sending the patch right now. We can remove the 'S' mode check as
> palmer have already sent the QEMU patch as well, .

Looks like I missed the boat for 4.1, though.

> 
> Regards,
> Atish
>> I'll also send a patch to drop CONFIG_RISCV_ISA_C.
>> 
>> 
>> - Paul
> 
