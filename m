Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EFCC43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 10:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C912220675
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 10:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfB11rGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfEDKSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 06:18:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35870 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfEDKSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 06:18:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id a8so9104984edx.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2019 03:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bRfHc0UaHB0k6MjPno+5CwPodY7kjaQc8HLSJk/CQCc=;
        b=YfB11rGXBmj9IXr2nL97hKY/e8TtLpEAtYg7nZafkL5o2nO10WHm7uHFcvAxa5NPjo
         Is/u2yAWje+J26Pz5W3scquANdHKoBcRFLfKQ+TevsV9hAYZSK8LcMSgL3SpEXckLOu3
         89rvxkjL3wW4CUKr3HPnITT214EQoC6YxzoE32mK4DVowtqqEXU4HIyFbopUEDzvh0Ns
         mYzQF+avRSDGjR0eJB04pRbTw/pjRmxRks6zQVACgJXapeTmpGVmryex/L5/3CmXHtpy
         tm/wAEj7m+TzXTMrwo3nQ3nCt1+m2ds02jIb3WbyGrUr5Z35vjAvK7QA+inyQ3FO2CJC
         mxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bRfHc0UaHB0k6MjPno+5CwPodY7kjaQc8HLSJk/CQCc=;
        b=jM1vbUnSUscIwLpeJMG61tF3CnCKQ7VYm7xSE6M+RrKF6SGEDuUlQfCj8c0FyePdBc
         0hwHHTjWurdL+ev3etdPUVTqXz3uPTz2iTqc9ZLHY8lxZZ4jlajEs0uALXsrFY2/ZI+b
         C1LoRu/fz1Vj25jkTaUZdFvJn85fUHeLr8qoOjSKCN5FvRiimcSLQDhISevvECw0+2tu
         af6FPY5BOd9lVn/0E0UtKWQnbVPJM81PbJtJF7uKysRx8++NCnK+u19I3oDhq0rpPEwb
         QJFpy6MW7wXVNe9TUhWjK0VtKeUPbwXWK5OGEOrgJ2Vg3ZJo57dDehYJrr+vpJBZYwEv
         Uzzg==
X-Gm-Message-State: APjAAAUVIDfzD4bKFWlFqpyDxcsycHLHRy2FT7AJZ/NebdP/lSxoPdWx
        MdW8bfEppG+P/Nfft/3WmqNHU1uj
X-Google-Smtp-Source: APXvYqzGHkIqyqaiY2TQKIwqeBC/e6rmCepRzS/+JpDJd5QPk2zFiGcDVVzDlBINXJa6N4M9kJz6Fg==
X-Received: by 2002:a50:9177:: with SMTP id f52mr14187134eda.18.1556965132596;
        Sat, 04 May 2019 03:18:52 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:9e39::64])
        by smtp.gmail.com with ESMTPSA id p21sm1271859eda.80.2019.05.04.03.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 03:18:51 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gabor Juhos <juhosg@freemail.hu>,
        John Crispin <john@phrozen.org>, Jo-Philipp Wich <jo@mein.io>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Matteo Croce <matteo.croce@canonical.com>,
        Steven Barth <steven@midlink.org>
Subject: [PATCH] mailmap: reroute openwrt.org email addresses
Date:   Sat,  4 May 2019 12:18:58 +0200
Message-Id: <20190504101858.22772-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.13.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the fork and remerge of LEDE and OpenWrt.org, use of @openwrt.org
addresses has been discouraged, and some addresses aren't even working
anymore. To avoid patches being overlooked add appropriate mappings
based on recent commit history in Linux and OpenWrt.

While at it, also update the addresses in MAINTAINERS.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 .mailmap    | 9 +++++++++
 MAINTAINERS | 4 ++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index ae2bcad06f4b..842f69b019d4 100644
--- a/.mailmap
+++ b/.mailmap
@@ -58,14 +58,17 @@ Douglas Gilbert <dougg@torque.net>
 Ed L. Cashin <ecashin@coraid.com>
 Evgeniy Polyakov <johnpol@2ka.mipt.ru>
 Felipe W Damasio <felipewd@terra.com.br>
+Felix Fietkau <nbd@nbd.name> <nbd@openwrt.org>
 Felix Kuhling <fxkuehl@gmx.de>
 Felix Moeller <felix@derklecks.de>
 Filipe Lautert <filipe@icewall.org>
+Florian Fainelli <f.fainelli@gmail.com> <florian@openwrt.org>
 Franck Bui-Huu <vagabon.xyz@gmail.com>
 Frank Rowand <frowand.list@gmail.com> <frowand@mvista.com>
 Frank Rowand <frowand.list@gmail.com> <frank.rowand@am.sony.com>
 Frank Rowand <frowand.list@gmail.com> <frank.rowand@sonymobile.com>
 Frank Zago <fzago@systemfabricworks.com>
+Gabor Juhos <juhosg@freemail.hu> <juhosg@openwrt.org>
 Greg Kroah-Hartman <greg@echidna.(none)>
 Greg Kroah-Hartman <gregkh@suse.de>
 Greg Kroah-Hartman <greg@kroah.com>
@@ -94,13 +97,16 @@ Jens Axboe <axboe@suse.de>
 Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
 Johan Hovold <johan@kernel.org> <jhovold@gmail.com>
 Johan Hovold <johan@kernel.org> <johan@hovoldconsulting.com>
+John Crispin <john@phrozen.org> <blogic@openwrt.org>
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
 John Stultz <johnstul@us.ibm.com>
+Jonas Gorski <jonas.gorski@gmail.com> <jogo@openwrt.org>
 <josh@joshtriplett.org> <josh@freedesktop.org>
 <josh@joshtriplett.org> <josh@kernel.org>
 <josh@joshtriplett.org> <josht@linux.vnet.ibm.com>
 <josh@joshtriplett.org> <josht@us.ibm.com>
 <josh@joshtriplett.org> <josht@vnet.ibm.com>
+Jo-Philipp Wich <jo@mein.io> <jow@openwrt.org>
 Juha Yrjola <at solidboot.com>
 Juha Yrjola <juha.yrjola@nokia.com>
 Juha Yrjola <juha.yrjola@solidboot.com>
@@ -117,6 +123,7 @@ Leonid I Ananiev <leonid.i.ananiev@intel.com>
 Linas Vepstas <linas@austin.ibm.com>
 Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@web.de>
 Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@ascom.ch>
+Luka Perkov <luka.perkov@sartura.hr> <luka@openwrt.org>
 Maciej W. Rozycki <macro@mips.com> <macro@imgtec.com>
 Marcin Nowakowski <marcin.nowakowski@mips.com> <marcin.nowakowski@imgtec.com>
 Mark Brown <broonie@sirena.org.uk>
@@ -124,6 +131,7 @@ Mark Yao <markyao0591@gmail.com> <mark.yao@rock-chips.com>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@theobroma-systems.com>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@ginzinger.com>
 Mathieu Othacehe <m.othacehe@gmail.com>
+Matteo Croce <matteo.croce@canonical.com> <matteo@openwrt.org>
 Matthew Wilcox <willy@infradead.org> <matthew.r.wilcox@intel.com>
 Matthew Wilcox <willy@infradead.org> <matthew@wil.cx>
 Matthew Wilcox <willy@infradead.org> <mawilcox@linuxonhyperv.com>
@@ -199,6 +207,7 @@ Shuah Khan <shuah@kernel.org> <shuah.kh@samsung.com>
 Simon Kelley <simon@thekelleys.org.uk>
 Stéphane Witzmann <stephane.witzmann@ubpmes.univ-bpclermont.fr>
 Stephen Hemminger <shemminger@osdl.org>
+Steven Barth <steven@midlink.org> <cyrus@openwrt.org>
 Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
 Subhash Jadavani <subhashj@codeaurora.org>
 Sudeep Holla <sudeep.holla@arm.com> Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 057a72a85156..6ab77d69842d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9736,7 +9736,7 @@ F:	drivers/leds/leds-mt6323.c
 F:	Documentation/devicetree/bindings/leds/leds-mt6323.txt
 
 MEDIATEK ETHERNET DRIVER
-M:	Felix Fietkau <nbd@openwrt.org>
+M:	Felix Fietkau <nbd@nbd.name>
 M:	John Crispin <john@phrozen.org>
 M:	Sean Wang <sean.wang@mediatek.com>
 M:	Nelson Chang <nelson.chang@mediatek.com>
@@ -13048,7 +13048,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
 F:	tools/testing/selftests/rcutorture
 
 RDC R-321X SoC
-M:	Florian Fainelli <florian@openwrt.org>
+M:	Florian Fainelli <f.fainelli@gmail.com>
 S:	Maintained
 
 RDC R6040 FAST ETHERNET DRIVER
-- 
2.13.2

