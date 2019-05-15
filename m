Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF954C04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 02:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88ED920862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 02:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dXjwoQpn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfEOCCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 22:02:30 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39927 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfEOCC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 22:02:29 -0400
Received: by mail-vs1-f68.google.com with SMTP id m1so641044vsr.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 19:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AxA0x4PyivVs2YLv3eXq9QQMTB5geMHM8Hexc+yQ7mo=;
        b=dXjwoQpnVsDqYDrL0Cnicd2MotWpdOFr7GH9DOjbDlq67I4sZGEfis+5EBw95xXMvF
         IbOJ8aq5o2OSe/E7ekC9qYayFL/4Wjs7wGz4Vkxxeyhz7svrgu3CUlX0qU6XlLarlsQE
         XLWo7ChQkbI13KqRlSEnD8eB0HxjVgLq5LeTWAevPIARzl9nozOucpkTw+LRMnlA7+18
         /O/337lLvdFHIcpZmhd14DxEzXu03cShUorZmYGRMoofO+96lypySevQRzuJXtRpwv2S
         sGVTvHKEtLmNl/s4FHPbSoCR0/QUdyBpjEvrq0s48VL5Xh62HHKjEgOThv0ACml6uYjh
         ncvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AxA0x4PyivVs2YLv3eXq9QQMTB5geMHM8Hexc+yQ7mo=;
        b=mgEglVRs3psIZSFeKEyhOEUFeWrcBbhnVgfuhlWIZZFN8qBjM852jQHWwLx6LqTjyB
         ctQk6RAbGSBC2Jj46yZouDKEm0vV1wwQuQwnK/fS2dvzT9U0zGnLNl5+S+0SFGF7U3zM
         d0m/WPALFkoDIyX4eNAH1ELGXN3hvLG3c35VySHx6jeZ/hLWL2sBU45KhsHycS9sjHb8
         cB2FpbKvMr8o5BPcaQL/JYXj0r6i9uX/Ikoay+9GksyDJEVazLV4M3sRDXhuv1vxOXpR
         Y6VjAEZCqfAiCOoqZwE094d3rJbEUZgbz+WLm9ZQExFjlRWgUW5RVqcfbSDGUXAfqYd7
         0FSA==
X-Gm-Message-State: APjAAAXH1iwMlcpG6P1vUN1iXcEpF/Of+/JQ0uaxAeSNq9sOLSs4FTc1
        j/zSa/HGXHBlB5ozuJMWo+p0G686dxu222uSmsdRiQ==
X-Google-Smtp-Source: APXvYqxIRDuESb28VHPDBf2noVQZmbwLgfSNzYuspFpDWguKCT7rP6ucq1S57/0nWplSsbRvDowflcDST1f72rVZ2Dk=
X-Received: by 2002:a67:2781:: with SMTP id n123mr1212734vsn.141.1557885748720;
 Tue, 14 May 2019 19:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190415155636.32748-1-sashal@kernel.org> <20190507174020.GH1747@sasha-vm>
 <20190508124436.GE7642@linux.intel.com> <20190514193056.GN11972@sasha-vm>
In-Reply-To: <20190514193056.GN11972@sasha-vm>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 15 May 2019 07:32:17 +0530
Message-ID: <CAFA6WYM06E0y9o6+CLNPe48spiL=UDEqoGsidMbk1dBa5Rbmkg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] ftpm: a firmware based TPM driver
To:     Sasha Levin <sashal@kernel.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        peterhuewe@gmx.de, jgg@ziepe.ca, corbet@lwn.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@microsoft.com, thiruan@microsoft.com,
        bryankel@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2019 at 01:00, Sasha Levin <sashal@kernel.org> wrote:
>
> On Wed, May 08, 2019 at 03:44:36PM +0300, Jarkko Sakkinen wrote:
> >On Tue, May 07, 2019 at 01:40:20PM -0400, Sasha Levin wrote:
> >> On Mon, Apr 15, 2019 at 11:56:34AM -0400, Sasha Levin wrote:
> >> > From: "Sasha Levin (Microsoft)" <sashal@kernel.org>
> >> >
> >> > Changes since v2:
> >> >
> >> > - Drop the devicetree bindings patch (we don't add any new ones).
> >> > - More code cleanups based on Jason Gunthorpe's review.
> >> >
> >> > Sasha Levin (2):
> >> >  ftpm: firmware TPM running in TEE
> >> >  ftpm: add documentation for ftpm driver
> >>
> >> Ping? Does anyone have any objections to this?
> >
> >Sorry I've been on vacation week before last week and last week
> >I was extremely busy because I had been on vacation. This in
> >my TODO list. Will look into it tomorrow in detail.
> >
> >Apologies for the delay with this!
>
> Hi Jarkko,
>
> If there aren't any big objections to this, can we get it merged in?
> We'll be happy to address any comments that come up.

I guess you have missed or ignored this comment [1]. Please address it.

[1] https://lkml.org/lkml/2019/5/8/11

-Sumit

>
> --
> Thanks,
> Sasha
