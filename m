Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B441AC468BC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1D1206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="egnZVNmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbfFGPWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:22:48 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:39620 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbfFGPWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:22:48 -0400
Received: by mail-qk1-f177.google.com with SMTP id i125so1475702qkd.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 08:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=EXSmSWjcDB1szNpUZ4RnHlO+2EIGCfLRdk7Vv90DHik=;
        b=egnZVNmpT+xaStlzfGJh/0+mgbm9Y1D3frhr8us4SZ0cc+8P1SqFWwbZeJkeLGvBYg
         vmcQo+AQrNm94yjlLva8y/EE5ss3LNdbcCepnPnb0EMpW7lZ/jwdQE2CkTgFo6R1Qrpl
         itLjlfyRcl+/7ucoTB3iMRia0IuNop9r5ZoAY3ydtCpxEjME/kxXMUE+kg4QQxYBytVr
         AvdkvU9/fcAQrIjmbhID3rtrRQE8/wLVCjd9Zo1lhMWjVkAyAEkp3MhN4mv+yEfp8wdI
         MyrDrbYIiOYnkjZKhNkZCAcKTWYM86rPHzCFB9OU6EApBzC7mspDMr5dbZejDKGF5oT0
         8hLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=EXSmSWjcDB1szNpUZ4RnHlO+2EIGCfLRdk7Vv90DHik=;
        b=rLALlf9Shb/uxivu/9B0HPbJv8yd5V3ROZRgJMiwWXdlcSDstrxF9zzUwRCOQK+j4w
         QHizisHTYy8dSsBFPlWVH+VgnOhZrPH5oKUijhjoUs8hcvJgMgynIWVDV1Jx58otmu+u
         HuReKL7AblPQlZ/onyTPBIBvZ/Pob1jWWjeJtTZWnS4HFHuMtFOfE2u26GU1pzFtiOVB
         zkmzSWuGV9RD6aVY+x7wc537le8X3EQMlrOECdcDTny/13h+LueOie5klbV7aD/edXUB
         +s33r/yTthSNSYcj6/BlO5rY/75hBbUNbNZWwqMaJrpsL2aWe2nQ1Y5VLvcnY4HGOn7s
         mhmw==
X-Gm-Message-State: APjAAAUYcUYh09Qv9+2gaWuARE/OHzMJ1wYoVHpHUY8dv8euo1jc6Iue
        kT/1rXS8Wc611f8brVfm4/Btyw==
X-Google-Smtp-Source: APXvYqy2bl40AjAKSQ91cJSFv3ieqdq17wcLtP1KGmw5Lg/DXfJAm/maZoQXjHWA5ZhBJnnO2CAnjg==
X-Received: by 2002:a37:640f:: with SMTP id y15mr43201126qkb.79.1559920967395;
        Fri, 07 Jun 2019 08:22:47 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id k54sm1404799qtk.54.2019.06.07.08.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 08:22:46 -0700 (PDT)
Message-ID: <1559920965.6132.56.camel@lca.pw>
Subject: "arm64: Silence gcc warnings about arch ABI drift" breaks clang
From:   Qian Cai <cai@lca.pw>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org
Date:   Fri, 07 Jun 2019 11:22:45 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-next commit "arm64: Silence gcc warnings about arch ABI drift" [1]
breaks clang build where it screams that unknown option "-Wno-psabi" and
generates errors below,

[1] https://lore.kernel.org/linux-arm-kernel/1559817223-32585-1-git-send-email-D
ave.Martin@arm.com/

./drivers/firmware/efi/libstub/arm-stub.stub.o: In function
`install_memreserve_table':
./linux/drivers/firmware/efi/libstub/arm-stub.c:73: undefined reference to
`__efistub___stack_chk_guard'
./linux/drivers/firmware/efi/libstub/arm-stub.c:73: undefined reference to
`__efistub___stack_chk_guard'
./linux/drivers/firmware/efi/libstub/arm-stub.c:93: undefined reference to
`__efistub___stack_chk_guard'
./linux/drivers/firmware/efi/libstub/arm-stub.c:93: undefined reference to
`__efistub___stack_chk_guard'
./linux/drivers/firmware/efi/libstub/arm-stub.c:94: undefined reference to
`__efistub___stack_chk_fail
