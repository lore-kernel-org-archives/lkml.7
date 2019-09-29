Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5E9C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 00:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D3F207FA
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 00:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="oeAakd7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbfI2AVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 20:21:21 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:51339 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbfI2AVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 20:21:20 -0400
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x8T0L80N016203;
        Sun, 29 Sep 2019 09:21:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x8T0L80N016203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569716469;
        bh=5fDc5YaT7f/VUVtzw3IY9ZlI3jXeAzbdB4vRLcrugfI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oeAakd7g6wCJoOhdW9zt5iE6K9cgSMnoV8CoZ5y56M+issdOJmtkMxdqpupZWdPBd
         HpIk0rLrLvFNT5RIZk4NRBViVzQaZ1ZA8nReK5SvYtQ37dZ+yRQVsIcZ28Ovk/vTR7
         g/FDELPEAd+MwfZ9aKuQhcHcB+pCaVoKBtEfCcLbfUJ7i3L4aS4Sk2XwQaXF1v9/M6
         SULysb10cNZKdskauvD7kil0UCOJl4FfPTJfL1C5PQ2JTs+3Zz4xpAIQaJNmLyjw60
         BBqII+/cD51qDmVwm1wGJxiK/bJZMwB7ZWvxxEZiqUJ277D9cWSScit9/IAcEZXUPV
         /aFX8AeNdTRqg==
X-Nifty-SrcIP: [209.85.221.169]
Received: by mail-vk1-f169.google.com with SMTP id t128so1966478vkd.13;
        Sat, 28 Sep 2019 17:21:08 -0700 (PDT)
X-Gm-Message-State: APjAAAX35arnr32zBrpccdztCwDIeqxFyaFE/80BurrXoANgwIRykV7F
        ubG9cvOmBXYYD7eaHIf94nHrlAe2ari+owfsDj4=
X-Google-Smtp-Source: APXvYqymOZkiXNxKVDSVKujhu5kJTfTDulxnWJzegGEnWkmbn4GZXf+H5EJwbxw+EyLqr/6h8oVz67rObQDH2Fk3mWM=
X-Received: by 2002:a1f:2343:: with SMTP id j64mr1919485vkj.84.1569716467891;
 Sat, 28 Sep 2019 17:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190129204319.15238-1-jacob.e.keller@intel.com>
 <7b26e6cc-10ce-5df2-6375-1f95bc4da04e@infradead.org> <02874ECE860811409154E81DA85FBB58968DBE54@ORSMSX121.amr.corp.intel.com>
In-Reply-To: <02874ECE860811409154E81DA85FBB58968DBE54@ORSMSX121.amr.corp.intel.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 29 Sep 2019 09:20:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNARyUEakeG_N9TWcO2cjFSzbgY__k_QJm6C+oOz+fW0aeg@mail.gmail.com>
Message-ID: <CAK7LNARyUEakeG_N9TWcO2cjFSzbgY__k_QJm6C+oOz+fW0aeg@mail.gmail.com>
Subject: Re: [PATCH] namespace: fix namespace.pl script to support relative paths
To:     "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 8:30 AM Keller, Jacob E
<jacob.e.keller@intel.com> wrote:
>
> > -----Original Message-----
> > From: Randy Dunlap [mailto:rdunlap@infradead.org]
> > Sent: Friday, September 27, 2019 4:12 PM
> > To: Keller, Jacob E <jacob.e.keller@intel.com>
> > Cc: intel-wired-lan@lists.osuosl.org; linux-kernel@vger.kernel.org; linux-kbuild <linux-
> > kbuild@vger.kernel.org>; Masahiro Yamada <yamada.masahiro@socionext.com>
> > Subject: Re: [PATCH] namespace: fix namespace.pl script to support relative paths
> >
> >
> > re: https://lore.kernel.org/lkml/20190129204319.15238-1-jacob.e.keller@intel.com/
> >
> > Did anything happen with this patch?
> >
> > Please send it to linux-kbuild@vger.kernel.org and
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> >
> > You can also add:
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > Tested-by: Randy Dunlap <rdunlap@infradead.org>
> >
> >
> > I was just about to fix this script but I decided to first see if anyone else
> > had already done so.  Thanks.
> >
> > --
> > ~Randy
>
> Done, thanks.
>
> Regards,
> Jake


Applied to linux/kbuild. Thanks.

-- 
Best Regards
Masahiro Yamada
