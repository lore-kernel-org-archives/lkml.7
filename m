Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C77AC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7132721783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 12:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f23rjIBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbfJBMES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 08:04:18 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:36353 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbfJBMEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 08:04:15 -0400
Received: by mail-lf1-f48.google.com with SMTP id x80so12553324lff.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 05:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QRH9ZC+8Ny/msHWcjGNR4E0iaqUnOOF/L6UnfzfPUco=;
        b=f23rjIBkvLQp+jBBwDivqvjjR/UzmHdWYZ4YuKB85ScWs9VNgvA4l82vxQfSKKcZEP
         itqjeh+PE4szh6m8AkdQaJJxl6kUhJ8wJOarb5IdXg9vbAtL1XMIVR5GAnhstXFNND9/
         Tp4gkIs5PllRsdkpY0tfIKPIgCcuc2Jev1sSRm073Mp01icxsgnlr84wDdLUSQaXMP+k
         gdZUX1vY5UU14Jlni8T57B/T5LsGEjD7zT/IkovAMyovfrbBrh+A7DWt3m3hHZSCotdE
         2TdjRXRHjDwrrJHQpJb0i4AzX8eAXPkFYyS996qsFqApNUZqWLy6/4AJfn9J38+jDwIq
         Z0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QRH9ZC+8Ny/msHWcjGNR4E0iaqUnOOF/L6UnfzfPUco=;
        b=GSk/iLebknH8uhN9cPS4UefUNfKeD2Vcp3szW2gpNZh0lYrW5XtEdvwBQBRoPM/riy
         pPmoiDr6wDGfUfm0i4EfacbtaaBMKH6wvgHqiqlHsmh71HqRdCFcGJsFcV8uyKwpRO4t
         yYoZfezsjP6iPyZeaPYNls6zhuyqUqLRSDPXMz5RRTEqSKvLpnxEOAeJ2Oo4rH7OddAU
         +Pm5x0d9hl9nTgXsZbtiKHYWC6rOZZGOi/CBOZcouNscZMBHhIpkemUdqsL9iJFSB8B3
         VRatZtMKPwHKYj6vaB1tw1QKZdVhuXl/3xl1z+NwXtzH01aUIGbw2KE5zDqmXNwF1JIO
         XSKQ==
X-Gm-Message-State: APjAAAVaiDmNGI1SNJwwHqBzxPBr+pb7HIq6CEKHbe0k8idp4M8hytI8
        OgtqCPtqRDDIgWFnc5SmBx3RLA==
X-Google-Smtp-Source: APXvYqyyyNzF3fRohqc2QWfIhha0eeknjrB2f4OKPHr3+Ot91a5QKrvaEtH0TD3WHGORsSn1/bsxrg==
X-Received: by 2002:ac2:5925:: with SMTP id v5mr2150152lfi.8.1570017852633;
        Wed, 02 Oct 2019 05:04:12 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id x2sm4833827ljj.94.2019.10.02.05.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 05:04:11 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next 0/2] selftest/bpf: remove warns for enable_all_controllers
Date:   Wed,  2 Oct 2019 15:04:02 +0300
Message-Id: <20191002120404.26962-1-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This micro series fixes annoying warn described in patches
while samples/bpf build. Second patch fixes new warn that
comes after fixing warn of first patch, that was masked.

Ivan Khoronzhuk (2):
  selftests/bpf: add static to enable_all_controllers()
  selftests/bpf: correct path to include msg + path

 tools/testing/selftests/bpf/cgroup_helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.1

