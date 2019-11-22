Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC63C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 22:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558242070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 22:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TtdrSbZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfKVW5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 17:57:37 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:44654 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKVW5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 17:57:37 -0500
Received: by mail-io1-f41.google.com with SMTP id j20so9900325ioo.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 14:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uj2Ztb9iUAhbf9rH9PWOL69mPO/eEt+nZByhj8SBdF0=;
        b=TtdrSbZ13QpZA+903XTzpENZhwLPlCl3eTbFupVTijcqqQXV6OKHmcjVrRp3tzA7Kh
         moALB6g9sRrAlmWGrcMWWJsLVEWzpOBkn1rJN7CxBa5FdW/D1Y27t5zsnt7JWe2DOnLj
         OOWZzFSHbxZ25VHBCA8lM+IYM03/UDpIXO6fTmOSxP9PWgHutbno13uQEAiIuTeAaEQK
         FOBtW9im2KVSkmOpaGamtbEOiHXSJQjmQRBaRixtxtjgblZzHQCJ8NfGo3X7bfkdpZg0
         +jrlfl+a2emN/TBtXwWZndcuOpG6GZLLT++33jgsi3R4vp4pGRmBFvwgZASxW02JBv4Z
         n52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uj2Ztb9iUAhbf9rH9PWOL69mPO/eEt+nZByhj8SBdF0=;
        b=TNt7+b531BSngWxvCU5XslpP5W7mXecZcPLKCBA7bawMdvhvwyMHE83VBKMysDMsPk
         NKytbEYfapYYyRimBqw1pxWcROUXzwQaR0p+iuLK1rGPzhuWswo4loC4AzG9p6mkg5JR
         L9k6Gmkqhktd447REf/EBKY6ZaqxMzhWgtGqMKWqkR9KlV8z5E6EdV8iRDptQK22ksB+
         ++crlAFLNfi4Qdmz+TM7cPidS3hkNI10Iqc7jQVLhnDIQrvVRF/OCwHlCwpCGO7MMrYt
         Cjp3e4Zn6fwm2jMzOg9luXS+OKTfO2ryn5w429P+rg6YqsABGoLKOYUfZvRjbKXtvVu8
         bMCA==
X-Gm-Message-State: APjAAAU90B7WHgPIzMNmZEw2UGA8Is6rMtLGea+ZhA7ILD6w9NhLVLri
        KpFXq6fc8x/K/eUH1KUJshoaREPnXIY=
X-Google-Smtp-Source: APXvYqyDDR6XWNHRiIJMoWrs9+l4wDYNEH8Foe6GnyqUiQ3MqB9IEAxn9IL9m83C6JG2XUbIuXEZBQ==
X-Received: by 2002:a6b:c8cd:: with SMTP id y196mr8658070iof.266.1574463454895;
        Fri, 22 Nov 2019 14:57:34 -0800 (PST)
Received: from viisi.Home ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id x9sm3277098ilp.43.2019.11.22.14.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 14:57:06 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] riscv: defconfigs: enable debugging options 
Date:   Fri, 22 Nov 2019 14:56:57 -0800
Message-Id: <20191122225659.21876-1-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.24.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable more debugging options in the defconfig.  Debugfs is generally
useful for everyone; the other options are intended to make it easier
for developers and testers to catch problems earlier.


- Paul

Paul Walmsley (2):
  riscv: defconfigs: enable debugfs
  riscv: defconfigs: enable more debugging options

 arch/riscv/configs/defconfig      | 24 ++++++++++++++++++++++++
 arch/riscv/configs/rv32_defconfig | 24 ++++++++++++++++++++++++
 2 files changed, 48 insertions(+)


Kernel object size difference:
   text	   data	    bss	    dec	    hex	filename
6665154	2132584	 312608	9110346	 8b034a	vmlinux.rv64.orig
6779347	2299448	 313600	9392395	 8f510b	vmlinux.rv64.patched
6445414	1797616	 255248	8498278	 81ac66	vmlinux.rv32.orig
6552029	1921996	 257448	8731473	 853b51	vmlinux.rv32.patched

-- 
2.24.0.rc0

