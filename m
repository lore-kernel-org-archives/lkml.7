Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9C6C74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 19:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C1320844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 19:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="a+cMnKl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfGJT1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 15:27:04 -0400
Received: from first.geanix.com ([116.203.34.67]:39892 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727406AbfGJT1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 15:27:04 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 511C530A;
        Wed, 10 Jul 2019 19:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1562786819; bh=SNo7N95GK7AKcH92YrsiSLTrGaZYQdN8khIIua9jIxg=;
        h=From:To:Cc:Subject:Date;
        b=a+cMnKl5ehemINHAzfKAtjy3CrFQtWHddWVSQ5OJhiLBcNwA33wvSY6774MY1eM+r
         ooif5pUlTDJ//Lq1xlAiMb1iPsutJ/Dov2AbvsZbuorq9b+PNUgSBcxgA3OQnUREg/
         bcOfAj1nnwfDqgxm9Igf83vKVbHEJdLM62vO4He/tJ1gKuxixhaSIu2NcEfhdcx4tG
         J0i+ZzgTH4JjEMFNHHUIbPXc/R0dclynbuvoKJmhA+itfuAkykgT3LnnhvSdwNk2kc
         UmuDvz3oFKUxNTPIAGxwTeiaVVuEq1u4YWVbm0OQ+2zBVN2kcVy0HbYfz/lLg8yMP9
         rfgfrH/1RWTUA==
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
        =?UTF-8?q?Sean=20Nyekj=C3=A6r?= <sean@geanix.com>,
        Esben Haabendal <esben@geanix.com>
Subject: [PATCHv3 1/4] tty: n_gsm: remove obsolete mknod doc example
Date:   Wed, 10 Jul 2019 21:26:53 +0200
Message-Id: <20190710192656.60381-1-martin@geanix.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The n_gsm driver handles registration of /dev/gsmttyX nodes, so there's
no need to do mknod manually.

Signed-off-by: Martin Hundebøll <martin@geanix.com>
---
 Documentation/serial/n_gsm.rst | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/Documentation/serial/n_gsm.rst b/Documentation/serial/n_gsm.rst
index f3ad9fd26408..4f37198423f7 100644
--- a/Documentation/serial/n_gsm.rst
+++ b/Documentation/serial/n_gsm.rst
@@ -63,24 +63,14 @@ Major parts of the initialization program :
 	daemon(0,0);
 	pause();
 
-4. create the devices corresponding to the "virtual" serial ports (take care,
-   each modem has its configuration and some DLC have dedicated functions,
-   for example GPS), starting with minor 1 (DLC0 is reserved for the management
-   of the mux)::
-
-     MAJOR=`cat /proc/devices |grep gsmtty | awk '{print $1}`
-     for i in `seq 1 4`; do
-	mknod /dev/ttygsm$i c $MAJOR $i
-     done
-
-5. use these devices as plain serial ports.
+4. use these devices as plain serial ports.
 
    for example, it's possible:
 
    - and to use gnokii to send / receive SMS on ttygsm1
    - to use ppp to establish a datalink on ttygsm2
 
-6. first close all virtual ports before closing the physical port.
+5. first close all virtual ports before closing the physical port.
 
    Note that after closing the physical port the modem is still in multiplexing
    mode. This may prevent a successful re-opening of the port later. To avoid
-- 
2.22.0

