Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB201ECE589
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F78215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="iDAM+R9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfJAJc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 05:32:28 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40909 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729292AbfJAJc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 05:32:26 -0400
Received: by mail-qt1-f194.google.com with SMTP id f7so20724275qtq.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 02:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OFYZf47XM4r0xE8wHoVEHk7v0YQ69pCu6pGafD2jwco=;
        b=iDAM+R9ANcbzIjKCTN6ZYSi+Aksa0PboAWyf4s6tXCRILXfjN3srMVk9rzXdIqonNN
         C9tv2GNLMLTLlcZF4RTX407fQQa7EBvmm2QK21l9IcRLfczMl3ma6kDFRqqyBPouORRx
         JZ/RhDpKYXtEX30EgeQ56tCgIuBlcbFg9y2srZkbkZX+E7tUi8PYPAYd2r/N17AWhvVG
         s4Et//tI2AlllqkmYdaS8QVYEKC15gqaZ4bH6rNd9y/yNi15b2pDCdtRFyPfJjHI46yl
         sGHyzAzz7QTQhSZLZoWbeNkX5FWMhPnhPPCFNgYOPGekKsGpB5/ZkIhxmOuO4a8p+QWr
         jTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OFYZf47XM4r0xE8wHoVEHk7v0YQ69pCu6pGafD2jwco=;
        b=JtnfFawXD600Da3dRvRlfynRBRhW3PV49lPheM+ZJ3sRBf7519e7eYaeaL9C/blfl6
         3t99vwATBo1FrbMJyeDW3wkmj3DTlD5EgnGEg9e5fuCci5p8izZur1kaS4icQ2U3o2tH
         ka1ERbZDxT7qlxpuu7VyW3v3cPrm3PtxcnA/H5TIvCB7b3rQI6YnUeDJHE6ZxRhYyKN/
         Uv++yOEkwJbM5+u9Fn540PSI4Xuj/YIkd8p+ImVIzV/WRyM+fj0uwolNb9L96wDpoXnQ
         PJsCUT+ApdFtBq6XDWk0Hc7HqXXJHcdIt/OcP2P8J5wfsI9WmOZXYEmfjsAOKNQk+xtx
         /X1w==
X-Gm-Message-State: APjAAAVYnziFAWkw3T6YBPYdTgkLtW6x15nTpp/OgBQOEavFW3+v9yiX
        km1b8qfw7C2S/fQ9ge9iHP0I5GOu0q642ueVxsq57Q==
X-Google-Smtp-Source: APXvYqx/69O5IdHsZutFRVhhkJCSDgmYpJbh7WyfugO2INdJv/xpqNfiengrZJKHyEPhWEsJ/6sllro9UJLiTLagBoI=
X-Received: by 2002:a05:6214:30d:: with SMTP id i13mr24557854qvu.101.1569922344454;
 Tue, 01 Oct 2019 02:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190911025045.20918-1-chiu@endlessm.com> <CAB4CAwcs4zn4Sg0AkFnSUE-tbkdrHE=3yYeF8g+-ak5NyPBkuQ@mail.gmail.com>
In-Reply-To: <CAB4CAwcs4zn4Sg0AkFnSUE-tbkdrHE=3yYeF8g+-ak5NyPBkuQ@mail.gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Tue, 1 Oct 2019 17:32:13 +0800
Message-ID: <CAB4CAwdO5evU8K5qjGe0rXJPmQA8gSd0tLkN6nh-EzyATU9aOw@mail.gmail.com>
Subject: Re: [PATCH v2] rtl8xxxu: add bluetooth co-existence support for
 single antenna
To:     Jes Sorensen <Jes.Sorensen@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 9:44 AM Chris Chiu <chiu@endlessm.com> wrote:
>
> On Wed, Sep 11, 2019 at 10:50 AM Chris Chiu <chiu@endlessm.com> wrote:
> >
> >
> > Notes:
> >   v2:
> >    - Add helper functions to replace bunch of tdma settings
> >    - Reformat some lines to meet kernel coding style
> >
> >
>
Hi Jes,
    I've refactored the code per your suggestion. Any comment for further
improvement? Thanks.

Chris
