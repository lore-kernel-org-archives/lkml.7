Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72432C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010D0216B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="DJxLD49s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfEUKZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:25:06 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:37659 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbfEUKZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:25:05 -0400
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x4LAOwZ1025211;
        Tue, 21 May 2019 19:24:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x4LAOwZ1025211
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1558434298;
        bh=g1eTgJOllZAMscUYC3eHoMSUDCzCFgfluUEbaSmpZII=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DJxLD49sLiFHtIDhxYyfA4/ZDjjF3p6f3/vezpgTil/hC7qTF61AcTrzBgVpQD9/R
         NCIbvIluoVMfHVT4HEv0NAPdOPqNDtcue41GSJqA0rbvC5ObjxEH5+A2yT5IaTDTSH
         f+8fDh0d4fDJ6ecR1v4v4CAMSDAOLFxdSsX6kZRV61IrbrOuPwxuPjJEqNNVplmU+l
         RVSf0kePEixdGTHoz/MToKWMGKu00lBsNwfFfvSlnjIfjEcGtSijsrlQV1mRMxfPAZ
         XJoc0jFYLG/arAA4AIWoVDzqAXVWmvcCx64kPMGkeGjq21Si7ZaxRjdShnsLabK2an
         nmZ0GZ+nUEwlg==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id m1so10790360vsr.6;
        Tue, 21 May 2019 03:24:58 -0700 (PDT)
X-Gm-Message-State: APjAAAVr/HVL4u4eMAU0kdKrWsKf+kfPvJtwSRffsqixSbEQeJcwqHWn
        7lp5wXfE0ZJF1y/15didGrCXP9ysw1OOaFd3X0c=
X-Google-Smtp-Source: APXvYqwb9CDXB51Tkt/ijB8qbrhDOCbaM3Dk/o4G75bkdTd/OXX0x1q59GwzRWpTxaSJj7RsjuCtDAo5ZYgv6kZwXTk=
X-Received: by 2002:a05:6102:3d9:: with SMTP id n25mr13609687vsq.181.1558434297247;
 Tue, 21 May 2019 03:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190520092856.26307-1-yamada.masahiro@socionext.com> <CAKgpwJXEHjww0aV4x033qugw75NUtkMg3vvgtCDNgWaWbps29A@mail.gmail.com>
In-Reply-To: <CAKgpwJXEHjww0aV4x033qugw75NUtkMg3vvgtCDNgWaWbps29A@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 21 May 2019 19:24:21 +0900
X-Gmail-Original-Message-ID: <CAK7LNARn+wok5YXrnX-Vatv2-d=+awXtnBCPJmAR2nb8Fi=trw@mail.gmail.com>
Message-ID: <CAK7LNARn+wok5YXrnX-Vatv2-d=+awXtnBCPJmAR2nb8Fi=trw@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: move core validatation after clock enable and
 reset deassert
To:     Jun Li <lijun.kernel@gmail.com>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb <linux-usb@vger.kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 6:14 PM Jun Li <lijun.kernel@gmail.com> wrote:
>
> There is already one identical patch for this:
> https://patchwork.kernel.org/patch/10934937/
> either one is okay.

I did not notice this.

Please go ahead with yours
since your are the first submitter.

Thanks.





-- 
Best Regards
Masahiro Yamada
