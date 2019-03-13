Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20789C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9891213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSStq4Gs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfCMTun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:50:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36615 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfCMTun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:50:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id g18so3366004wru.3;
        Wed, 13 Mar 2019 12:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aEGz6YCCJaeLKuAxB7qZ9njEItgiszoiAU64XvcXliM=;
        b=kSStq4GsNaT26DAWPR8Ec95ygqYnIlvxUZLwEPu1OEJDxqlDUqp1dDEGrkxS/cSdee
         4v155TdLPJ/+0sBdkiJui0hmfz/ZYjtZIOytUs8D0e4r3G61bcaYVqP8qklpuKEQtrxd
         RDI81xpF4EZ/fIOE8gz6YMSRuXQly7yvtmOJ1ovD92zP0xcvksFunlQ5QJmWIFcxZ4yV
         Z3zG3VtNyYXlZhWIFND8BZ0pNx1pkrIcOe1VLPvqzFaOVWKd6DcQfF0bDQe16im4gjZ8
         9bub6VVh+4izAvPMPiZsf5Wz1BTBiYdtki4CS7U3BMVFy+fgsEB7ibvQPqrrO6BO3fJU
         yaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=aEGz6YCCJaeLKuAxB7qZ9njEItgiszoiAU64XvcXliM=;
        b=P6vz0ePp+wlFFU8vk7zXJijNHqIJCuOvjsujrdcgINkpCFNLI+TvI7psSM8rwLGnQp
         pTgnJZeODX0viSgRVbFZ28WHXSrxUrZ4YWlDUTVAZYJnSukVNQFwfjaXuCwWk4FwW58i
         GiaZTADSx0ZHEyxZI7YHT+s0mMzMgu49T2edr3CqzfxZF6FuKvNacHFgQXdta+tMofWb
         FnzNvl05PHcuuFR1RITL0tAvSmgUA6EowKYIymrAFw5CIUjQ4i9K1eZmCNl9f7qShKlW
         NyRiUb/5xV+s558P5Emcv2kNi7EelpvGeeShx5aUzoQqDYrPzOTkD4g0bVlT4wIxPl62
         Djzg==
X-Gm-Message-State: APjAAAUyuhwIPKU923lvfZXNu7m81fIzKqORasy4FRe2WUs+bFsFM/k6
        lFfCsNXdOMzrbt1ErMU5sPA=
X-Google-Smtp-Source: APXvYqzYLUlg3fiYG6jvHIn2iXs2PnhxY/6K2ipVlWXO+Ef6wktKxJbZCAWMq0peRaf5dzSPgycfIg==
X-Received: by 2002:adf:ba12:: with SMTP id o18mr30891238wrg.326.1552506641123;
        Wed, 13 Mar 2019 12:50:41 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id v6sm4623958wme.24.2019.03.13.12.50.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 12:50:40 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id CB2DB1140A07; Wed, 13 Mar 2019 20:50:38 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Riku Voipio <riku.voipio@linaro.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: deb-pkg: set executable bit for debian/rules
Date:   Wed, 13 Mar 2019 20:50:28 +0100
Message-Id: <20190313195028.18196-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will remove the warning:

  dpkg-buildpackage: warning: debian/rules is not executable; fixing that

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 scripts/package/mkdebian | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index f030961c5165..3c6c82f28cac 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -221,5 +221,6 @@ clean:
 
 binary: binary-arch
 EOF
+chmod +x debian/rules
 
 exit 0
-- 
2.20.1

