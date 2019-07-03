Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02001C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0D32189F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 07:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="dxP42nkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfGCHmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 03:42:15 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42168 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfGCHmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 03:42:14 -0400
Received: by mail-qt1-f195.google.com with SMTP id s15so1454212qtk.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 00:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vbcXnianh87vXEjFT9B3w4NaWyc5uSKsAaNy2YUdSho=;
        b=dxP42nkV2Pahhr14oxk8h1+yFAtHKvsqK+i/hKWRTlIRRlRO5mFwJG9ui1MB8rtU01
         sYBVHMMi8p89rlPnckYovpljhcmbRZ4OQRlLOvW6H/7OHl3KAogXVqLzGOQCoiFt55ei
         f8pjU9lYEX7VRj04zhgxmYjCT4rICFJuuMGUyWSW7TClIYf535dZ5VJAi8skgOzIREJ3
         m03y2w8s9hV7MBbsYwP59mI6vCoIycMafoNg10QoZMr+HEbKVS17+nW3aES4NDjsMMGv
         SETeuUCeyOOlMJZoNazL/PITVGLR6bc/9zoUO2zpuWCq+hGalbrJpS7fuVPmMaVHbQJv
         H/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vbcXnianh87vXEjFT9B3w4NaWyc5uSKsAaNy2YUdSho=;
        b=V4SGwb1hzRU0/ScKI1wSB0pyyL8s/bJC7hvsbdEVDLDf/LEXJ6MhiKvprEp/EB1vMj
         g4xMNzviEYhqh3ygaRZ2ILAH9aSuFYDsPoqswEq/lB4iZUD91m3Qxx1/cww0cAM6IGd5
         SbOPq+x98sVqMCN4NIQlCDNTAF9w64X88rQkXAqdZ0Ant6fFRc7EsPGPj5tz1qjNuVi+
         QQbbm8FMDsn7Vb97oPJQX9PkMnb9Geld2PWoVm0J7niQreRG3K/xpjFdjlo5/BnZqFMQ
         Zkq/c8IOp8CupVmcDBwvq7ul7BY+vV4oepNsusSTBjHxOosBbj7E2dVczsIH5wH3m9oH
         LddA==
X-Gm-Message-State: APjAAAV9UcltByj7HVojZDynUbfSsc/WAUQBKcdHfjVkhtr8hJ5Ugp63
        Dui4UisHywuVF+B2KDZdUvYJXrJT6lUUCCsPVe3UiQ==
X-Google-Smtp-Source: APXvYqw2helkZ3RMQLGNhGXrJACkePG5udZckFLg9KzZq3HT+da0RblRTkPUzH2vRKtJZ1SuWZitoxREttaJ45NLpCw=
X-Received: by 2002:a0c:d4d0:: with SMTP id y16mr29761996qvh.191.1562139733812;
 Wed, 03 Jul 2019 00:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190627095247.8792-1-chiu@endlessm.com> <CAD8Lp44R0a1=fVi=fGv69w1ppdcaFV01opkdkhaX-eJ=K=tYeA@mail.gmail.com>
 <4c99866e-55b7-8852-c078-6b31dce21ee4@gmail.com>
In-Reply-To: <4c99866e-55b7-8852-c078-6b31dce21ee4@gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Wed, 3 Jul 2019 15:42:02 +0800
Message-ID: <CAD8Lp47mWH1-VsZaHr6_qmSU2EEOr9tQJ3CUhfi_JkQGgKpegA@mail.gmail.com>
Subject: Re: [PATCH] rtl8xxxu: Fix wifi low signal strength issue of RTL8723BU
To:     Jes Sorensen <jes.sorensen@gmail.com>
Cc:     Chris Chiu <chiu@endlessm.com>, Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 8:42 PM Jes Sorensen <jes.sorensen@gmail.com> wrote:
> We definitely don't want to bring over the vendor code, since it's a
> pile of spaghetti, but we probably need to get something sorted. This
> went down the drain when the bluetooth driver was added without taking
> it into account - long after this driver was merged.

Yeah, I didn't mean bring over quite so literally.. Chris is studying
it and figuring out the neatest way to reimplement the required bits.

As for the relationship with bluetooth.. actually the bug that Chris
is working on here is that the rtl8xxxu wifi signal is totally
unusable *until* the bluetooth driver is loaded.
Once the bluetooth driver is loaded, at the point of bluetooth
firmware upload, the rtl8xxxu signal magiaclly strength becomes good.
I think this is consistent with other rtl8xxxu problem reports that we
saw lying around, although they had not been diagnosed in so much
detail.
The rtl8723bu vendor driver does not suffer this problem, it works
fine with or without the bluetooth driver in place.

Daniel
