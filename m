Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4AAC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FD922DBF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZDi1SFp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730452AbfHTNlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:41:44 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39721 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730430AbfHTNll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:41:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id x4so5173542ljj.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 06:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gNuDQYJVmflL/Wny4LHIdiHjJtChxjlf3zzR+P07bYQ=;
        b=ZDi1SFp8FXJaCjqmp4zm/ByzXqtJBaAQvabUX02QHSb6SDgYVNy5d57jcfvwyT0dA5
         8fzbFhHg9LRNWdJpl72dppeSuclNMByTBbZmU1xF7nAeqeBmQRvhlMYjmaiXLE4LV8wa
         zxoY/hF5DCBbdn3mRlsGF/QKdWdyYmxwOQPdPchKF8HLcZypJV/Ukw61WnY3PsnFAK6u
         Q+YJvglENuW+ieeSkGQnazSrxJiAcBHbB6uLYLGz1AJ9h/LaCq1SaT3QhJAAHmVF4Fz7
         Q2G5T+L+zrAQfW0/HE1GXl6UCt7EAtJC8GptIXHJXVjn/yaRqmlb/VYXAa36kix3OPE7
         AUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gNuDQYJVmflL/Wny4LHIdiHjJtChxjlf3zzR+P07bYQ=;
        b=D6QC0+3gBlYiVebz3PnLeq0DBEvsBFgARIsqscWcJK2Dpoq17sX3Cr34sfwj9iiD5M
         jaGQb76T5cw5PHFiWppl1OW91jxOAGU83DI5CMRz8EznJME2+jmrMFLbN2wCq388KZ4g
         DbbHz1q+0NdOaJhYVWqUDRlS6FLzA5dDOxyDuo3CqKKJS4WpRXsmeTyDZxB9VONRs2y1
         0QQlA50rdhsxJ7FDp5ZUepSN6NBDG2/56S22vB14Rb8AMdofdcZatn5r60MbWIo5yVUJ
         cmL/tadGsBJeZXuFza8GBm3C75+0QtqwJnER50mNRba1TXoL8JAlMspcyirHiCjyml2v
         4vfg==
X-Gm-Message-State: APjAAAXXYmmlH+TP7GEZLzDMie6uacyuZELEGfAzPuJmmw06fMkVHQWu
        LMAYOX08qNAtDUKlFNHq4jAqow==
X-Google-Smtp-Source: APXvYqxp8WgHlmWB1TJ1U6T1cdPC1f76z95rZGZ+Y6JhIi2z2/jagdLSnDlzo64tshfBrRxPu29rpQ==
X-Received: by 2002:a2e:b0cb:: with SMTP id g11mr15447861ljl.76.1566308499392;
        Tue, 20 Aug 2019 06:41:39 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id f22sm2820208ljh.22.2019.08.20.06.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 06:41:38 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: bpf: add config fragment BPF_JIT
Date:   Tue, 20 Aug 2019 15:41:34 +0200
Message-Id: <20190820134134.25818-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running test_kmod.sh the following shows up

 # sysctl cannot stat /proc/sys/net/core/bpf_jit_enable No such file or directory
 cannot: stat_/proc/sys/net/core/bpf_jit_enable #
 # sysctl cannot stat /proc/sys/net/core/bpf_jit_harden No such file or directory
 cannot: stat_/proc/sys/net/core/bpf_jit_harden #

Rework to enable CONFIG_BPF_JIT to solve "No such file or directory"

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/bpf/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index f7a0744db31e..5dc109f4c097 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -34,3 +34,4 @@ CONFIG_NET_MPLS_GSO=m
 CONFIG_MPLS_ROUTING=m
 CONFIG_MPLS_IPTUNNEL=m
 CONFIG_IPV6_SIT=m
+CONFIG_BPF_JIT=y
-- 
2.20.1

