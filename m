Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93470C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F99222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 19:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PU7Vz9tJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfKRTkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 14:40:10 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44925 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfKRTkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 14:40:10 -0500
Received: by mail-io1-f65.google.com with SMTP id j20so9122981ioo.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 11:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ga2QOfLsmfhUnk6OwFJIP/FQLzU959KChsQqy2SkK0Y=;
        b=PU7Vz9tJaqQojCfLRboG837OeLoOtQZpwQCf8MXYQXSQ0yEub51VGxshLMUi7epDOd
         xs+ageFwVejd8Guw1fRAXgEkqH5NWGUoacZvQfZWOkGi80u8rFvFiXygRzqdO93LGI9O
         /MW3unwEs6/Z15UUIOpA7rZOHQ4/OQN65nOlUo7xT2tBFkRhqtgqGAOaiaWZ8tV6kExX
         ntZIlMGXS6u7FIBlN3BkxP/gLBPtlaR5VxLFMN6yC0qEx5Igeop/GgHvvuIt9/yuJYp0
         mN3Wtbhb2oT1mZTHHc5opIaQaFnOs2AbGTP7nWs5zvpHRMt2yHHC01KX+EMXVYsiVqHT
         ndWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ga2QOfLsmfhUnk6OwFJIP/FQLzU959KChsQqy2SkK0Y=;
        b=l6pcACJ1IHEPXubgaQDwZ3kBbVOVrrQ7VP3vgqQm4L5a8gPz6PVsEyoFPnYWnvBqcI
         Nf+m3Ofph592xbrHpxhfiwdFWplKyJoN3CdldSBDiENkZkYhF78pStJSSTPHGvgZYzxO
         KbAcIVlYAh/5NdYXhPSR38MRVyTjK6auVauEqUOdW1nlm0OLCGOB+7QrgjpdJNhkHB3+
         8g6Zf2DgWaHdGV5ZOQxkFQRLxUx+7w3BSUao9tMc0k1e8TXgniWMoSrRoEPKwRFsTRqZ
         JQogapc1N4ftIiPyBfWCjBJNkXi22gWvPJ+68cSsANvT+zKUfDoh37helnIf+fjYZCoH
         D/JQ==
X-Gm-Message-State: APjAAAVPw4KJgnduqUUj4E6xDBTtG/iZIG32VRQgN75vnxj6TjRHLr2f
        quqQI70E/TmjFIYyLBgkSTiXtmHrosewm6Z6Vy8wkvDT
X-Google-Smtp-Source: APXvYqw+d2zHth6qS/TxDmab4ggByifB0NaAT7RS/+ysk4DVgF/PlEVHyn1tIEWtnKHuSz1obEsITYvKNRASyR77Icc=
X-Received: by 2002:a5d:9b08:: with SMTP id y8mr7466853ion.108.1574106008870;
 Mon, 18 Nov 2019 11:40:08 -0800 (PST)
MIME-Version: 1.0
References: <1574101067-5638-1-git-send-email-pbonzini@redhat.com> <1574101067-5638-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1574101067-5638-2-git-send-email-pbonzini@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 18 Nov 2019 11:39:57 -0800
Message-ID: <CALMp9eQjkp7H5oj_XrmqbTsQjrjq1LrbYfxqeNUzWfT4a_Tg8Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] KVM: x86: fix presentation of TSX feature in ARCH_CAPABILITIES
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        stable@vger.kernel.org, Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 10:17 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> KVM does not implement MSR_IA32_TSX_CTRL, so it must not be presented
> to the guests.  It is also confusing to have !ARCH_CAP_TSX_CTRL_MSR &&
> !RTM && ARCH_CAP_TAA_NO: lack of MSR_IA32_TSX_CTRL suggests TSX was not
> hidden (it actually was), yet the value says that TSX is not vulnerable
> to microarchitectural data sampling.  Fix both.

I actually think kvm should virtualize IA32_TSX_CTRL for VMs that have
exclusive use of their cores (i.e. the same VMs for which we disable
MWAIT and HLT exiting).
