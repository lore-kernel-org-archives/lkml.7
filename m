Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F21C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805B52196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U8B4vmxp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfJKA2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:28:37 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43201 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbfJKA2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:28:31 -0400
Received: by mail-lj1-f193.google.com with SMTP id n14so8001802ljj.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 17:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZXAfjdX+WvsCZ4Putv4iaBG542bdy+GxK4sst7rF5S0=;
        b=U8B4vmxpgfJnzBiDJsbyyQvQCGTuwkGq440RprVd0W/jBwPaWulfeCmeD7ZzaIVdWh
         PBT2V1HNzKuxn9toI+ubYWKykuXxFguzRYTDd8aU43+pbuXMFAXCOFHgx8OTesJKeHiP
         u8fxXTOmnvuWqXYlx3MeAD2HpWswrvkvtw0QVFQ1TgcOPxhyNo1fHUaNodXg+eVN8lHz
         lyUqk+Nwewllbi0cPmn0R28no3ae8PrTbX1i54WHZxoYPkI0ILgtCmFu+vOGKLD3Eskz
         vjscmyBfhit3N498RUoFIS4ShuUVwWFD8rcLhkMAMURHLcw3iCv8D598o9x/C5n1OoqD
         dIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZXAfjdX+WvsCZ4Putv4iaBG542bdy+GxK4sst7rF5S0=;
        b=m/XmnR5Mc5y8v0FdR5T3USIo4SwuJvjnbJy8k+3U5tObDA+WkQpb1+MUjrhaLRrydu
         YzpyTg3GVyXomHhaYqyFYDMGkvkdodm0mvLkoiOGXSI0CvRSoyFbxmlFkP6WiUemkFiS
         HLuPqWDuuUiV/E6gWW70LJiLW914EGvjdLvVqbt906iWQP+PZm073Cud5CbomtOQ79B8
         i01J1YlfSFUKLiv8uKhYADWHVAVvMX2SDYlpZ9Ewe8B2Nn94Gnl9XYc37NvSnAAgrxYq
         TdX+OErOBJ4EnrNeUrb+caDX1B45nTbgmsNJCaeAwHNCkp1xWMjDJmgnpvkz/4gWNOVu
         nCEA==
X-Gm-Message-State: APjAAAUOXgY8J5ZKyFcnod0ZF2K5nXmqdG3oSFRi27EsA5CiSFfn8X8v
        OnaVJfBBSG5POm+NQY9hefaRvw==
X-Google-Smtp-Source: APXvYqwArHNK6yFOGfNBm56dLOLa/ki3fV+x83BMbZjybbtZFF/vhXt8lhYHjA0KBaEmMKXer8mkYA==
X-Received: by 2002:a2e:9890:: with SMTP id b16mr7075689ljj.153.1570753709112;
        Thu, 10 Oct 2019 17:28:29 -0700 (PDT)
Received: from localhost.localdomain (88-201-94-178.pool.ukrtel.net. [178.94.201.88])
        by smtp.gmail.com with ESMTPSA id 126sm2367010lfh.45.2019.10.10.17.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:28:28 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v5 bpf-next 06/15] samples/bpf: drop unnecessarily inclusion for bpf_load
Date:   Fri, 11 Oct 2019 03:27:59 +0300
Message-Id: <20191011002808.28206-7-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
References: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop inclusion for bpf_load -I$(objtree)/usr/include as it is
included for all objects anyway, with above line:
KBUILD_HOSTCFLAGS += -I$(objtree)/usr/include

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 9b33e7395eac..bb2d976e824e 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -176,7 +176,7 @@ KBUILD_HOSTCFLAGS += -I$(srctree)/tools/testing/selftests/bpf/
 KBUILD_HOSTCFLAGS += -I$(srctree)/tools/lib/ -I$(srctree)/tools/include
 KBUILD_HOSTCFLAGS += -I$(srctree)/tools/perf
 
-HOSTCFLAGS_bpf_load.o += -I$(objtree)/usr/include -Wno-unused-variable
+HOSTCFLAGS_bpf_load.o += -Wno-unused-variable
 
 KBUILD_HOSTLDLIBS		+= $(LIBBPF) -lelf
 HOSTLDLIBS_tracex4		+= -lrt
-- 
2.17.1

