Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089EDFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 14:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACC720679
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 14:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfKHOsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 09:48:02 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:41359 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfKHOsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 09:48:02 -0500
Received: from mail-qv1-f42.google.com ([209.85.219.42]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MOiLv-1iHMnn1gNj-00QESX for <linux-kernel@vger.kernel.org>; Fri, 08 Nov
 2019 15:48:00 +0100
Received: by mail-qv1-f42.google.com with SMTP id f12so2293676qvu.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 06:48:00 -0800 (PST)
X-Gm-Message-State: APjAAAU1dtzoIi2155Lwh6rigHuPQSL58XVszqVsRsNTQzkmgCc8Rfzz
        eo6Zt5mthUAa6N2V5bRerEn7GTpXlxcyi62Rgpw=
X-Google-Smtp-Source: APXvYqyVJ7ri3PpvqDJvxS4dhy+Bd61tIT3XCHBsySDmLtD8792QhGFFgHdjSo3cpPPgKXk5kyuMJT6oTVsNvUrIQ7E=
X-Received: by 2002:a0c:c70a:: with SMTP id w10mr9866836qvi.222.1573224479304;
 Fri, 08 Nov 2019 06:47:59 -0800 (PST)
MIME-Version: 1.0
References: <20191107193647.1944-1-wu000273@umn.edu>
In-Reply-To: <20191107193647.1944-1-wu000273@umn.edu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 8 Nov 2019 15:47:41 +0100
X-Gmail-Original-Message-ID: <CAK8P3a10Gs=gjzKPROvvqXHN0GGGH9wtGjyVQyvT9BYRkeUjJw@mail.gmail.com>
Message-ID: <CAK8P3a10Gs=gjzKPROvvqXHN0GGGH9wtGjyVQyvT9BYRkeUjJw@mail.gmail.com>
Subject: Re: [PATCH] drivers: fix a memory leak
To:     wu000273@umn.edu
Cc:     David Airlie <airlied@linux.ie>,
        gregkh <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:FRFc+7hqULJOj7LjMupQDdCgXgl9YL0ZDYO3jyn7umKF8JHbr07
 rsWtWjeEqFVXZp7gQDL44l4yV7DVe/nX4cRWJC8l2qDM65aJ44PqWw7gDAwkrcyng69X/cT
 sygAcszq6eeEyptxmgEJTaUTymRuPp7GSVj+DtmXZS4x1hD1wYHUHSqI97Mk0Oh1XNmbjax
 pMkEBR7sIS8cWlwGSjhVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mEcp5301yrE=:azqvk4YWMf+e1CFCC6owYh
 +SCN7Rv/H1etcg683LDbvCZ+N8GZqtbLek145MLN8ESjkcrSWTfDHdkhcdrhS93WMs+KICIwD
 jEbzGNNCzx15FmwQYFy8q5gcUsqfp2/VCCtWNRKGldNFvLsCitTSl8qH9+tMFf/ygY0gnDpGr
 naFvzhZjeSlhXH2klelqx8gDK7Ns158EI17o3iI3FCxAQEpQTYHz2fzvhjXYW6tY1X2XvFrNE
 B2u9x4KElOdiAm7NMHIFhG17D04bjkztVG0lqhaRlQd67uZ28ABlmpodfw2aghFMOAo/hzDau
 Wp2OLvcB+ffAdK6364eYKzd0BmDRWoH7PAa4A6+LB85c9zDREeNk3N6baYbwa7Ya6kvhBmd5S
 mGUWwbyyMxxMS1QR1K6ZrBpwHi5n/BSUEMJGU6FimEeh3QMYLhrk8SBfgqwbSDy/iUon9vJxk
 KAyFQT79cAQgqzcS9hwfE4tzzRMpkQP+mtgsdHXzI0Z3vtfj61ecLXja4WXwxY9+mf8PQ3PiQ
 y7m79lhj2eWc3eSTI/PmBR0p6HhYPqdHFOuUvq5C8ReHNZKOxD+v2FaKKLQIztiJ2s1UVlFbb
 kCKJRefXvcFJipWt9OJfk9tH1bKhJU8aFeKZCBFzwnUN2rkM4KzkONO/xU0Rf850KJzOoa0xn
 vPELA5PbVDJ/C1HdYlJN+nnlBBjDAIHUEjtF/uiL9vJCrzYLh8va2C/ryIbai8QZgydJXMPh/
 s3EBx4pZTy06j6MDpRuNt5MQldeDfZn+jGtBQz4AJ9lfFBpZZ+6sfzfmI9gV9cBo0kOVeeoGS
 wJTRbMxNrCXUDKOR+fWtcG9Hp6gA9oIgFs8ddkRlx59vCr1KgXxSu7/tliREYO3WgDt38pjag
 dGxMZVAE55IGOWvefC5g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 8:37 PM <wu000273@umn.edu> wrote:
>
> From: Qiushi Wu <wu000273@umn.edu>
>
> In intel_gtt_setup_scratch_page(), "page" is not released if
> pci_dma_mapping_error() return errors. This will lead to memory leak.
> Fix this issue by freeing "page" before return.
>
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
