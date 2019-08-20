Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479A2C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1C722DBF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NCf+aQCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbfHTNlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:41:14 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45763 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730341AbfHTNlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:41:12 -0400
Received: by mail-lf1-f67.google.com with SMTP id a30so4148544lfk.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 06:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qKDCjGrUGEITn9keK4O4wSbQw8s60BA2KTQLoKiFzno=;
        b=NCf+aQCLyOPmICxmwDK6V0Xcg9NK5tJa5uZ4tFopVmo3qpZW6uFwm9JMgevQtG9Qns
         hGHjeb0UzJ7k09qOfUkp4Tql14PTk9unwPbaHn939zgf4VvQG10w3MfUxWZjjoCKatxl
         EPG7eYhW6U7R91XYDZNKBKlrBYpL8eES3GJDUgi5sZdP7nqOjqr3C28o5/77BHkLSvqF
         Fc5OouIJ09I1e4/Qzl0Aw9X/1cvzsuWb4o3+kehRU8k3RCQV2jdLDOmi2XICAYA8O50t
         UC9Rsy6Wxa5j/F4H6Kjn2u4Dj9hkiAVk1c/6idfukQi4nLlZwGfGWAdkhlgEdvk2An7m
         3X9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qKDCjGrUGEITn9keK4O4wSbQw8s60BA2KTQLoKiFzno=;
        b=BaJJoAGiUdIMCvv2WfFqNK5vIjDLS7MT+RJkHLYplIEcK1zpKhSrsIaF/V1DPmRdGl
         alM7qwLMLOgCCE5m3gTsRdcWQsUUMyjCNc3Nt8W4N7f3rWbV3fpf94u79u2K/XMr9OGA
         /R7xQnzKBkCeDEkQRhVVhDd0M6jZXEqe2EohDovkMaEoFT8jRjBp/QktxXnep5OclOw6
         66OcgHD+zZ0JTld6VbjlJ502kFzb1pnAwCAP32B9NxFV/DSHuXkpg6Z8PRf7I5EKNnzu
         ZaeMYyIQRlPw4uE4ICVNgu0LlXia9tu1uTTAF1k8QsIQi8XO8zzMDoq7fXBCgnH1/Hd5
         o4gQ==
X-Gm-Message-State: APjAAAX1TL/J2mz2wwaPZxxFLb6Fo8+T5v23MQ/8UfpthctmO0IyAKi5
        EdsafHYGJvRFMyHVov+Em5zs1w==
X-Google-Smtp-Source: APXvYqxttx78GtX0vd5yiKKkdqsdz1pehalivWVgs1kXk1dF/0y8Iyrv4JOoqygWTduXugZhAZBz6w==
X-Received: by 2002:a19:a416:: with SMTP id q22mr15652060lfc.145.1566308470396;
        Tue, 20 Aug 2019 06:41:10 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id d3sm2867007lfb.92.2019.08.20.06.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 06:41:09 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     davem@davemloft.net, shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: net: add missing NFT_FWD_NETDEV to config
Date:   Tue, 20 Aug 2019 15:41:02 +0200
Message-Id: <20190820134102.25636-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running xfrm_policy.sh we see the following

 # sysctl cannot stat /proc/sys/net/ipv4/conf/eth1/forwarding No such file or directory
 cannot: stat_/proc/sys/net/ipv4/conf/eth1/forwarding #
 # sysctl cannot stat /proc/sys/net/ipv4/conf/veth0/forwarding No such file or directory
 cannot: stat_/proc/sys/net/ipv4/conf/veth0/forwarding #
 # sysctl cannot stat /proc/sys/net/ipv4/conf/eth1/forwarding No such file or directory
 cannot: stat_/proc/sys/net/ipv4/conf/eth1/forwarding #
 # sysctl cannot stat /proc/sys/net/ipv4/conf/veth0/forwarding No such file or directory
 cannot: stat_/proc/sys/net/ipv4/conf/veth0/forwarding #
 # sysctl cannot stat /proc/sys/net/ipv6/conf/eth1/forwarding No such file or directory
 cannot: stat_/proc/sys/net/ipv6/conf/eth1/forwarding #
 # sysctl cannot stat /proc/sys/net/ipv6/conf/veth0/forwarding No such file or directory
 cannot: stat_/proc/sys/net/ipv6/conf/veth0/forwarding #
 # sysctl cannot stat /proc/sys/net/ipv6/conf/eth1/forwarding No such file or directory
 cannot: stat_/proc/sys/net/ipv6/conf/eth1/forwarding #
 # sysctl cannot stat /proc/sys/net/ipv6/conf/veth0/forwarding No such file or directory
 cannot: stat_/proc/sys/net/ipv6/conf/veth0/forwarding #
 # modprobe FATAL Module ip_tables not found in directory /lib/modules/5.3.0-rc5-next-20190820+
 FATAL: Module_ip_tables #
 # iptables v1.6.2 can't initialize iptables table `filter' Table does not exist (do you need to insmod?)
 v1.6.2: can't_initialize #

Rework to enable CONFIG_NF_TABLES_NETDEV and CONFIG_NFT_FWD_NETDEV.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/net/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index b8503a8119b0..e30b0ae5d474 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -29,3 +29,5 @@ CONFIG_NET_SCH_FQ=m
 CONFIG_NET_SCH_ETF=m
 CONFIG_TEST_BLACKHOLE_DEV=m
 CONFIG_KALLSYMS=y
+CONFIG_NF_TABLES_NETDEV=y
+CONFIG_NFT_FWD_NETDEV=m
-- 
2.20.1

