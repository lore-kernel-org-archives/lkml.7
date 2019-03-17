Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734F6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 01:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF842184C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 01:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWFDT9ah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfCQB7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 21:59:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54676 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfCQB7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 21:59:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id f3so9882556wmj.4
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 18:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=h2+O2/DVwTzLpIO0SKrcCKjQsKts7sAWIiEcpl6v0/A=;
        b=ZWFDT9ahClitU18J6oVjkGpd3ALF4reFfROdFWtum1V748CGAQoGq7u2C7uRcTrXJT
         XLJs05tBXA4lBOUJeh+C1puXNr6dpQ056dtjuLBh/FyartGq48jYNZ8MUBuKFxEbFPdc
         MUplT5W+VNWSZqaTsjfQ/pFFfqWVIpYWsqdWVvOq4+BRqLGRcyWBiMNg4wiJDiYby2R+
         fgFWWKJWYXydfRM0tOCHq3trvr76LIV4/EYvlSUl+LEZ1zLq3c0Duk8E14jDA5gFL2BW
         ujSGJYGRR5T7nF/vIhvGkVfO64hqfc6z81XNMFnjAIiofEqMv7qsVgfUZAWO5QKj3mSz
         fMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mime-version:content-disposition:user-agent;
        bh=h2+O2/DVwTzLpIO0SKrcCKjQsKts7sAWIiEcpl6v0/A=;
        b=KvwFxx+i3gpAsd4HVhCtrYAnfiooOBfnwpbAU4EiKMdNJFDS6QZ+RMEoxcRZKEpUnZ
         alBQH/4RcuPUQ0mdR/Q+0xGH5xy9dlOac9LIt7mavRhwNJja0pykMZAiUoewHv61fIiz
         0GF2lBd7f4CzprdE/sXxBetFGVpRcyak+t40HkWtLtzZgGrc7Bzl99KcysoLDNQRIhvZ
         GskpqdaAP1w/9fFcW+9VxPjX+6DrPj/w2hENld7DR8Md0OaXOwbnf4uiMTpMZPR8+Qsz
         T5+rrZRpgi5RWdCEmzFlABUwmp/496xw3GceBfjLVMEllsZW9nX0nlmu+btXoqvOJb08
         3OzQ==
X-Gm-Message-State: APjAAAU9oJgBqwahdM6f84i2uBxaYMa7EHvPtUvaHWAOcMC9pz6oWeVZ
        6D9ZRLskwnlWnWacGhiShbw=
X-Google-Smtp-Source: APXvYqyC2tLhRsvHNlqV3EhI5w88VxgHVfcgGbtoLDuznzAUeEGxTJAzGNLkzEkNZgws6xP0ANQf6A==
X-Received: by 2002:a1c:66c2:: with SMTP id a185mr4720142wmc.139.1552787974599;
        Sat, 16 Mar 2019 18:59:34 -0700 (PDT)
Received: from p200300EEEE2F.fritz.box (p200300C98705F80045694D516271D164.dip0.t-ipconnect.de. [2003:c9:8705:f800:4569:4d51:6271:d164])
        by smtp.gmail.com with ESMTPSA id g10sm3885899wrq.61.2019.03.16.18.59.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Mar 2019 18:59:34 -0700 (PDT)
Date:   Sun, 17 Mar 2019 02:59:32 +0100
From:   Emanuel Bennici <benniciemanuel78@gmail.com>
To:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 2/2] staging: vc04_services: Add blank line after struct
 declaration
Message-ID: <20190317015930.GA1747@p200300EEEE2F.fritz.box>
Reply-To: benniciemanuel78@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
---
 drivers/staging/vc04_services/interface/vchi/vchi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 7b13cb04c119..43eaf7703777 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -55,6 +55,7 @@ struct vchi_version {
 	uint32_t version;
 	uint32_t version_min;
 };
+
 #define VCHI_VERSION(v_) { v_, v_ }
 #define VCHI_VERSION_EX(v_, m_) { v_, m_ }
 
-- 
2.19.1

