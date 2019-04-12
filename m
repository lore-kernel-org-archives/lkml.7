Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD43C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4D720869
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="jwIaWv78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfDLTh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 15:37:29 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33447 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfDLTh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 15:37:28 -0400
Received: by mail-ot1-f68.google.com with SMTP id j10so9433992otq.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 12:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tZfBY8D1WgXooJQRUiHKhSamR6kz9YpYQFKQ9Eq/1hU=;
        b=jwIaWv78fvkEa5rZbx+eP0fzYbqceSlvTJoR1XduCWAb2gsh8C3klYYgy/UEWlbg3W
         e1k5DE58xsWFRpnox+gDv2pxsyPeGd1VliXQdTqN/wjEe39t7A1LfOBY1Xw2oNp4IQFa
         izdMri970aizgvHVP7AGfoEDXy7apK6am+qaX0cHHnfXzrXeGMBd7PM/5URUlSE3Tjvv
         MU4YS4qovjxjhFGDBxrgmeU0ePJ2LKUa0pGMb+O0e+GfIn77BxF9oo+BRyxvHhW9LjqB
         xR/YJIrdWsl3PIAR/xzmCiHnNkkJXfmydSV2tKK7P3Oie3UkqJ0LeJfKW/5ZfXPUrnvS
         /+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tZfBY8D1WgXooJQRUiHKhSamR6kz9YpYQFKQ9Eq/1hU=;
        b=jaSaiYWR5JnAWlX0DVvVYW9uQ28CzPD/tv5nTWk0xCPWMiLNdpscXa+p8T52SMzYuO
         ReQNsMAvsKyHpk8+VJ4BFOUA0xf/4qp4cGDSVg1hmLL+K+Dup9SIc0OYWaJIAEaKJnyk
         taYjmPSu2dLRyAXGaXa66QZr+aKFcg41+cpELPg9JlTK41HAWQ3ZcCkn0lzNCYguy+/i
         IGz7CeS46Y6FQPI06RE4qoLgmmT41+xNR4MXXh5NHI7WM29e3vAHoLGt2ImXrNFDvKev
         +hXgFlUqxcPw3CMUN3ox5YMJyHOzBauQ/rNCP11Ivd/usBZxgyzZa2ouJFDiX/qLz60b
         SytA==
X-Gm-Message-State: APjAAAXG8SEJtvS8x/i6ArkoGbmJ5ravK7zxsuuvUQwcIsOD6FZlIsT9
        OjXyJfC+kM1WpX5kXv/jwKv6scfCRoH3FSGMeGT1Yg==
X-Google-Smtp-Source: APXvYqzhThKbq5GHetTkjSO5HdGMCT2FjO95YYhE57pp/4fhw00RFxMp33Lhq/TjtVDDMqbk9Vdgq3NV9eBZbTTkHEY=
X-Received: by 2002:a9d:3f4b:: with SMTP id m69mr37976108otc.246.1555097847859;
 Fri, 12 Apr 2019 12:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555093412.git.robin.murphy@arm.com> <25525e4dab6ebc49e233f21f7c29821223431647.1555093412.git.robin.murphy@arm.com>
In-Reply-To: <25525e4dab6ebc49e233f21f7c29821223431647.1555093412.git.robin.murphy@arm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 12 Apr 2019 12:37:16 -0700
Message-ID: <CAPcyv4heZ7+2QuS2YXYsZcU9EOb87MDymfO8-+bLhbPgYQAYJw@mail.gmail.com>
Subject: Re: [PATCH RESEND 3/3] mm: introduce ARCH_HAS_PTE_DEVMAP
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Linux MM <linux-mm@kvack.org>, "Weiny, Ira" <ira.weiny@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Oliver O'Halloran" <oohall@gmail.com>, X86 ML <x86@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 12:02 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> ARCH_HAS_ZONE_DEVICE is somewhat meaningless in itself, and combined
> with the long-out-of-date comment can lead to the impression than an
> architecture may just enable it (since __add_pages() now "comprehends
> device memory" for itself) and expect things to work.
>
> In practice, however, ZONE_DEVICE users have little chance of
> functioning correctly without __HAVE_ARCH_PTE_DEVMAP, so let's clean
> that up the same way as ARCH_HAS_PTE_SPECIAL and make it the proper
> dependency so the real situation is clearer.

Looks good to me.

Acked-by: Dan Williams <dan.j.williams@intel.com>
