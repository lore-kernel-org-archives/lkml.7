Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585BBC282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257F021855
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 06:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554530759;
	bh=A8fs4XyKMRiqc8FsiJVZjtdvBKHdxp2STQz7SW1gyGk=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=hYefRRHf2RjE7xKXJkMGu9H4n0o+mKMQ5hVMaVoGTDMvq+IgCVrzuoEGBZmckoDEX
	 DaUe+RDTMFNpKoRwgnZLDXFoR55UrzM/9l+4PVRfLnva4RLSlJwyqYxTkpMrbwJ414
	 JlNWErG62b9FiIJdmHRc8G91XZtxjOwYiHxBhA/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfDFGF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 02:05:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38581 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbfDFGFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 02:05:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so4457468pfo.5;
        Fri, 05 Apr 2019 23:05:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=Y2LNPDDgAWFMTxjrphq8l1ZkmN7zBDhbLgoLv2GUpQI=;
        b=ZL+I6pR3VUCJ3g41EY/imZ/e7ht2Ux+aLqPr37sO03UyalFN/Ie55akZ+4xOxAQO6C
         XH8DDKA7rCbv8m163vOD+pjd6JNngFNM4bOOXjxveGLBSeu75CdT6VeBwsDzqWTlyJrD
         WgS8mOLwiZJf/SsJMg8ILvx8r8prE2opICgvbj6MA8evRvgt/Wl+LYnyn+d2WB5BtHdQ
         qpIqaNLlo0GwXy0czT3azVBHV9OHV8bFZHJ+4X0xaG+Xe7vXs5wGC5Vhrdi4SJOjymZG
         6CiB2tdejT+7QD2P5UnH561aOnH1VbSDCptDjufuyH+ElkuUEfYKWjZRFK+Dn5PZazQT
         0tEw==
X-Gm-Message-State: APjAAAXXobN83GycwLiv3W0/0HXnmNGVDpVGKMZ1XmCaBzSN1MwZZPyO
        UF7qPaUyH4YoJHdqQkRWyQ==
X-Google-Smtp-Source: APXvYqzxH1SLJcGx7X0hbQGNI/T13FsW1H6PxA4ICO1KCBgoxCNQBOen/bGkVuwDPeTOEjmbWr9oVA==
X-Received: by 2002:aa7:8719:: with SMTP id b25mr17011728pfo.90.1554530754485;
        Fri, 05 Apr 2019 23:05:54 -0700 (PDT)
Received: from localhost ([210.160.217.71])
        by smtp.gmail.com with ESMTPSA id v82sm56318833pfa.170.2019.04.05.23.05.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Apr 2019 23:05:53 -0700 (PDT)
Message-ID: <5ca841c1.1c69fb81.44d14.3a88@mx.google.com>
Date:   Sat, 06 Apr 2019 01:05:51 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: clk: axg-audio: add g12a support
References: <20190329160649.31603-1-jbrunet@baylibre.com> <20190329160649.31603-2-jbrunet@baylibre.com>
In-Reply-To: <20190329160649.31603-2-jbrunet@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
To:     Jerome Brunet <jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2019 17:06:46 +0100, Jerome Brunet wrote:
> Add a new compatible string and additional clock ids for audio clock
> controller of the g12a SoC family.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../bindings/clock/amlogic,axg-audio-clkc.txt          |  3 ++-
>  include/dt-bindings/clock/axg-audio-clkc.h             | 10 ++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

