Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5780AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274AB2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGbOD6Wc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732016AbfCZRXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:23:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36656 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfCZRXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:23:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id r124so8571299pgr.3;
        Tue, 26 Mar 2019 10:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y447w/xzKkiWcVsKJ90y3SbOuR6EtvaZ+TM2mMuthaM=;
        b=eGbOD6WceRK/2gdzokhP5Aq1+qjdi+vzJOrKEVwKKK2mTKBVo8Dz+RQtzQzHMvUYeP
         VG8mFI0Xqet/ksddQwbOCKZLyajUEJf8rP5xTojbheNG8cB4wcz3mzsU0tEQQfeVaibq
         GtZUVGihX0QmUPzmUuHL0IU6xGtJKRwTuFCBHVBX0MuVTmKlT/acdywlEdWcWtT6g2lU
         j85z1W2Wj5oeqGx4aVddPkRtTZVDySXo3oJrgi1BdM+3n9mGlgpxwcd36sayySxAiLEY
         NXcILu6sRMByVTJVe9yaa4lLz8tooofTkrW/mVTK+4WJDGXhzqc/vKFT0D9utSnMah2O
         mOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y447w/xzKkiWcVsKJ90y3SbOuR6EtvaZ+TM2mMuthaM=;
        b=X5jRukKFCYS0SR7teyXelbltRE62Gu0jI8/EvFiOzDe3SeE49Aqwd77Tke3RNmk+33
         0ltpfuGKYKSkW88wxd/i+MCDgHNjgLzs18wY9RykH9wSuMhb5knN4nZIBbdGgbLlUC9A
         qho2eZ0BKP1cwF4QnXgHcCb1U3D14/ZYOddmtp8Cm+YTD0kBBLvkg4mAOF8MoKTXupAG
         A4Y96uDtzG+GyTiBOE5iaWXbVjdfH3XWEXwQ3MmfS4ixYCqvWIc9A+Z+XymCi4CKSEjx
         kAGYKjScWaWurkDh4kdhq19HqlM62A0IHXHuOcgJgojAiV0YUtKLvFNfjGaICH0BdjfS
         iulA==
X-Gm-Message-State: APjAAAW7sRhT2HoWr1R6VrigLwOwKgPCPmVb0JD9MAA+FBkjPlkwEnZP
        uIxZKC8tn12NvnAl+TMwFWI=
X-Google-Smtp-Source: APXvYqzM7OUlh6Ejiu8I6+jP6jX7xWjm+uK+SRQAXU0qBaMYpa0s96ajEBpHczh4mkJ2jT2We1rg9Q==
X-Received: by 2002:a62:39d6:: with SMTP id u83mr30874692pfj.161.1553621004568;
        Tue, 26 Mar 2019 10:23:24 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id j13sm25108919pfh.32.2019.03.26.10.23.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 10:23:23 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jayachandran C <jnair@caviumnetworks.com>,
        Tejun Heo <tj@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 3/3] arm64: dts: Add USB DT nodes for Stingray SoC
Date:   Tue, 26 Mar 2019 10:23:21 -0700
Message-Id: <20190326172321.26289-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1552986944-3398-4-git-send-email-srinath.mannam@broadcom.com>
References: <1552986944-3398-1-git-send-email-srinath.mannam@broadcom.com> <1552986944-3398-4-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019 14:45:44 +0530, Srinath Mannam <srinath.mannam@broadcom.com> wrote:
> Add DT nodes for
>   - Two xHCI host controllers
>   - Two BDC Broadcom USB device controller
>   - Five USB PHY controllers
> 
> [xHCI0]      [BDC0]            [xHCI1]            [BDC1]
>    |           |                  |                 |
>   ---------------               -----------------------
>    |           |                 |         |         |
> [SS-PHY0]   [HS-PHY0]        [SS-PHY1] [HS-PHY2] [HS-PHY1]
> 
> [SS-PHY0/HS-PHY0] and [SS-PHY1/HS-PHY1] are combo PHYs has one SS and
> one HS PHYs. [HS-PHY2] is a single HS PHY.
> 
> xHCI use SS-PHY to detect SS devices and HS-PHY to detect HS/FS/LS
> devices. BDC use SS-PHY in SS mode and HS-PHY in HS mode.
> 
> xHCI0 port1 is SS-PHY0, port2 is HS-PHY0.
> xHCI1 port1 is SS-PHY1, port2 is HS-PHY2 and port3 is HS-PHY1.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---

Applied to devicetree-arm64/next, thanks!
--
Florian
