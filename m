Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3958C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 06:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8846A20881
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 06:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+uuMuAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfGBGhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 02:37:36 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:32806 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfGBGhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 02:37:36 -0400
Received: by mail-pf1-f180.google.com with SMTP id x15so7759957pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 23:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ZhvKZPBHtqlWYn5aQ+LHumK996S+XHbvPSVeWsaVn+Q=;
        b=d+uuMuAVs0xdXgQBW0Ib5RbKb2idX1BA+YdEAA6m21/+x6g59r0ikdCAKdl66g46i9
         4YxijYOFF+jdPv2VzrHyxnWrSlmOybtYgEncUTDIuTkQ7WPFjdOI9v6L5mPsUcqYSg9F
         VzGl2t07CQSj1caH4WFL7KsFjFmr72eLdWQQF1HcuzPiQ+5fmTfJmdBOq4khC0vq9IKE
         rygM+XCNw/pC4pmNrP6r/QX6BvuC0HAIFMySrLAS43FFe8Z2Dj6gsHOPMpeNj9t6nF+8
         iiZSQd4ehI3+aqU5GH7AxzzEIJV3QL0dxu3TKOaF2Druv9dSUmkcLO8NeG4/1kdcPm3i
         ThVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ZhvKZPBHtqlWYn5aQ+LHumK996S+XHbvPSVeWsaVn+Q=;
        b=ZV/iy/8tgC7dRDc+/Ni9W6fzitZrq05Db/ByK1GSvRk99CAnGBhsrt1SJSCTo8yoUY
         iBGFms0eq8iHjiBMA/DH+KGvrNwTZB649/65o7d2ZACnBiEpe8Pa2n099+In08Uwf98d
         KnhWr2+Ejh4hreMeOfo3eLD0UtrZODp9UeEM9nhZ/jaFo8tFfldcirIMBkwkDuJXtPOx
         ggh9Vmlnb7/RxjxY6sgPhU6ciTgifiF2l0p19TOo56TkzPe7ntD1XmqSdcjNcJDwS6k8
         ge1RQKWax9/Oh6P449NfrO+feEEwKtfVmzc19Infqq1oKgzVwm+gE35jK6/2VzGStY05
         T0MQ==
X-Gm-Message-State: APjAAAUgAtSZ6uAucuW9mRbmxS3gthbLlKwPXHL6dd7TO8DR75/rwSGN
        ul+mMoALrBFAZo4GnzluK0kO4mum
X-Google-Smtp-Source: APXvYqyBNH7kgsggP7hgvoNIjLAazXPBrAU3O7/+xZOUiiwKVm7RrMKFq8ppt8SOdiDLBRImLjWPoA==
X-Received: by 2002:a63:c14c:: with SMTP id p12mr29124787pgi.138.1562049455708;
        Mon, 01 Jul 2019 23:37:35 -0700 (PDT)
Received: from ?IPv6:2601:641:c100:83a0:50b6:82f3:beba:8d5e? ([2601:641:c100:83a0:50b6:82f3:beba:8d5e])
        by smtp.gmail.com with ESMTPSA id i36sm12697781pgl.70.2019.07.01.23.37.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 23:37:35 -0700 (PDT)
X-Mozilla-News-Host: news://gmane.comp.lib.uclibc.buildroot:119
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     linux-rpi-kernel@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>
From:   Tinchu <tinchu.nitrpr@gmail.com>
Subject: ARM setting up secure mode vector table
Message-ID: <4fb7db36-bce6-ea42-7dd8-91d71857697c@gmail.com>
Date:   Mon, 1 Jul 2019 23:37:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Apologies in advance for extra CC list.

I'm trying to hack linux kernel (v4.14 LTS) for Raspberry PI 3 (ARM32 build), to
enable early boot code switch to secure mode using SMC #0 instruction and return
(and later tinker with some secure mode registers).

While this may generally not be possible, it seems it just might for this platform
(i can do this on a baremetal library, but not kernel proper. Apparently the
current BCM firmware sets up secure, non secure  and monitor vector base addresses
to 0x00000000 before calling into zImage and all mem is writable for non secure
mode. See the gory details in ultibo pascal library code comments [1]. The trick
is to copy a vector table with SMC vector to address 0. I'm suspecting this not
working for linux as having to write the code in true position independent way.

Here's a rough hack to arch/arm/kernel/hyp-stub.S
I'm simply hacking in a vector entry into existing hyp vector table and then
copying it over to 0 (I've tried using a completely different table, which fails
in same way).

+	.macro sec_vec_install_run
+
+		mrc p15, #0, r4, c12, c0, #0
+		ldr r5, .LSecureVectorTable
+
+		/* 8 bytes of vector */
+		ldmia r5!, {r6-r7}
+		stmia r4!, {r6-r7}
+
+		ldmia r5!, {r6-r7}
+		stmia r4!, {r6-r7}
+
+		ldmia r5!, {r6-r7}
+		stmia r4!, {r6-r7}
+
+		ldmia r5!, {r6-r7}
+		stmia r4!, {r6-r7}
+
+		/* 1 word for secondary table */
+		ldmia r5!, {r6-r7}
+		stmia r4!, {r6-r7}
+
+		/*Clean Data Cache MVA */
+		mov r5, #0
+		mcr p15, #0, r5, cr7, cr10, #1
+
+		dsb
+
+		//Invalidate Instruction Cache
+		mov r5, #0
+		mcr p15, #0, r5, cr7, cr5, #0
+
+		//Flush Branch Target Cache
+		mov r5, #0
+		mcr p15, #0, r5, cr7, cr5, #6
+
+		dsb
+		isb
+
+		.arch_extension sec
+		smc #0
+
+	.endm


ENTRY(__hyp_stub_install_secondary)

+	sec_vec_install_run
...

+smc_hdlr:
+	/* do stuff later */
+	ret	lr
+ENDPROC(smc_hdlr)

.align 5
ENTRY(__hyp_stub_vectors)
__hyp_stub_reset:	W(b)	.
__hyp_stub_und:		W(b)	.
+ __hyp_stub_svc:	ldr pc, .Lhdlr2
- __hyp_stub_svc:	W(b)	.

...

+.Lhdlr2:
+	.word smc_hdlr
+.LSecureVectorTable:
+	.long  __hyp_stub_vectors


Can someone please tell me what part of code is wrong. Pretty much similar code
works in baremetal setup.

TIA

[1] https://github.com/ultibohub/Core/blob/master/source/rtl/ultibo/core/bootrpi2.pas


