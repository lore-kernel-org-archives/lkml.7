Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA89C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 05:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8F52070E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 05:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oC97eC5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgAGFr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 00:47:57 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41884 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgAGFr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 00:47:57 -0500
Received: by mail-pf1-f194.google.com with SMTP id w62so28028244pfw.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 21:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a5znaXZKlBTVMs68+b0GTeS4YJ7CQCUkofQQyekYzV4=;
        b=oC97eC5TLPVr7Jrsjlrnmc83ooVvbjeUIh3ZiqGqLoKtjrO4Ij8a1NAl9kCzOIwEYi
         6QeOXid2yQ70AjpokUwCI3BpCoRzJMahrUsFwLSC5xjTzfsNgMSolD8NCiEm9Vc3H2St
         ue4nnXeoi3Kbj+VXtdxCV0QwUbhqMSAj6tWsxwDwsHM67piQHOz98uWvEGo37Fetg33f
         W6k/zzB9NE6gCR3VKPVP9cQEcNnCUfYu8nY28qAnCKerlVIjSa4TeoYkvzF40FQvhOg+
         X8DFm1JQSs5iTA6seyPXtPnMDI8t0rUvSu9nNkHqLitJfH9/qIaWrVrBwTJUesTuEBX6
         EH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a5znaXZKlBTVMs68+b0GTeS4YJ7CQCUkofQQyekYzV4=;
        b=O5IjxNjSwZIEjdqQ63WORHqKmLJgzIl2dmlyW2UDSbycz6UO1ZfyX6V9jkb37Yg0sx
         9ZquXxygwAXIqceiwMqazDnKnqIxfupbHwFWBQjM/iL5xRQs7jAfqduGZZik1n8KuXDy
         6cqn+Grv0+HWR6edc0N510kQSIkrHPm/nxpVUpHZF4IyB5CkwV0XYCGuLuj5udZ/mM+I
         8PZdGE6rgZlTACmPmdo3bRKjW1nk/O58SrG1JD2w38rAGf1Ui3kU9KJIDJ9xH5Xsx7UY
         FEM0MV+yyf5aVwjiUxG/97BiOv+z+ePVMZ0Ii+RkVfx32ZST9V1ruNlZMDIo0O21y3wd
         7d7g==
X-Gm-Message-State: APjAAAWPJwRGIQeIWGZV106YXYchO/ItXINIAbaM1Qwqwu8oisCuzyIb
        Pc6SsL/Gx7O9ANzVQH2Mp4XgMA==
X-Google-Smtp-Source: APXvYqy2leZLuc9tAwF1AB/pqhfsi3mK/YIK7ZOzGsgaxNOLvQ9JQ/qFXE8LAge+Av32D8Bq/3Tvww==
X-Received: by 2002:aa7:9115:: with SMTP id 21mr81653278pfh.224.1578376076558;
        Mon, 06 Jan 2020 21:47:56 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k21sm67129177pfa.63.2020.01.06.21.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 21:47:55 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Chris Lew <clew@codeaurora.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 0/5] QRTR flow control improvements
Date:   Mon,  6 Jan 2020 21:47:08 -0800
Message-Id: <20200107054713.3909260-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prevent overconsumption of resources on the remote side QRTR
implements a flow control mechanism.

Move the handling of the incoming confirm_rx to the receiving process to
ensure incoming flow is controlled. Then implement outgoing flow
control, using the recommended algorithm of counting outstanding
non-confirmed messages and blocking when hitting a limit. The last three
patches refactors the node assignment and port lookup, in order to
remove the worker in the receive path.

Bjorn Andersson (5):
  net: qrtr: Move resume-tx transmission to recvmsg
  net: qrtr: Implement outgoing flow control
  net: qrtr: Migrate node lookup tree to spinlock
  net: qrtr: Make qrtr_port_lookup() use RCU
  net: qrtr: Remove receive worker

 net/qrtr/qrtr.c | 314 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 242 insertions(+), 72 deletions(-)

-- 
2.24.0

