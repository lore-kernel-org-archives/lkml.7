Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86350ECE58B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7CC2133F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="BuKfaXOG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfJBMiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 08:38:21 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40786 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfJBMiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 08:38:20 -0400
Received: by mail-qk1-f193.google.com with SMTP id y144so14737356qkb.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 05:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XjGcad+/AEf/LQ6JW0XEmjTyfYLZoWupXny7/907quI=;
        b=BuKfaXOGJkGNN039Bc44rug88lxpIT8oI+YcKkFCeQMvnOv102ztRZn3SwNsZHcFQv
         v7EROximmU2mlCX6FLXNGJHwfUzzoPDW1Oefmyzg39aNXdAC6AqMjwoO6SjQWSKMbudq
         pulzcmolj9dCghigUJiI9p+w8GbPQEUDaHe5LWEgLwfyO809Zo30CTyP4flXdTA2I3RY
         3dd/olg1yHbQ8Rlvq3oSAIkPjSsWmdC7u4ispRQzoFBiHUl3b3bEcf6fEYPibxSXfieg
         0f2oFQcuZQN9y0NZeHXdfHBS1pUWGCf3klcTqlKVfpKC2auiBaZQSEjPN21VvEBadw8Y
         A0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XjGcad+/AEf/LQ6JW0XEmjTyfYLZoWupXny7/907quI=;
        b=Q1dKk5ZwK01pSWJrdLoVj1eXGLz3IO3S0tPnV82fJ2PH90lNSvDn9+uhv1+QEPFXiP
         h5DB8WqhKatcxXHv2kKiBm8hofQPzMr8o2oThdAw0CtU8O3udI+hKBFsPmHhpF0C49gq
         eyXN6Ydkga1yZ6r+9sTPXjaywnYHSjH5uS3KAclRWmGeTuKKnPY8+X1VSjojwvL+caXw
         +iSj/N3Uq4FFNEuqVfOl/rZBv4B6aHY+QbDQpUlfsky9XN83bUDCuuFTJ0q7rzJJc9w5
         uD/In8KvW7dlzWSBNDMnpls+5k0IMUfN7UHPtZDHb3XYdFqQ12cxdO4MWgDJq2MrbG5W
         V2tw==
X-Gm-Message-State: APjAAAUaTVUWFlHH4Octo5xxmVNeHOFcfYTdirOgFoOdEu4wPk4zr/f6
        +vMtEyZXW/xSjf2+AGyTf03F4ExP+D/dLzdH03ny2A==
X-Google-Smtp-Source: APXvYqwgMZyCWyDd3fnNskodhxm92UgANHaXL7pTyigGGX+fmEMuqAfA/i/iU3ag6oSmB1WW21ZFh/8Qjlo/LOZHEqM=
X-Received: by 2002:a37:9c57:: with SMTP id f84mr3540760qke.250.1570019898066;
 Wed, 02 Oct 2019 05:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190911025045.20918-1-chiu@endlessm.com> <20191002042911.2E755611BF@smtp.codeaurora.org>
In-Reply-To: <20191002042911.2E755611BF@smtp.codeaurora.org>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Wed, 2 Oct 2019 20:38:07 +0800
Message-ID: <CAB4CAwdvJSjamjUgu2BJxKxEW_drCyRFVTbwN_v-suXc2ZjeAg@mail.gmail.com>
Subject: Re: [PATCH v2] rtl8xxxu: add bluetooth co-existence support for
 single antenna
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        David Miller <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 12:29 PM Kalle Valo <kvalo@codeaurora.org> wrote:

> Failed to apply, please rebase on top of wireless-drivers-next.
>
> fatal: sha1 information is lacking or useless (drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h).
> error: could not build fake ancestor
> Applying: rtl8xxxu: add bluetooth co-existence support for single antenna
> Patch failed at 0001 rtl8xxxu: add bluetooth co-existence support for single antenna
> The copy of the patch that failed is found in: .git/rebase-apply/patch
>
> Patch set to Changes Requested.
>
> --
> https://patchwork.kernel.org/patch/11140223/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
>

The failure is because this patch needs the 'enum wireless_mode' from another
patch https://patchwork.kernel.org/patch/11148163/ which I already submit the
new v8 version. I didn't put them in the same series due to it really
took me a long
time to come out after tx performance improvement patch upstream. Please apply
this one after https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2117331.html.
Thanks.

Chris
