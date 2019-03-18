Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67D1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8284A20863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJYr6ZfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfCRSEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:04:07 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37822 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbfCRSD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:03:57 -0400
Received: by mail-it1-f194.google.com with SMTP id z124so22778275itc.2;
        Mon, 18 Mar 2019 11:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HL7sqfAZpk5phRiscn+MgsnvWTRh03VbAEeyR0xDslo=;
        b=GJYr6ZfHpnN5VcIYPB8H2SogvaIh7gEf/9+I3T/Yq9Sj+kwhSnTytqS/Y/S6EVJruc
         k+y6vSxVZld4z4MOLmFTOT75T9fg9InYFK6anqd/jwdBfIBrsQmORt+oMcFlpS73tQoF
         4QiM0DLE61/dPpowN0xy2m/xtlpFArCJ93iIlBtaRu1zYWGsR7VguFV+xGfzcKaKci0h
         v2SQJ+4XLPSTTy2aWguSudvYsmjhGQwDhBPRopHD5loRTO5eTpbLX8o67EfwP0LzVH0J
         CWmMBbEbgLwdVDP0wz/SqZ3nPwvRzSYD29nCifX7eZPRIWpMl+f1NOh5ORAjlTk5P8kj
         7cjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HL7sqfAZpk5phRiscn+MgsnvWTRh03VbAEeyR0xDslo=;
        b=q/LLaOJDIrpwzEZP8BgUOuHDh8ycI1LyWmi5aEv0IQQfVw6DerklBvKvll4VzxhzLE
         fD+wg1PhQo/Va1uOv3hOxg84Zqz/igl+4YbwXyANbt8K7fjtV52is2qM59tBc0jh/6kS
         MBXqS63T1qMXqRmk8HO6bMS1/ZVyhsdqUx9NGQyNYI1TMg/ls9yxFRVWR9brjKoH4Ald
         a4ICxof7p3sk2ZYWReZMiBL6kEsAiQoyZzB7OOJZoH0N8plzSP0M7ftmXBFIvlgX+7DH
         K/oh3NNmFTT+GZNUF4nZfOfvT1SXgcFSJTv8rGMMVi+78IC2+5VcLTZP3guqbgyiD/Qz
         1L0g==
X-Gm-Message-State: APjAAAWkkk2q76UzMKXB57GuG4wXxsXzl2nHanDTBovoMlS9JslU402Y
        W/KVg70Q1NkIe0FKT3KTkP0=
X-Google-Smtp-Source: APXvYqwkuSovSU4hgzERhhl8EAleAQ/xL03O7Sa/o+SHrzRvyPIMfvuoxbE2vP33mKdO2ReJZ7RGQQ==
X-Received: by 2002:a24:338a:: with SMTP id k132mr69171itk.123.1552932235937;
        Mon, 18 Mar 2019 11:03:55 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id 76sm9956itk.40.2019.03.18.11.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 11:03:54 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     robh+dt@kernel.org, linus.walleij@linaro.org
Cc:     lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, jan.kiszka@siemens.com,
        maxime.ripard@bootlin.com, linux-kernel@vger.kernel.org,
        linux-netdev@vger.kernel.org
Subject: [PATCH v9 5/6] dt-bindings: Add vendor prefix for arcx / Archronix
Date:   Mon, 18 Mar 2019 14:03:37 -0400
Message-Id: <20190318180338.23964-6-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190318180338.23964-1-TheSven73@gmail.com>
References: <20190318180338.23964-1-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arcx Inc. is an engineering company which provides advanced
embedded systems and consulting services.

Archronix is a technology design and product engineering firm
specializing in hardware control systems and enabling software.
Clients include OEM's in the transportation, aerospace,
medical and commercial sectors.

Websites:
	http://www.arcx.com/
	http://www.archronix.com/

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 389508584f48..7c84df526018 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -35,6 +35,7 @@ aptina	Aptina Imaging
 arasan	Arasan Chip Systems
 archermind ArcherMind Technology (Nanjing) Co., Ltd.
 arctic	Arctic Sand
+arcx	arcx Inc. / Archronix Inc.
 aries	Aries Embedded GmbH
 arm	ARM Ltd.
 armadeus	ARMadeus Systems SARL
-- 
2.17.1

