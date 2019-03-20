Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87354C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AFAD21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHRjaLc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfCTReb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:34:31 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36378 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfCTReb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:34:31 -0400
Received: by mail-ed1-f66.google.com with SMTP id e4so2733695edi.3;
        Wed, 20 Mar 2019 10:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jAsNi26TKH9Dmlb5JIesmArjLcNt9Wble0Sl7/O3SC0=;
        b=gHRjaLc/BytrTpBoCzhr3Z9PDyaNhWcrAMAM+SCL3R+5NGjyIaCAiY0CnPTgcXDpVF
         6rsi5Pbi07BPKRwGc9LCvp5ASLHpRWZ+BWQghMiU7Crww727lNhzh5+nCcHTzAb7i1gb
         ZV0A5+QKHBdnUPYw9qU7HAqOShWpyqqsPV/67eNlNqiEJp0Q5g5vBZaU/5ln1T3rnBOz
         PPyIZW7kixfHsjH/XYc52po2ne7ICkV09E3X01LRORfz8mgnXxen7ci2qG0L2odtoMMr
         bQfW/hgFbKWhvv61sb+iUqovaO9oRROVySEuxeDN8nww2Dg/dR04rv85p0VFy9w1elEF
         smDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=jAsNi26TKH9Dmlb5JIesmArjLcNt9Wble0Sl7/O3SC0=;
        b=GGcVAI+eF3fZPjc54wOAu9SkMis25MJa9Q2pqLM8Mvt386OqPw0C1ITDFQGQ0VK2DC
         X2dWVtRbuutL4lufIonIG3hvDgK1gKqyeXzLfN4Cm47vNdOe2l0+e9aaN+XKnwHDoVn5
         ZV2ab4ZtdFnbghFAtVfY5dKOvg2tTBNdaiVU2rLsy0FpzXZlwCNO59lGM9PUDtrA6SIQ
         j8aRBbRZqQ2xWxhjvXOhYR6l4r6M7uaGYNHZuJL5KqvILrGZXfvkPa1Y24s702C4vhm7
         JLJcpXrq8oWdEYXB07EL5d9VAB50jLmkObwXQOpJSl7Iqft4mxiZsDotARdelJTvWkvB
         2WFQ==
X-Gm-Message-State: APjAAAVfIjbLyBAyBZf6YCUvecDn5JocMQu2TV/ObRSoWyrnzFHrmXS4
        OOZI9N1E5QVGmOWhP7e2sG4=
X-Google-Smtp-Source: APXvYqzey3gthv0iLLsO2d4clFYVqV7fv9yz5tuLFwNGq6hVdpUV7nVSFTRIZpu+tWxf9a8IxkQCEA==
X-Received: by 2002:aa7:c1ce:: with SMTP id d14mr21226100edp.50.1553103269044;
        Wed, 20 Mar 2019 10:34:29 -0700 (PDT)
Received: from neptune.fritz.box ([178.19.216.175])
        by smtp.gmail.com with ESMTPSA id 5sm828606edp.50.2019.03.20.10.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 10:34:28 -0700 (PDT)
From:   Alban Crequy <alban.crequy@gmail.com>
X-Google-Original-From: Alban Crequy <alban@kinvolk.io>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alban@kinvolk.io, iago@kinvolk.io
Subject: [PATCH bpf-next v1 1/7] tools: bpftool: fix infinite loop
Date:   Wed, 20 Mar 2019 18:33:26 +0100
Message-Id: <20190320173332.18105-1-alban@kinvolk.io>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alban Crequy <alban@kinvolk.io>

Symptoms: when forgetting to type the keyword 'type' in front of 'hash':
$ sudo bpftool map create /sys/fs/bpf/dir/foobar hash key 8 value 8 entries 128
(infinite loop, taking all the CPU)
^C

Signed-off-by: Alban Crequy <alban@kinvolk.io>
---
 tools/bpf/bpftool/map.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index e0c650d91784..994a7e0d16fb 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1151,6 +1151,9 @@ static int do_create(int argc, char **argv)
 				return -1;
 			}
 			NEXT_ARG();
+		} else {
+			p_err("unknown arg %s", *argv);
+			return -1;
 		}
 	}
 
-- 
2.20.1

