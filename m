Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AA7C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5916E20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TvUJrQw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbfDPPlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:41:52 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:47909 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729226AbfDPPlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:41:51 -0400
Received: by mail-pf1-f201.google.com with SMTP id n63so14325807pfb.14
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 08:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=volERb+tc6n70vCQmrKM17XlywoBF9avKxr4ny+kra4=;
        b=TvUJrQw2whCWS8/qe5IgMgEwqgmHSFUxtfR9tpPUYzAixaCSA5wS0tvuMMOgpCZMbI
         g8DOy9/GVpL6iS72hH63C9B4/sfUbBlWhofgPgsvZAKG2CEKTOp4A9Qb2ImDUp6z+IAi
         zfXwLkwYtSbXyJLCx0Fsc46h76PADuZSWTNEKw2Blue74AuosRHkH4SBv8UTXL8b02G1
         D3cPz3zJbwzgMSBmKZpI+tsf6+eO5jNUUJP8dPqayXXH69DArJlt2WtqH3Qoe7yXxKL5
         YUFyE2r393N2CL2RiQldjvw3AZc01zoYWQA4EOdhguDPdEfsfykOaD1cjP6CtTzLHXpo
         kUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=volERb+tc6n70vCQmrKM17XlywoBF9avKxr4ny+kra4=;
        b=poqDhcUuPtMP2DUhMM3i1/sDSRNXrQkqOZgNm8WZVJubFW3lFhEkeFE2HyFhDvM3hb
         RT7bdEDyRczaQSh/YZ57u+fGtlGNG3W/aR/5x8cNZJ1LSoQsG5Z1X6sNUFWR/SWfmEz9
         g/EsydUoEphgP43LyX8ja9zC5UcEMU8J/Hd9Is4n3wMK9mbfHIp0chwaqQS4M2tG+zLA
         AKUJDU0un5HJZhEN243nmY8DPaLPfSXNxU6QV8gJFTir8JTmu9LgQ6tnMaW5oM75UCW2
         35UMC79yukZ2sohGutP4Q1XN7CKk/xRwKnmr1IHids5YOqQ3pXRoK4Y9RrfNQS7G2I+S
         mZWQ==
X-Gm-Message-State: APjAAAWkqtGgAJqUM7tkqlLpx0JalvmQabAIiMcrBZ0wP8YsxQrD6XRr
        dh6kN7mkCfiWWjpxfy23xjH3pgkokcPc
X-Google-Smtp-Source: APXvYqxsAQNeiU/3KrJrdjH7s1jTNT8zrNzD5GlDSa4XwR4oUjuT5WS8bSuuCdf0jkJhjfmai23ujoRsvgsH
X-Received: by 2002:a63:f47:: with SMTP id 7mr1180315pgp.75.1555429310637;
 Tue, 16 Apr 2019 08:41:50 -0700 (PDT)
Date:   Tue, 16 Apr 2019 08:41:47 -0700
Message-Id: <20190416154147.125602-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 2/2] dt-bindings: Add isl68137 as a trivial device
From:   Patrick Venture <venture@google.com>
To:     venture@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        trivial@kernel.org, linux@roeck-us.net
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The isl68137 is a digital output 7-phrase configurable PWM controller
with an AVSBus interface from Intersil.

Signed-off-by: Patrick Venture <venture@google.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 92184ef0db2e..747fd3f689dc 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -104,6 +104,8 @@ properties:
           - isil,isl29028
             # Intersil ISL29030 Ambient Light and Proximity Sensor
           - isil,isl29030
+            # Intersil ISL68137 Digital Output Configurable PWM Controller
+          - isil,isl68137
             # 5 Bit Programmable, Pulse-Width Modulator
           - maxim,ds1050
             # Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
-- 
2.21.0.392.gf8f6787159e-goog

