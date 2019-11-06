Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7745CC5DF65
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AAAF2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Y9Xhwrmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732018AbfKFTJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:09:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56218 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbfKFTJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:09:48 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so2145101wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 11:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=98bdaefMMvLZQIHTqFywF3ip5/YAIodCEvGFdU9Er/M=;
        b=Y9XhwrmbWLORhZlwLUkLchMbGrptmOACK9FnrfpdNSRNFuazWNMXmChIwpD58f2jVr
         N/t9585V/7Ltdbbw3aKeEBJoE4Aw7fiagtcD6Vlwi04FalagvHT+fU7MlceZUwoAK04m
         6D8/u1hOAzzIIP6M5PcyZTalMOc8T6LL5PU+S+fSUHA69SZQB0Zjdcmy0klhxzugPmHj
         1b/qOZ02Wl7pan4CwBkE0Pj+rPBiUw9CvltBdTK5QnPib8MjMqp5DbSSxNI3/NYv9+H5
         O4nW1nxH/8euZ71BcJibTC9CWivgFfvXAvjQF4vyMfHsh4/IMjHutpqNIdqKh5P2EMqb
         Um6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=98bdaefMMvLZQIHTqFywF3ip5/YAIodCEvGFdU9Er/M=;
        b=AjtdDhkN+3tmwZVUVjh1X/rPiHyTn/Rc/RLroSILGYl4LtTqUv2QH6XoCYumtoSZnW
         E1WSWtA3TFfi+DWPb/Ah9egDpZ+is7Mj/UMIe3I4tPBtxwTuJUriATdd4orHBKpH4r3l
         6YWadnlZPhbgadP0ksFCcEozDQ4H71p2p62AMjkImlSLPiDEIqzT1YShLp/KTUw5qMJf
         4jRUYMZl8mm1IaI7syvb/lsoCbvzi4UfjWUgma4AshcMifswNYn4oGJ7X4NTM5lTnxb1
         ryjm2cAE80MKo8KAll6Z0A+gBCGotOMv4pwlxfjxf+E/pmuRJM/NtwcxnphvDpQOcOL3
         dEEw==
X-Gm-Message-State: APjAAAUA/RMKjJ1/50u21NLutt0BUKJmDO5M3J9pI1V5XaabZqOEMD8k
        u3koewJtaUKD7yYBOM/aFU1veA==
X-Google-Smtp-Source: APXvYqyCY1lln9b2iPCyHCKanV4eXIoEfn+QcpUfs/G9tRuieF5Y42EKu4s/16n4VkYDgpiAaqYiqA==
X-Received: by 2002:a1c:2344:: with SMTP id j65mr4213269wmj.38.1573067386601;
        Wed, 06 Nov 2019 11:09:46 -0800 (PST)
Received: from localhost (amontpellier-652-1-71-119.w109-210.abo.wanadoo.fr. [109.210.54.119])
        by smtp.gmail.com with ESMTPSA id j11sm20930039wrq.26.2019.11.06.11.09.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 11:09:45 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: khadas-vim3: move audio nodes to common dtsi
In-Reply-To: <1571416185-6449-1-git-send-email-christianshewitt@gmail.com>
References: <1571416185-6449-1-git-send-email-christianshewitt@gmail.com>
Date:   Wed, 06 Nov 2019 20:09:44 +0100
Message-ID: <7h4kzg7rev.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Hewitt <christianshewitt@gmail.com> writes:

> Move VIM3 audio nodes to meson-khadas-vim3.dtsi to enable audio for all
> boards in the VIM3 family including VIM3L.
>
> This change depends on [1] being merged/applied first.
>
> [1] https://patchwork.kernel.org/patch/11198535/
>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>

Queued for v5.5, but...

> -&frddr_a {
> -        status = "okay";
> -};

This node doesn't exist upstream...

> -&frddr_b {
> -	status = "okay";
> -};
> -
> -&frddr_c {
> -	status = "okay";
> -};
> -

... and these two were present so were removed after manual fix of the
conflict.

Kevin
