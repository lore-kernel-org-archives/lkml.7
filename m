Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E25C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE4620872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f6bDxc2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbfDPLtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:49:42 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36277 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfDPLtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:49:42 -0400
Received: by mail-lf1-f66.google.com with SMTP id u17so15794089lfi.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 04:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Krs9sHPp8z9MXsmuEgg3g1mrE9joQItvPzXPnHsCuFg=;
        b=f6bDxc2C5LwhAMiwuCVh0Ci41OtMj5jGhTLGYHR3r7q1hNNDG5Ml5t1cu6ytxQ4MAK
         kvDS/ykzjKI+hVSlsNOR8pyXE0ywRbHlnb8VGJ2+r7QtFaVOhK4n/HDdgQRNdjDSdsDX
         D64k2r1oZGKHiBGJTaYBRimhpdUy+aj1JLUAk4QpoJg/L6HwD6vc9HCJCwz7wBA39ODc
         LDLBHVTos+aBXh0aDtIRfeq5Gi4yTHOsZiooLuD8iQbPAZ5mFOuHemfTIeIG+KUxfVzl
         uzeQrvghjK4oebOTji5/Kt0Sw3kC0v8Dh/q58IakxT7tNfhmNPCOlyiV9RXgnfWfYcOA
         ch2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Krs9sHPp8z9MXsmuEgg3g1mrE9joQItvPzXPnHsCuFg=;
        b=DjIgNzC9xGmHPqTmo0xqtSznUM86GtF8/ifumMPegbZ7jwZlDPS8ISQ/16PqI4d029
         Se3D2LgN4fzsaVu1GU6HJyA68Vr3FdptGuDNEenkQNH3wtFD6xSs5MMet6+dUPlvorCP
         PxvJpJgGa7+09G+J+EraXPOarO/MY1pJc6LFWtQ/LNoy5HOwQ2NePr4sJSFCKuYdCtmh
         IlN0X6XEkhSsFdCnjNdTxaiBN+ThhXsdQ+MmXTqpDmm9CsHRpZmhMgYzbQ4h7OWk8VCV
         ITsmpTXKOb0sag7E2o8gpNCqLYIYNJ3eiZ/ExR20qWxXIJRvPcxqGqQkkb70FAjDL5Ne
         Oc/w==
X-Gm-Message-State: APjAAAWtaPBhRMF37/jPa0TT5S4BS2c6UPqb06DqzgOaxNIRZDmw0dcP
        95CjDZUH9oXta882t+6ev96/4wlltwQPRfWEWmbdkg==
X-Google-Smtp-Source: APXvYqxwKZRePPoSAX29FdPHrjnG13svRN3Yq8b1Znx//rFJNjrLIVR5UoN5c4Pxe0UjXSW15gEO/0NkuKhwiYsxPgk=
X-Received: by 2002:ac2:4285:: with SMTP id m5mr9268047lfh.103.1555415379792;
 Tue, 16 Apr 2019 04:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <1555139666-948-1-git-send-email-hofrat@osadl.org> <1555139666-948-10-git-send-email-hofrat@osadl.org>
In-Reply-To: <1555139666-948-10-git-send-email-hofrat@osadl.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 Apr 2019 13:49:27 +0200
Message-ID: <CACRpkdbTPSvYpMvWWUWy=JpJeNvv6grBLHpebu5vLQa=Oem_Qw@mail.gmail.com>
Subject: Re: [PATCH] ARM: ux500: add missing of_node_put()
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 9:20 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:

>  of_find_compatible_node() returns a pointer with refcount incremented
> so both in the error path as well as after usage in soc_info_populate()
> respectively actually b8500_read_soc_id() an explicit of_node_put is
> needed to release backupram.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: commit 18a992787896 ("ARM: ux500: move soc_id driver to drivers/soc")

Patch applied to my Ux500 tree with Ulf's ACK.

Yours,
Linus Walleij
