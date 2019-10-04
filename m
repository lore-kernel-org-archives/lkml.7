Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BA1C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 22:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1497B222BE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 22:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qbrJI1nS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbfJDWO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 18:14:28 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46826 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbfJDWO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 18:14:27 -0400
Received: by mail-lf1-f67.google.com with SMTP id t8so5456464lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 15:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S8mPVffMcLGte/wHbtTKmdFyoHNnsyDaHZetmGYETyI=;
        b=qbrJI1nS7K2Rd321FJnk6g/mCczAUiwrknzRclj4Ij1aTcpmviFEYrfD0bKA/tr6F+
         92kQ3oj4e6DANBZ1g4S+Z2SaNunY0/B0+WMh6sjxkeKvdI9ZL7BYHLqC+xf6ahRkbkHC
         Y4kOqhN6PadJfxjDZY2BVnZSbJ6q8Zk5/1eDJZ60H8AvaTlzhRXkd6WBMfkyCJIZCF4I
         sj0HLAoUoAmgwfy1odnZQalxEUZnfZUZotctVciJcG0IYdkDAAUUDVPPEA0+lVOqk08s
         nHpbsoTlSwvca3bjTfZox6FD74uthGrjxcHRB9+ACZ7D6Re8IuqZy0lyim9cAug6FoMg
         nZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S8mPVffMcLGte/wHbtTKmdFyoHNnsyDaHZetmGYETyI=;
        b=Hf/bBW6ENba2/Ii3dNFm2onCRVxD4MBFZ4gsGf4+GPf28Rqa3SyV4fXwUO7Th23E9z
         LJ9ykcEOtm91jGi4RclfVHettpvnIpnbf5155vRCODe7GoJUDmUGQAfuX1eBLz5+kN1o
         AZ4uCaniYDTmC6gcweoSrFxffi2Sp1Tz3NVcr0o5XS4NRcsp0OxqSe/CY/sJbVsTGQF9
         RrjK/wCR2e8vp7sbXuPkFSKfNOPcfeVh+GRqGOuRkvmlBWKpxSOGo++O8LKs+aRq1SME
         4JYsoANCrv1hZQxTUUhdKakEr13LcVMsmTSRzIBCQTE6o52hJnbuoV7galOFShrVe7OS
         ELJg==
X-Gm-Message-State: APjAAAV9XoO+xgIpBBP0SRgox9nTyqtr68CYQU4pn7ydwHs0A+xkY1WG
        DzxxdcucKBMbdM/58s+3lbL6ZZlKyOMQb6r7x3JE0w==
X-Google-Smtp-Source: APXvYqw6p3u0Nbk4EtKVZWVGxvJpwkNNralIapsPdyvTLc9k8feinsifqMxclwSQkxsfBTi9SQax5JQ1oEWvQP3L9ng=
X-Received: by 2002:a19:14f:: with SMTP id 76mr9883809lfb.92.1570227265893;
 Fri, 04 Oct 2019 15:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190926081426.GB2332@mwanda>
In-Reply-To: <20190926081426.GB2332@mwanda>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 5 Oct 2019 00:14:14 +0200
Message-ID: <CACRpkdY6f5MX16cJL--D3O=_4us=vXEF6vWfRpd+ju8T_JsE0Q@mail.gmail.com>
Subject: Re: [PATCH] ns2: Fix off by one bugs in ns2_pinmux_enable()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Ray Jui <rjui@broadcom.com>,
        Yendapally Reddy Dhananjaya Reddy 
        <yendapally.reddy@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 10:14 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The pinctrl->functions[] array has pinctrl->num_functions elements and
> the pinctrl->groups[] array is the same way.  These are set in
> ns2_pinmux_probe().  So the > comparisons should be >= so that we don't
> read one element beyond the end of the array.
>
> Fixes: b5aa1006e4a9 ("pinctrl: ns2: add pinmux driver support for Broadcom NS2 SoC")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Patch applied with Scott's ACK.

Yours,
Linus Walleij
