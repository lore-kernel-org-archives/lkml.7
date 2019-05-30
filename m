Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB949C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891BC25663
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 09:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzF+DW8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfE3JjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 05:39:07 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:32833 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfE3JjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 05:39:07 -0400
Received: by mail-wm1-f48.google.com with SMTP id v19so5649885wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 02:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=JwUIsqd459o226NuphV7ZoRoN1/Y+yAcPXTD37P/UA0=;
        b=hzF+DW8s54OP7n03EIBYbHGiIWf5SysY90EfbriJhQAsi5vJDIfxzdAXJ/1Py+B4Au
         auCJpdbcU76qHptLRr4kstSFW8DgoyFYVkAEdi2ADyQPTpG/d5k9P0tCDTioy3IjFslb
         Dfo9wlRNyoA+18OZUyHkHCzfXGLuneIEx7nE4/8hnOV8RqYA5yhlviGSjI3W9KGlTtu5
         2rjfb6ziHmEgfUt6mfyjY2NDLI9kVg825U/LlgXFwUFi3zM1OQoNxMZ1kiTcwhc1neMX
         lSkV443d4+kEWXWHBDclteMw08mP4tVbx16eOo9miaB8s7PHpllRqCjllJF2Z/hLDAvx
         GQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=JwUIsqd459o226NuphV7ZoRoN1/Y+yAcPXTD37P/UA0=;
        b=h89R9GnpbPTPtStyAVpZSKJzTAOTXqokZuEabklA5g9IHPGFp9mSIwZjqBKCn3UjZt
         F6LS6kau/0d67mZb7pyBDBQUjS+1QUNTZUspJ11q5cfUZuu/MeNM1AhzXA0s+b39OmZs
         a5yWyrJ1Qzt2HgAab1epWwkuTg7sp0WGaCTprtDPS9gLTfdR4QLZQVCF15lM1IlGRfNA
         lJCZC0E6slKl/5ioQIPN40VQNwmSWTdxRGKi1CYsGssUyLZY5FBJPqzMszvLSGooyyOq
         0E4lghlW4NIspH80R0YEKh6j1j713xxyA/GUe9Zgp/KI8c3+SkZf3gJyyGQayedY4cby
         i5QA==
X-Gm-Message-State: APjAAAWAVCOhQFI/evBPANbSo+BxxHeABjeXjEgn031GhbjyNYIGAWkR
        ctZqvl06JA/NbVfL314ISCCYjW1O
X-Google-Smtp-Source: APXvYqzqymi9mIlfYjDD4MzTUjzL5E3k8/lhzrnArC0FefuQ6+UuqCaRXEGGSZnzOWoGIgt3zhoDyg==
X-Received: by 2002:a1c:9eca:: with SMTP id h193mr1640821wme.125.1559209144970;
        Thu, 30 May 2019 02:39:04 -0700 (PDT)
Received: from [192.168.1.51] (ip-78-45-105-225.net.upcbroadband.cz. [78.45.105.225])
        by smtp.googlemail.com with ESMTPSA id k125sm4893663wmb.34.2019.05.30.02.39.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 02:39:04 -0700 (PDT)
From:   Zdenek Kaspar <zkaspar82@gmail.com>
Subject: MDS/SSB Mitigation for pre-Nehalem/Older Intel Hardware?
To:     linux-kernel@vger.kernel.org
Message-ID: <ca61553a-1334-17e8-bcbe-335705cc8215@gmail.com>
Date:   Thu, 30 May 2019 11:39:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

on old CPU the current situation looks like this:

l1tf:Mitigation: PTE Inversion; VMX: EPT disabled
mds:Vulnerable: Clear CPU buffers attempted, no microcode; SMT disabled
meltdown:Mitigation: PTI
spec_store_bypass:Vulnerable
spectre_v1:Mitigation: __user pointer sanitization
spectre_v2:Mitigation: Full generic retpoline, STIBP: disabled, RSB filling

There's no way to mitigate some issues without microcode
and Intel doesn't provide new updates for old hardware.

The Deep Dive document for MDS includes: "software sequences
to overwrite buffers" but it goes back only to Nehalem.

Are there any plans for software fixes especially for older CPUs?

TIA, Z.
