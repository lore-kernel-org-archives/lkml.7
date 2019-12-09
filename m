Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A893EC00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7973520836
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="veU94l/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfLISND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:13:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42381 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfLISND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:13:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so17243230wrf.9;
        Mon, 09 Dec 2019 10:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/Lzf1hIoDU/ZjVff0Ob50B/u4dz41ExonvLP+obnOrY=;
        b=veU94l/2yneEs2+AYnPRfypLrEwv/lHOSPvX2FqK4ks4WOdsJkkhAm4704nkBZ/6Mi
         lazIXl2B9ITEC8ee2XmyffCUC6U1UxH6gR89nd73H2hk9MND/KGz0gFcIDaoU59+mrNe
         s4vvhZNA0EcQumdairxyFg8FSbETavWj4ki9o6CcpeoxWnWox79TQtPOcnpnJQek4G1R
         WrFcNF+8ArAqMgIYmMiIF6YjptIwS/YnvFwU64wa67dKt4UvGQNRP3Oc1V+GG1r37M1p
         dlLjbhoiVa8aQS2KZXvMnQga8nB+XqTaw/IdkyHaxjVt5G6qK6/Im8JtyYoUxV5L2iZm
         YoqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/Lzf1hIoDU/ZjVff0Ob50B/u4dz41ExonvLP+obnOrY=;
        b=WU8BM4CQ+wMzXkyp2S7ZTvyB0bmFLeXQl4QbkmvwgZgQLrGGk1ZvwX+UDerPpALiRT
         cpZ2hOnluVBREy4Qz3wtmHNrc+Bhu5PchZU0hnS/KfIs9EVBR5ulFgReYtIVNbX6gUmk
         PmIt5zNxFSePQrPfSmQFtwMpJeldKFlAsYwE6jZ2t3irlG2NEl6Cx8WrOPFfMKFZFG7Q
         ahC7ShATXzEVuVZujwjk8wUonwfkc2fOeeQaZuCBxE7vVtZbgL8ousrLSF3H1kUa/bPB
         WwlDkG8NLZc2NbFFE0IVaJFUqxcmpM3+s3Na4EQ3nsN73AyXLi0KM+r7VKWWcs1m6Wdk
         BHLQ==
X-Gm-Message-State: APjAAAXNvDzQvG5NE2DJerSdwNvmbvcMPm+VF7VW0apeQ9n4yyJpUPgg
        vCTG//4g0tbTOspU1/ICEcI=
X-Google-Smtp-Source: APXvYqz09GH7IbLXL1n86qn2SJ7Z7dx3lAnu4LcZ3gQ+++4bhQhZLSjmbqLnsv9mnd/KlGDUZHcj5A==
X-Received: by 2002:a5d:5308:: with SMTP id e8mr3599909wrv.77.1575915181066;
        Mon, 09 Dec 2019 10:13:01 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g21sm219800wmh.17.2019.12.09.10.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 10:13:00 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>
Cc:     mbrugger@suse.com, phil@raspberrypi.org,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: bcm2711: fix soc's node dma-ranges
Date:   Mon,  9 Dec 2019 10:12:56 -0800
Message-Id: <20191209181256.5854-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191204125633.27696-1-nsaenzjulienne@suse.de>
References: <20191204125633.27696-1-nsaenzjulienne@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  4 Dec 2019 13:56:33 +0100, Nicolas Saenz Julienne <nsaenzjulienne@suse.de> wrote:
> Raspberry Pi's firmware has a feature to select how much memory to
> reserve for its GPU called 'gpu_mem'. The possible values go from 16MB
> to 944MB, with a default of 64MB. This memory resides in the topmost
> part of the lower 1GB memory area and grows bigger expanding towards the
> begging of memory.
> 
> It turns out that with low 'gpu_mem' values (16MB and 32MB) the size of
> the memory available to the system in the lower 1GB area can outgrow the
> interconnect's dma-range as its size was selected based on the maximum
> system memory available given the default gpu_mem configuration. This
> makes that memory slice unavailable for DMA. And may cause nasty kernel
> warnings if CMA happens to include it.
> 
> Change soc's dma-ranges to really reflect it's HW limitation, which is
> being able to only DMA to the lower 1GB area.
> 
> Fixes: 7dbe8c62ceeb ("ARM: dts: Add minimal Raspberry Pi 4 support")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---

Applied to devicetree/fixes, thanks!
--
Florian
