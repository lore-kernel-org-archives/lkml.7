Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B58FC3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 07:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2AB2173B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 07:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="K4dqBQMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfHQHTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 03:19:40 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:32965 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfHQHTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 03:19:40 -0400
Received: by mail-wm1-f46.google.com with SMTP id p77so4592262wme.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 00:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=TfeqkMlVoPddfWtkY+wqI3/i7NHYcDpPpZgdcpI+FMY=;
        b=K4dqBQMebWdjZKT8Kcxw6wpXoSp1Mn8c/epEiy0vnLXhWsptnhv99s2ksyrM2quR05
         qL8Z+KaJPVwLDeEdFAJyUaGcg39KI1vuEFuHaRhDy7bWy3nQUpvtMtfoXp3pajFYWgzL
         HEW+stu9AbvxqNEJZMfKqi+LMv/NyTYrzpNxAGi4MJHVpRcDLK60J1Dp2Tjz2+9Q6rrl
         JuCVX2Trc9EtCTayCML9HWI/itF9h+904vmPJlpZ4VAqAIY4K7jENajzFVve1mxjKp02
         Yi+IZGZ3PlF6aYGt9G8Ie2d5QKeLs47jeZ3EyTz1B8iu+j0QikRb4Y2W25rI9LZxSHvo
         9OdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=TfeqkMlVoPddfWtkY+wqI3/i7NHYcDpPpZgdcpI+FMY=;
        b=KPtwOE/2h8RFM0Oljn01q9H7XNM7BRqRTcUDnuoOKaxBucfODb30b/ZjGMrHnbiaQO
         GOc4blWXomKhMHXvgOD/MIfkWao+BWEncbdBUzvMAU5ndERfaZUGArXfgghxWYmWGIXo
         eGukzAbNMmX0PTzZTJ9IixToCD4I/IG//3thJtspxKFVAzevmJw9NT/ypun85bbH7PwC
         DpBK+qPo+4ci0Nhls6h4KUKi45u9LLD/815mYZ6bjD5YMO1FeIYZP+qlo+eAz8Y9wPbt
         AxJ92VR/Htq39B+KcZgrD976WfH3EJuoXkohMVA6L1Mv9GYobQsO5rKb27h7fTWMxJeU
         XU9A==
X-Gm-Message-State: APjAAAXinRNxIJDaaTQtmcln9RBpnNyfUyX172hqGDtN1zNSqcgXteQs
        9LLm47K1Rch1WnWhUh1ql0vBXYqI
X-Google-Smtp-Source: APXvYqwo2I8LHtxQWzYyBfnH+VK4vyBiN3LjaBgHzxyHAWrJ0kRWYNsmgoyNMlsHR95O/7YMn0mDYw==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr10679186wmc.6.1566026376979;
        Sat, 17 Aug 2019 00:19:36 -0700 (PDT)
Received: from [192.168.1.20] (host86-151-115-73.range86-151.btcentralplus.com. [86.151.115.73])
        by smtp.googlemail.com with ESMTPSA id n14sm23470201wra.75.2019.08.17.00.19.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Aug 2019 00:19:36 -0700 (PDT)
To:     LKML <linux-kernel@vger.kernel.org>
From:   Chris Clayton <chris2553@googlemail.com>
Subject: iwlwifi: microcode SW error detected
Message-ID: <42e782e0-78be-b3d4-d222-1a75df35b078@googlemail.com>
Date:   Sat, 17 Aug 2019 08:19:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I just found the following error in the output from dmesg.

[ 4023.460058] iwlwifi 0000:02:00.0: Microcode SW error detected. Restarting 0x0.
[ 4023.460178] iwlwifi 0000:02:00.0: Start IWL Error Log Dump:
[ 4023.460179] iwlwifi 0000:02:00.0: Status: 0x00000080, count: 6
[ 4023.460180] iwlwifi 0000:02:00.0: Loaded firmware version: 46.93e59cf4.0
[ 4023.460181] iwlwifi 0000:02:00.0: 0x000022CE | ADVANCED_SYSASSERT
[ 4023.460182] iwlwifi 0000:02:00.0: 0x0590A2F0 | trm_hw_status0
[ 4023.460182] iwlwifi 0000:02:00.0: 0x00000000 | trm_hw_status1
[ 4023.460183] iwlwifi 0000:02:00.0: 0x00488472 | branchlink2
[ 4023.460183] iwlwifi 0000:02:00.0: 0x00479392 | interruptlink1
[ 4023.460184] iwlwifi 0000:02:00.0: 0x00000000 | interruptlink2
[ 4023.460184] iwlwifi 0000:02:00.0: 0x0000012C | data1
[ 4023.460185] iwlwifi 0000:02:00.0: 0x00000000 | data2
[ 4023.460186] iwlwifi 0000:02:00.0: 0x04000000 | data3
[ 4023.460186] iwlwifi 0000:02:00.0: 0x42001A44 | beacon time
[ 4023.460187] iwlwifi 0000:02:00.0: 0x4E9F05CD | tsf low
[ 4023.460187] iwlwifi 0000:02:00.0: 0x000000D8 | tsf hi
[ 4023.460188] iwlwifi 0000:02:00.0: 0x00000000 | time gp1
[ 4023.460188] iwlwifi 0000:02:00.0: 0xEF55F6D0 | time gp2
[ 4023.460189] iwlwifi 0000:02:00.0: 0x00000001 | uCode revision type
[ 4023.460190] iwlwifi 0000:02:00.0: 0x0000002E | uCode version major
[ 4023.460190] iwlwifi 0000:02:00.0: 0x93E59CF4 | uCode version minor
[ 4023.460191] iwlwifi 0000:02:00.0: 0x00000321 | hw version
[ 4023.460191] iwlwifi 0000:02:00.0: 0x00C89004 | board version
[ 4023.460192] iwlwifi 0000:02:00.0: 0x0A05001C | hcmd
[ 4023.460192] iwlwifi 0000:02:00.0: 0xA2F93802 | isr0
[ 4023.460193] iwlwifi 0000:02:00.0: 0x00040000 | isr1
[ 4023.460193] iwlwifi 0000:02:00.0: 0x00001802 | isr2
[ 4023.460194] iwlwifi 0000:02:00.0: 0x40417DCD | isr3
[ 4023.460195] iwlwifi 0000:02:00.0: 0x00000000 | isr4
[ 4023.460195] iwlwifi 0000:02:00.0: 0x0A04001C | last cmd Id
[ 4023.460196] iwlwifi 0000:02:00.0: 0x00018802 | wait_event
[ 4023.460196] iwlwifi 0000:02:00.0: 0x00004A88 | l2p_control
[ 4023.460197] iwlwifi 0000:02:00.0: 0x00000020 | l2p_duration
[ 4023.460197] iwlwifi 0000:02:00.0: 0x000003BF | l2p_mhvalid
[ 4023.460198] iwlwifi 0000:02:00.0: 0x000000EF | l2p_addr_match
[ 4023.460198] iwlwifi 0000:02:00.0: 0x0000000D | lmpm_pmg_sel
[ 4023.460199] iwlwifi 0000:02:00.0: 0x19071250 | timestamp
[ 4023.460199] iwlwifi 0000:02:00.0: 0x14C0E8E8 | flow_handler
[ 4023.460257] iwlwifi 0000:02:00.0: 0x00000000 | ADVANCED_SYSASSERT
[ 4023.460257] iwlwifi 0000:02:00.0: 0x00000000 | umac branchlink1
[ 4023.460258] iwlwifi 0000:02:00.0: 0x00000000 | umac branchlink2
[ 4023.460258] iwlwifi 0000:02:00.0: 0x00000000 | umac interruptlink1
[ 4023.460259] iwlwifi 0000:02:00.0: 0x00000000 | umac interruptlink2
[ 4023.460260] iwlwifi 0000:02:00.0: 0x00000000 | umac data1
[ 4023.460260] iwlwifi 0000:02:00.0: 0x00000000 | umac data2
[ 4023.460261] iwlwifi 0000:02:00.0: 0x00000000 | umac data3
[ 4023.460261] iwlwifi 0000:02:00.0: 0x00000000 | umac major
[ 4023.460262] iwlwifi 0000:02:00.0: 0x00000000 | umac minor
[ 4023.460262] iwlwifi 0000:02:00.0: 0x00000000 | frame pointer
[ 4023.460263] iwlwifi 0000:02:00.0: 0x00000000 | stack pointer
[ 4023.460263] iwlwifi 0000:02:00.0: 0x00000000 | last host cmd
[ 4023.460264] iwlwifi 0000:02:00.0: 0x00000000 | isr status reg
[ 4023.460278] iwlwifi 0000:02:00.0: Fseq Registers:
[ 4023.460282] iwlwifi 0000:02:00.0: 0x0568FC22 | FSEQ_ERROR_CODE
[ 4023.460289] iwlwifi 0000:02:00.0: 0x00000000 | FSEQ_TOP_INIT_VERSION
[ 4023.460297] iwlwifi 0000:02:00.0: 0xDFFC324F | FSEQ_CNVIO_INIT_VERSION
[ 4023.460304] iwlwifi 0000:02:00.0: 0x0000A371 | FSEQ_OTP_VERSION
[ 4023.460312] iwlwifi 0000:02:00.0: 0xC338B29A | FSEQ_TOP_CONTENT_VERSION
[ 4023.460319] iwlwifi 0000:02:00.0: 0xD9E91E16 | FSEQ_ALIVE_TOKEN
[ 4023.460327] iwlwifi 0000:02:00.0: 0xAC99E6BF | FSEQ_CNVI_ID
[ 4023.460334] iwlwifi 0000:02:00.0: 0x07665623 | FSEQ_CNVR_ID
[ 4023.460342] iwlwifi 0000:02:00.0: 0x01000200 | CNVI_AUX_MISC_CHIP
[ 4023.460349] iwlwifi 0000:02:00.0: 0x01300202 | CNVR_AUX_MISC_CHIP
[ 4023.460357] iwlwifi 0000:02:00.0: 0x0000485B | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
[ 4023.460413] iwlwifi 0000:02:00.0: 0x0BADCAFE | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
[ 4023.460421] iwlwifi 0000:02:00.0: Collecting data: trigger 2 fired.
[ 4023.460424] ieee80211 phy0: Hardware restart was requested
[ 4024.639366] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DRAM
[ 4024.753171] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DRAM
[ 4024.817999] iwlwifi 0000:02:00.0: FW already configured (0) - re-configuring
[ 4024.829374] iwlwifi 0000:02:00.0: BIOS contains WGDS but no WRDS

The output messages from the driver when the system starts are:

[    3.667365] iwlwifi 0000:02:00.0: enabling device (0000 -> 0002)
[    3.670357] iwlwifi 0000:02:00.0: Found debug destination: EXTERNAL_DRAM
[    3.670360] iwlwifi 0000:02:00.0: Found debug configuration: 0
[    3.670525] iwlwifi 0000:02:00.0: loaded firmware version 46.93e59cf4.0 op_mode iwlmvm
[    3.723845] iwlwifi 0000:02:00.0: Detected Intel(R) Wireless-AC 9260 160MHz, REV=0x324
[    3.735117] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DRAM
[    3.735250] iwlwifi 0000:02:00.0: Allocated 0x00400000 bytes for firmware monitor.
[    3.780700] iwlwifi 0000:02:00.0: base HW address: a4:c3:f0:6d:9f:7a
[    7.919068] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DRAM
[    8.037667] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DRAM
[    8.104305] iwlwifi 0000:02:00.0: FW already configured (0) - re-configuring
[    8.119477] iwlwifi 0000:02:00.0: BIOS contains WGDS but no WRDS


Happy to provide more diagnostics if necessary and to test any fixes, but please cc me as I'm not subscribed.

Chris
