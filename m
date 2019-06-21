Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B107BC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D1421707
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5u5XAIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfFUPpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:45:47 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:39333 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfFUPpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:45:46 -0400
Received: by mail-lf1-f52.google.com with SMTP id p24so5420694lfo.6;
        Fri, 21 Jun 2019 08:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4fJ2PnraFqUF/JKW5XviEksJ6k/ji8A1pgBHcnkA8+E=;
        b=M5u5XAIr4/a9W+EOhbLJumvb8itBVqTB2Ji867d06wxMEN0K/uPSTFU/b9ZGKcMIXY
         YRP8sdd2tIHI53RrppKMThlzKXbPhv3tDlXKQy4i4reEDjcB51u8wPcitp6atGhZi/rp
         oWErBg+ya6fRSw2bFlVMMSSfLLqaB5b4ZMvmnvORkkyKOIEjIiFTazSIxpnxwGATssBR
         WG/WBqOrG1IFzN37qTZlimvtfgbxvmJXPnTrWTk0x2YuuRbWP5K0lzrW73l6aM0uWp5p
         H612FyjZgTBnT5tPGNXyAb31CJkAfoC7M64QEN1VMuTYjWU38OUd+IGzGTbsuR1jm8hB
         4L7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4fJ2PnraFqUF/JKW5XviEksJ6k/ji8A1pgBHcnkA8+E=;
        b=uRrwQnMRn9Wx5u+2JAf90e9W5KSRj5E0s1CXYvEsBvoGc/sbFtn6WW3yLFQD11O9hg
         1loF5fcCPqIwWRkoHdN8BJZbDhwQ5vtZOtsv+m7TpFgSHPSQ6z66eF7W/MPWKIUlUCRp
         RdnqAV/9lgQNRvXcerhdTSxWKS1XfIwNm8aIfKZ03TgkXJsCB4EZ+pMWBdQ1cPcW29jo
         tGZK8BHioAYlCtCcV2WvzCzKKpEAHkTEgXZ/199tVP6kJwptuGH/7yqdTfurxGiCimEO
         5Hpll19CgUM9OGi1Vv3mM9r4iQCCI0dKCEI9Y89gWCEw/7Qw/1gXV9Is3ZnJuUtvdE/z
         a9Pg==
X-Gm-Message-State: APjAAAVuVCLjagJ3yZVpDMNydSSEViN3avNwOTuNoXVs9rVWtxbA5Ej8
        y11nHnMtaQc0cS/np/utFtawjgIr6YSq5YI1M00=
X-Google-Smtp-Source: APXvYqz6D7hHywj9tjfdpfWvZgBxWUEM8p1b8MpTAcYzk1K50zC1HX6fCm6UtxOlAeLLvSEWoWzUM8ZiXDxjqeKAWlY=
X-Received: by 2002:a19:6e41:: with SMTP id q1mr61718401lfk.20.1561131944203;
 Fri, 21 Jun 2019 08:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <1561037428-13855-1-git-send-email-robert.chiras@nxp.com>
 <1561037428-13855-2-git-send-email-robert.chiras@nxp.com> <CAOMZO5DunK3+ovBd0c0X4NTf-zkW1Tjz6KgXFMaRQKMk2SBMiw@mail.gmail.com>
 <1561126587.9328.76.camel@nxp.com>
In-Reply-To: <1561126587.9328.76.camel@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 21 Jun 2019 12:46:02 -0300
Message-ID: <CAOMZO5D+7msAxc99KFi=OWCNeBSxKXtJ8O=J7U+YE6v=xz3cAg@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v3 1/2] dt-bindings: display: panel: Add support
 for Raydium RM67191 panel
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Fri, Jun 21, 2019 at 11:16 AM Robert Chiras <robert.chiras@nxp.com> wrote:

> From what I've seen in the schematics, the power lines on the DSI port
> on all the i.MX8 cores are coming from a PMIC providing power for all
> the peripherals. Since I didn't find a way to cut the power on a single
> peripheral (like DSI, for example) it doesn't make sense for power-
> supply property. For now, at least.

This panel driver is not supposed to only work with i.MX8 NXP reference boards.

The dt-bindings should be as accurate as possible from day one, so
describing the power-supply is important.

Please look at the panel datasheet and describe the required power
supplies accordingly.

Thanks
