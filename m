Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E97C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A7CF2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732338AbfFMPfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:35:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43918 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbfFMK25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 06:28:57 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1hbMyW-0002n3-1k
        for linux-kernel@vger.kernel.org; Thu, 13 Jun 2019 10:28:56 +0000
Received: by mail-wr1-f70.google.com with SMTP id q16so8621725wrx.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 03:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3vJoe4QOYmSpzL3TX3nF/EcZqCXILy8LMNIEV2dPMlw=;
        b=JhtA3jYZpgQ6M0FdqGTvwHGxguW2moCsmpkCrHaDKa6DIsUrdSZnHZQyhaUsIH5wI5
         8dIzLAGaxJWMkU8lOstr61fC6gcbgb8a3zR8B0tQT7ga+hvsER/+aAYZSXdMvhh7apBv
         9hYd+Em2gHHkVBaqEIjkh85Oi/dImXVLwlu3yfm/QeAcfXZvVZRyDmBJk3YwSoOxSjRH
         ATSirKbcJhOl2MwgUbGi93HrsSRnVWTGdG4hHY7xIGJ+uN3gpK4d1Hdn6Av4+/qpysx5
         B3gZRWO2worIwPxR3L/GtmZHu6sGdNM9xM5PtR+VFeYAMoGXjJqHvXquNTIr7x5eBYso
         C0IQ==
X-Gm-Message-State: APjAAAUAYGdONnCbMFA5Pk5N0iwgexpgVAxvenr033vNd9mcElRL0Tmt
        0sSTT8wgGT8BnM/YD4K6MQJbs11DeZTAjrLhQydAyWQZrjUVQN3pGQx7dvAczPS/Xdei6RPBMsQ
        cgR1G4DfuH37TBRH2GItqiJz4H89bgB7dBD4djIVZoXS9A4loe6uYM73Z
X-Received: by 2002:a7b:c313:: with SMTP id k19mr3050160wmj.2.1560421735777;
        Thu, 13 Jun 2019 03:28:55 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwgKUzFv9JlTv26cq3GlGgLVgjVoMCkwh6CKsBT7LawKThQzRDyIbi5mMPqn4/bfa1JwGFkSAyBv6iKEvpwYik=
X-Received: by 2002:a7b:c313:: with SMTP id k19mr3050140wmj.2.1560421735553;
 Thu, 13 Jun 2019 03:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190612064752.6701-1-po-hsu.lin@canonical.com> <20190612.092711.1626983045451710048.davem@davemloft.net>
In-Reply-To: <20190612.092711.1626983045451710048.davem@davemloft.net>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Thu, 13 Jun 2019 18:28:44 +0800
Message-ID: <CAMy_GT8YjDhRSHMYBALHeqDhKYhr2Z+--=imZ+T5WV0wCz_v6g@mail.gmail.com>
Subject: Re: [PATCH] selftests/net: skip psock_tpacket test if KALLSYMS was
 not enabled
To:     David Miller <davem@davemloft.net>
Cc:     shuah <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This issue was spotted on Ubuntu linux-kvm kernel, on which the
CONFIG_KALLSYMS was disabled intentionally.
I think this extra check could be helpful when running the net test directly.
$ make -C tools/testing/selftests TARGETS=net run_tests

Also, there is an identical check implemented in the ftrace
kprobe_args_symbol test.

I can send V2 along with CONFIG_KALLSYMS appended to the "config" file
if you agree with this.

Thanks

On Thu, Jun 13, 2019 at 12:27 AM David Miller <davem@davemloft.net> wrote:
>
> From: Po-Hsu Lin <po-hsu.lin@canonical.com>
> Date: Wed, 12 Jun 2019 14:47:52 +0800
>
> > The psock_tpacket test will need to access /proc/kallsyms, this would
> > require the kernel config CONFIG_KALLSYMS to be enabled first.
> >
> > Check the file existence to determine if we can run this test.
> >
> > Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
>
> Please just add CONFIG_KALLSYMS to "config".
