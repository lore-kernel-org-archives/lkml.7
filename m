Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9325BC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 15:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A5520836
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 15:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b="xkcLqf66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfCIPnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 10:43:50 -0500
Received: from imap.cs.msu.ru ([188.44.42.39]:53701 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbfCIPnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 10:43:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=IxQpZZp1jw2edUZ2FQBV5SphB3EGuIm0nBwjetxFqiE=; b=xkcLqf66sgRq19qkH4J5TGtmMD
        qwmlTJ7S1UTtIP9tBGEZBy0+/yS9nORnwj6eZ0rH04oeGzFS5157Mio6gZALD7MjJS3ozCo9m95GH
        hj6tX+BC5vhfjpnMu7Z6Zzzw5yMih9EjWpWFci7Wh7SCEY+VVzidnrCD/nLw1POkc5CZcvHZbMswA
        IIkJPWSpWGwM6urxat5alvch8ZwmhSk5xGUXHHUOKP7xLn70vACvPviXG7f7gkMXHVwgmTamLtzoI
        Ui8euR647Yz60WKOk/z5xA5SNnB/1v2HtzsIeons7VUQ6o5+s2/qhMtQGY274VG4tjZeKf4OqmCoj
        ZfiLdADw==;
Received: from [37.204.119.143] (port=44904 helo=localhost.localdomain)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1h2e8S-000IDA-Ec; Sat, 09 Mar 2019 18:43:40 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arseny Maslennikov <ar@cs.msu.ru>,
        Ben Hutchings <ben@decadent.org.uk>,
        Riku Voipio <riku.voipio@linaro.org>
Date:   Sat,  9 Mar 2019 18:43:06 +0300
Message-Id: <20190309154307.23039-2-ar@cs.msu.ru>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190309154307.23039-1-ar@cs.msu.ru>
References: <20190309154307.23039-1-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: [PATCH v2 2/3] scripts/package/mkdebian: avoid implicit effects
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* The man page for dpkg-source(1) notes:

>      -b, --build directory [format-specific-parameters]
>             Build  a  source  package  (--build since dpkg 1.17.14).
>             <...>
>
>             dpkg-source will build the source package with the first
>             format found in this ordered list: the format  indicated
>             with  the  --format  command  line  option,  the  format
>             indicated in debian/source/format, “1.0”.  The  fallback
>             to “1.0” is deprecated and will be removed at some point
>             in the future, you should always  document  the  desired
>             source   format  in  debian/source/format.  See  section
>             SOURCE PACKAGE FORMATS for an extensive  description  of
>             the various source package formats.

  Thus it would be more foolproof to explicitly use 1.0 (as we always
  did) than to rely on dpkg-source's defaults.

* In a similar vein, debian/rules is not made executable by mkdebian,
  and dpkg-source warns about that but still silently fixes the file.
  Let's be explicit once again.

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
---
 scripts/package/mkdebian | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/package/mkdebian b/scripts/package/mkdebian
index f030961c5165..d276eb671a27 100755
--- a/scripts/package/mkdebian
+++ b/scripts/package/mkdebian
@@ -132,7 +132,9 @@ else
         echo >&2 "Install lsb-release or set \$KDEB_CHANGELOG_DIST explicitly"
 fi
 
-mkdir -p debian/
+mkdir -p debian/source/
+echo "1.0" > debian/source/format
+
 echo $debarch > debian/arch
 
 # Generate a simple changelog template
@@ -221,5 +223,6 @@ clean:
 
 binary: binary-arch
 EOF
+chmod +x debian/rules
 
 exit 0
-- 
2.20.1

