Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E131C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A865206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IIW6uXWw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbfJIOlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:41:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46634 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfJIOlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:41:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id o18so3308970wrv.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 07:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I5d3DNfj3UA6KCjceYDwu/vM6pXPJTm3mAV1n/RYi9A=;
        b=IIW6uXWw5x6h2gZOH1bqnOvRlhorhjV9jCwS2rEyxcthChqC/RTW4YZiDTLs0vUeBP
         oIPFNYSP2BZ6aIxfOOlqNuyb3qJVJzD3j3hhGsIQ9ks9r4F9MOLEAkLWSyJeCmKcxTyj
         73LkoLXYwGIRBhEF8VlApWMxBSK7W28Fnr12pQnplIAjbla6RO50zow77gJdKLzea+oU
         ge8f3HhETu3p9GDeI6cduaG3KIKcF+U9ElMQ75+TeVUGnPzkdDqKHMHZNt4h536jTMmp
         ydhn7xfWECh6los8gITwTucinPO00zgWNYoGu/4lODL0uGbg2ZCxH93G3U/NrhE06/Lh
         0klw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I5d3DNfj3UA6KCjceYDwu/vM6pXPJTm3mAV1n/RYi9A=;
        b=MWcfx582Uq0qWq6uiX1ImQO+I0Lp0s4M5Q/6fLX5GYs+jji1US8wzx7mUhc9oGjw+t
         SMi9fSET0XozaZdmtnPlebljiBEBH91/iVz3SjPBfy43Bjv9P0rRHWzjMaJdjTnHhwrG
         Sgm5xVsT0IuxGj7S5dUN8tna0PC/2as37sbElyfHy+2WRzcQm10CZnaGeYIIZ2QlJCJ8
         AjNG5ck1ikxLUOktz0mhAiEM6fRlyvM25txOeL3SXkivbCZz1595ar0r+fDLExuVqIgb
         W94qbhksBslwXuYetJ4YQXkpKCODKTauwUsyMyJqMgl1FRA3APw3wrFhbirEqJdeQKxt
         5qMQ==
X-Gm-Message-State: APjAAAXqs+esc1Of5p6MBINlnxZaZc//iOknsgJ5c9vz2lRo3kSvqvFI
        IahdL3gAloOmqJzmvvHlP3by02t1DFc=
X-Google-Smtp-Source: APXvYqxlxa+gEM60N5SSZPMVXZ7GuaOPp8KqZKR6xvVmxXDmOaFWjFL2GPgWfjtjdbmt+kwl27BoYA==
X-Received: by 2002:adf:e28f:: with SMTP id v15mr3560520wri.17.1570632089602;
        Wed, 09 Oct 2019 07:41:29 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id b7sm3031770wrx.56.2019.10.09.07.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 07:41:28 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/5] misc: fastrpc: fixes and map/unmap support
Date:   Wed,  9 Oct 2019 15:41:18 +0100
Message-Id: <20191009144123.24583-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

These patches implement a few fixes identified while working on the
QCS404 ML integration plus we now have support for mmap/unmap of
buffers (so the process can be created with less initial memory
requirements).

Thanks,
srini

Jorge Ramirez-Ortiz (4):
  misc: fastrpc: add mmap/unmap support
  misc: fastrpc: do not interrupt kernel calls
  misc: fastrpc: handle interrupted contexts
  misc: fastrpc: revert max init file size back to 2MB

Srinivas Kandagatla (1):
  misc: fastrpc: fix memory leak from miscdev->name

 drivers/misc/fastrpc.c      | 209 ++++++++++++++++++++++++++++++++++--
 include/uapi/misc/fastrpc.h |  15 +++
 2 files changed, 213 insertions(+), 11 deletions(-)

-- 
2.21.0

