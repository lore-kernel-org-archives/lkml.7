Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879E0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE812083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="KCnYnxkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbfCVNbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:31:11 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50955 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbfCVNbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 09:31:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id z11so2208051wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 06:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g8a/6QFF5xRiCzUNrWvuGv54lLv2MelL/M6fpnjm+mE=;
        b=KCnYnxkrfcpVykllO6q84FRtzou33y2tRwrnRFbIxtoOOOuX//6GKsAYanPM8d5zDJ
         z01PPVqQRnlwifBAep9cNAkrFtH+w1er3a9nY4y1zjk/9aWTQSE06TDoa2ZgcnIAZ+rj
         KYa+tKO0J78IGCgHVFXF5LzOS9esg4t1YfUXIivxJB+U2m7Nej7JmJVlEbBBYebIN4sK
         Poh6iqOUFbiFPWDrkr5W/eT26MuV0hlLxgLk4N1BpoSBifjSjpKpPjKWqinI1ZFkpD/M
         EsXJrIAh35ltu4+ZVz7MjWCmWPQvOTJgMBQgwZOrq+61vWnwZd/IF+2/NSpvFNZZsXet
         dKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g8a/6QFF5xRiCzUNrWvuGv54lLv2MelL/M6fpnjm+mE=;
        b=GHagRumonbgZQ/LFmEX35rPO4HKi4L8q8duCwy8zXDWbIEn0qJ6G5Zk0BBVoHyLMtV
         HebMysdfizD1BvRkOBR2w3RtaaTf+HH4KAnutLJdV7Ly5y2r2M4hvv3BQAoKdBKrJSLE
         WyIJo9/ZVFaNOeHd9U4uCbsdVbdUYlpj+TX3HvyoUB8zTEdP+hXpqXF2j4tzcaiU9oNE
         RWDYxYhRWkxdF6j2XehkUAfBal85KE6I4Z0jYcWz+2u1K1cuQr8WaC4lX0JLEKW8oZ/n
         WKjeJcw4yGLGWRpXDS0ZsqvYsj0Ard7zIWTHlq0S1+rwZwIotG6Tc3ihaiM2w5zGA9eX
         d+cw==
X-Gm-Message-State: APjAAAUQjDqBCqh5VaAHg5uFMThTujbUyO1PBBTLPK5dPp9WUlpfZ+z5
        5psz07DYRhqfErUgzXyG6qNoHg==
X-Google-Smtp-Source: APXvYqy0yJqHy7SLu5l3UTNY9ieJ1AKo6BZohXk0a0d9iyKimrd7Ofl3DtX2hdT8JCXiEtaeTv/hTA==
X-Received: by 2002:a1c:6341:: with SMTP id x62mr3087409wmb.11.1553261469218;
        Fri, 22 Mar 2019 06:31:09 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id o15sm4684345wrj.59.2019.03.22.06.31.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 06:31:08 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 0/4] ARM: da850: enable cpufreq in DT mode
Date:   Fri, 22 Mar 2019 14:31:01 +0100
Message-Id: <20190322133105.5945-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series adds cpufreq-dt operating points for da850 boards supported
with device tree (da850-lcdk, da850-lego-ev3, da850-evm) and also
includes a fix for the da850-evm boardfile which checks an unset variable
to determine the highest available frequency for cpufreq.

Last patch enables CPUFREQ_DT in davinci_all_defconfig.

v1 -> v2:
- use the VDCDC3_1.2V regulator as cpu-supply on da850-evm

Bartosz Golaszewski (2):
  ARM: davinci: fix cpufreq registration on da850-evm
  ARM: dts: da850-evm: enable cpufreq

David Lechner (2):
  ARM: dts: da850: add cpu node and operating points to DT
  ARM: davinci_all_defconfig: Enable CPUFREQ_DT

 arch/arm/boot/dts/da850-evm.dts         | 12 ++++++
 arch/arm/boot/dts/da850-lcdk.dts        | 31 ++++++++++++++
 arch/arm/boot/dts/da850-lego-ev3.dts    | 30 +++++++++++++
 arch/arm/boot/dts/da850.dtsi            | 56 +++++++++++++++++++++++++
 arch/arm/configs/davinci_all_defconfig  |  1 +
 arch/arm/mach-davinci/board-da850-evm.c | 12 +-----
 6 files changed, 131 insertions(+), 11 deletions(-)

-- 
2.20.1

