Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9D6C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54C02085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 18:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tw75cR9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfCHSnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:43:39 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38917 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbfCHSnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 13:43:32 -0500
Received: by mail-pf1-f193.google.com with SMTP id i20so14759124pfo.6;
        Fri, 08 Mar 2019 10:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F+Ty56act3tflktQ1eI/bo3Oc9EDN3zzuOZNjd9K+ag=;
        b=Tw75cR9H+hgmvfsVvbsbtDtvUFAqT5tvGXojBPmN5QZqSCdBZSIOZj2QWHAf5ed26b
         RGAganrNuYBYaW5EoQKaVBGHu7RPlQOs/blaQW+7ZSqUd2F0urZWAcI0UrYICb1YJeBQ
         i+lrG4HylK+CQMonKHh47t9WMU0QvqfhpgNehK2hb7nb9iAevQp9YswbmyfhclToNIxd
         7ZvstlYk7Yf7JtuMo+PbUz0yCDCymN5BEH36xwBbHHltIWyw9Zel0v0txkUuo12/I7cM
         48W37FI3VDpUu2s2H7Cv67vloeqzNYlLbAEIP0zEr+Egu0G3d9fJjFvlbjrMebYwpB4y
         SsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F+Ty56act3tflktQ1eI/bo3Oc9EDN3zzuOZNjd9K+ag=;
        b=t2tUnNSxt7vetAgP/uJ3mVDJP0POUajVuOxWq+e7w7DGgnDqAablKkBoxiLyOKzsHu
         pGrbfQ6e7JUeA8MfNkL+WYdacfN1jY0YIrpjrkfcCrA3PHNqiXFwN7usZtHSZ9Js/jxb
         HZXdhSMZfyMM7RV4/0kD39H8t3bdvo9fWRZTwibwQKVUytpmlHIXPqX6sTXb4irA0v1I
         KR5a9LQEwEueJnqROQAHcMMdPYdx+soJnQ/vAsZ0GNAVdXmr9rgjKdPIk6fHS2+ddeRq
         iJ0qADfMGwWTNJMRUdUqN2sr6o6JTN7lacf5Odg26LpauKgXeqN6ohDuRvgLhn4S8CJn
         aRAQ==
X-Gm-Message-State: APjAAAUqFi3icyLAIpjTJmSN+5m44yUCrn65N/WV71Dt0+saC+hrKZPZ
        CiiCNRSzfx7bIQ7O+pm0Sm8=
X-Google-Smtp-Source: APXvYqyi4on0MbIxRhAMpLhUjSUPx6Dxl288E/OwAiKpcqYm8PrnyEQNypT8X6/3+W2eK/lnhqwLHQ==
X-Received: by 2002:a63:8743:: with SMTP id i64mr18036201pge.69.1552070611051;
        Fri, 08 Mar 2019 10:43:31 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id a184sm14112440pge.68.2019.03.08.10.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 10:43:30 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        daniel.lezcano@linaro.org, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pramod Kumar <pramod.kumar@broadcom.com>
Subject: Re: [PATCH v6 3/3] arm64: dts: stingray: Add Stingray Thermal DT support.
Date:   Fri,  8 Mar 2019 10:43:22 -0800
Message-Id: <20190308184322.14451-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1546505734-24527-4-git-send-email-srinath.mannam@broadcom.com>
References: <1546505734-24527-1-git-send-email-srinath.mannam@broadcom.com> <1546505734-24527-4-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  3 Jan 2019 14:25:34 +0530, Srinath Mannam <srinath.mannam@broadcom.com> wrote:
> From: Pramod Kumar <pramod.kumar@broadcom.com>
> 
> Add DT nodes for thermal zones memory base address
> to read temperature.
> 
> Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> ---

Applied to devicetree-arm64/next, thanks!
--
Florian
