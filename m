Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E291CC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B382B214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=techveda-org.20150623.gappssmtp.com header.i=@techveda-org.20150623.gappssmtp.com header.b="rk8JETip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731787AbfHFNT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:19:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43511 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfHFNT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:19:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id 4so30874835pld.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 06:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=techveda-org.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=IBYvx+JN3Tfby2a0Arr9iQ+FXDdmq2f9yE3G5sV6sLw=;
        b=rk8JETipFCVycaKi9C2t1/NXX6S9JXK3Kci+dufck79btVc+OPSWTY8bo4+JdQvNzs
         wc1xY+HSpCBWg/RHE54WVzhNLjtfMVV/9fWb6Gofl9zZ5Rnoc3ec5Tj1x3+tfXZYCIoJ
         5q9fWxc/tE1GE2rHWpJU6uA4KWYY4+jqCFmbJ8WMZR6TpZluBcCuBL2AwVKzm2pejAX6
         o91L5g3Peu2pH06dFOlmxN5mVeBDBMxITfy40Qz3cFDYUp8uWOWJ87OGWdQMf9Z2+q8e
         yt2SVZpZGFSJfw7WqFr/mSqe7crd3spigbpomxSqXHHbMZTjByf2z957ggO8c0sVs7Ev
         JC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=IBYvx+JN3Tfby2a0Arr9iQ+FXDdmq2f9yE3G5sV6sLw=;
        b=rbRVaFGPrs6jcZ2sApqQbstpZ/V9OrfcRo8ltAiqRANzE9Zp2n/FyUXA0+kS+TPjpe
         J1OmFBEqQBAeI5uwZmcPE3OrI+gc5cvvuMQP2FqVwlBwWuTD2Qp/ogdATSxBAAjqyAPq
         wsn5ry1WVmxLgd3NRfcjZQqMPdP87WvfgCM1l7S7S1kCiUlHcRfGyX/nMLMHQf30ETeg
         s9SYUQwsu9AmH25+mpXD8QzW/eFNee6eHjBpgTnsIf0zPAfqlvoTZJrg/9kS+VrSxFug
         zvFznMNXiXW79XeiwtLzNlc5/rAfzb7zOWOvuwUjRA3haDZx8uGhPjbf112Q/ipAhAji
         XC8A==
X-Gm-Message-State: APjAAAWZlhnBi6kK+jv0njBpBI5sMTc8gt9hFd7lQ1Atv6UROExbE0Hi
        1MhK76sLDL0Eluegh09XkVhpsre9NfU=
X-Google-Smtp-Source: APXvYqx17DAM1y2MpTGW4R9yvKYeLMnLAnm2Qpx44e6ubvVEIXtRpAvdyjcfrquxR5V+ZpCsaGThZw==
X-Received: by 2002:a17:902:100a:: with SMTP id b10mr3120380pla.338.1565097597255;
        Tue, 06 Aug 2019 06:19:57 -0700 (PDT)
Received: from [192.168.1.3] ([49.204.224.178])
        by smtp.gmail.com with ESMTPSA id n185sm75009415pga.16.2019.08.06.06.19.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 06:19:56 -0700 (PDT)
From:   Suniel Mahesh <sunil.m@techveda.org>
Subject: Machine specific static mappings iotable_init(), are they required ?
To:     linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     thomas.petazzoni@free-electrons.com
Message-ID: <a0d03054-b583-2d6b-aa32-e0f453767b88@techveda.org>
Date:   Tue, 6 Aug 2019 18:49:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to port a machine based on arm926 with MMU, having 64MB of RAM.  

I am trying to understand the difference between: 

machine specific static I/O mappings which are done via iotable_init()
(done via callback .map_io in DT_MACHINE_START) and 
dynamic I/O mappings done via ioremap()

In the kernel docs/mailing list, I have encountered a statement which states:

"with machine specific static I/O mappings which are done via iotable_init(), 
registers can be mapped at the upper end of vmalloc area so that one can use as
little of the VA space as possible so vmalloc and friends have a better chance of 
getting memory"

I am writing board initialization C file and got stuck at .map_io callback function,
whether to define it or not. If yes, under what scenario should I do it

now-a-days I think less boards are using iotable_init(). (is this defunct) ? 
I might be wrong here

Can't I use ioremap and do dynamic mappings when ever required via device tree ?
If I do so will I encounter any problems with vmalloc area.


Thanks & Regards
-- 
Suniel Mahesh
