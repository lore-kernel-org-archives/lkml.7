Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB80C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B84C21871
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570547103;
	bh=rX0PXXQKYXyZRDbrBWfRRnZ6rIagZRqMiLAQaZV8zbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Nb1dBbKOtnoKSH5zm5tzAIFJKp0Ci+RxaO7JaV7ARM8lfCp9cH3d2dZ6s1qV12UXW
	 zBPBWR8yB2B9KM3oxGRbY/F3kqbZ3uz/YZwBPM3GO91vTgHyoieyEMP18cvuUyHu5O
	 Z9qFJx0dwcQHYuRMA0igj/798PRsAWvzyi4O2huc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfJHPFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:05:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45827 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfJHPFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:05:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id r5so19754894wrm.12;
        Tue, 08 Oct 2019 08:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rX0PXXQKYXyZRDbrBWfRRnZ6rIagZRqMiLAQaZV8zbs=;
        b=iwpd6ZXMGD2NSbpFwq/VzQkESAz09B5XgNlWI6GeIVgsB1lDUjqyG0ipvKqxdoSwzl
         qvZvQfCZmOzxT6+qCKUF8x11CUODSbhZdBx9aMJZUEZGpNbJ3NVU1emSIMgqAV5VCBko
         JQgcAbb8W14RVLAAh9aCPRPDMDhAYEOd8U7GH8q/IFtRbTyZmmm0CtapCAXTXp2WFrep
         2l6516wwWW+gcI6iLiga0iwoptjCA91UIIqKE0NW6ZBGugqfLLat8ffwqoyQvZugqmXl
         +58x0NqcpFmv2xkKfcTCEZmT/PQv5sHRyRLNXauvsn2T1/Ch6BdKLB9LuwUh3B5IfO0G
         CQfQ==
X-Gm-Message-State: APjAAAUQfnGwGxsZG9VPL7H1IBSYs01n9jBxs0ZE0QKRCnY+TFC5iR3H
        lLw5f2LafGdKtAUmfxdQ8Vw=
X-Google-Smtp-Source: APXvYqxbH6kNC2No7U6c2Eckjb4BC3VaoHcgnIuNUSw/LgzIdnnn5qz0WdDmVXiEjMQbUVy1l+M2yg==
X-Received: by 2002:adf:f311:: with SMTP id i17mr17611648wro.394.1570547099949;
        Tue, 08 Oct 2019 08:04:59 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id l9sm3273799wme.45.2019.10.08.08.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 08:04:59 -0700 (PDT)
Date:   Tue, 8 Oct 2019 17:04:56 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: arm: samsung: Force clkoutN names to be
 unique in PMU
Message-ID: <20191008150456.GA2683@pi3>
References: <20191004151414.8458-1-krzk@kernel.org>
 <CAL_JsqJDTcHu5oXG6zszGHCBhTE6EW94AANUjyMV78SkKcn5yA@mail.gmail.com>
 <20191008125038.GA2550@pi3>
 <CAL_Jsq+GcsUWN6kjBLkyr1rHGh6_4=w6JL6+k7DBXkBcvHcSBw@mail.gmail.com>
 <CAL_JsqKBzZCShxx99aB4z15XYNbUionVicmfNNXEfq=iohWLCA@mail.gmail.com>
 <20191008142900.GA2635@pi3>
 <CAL_Jsq+ObMD=inkMFqkZbKFoKZUxw53gUMnjsC1pU5GwumK8LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+ObMD=inkMFqkZbKFoKZUxw53gUMnjsC1pU5GwumK8LQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 09:38:15AM -0500, Rob Herring wrote:
> Are you running using DT_SCHEMA_FILES? If so, you won't get the core schema.

Ah, yes, now I see proper errors. Thanks for pointing this.

I'll send next version of this patch only (if others are ok).

Best regards,
Krzysztof

