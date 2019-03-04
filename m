Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECE5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C9B20663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0t7WQs3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfCDSWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:22:53 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40846 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbfCDSWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:22:52 -0500
Received: by mail-pf1-f194.google.com with SMTP id h1so3599742pfo.7;
        Mon, 04 Mar 2019 10:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zp5gcCPaXW0FCY336t08H8NoUg02AGaf86lk2haHF0A=;
        b=d0t7WQs3IiJpLZGn88DGzIfMn8HM2FNG+5QXM0wzdtP1TKxV4kXZZyyR7BC3vsRmxD
         BFG2ExNlk3dwq77Sn4IPH1/BsWsF0yiTUe9s5NCY6rlp3SqvNPNxEmOYjxkkbGaUKU2x
         iC47BWH4ft5fcdstP2B14jyx8OxEZjZPNtBNTmqT5h0GB3o3RSN5UNpWlhtvxx0fD0Nx
         k00rQg7+Q+y54pUVGd4BkQ5WPq/USXcOpNmo8tJajMsoqhn0jD2xFzvYuqJAy3hX7+kC
         zax5JJc9Vc7QEHc3EAKcHIqTw/DRG6YumOItEA9eXNGUWALUMZJQ4ZfL+fXgtBS7bUoe
         eKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zp5gcCPaXW0FCY336t08H8NoUg02AGaf86lk2haHF0A=;
        b=owWjTCyzJsBl0mmjNNM1cr4I4IaGEHt/doYsY3CB49x77rNWEkXh276/pnmYnVU1FW
         Mpgd7moQU9JZDQu3A4MwrWgMTVK+FD4FbyA36xYFW/nydl76PCU6jpRmOnFDoxV9vqf/
         9poe2mhUcJrSkcr59SzXAJeSj86Rn2stYPpub+no3YuRZjNri+Idwf/8HcR0zzH2XUJW
         +pe77N7g57yP73OuT0JgJ1t+hs96nfFsmgFJ6sj1CnhMv0mjDcSsvjfV60Jm1/z/04px
         cn5OAZXlXqu/Wr83zD2ysnh4KJptSgVhzutZGk/ZJoEQLxFvdybD6crJh5UdGjG6dyBI
         8BgQ==
X-Gm-Message-State: AHQUAuYzBfgbRsTOAxZoPsoBuR2h651en3voCKuCPy48YulQrb2wYxCS
        lFMd8n2gQYQW5liUfKCMBdVfUZyG
X-Google-Smtp-Source: AHgI3IYZDf+qHaqeZrzX7tQZGvM3+XBuFicIEjoN3fDNzVunyQh/FP6yj9qsZQPwMeIfPtTHQ6XFFA==
X-Received: by 2002:aa7:9255:: with SMTP id 21mr21455859pfp.8.1551723771770;
        Mon, 04 Mar 2019 10:22:51 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.18.146])
        by smtp.gmail.com with ESMTPSA id x19sm9446256pfm.108.2019.03.04.10.22.50
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Mar 2019 10:22:50 -0800 (PST)
Date:   Mon, 4 Mar 2019 23:57:19 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     adobriyan@gmail.com, shuah@kernel.org, sabyasachi.linux@gmail.com,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] selftest/proc: Remove duplicate header
Message-ID: <20190304182719.GA6606@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate header which is included twice.

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 tools/testing/selftests/proc/proc-self-syscall.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/proc/proc-self-syscall.c b/tools/testing/selftests/proc/proc-self-syscall.c
index 5ab5f48..3a4fec3 100644
--- a/tools/testing/selftests/proc/proc-self-syscall.c
+++ b/tools/testing/selftests/proc/proc-self-syscall.c
@@ -20,7 +20,6 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <errno.h>
-#include <unistd.h>
 #include <string.h>
 #include <stdio.h>
 
-- 
1.9.1

