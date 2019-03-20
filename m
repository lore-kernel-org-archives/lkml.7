Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92122C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD8821873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LORM5MVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfCTRf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:35:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45267 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfCTRf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:35:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id m16so2692369edd.12;
        Wed, 20 Mar 2019 10:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yxkFxOstgye8P+oM5yJDIcooGGf5Gy5OyQ9cdtrDtq4=;
        b=LORM5MVW4Ay6Ye/3qm3rR2RJ/oaoijM+bjZ1jrK8t6o5euW+5qEvyenxUgZAvXvgpI
         nvNowIUCkLTdtqepEF+UTlQioY5fnos47wpsrdeQN9bXh+YAxNM5hxtm6H1BCENvO2Ii
         kET9YS7QBPE/o6HvaQ5+RUvLadAUw9wkDLsRjSCImPHbfaMpcnFHgP70sB80UKpoBK3K
         3wg3X6HfvpeQy+obHzRrAGQVSZx6ICkOO+SOqcQ7vwMLd2fDKhaEGgqsWbxXcHhL9hzR
         Q77q/3umw6HD1Qx8gVOsurBP2B5v3hxVd4qJv2oagknRHj+cAl3VYOu225QxjV0CHU25
         fjbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yxkFxOstgye8P+oM5yJDIcooGGf5Gy5OyQ9cdtrDtq4=;
        b=GsIzGL65KGsfgGBnnxJ8m8A51KGngVlJ/F4CfZ+UeaPxMSnSbB21rZfxVMgIsuxIB4
         MnOnZWE3fWrS4Ic69fVhES//XC4bCKwiBHite1sRoqOiN60np/HDwTXpTB96G1iD5LBu
         CcQ4kml3TtgHTi3O+il5gVwQXmCSjQ8iu40WRpPRUsAPOo9cURj2iMZItf0xnQrvFA7C
         bUCnEwJMnYiA4ErHNDF1yzgLa9RPSJVN8Y6gBofBeWC/O9kZ1GGIetF+Gnra4L8hOMYV
         +nydbuCrTtuAm18rhrBOSVMh9NLqk26yqqmrZNMt2+GwxJ2txnAFwS0O8Ihrn7RvTWsE
         MlAQ==
X-Gm-Message-State: APjAAAXD03cfD5vXHX7GlVhZXDi4vKqZYsCst1wP3g0TPyPHVLnJ7s5e
        BTHy0N2S/bZhnoi+ycIQmsM=
X-Google-Smtp-Source: APXvYqxfnpN6jzM92LPKcFqrTc0aQjMfs0y3c+5e7+ygniaCMzYTeVX8FxqSt2hBMtVu+8w9KUXDyA==
X-Received: by 2002:a50:be05:: with SMTP id a5mr20795439edi.87.1553103355859;
        Wed, 20 Mar 2019 10:35:55 -0700 (PDT)
Received: from neptune.fritz.box ([178.19.216.175])
        by smtp.gmail.com with ESMTPSA id 5sm828606edp.50.2019.03.20.10.35.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 10:35:54 -0700 (PDT)
From:   Alban Crequy <alban.crequy@gmail.com>
X-Google-Original-From: Alban Crequy <alban@kinvolk.io>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alban@kinvolk.io, iago@kinvolk.io
Subject: [PATCH bpf-next v1 7/7] tools: bpftool: add error message on map pinning failure
Date:   Wed, 20 Mar 2019 18:33:32 +0100
Message-Id: <20190320173332.18105-7-alban@kinvolk.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190320173332.18105-1-alban@kinvolk.io>
References: <20190320173332.18105-1-alban@kinvolk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alban Crequy <alban@kinvolk.io>

Symptoms, when "dir" does not exist:

$ sudo bpftool map create /sys/fs/bpf/dir/fooB type hash key 8 value 8 entries 8 name fooB flags 1
$ echo $?
255

This patch prints an error message when the map pinning fails.

Signed-off-by: Alban Crequy <alban@kinvolk.io>
---
 tools/bpf/bpftool/map.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index 9befcabc299d..c825eb1bbf8f 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1305,8 +1305,10 @@ static int do_create(int argc, char **argv)
 
 	err = do_pin_fd(fd, pinfile);
 	close(fd);
-	if (err)
+	if (err) {
+		p_err("failed to pin map to %s", pinfile);
 		return err;
+	}
 
 	if (json_output)
 		jsonw_null(json_wtr);
-- 
2.20.1

