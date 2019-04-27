Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7AAC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95C42087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfD0MxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:53:21 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:37453 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfD0MxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:15 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M2OEw-1hM22x2IWM-003z2b; Sat, 27 Apr 2019 14:52:33 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, andrew@aj.id.au,
        andriy.shevchenko@linux.intel.com, macro@linux-mips.org,
        vz@mleia.com, slemieux.tyco@gmail.com, khilman@baylibre.com,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com, davem@davemloft.net, jacmet@sunsite.dk,
        linux@prisktech.co.nz, matthias.bgg@gmail.com,
        linux-mips@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: serial drivers polishing
Date:   Sat, 27 Apr 2019 14:51:41 +0200
Message-Id: <1556369542-13247-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:KJDamy/sLPxVA6+e/xJ3QUvJO2vZRQRZ7H0KMjcX3Xau2yWekpn
 NpGyWcv0BdxhaW7aX7/vr2xwwxMEX+6774NoAKSIMs3MmeEZ+xYywOxnE2TTovvdXTrh2yJ
 RNeD0ze+njam53jHsvoBAF38TFF8FCMFOboXlpNsaf5RaLhhCCBqtkthfNYpeDWcM41q4C0
 CVkuapPP3KK3JkmPsaT5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UgSrRnCWrUY=:7fJ0rhQipVcqjbOMouuuLX
 HpGMJ1r9jBZF63ISf/g4eJR7MR4pim7nBhig4Jl6mL9rhhjlxhwR2qh1N4i4VbbUFcAAJS4Ir
 3ehiLQX6cqWnF50zJ7z21t0eDxTtPggAbzQRa+2t5Cjiod8h5Wb5R4iORC6PmyUH6vKKXXUM+
 R9rHMmPwJ7xow24gQslekOboEkjLcPhRKBzHll9gB05PrKyGQOO6IpPuj6JsGixD3/SV3rmAI
 WRreW0Q86/xSc9xzAZ/s0Tg16UGmFtYYzADiDOPYcz3bsuoRYHOUzjkSUBY7pks4GDFdjYMMY
 J/JvztrHNATKtF+xcSdHOfYpteSdbEr/adF2EdyGRbxXQKt/TrGXW7mmq08GeH8Pf+Ddxxi57
 gX4f5PaLFHVVAJwJNkdrPkVeh2oB4ZHHOgB7VwynKoG66tYGIwGyrt4JIE1NQxJ6/CCNQokSN
 tV88raPuIGD29SSpSBLoPwxN2NaH59lI0OHOA+RLEySArhq2aDwIEO1siM+Ym55O0C23LpHF/
 hhfoTRUvhYjfKChKVcwQzaBKOc6JX3KasD/lLqJOlFd4rOiG+bk5N2aqTqu9WhMZGPdByTTNn
 dZijwtgoeZ/ESNSagGa5Wp6TuGjsZnfKLyqzZ9EJkEAL0lFMwoIHRDBYlKB3pdj5Z6vK9cpbZ
 wU/2h8/Ce7j4rFZJwmpQfbVxZ6ipvpbPepnAyc6fl580YIKcwbDd50N+z74IAAonMBK2/PlY6
 SM9MoLwOFEsiV5jP9jDXm+Fk2osf8+pzyh1JcQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,


here's another attempt of polishing the serial drivers:

* lots of minor cleanups to make checkpatch happier
  (eg. formatting, includes, inttypes, ...)

* use appropriate logging helpers instead of printk()

* consequent use of mapsize/mapbase fields:
  the basic idea is, all drivers should fill mapbase/mapbase fields at
  init time and later only use those fields, instead of hardcoded values
  (later on, we can add generic helpers for the map/unmap stuff, etc)

* untwisting serial8250_port_size() at all:
  move the iomem size probing to initialization time, move out some
  platform specific magic to corresponding platform code, etc.


Unfortunately, I don't have the actual hardware to really test all
the code, so please let me know if there's something broken in here.


have fun,

--mtx

