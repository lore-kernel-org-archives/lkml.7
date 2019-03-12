Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3523DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBF52075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfCLO63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:58:29 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:41445 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfCLO6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:58:25 -0400
Received: from orion.localdomain ([77.4.190.91]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N5n81-1h0XKW0vTH-017G7f; Tue, 12 Mar 2019 15:57:59 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: RFC: cleaning up the serial drivers and use struct resource
Date:   Tue, 12 Mar 2019 15:57:32 +0100
Message-Id: <1552402660-31730-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:JsCz3ftMIgHIRuwj9yhGBGGATI0Opj8P1QXrNkxnudz3oAMyDR1
 hmiUuH+z5gtxO66ffZyD7gQMMaorDbfT2SP7JPcVoJOYbXhua3If5pR+p2dDkiFcOE8EaGM
 T8QQ5a0J/bb+cMyojJivAvVvZMw1dBW7SB8a4pU8UOzB92FHsPdtiCf/5ppX147WTpS2wx1
 aGFeDfYgG74AMcHiW/JDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jsZMIj2pDuc=:NtMfh4C0h+L4ApiTdr5i/E
 sAQc2S/qGiApsvCkQw0BGBNyTfGZ/WN3bR9Hf355omqnJXSQ5JuyCas/ZLQHs+Kn79B0F3XXs
 R8+uQhnV9yimzJ08SpK4oJj+tBSoT/wsn6vXmPU9fKyqCHN4xfCFF4i/EacBW6oXP3Lmfc66y
 JGRoSOSHEtci7EYAKbwro1dC3tmnhnf7wut/aOhaiIqCgG+1SwRNjwimodjkByZ/x+aYRSsy2
 D8IK4kfpysa5MUDaVKTS7LWj6BfXN046nkdLRm9If3Q3QyFZg8XSr4NUyuSfjDf0KoICQUC32
 uwODaknYBW8q21zb1NQAlFddtTBYNf1VO+NMuVwSKLrJ+zyh/H4S87byf0xVUhhrMCdA7qs4X
 I97SOgg/3oLbk3+c8TF8HDMrq9uaziqWmEuSkEZb/calenQXszcIGRLUy/MKMsinqNbMnOdVG
 H/+GKP03rRUb3EBo3Y7zKhXKlSh4j88qPO9oPiLgbe9Xg6pTb2nlw2wlO95auf+6dUfkejoMO
 t5NXVH8mM6/tG2faTMFV5saGkwTA79k67BIJHa4g5Lu9RMpOGODm0W7hfJepkKTHZ1GRmF2rY
 nSS/y5fmPIoPov1rpMrOM0oYAY7ygqqo23lpwBeYScSpTaqvLxaEr+UCVXdN5/bmSa9hE+O81
 VqjGvW/HkUT9IPx+Adj7mEAyI2e1cYFeAFAz3Ss8fh0gnkC630+Yo7sDh6449s62WxcI4bayB
 nVJBOsIAuzCb3GVVHIuAeHqjVM7p/LuD9C/Nsw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

I'm currently working on some cleanups in drivers/tty/serial.

There're several cases where new helpers, like devm_platform_ioremap_resource
can be used, other places can use devm_ioremap_resource() for a bit
cleaner code.

Another topic here is using struct resource, instead of separate fields
(BTW: struct uart_port->mapsize doesn't seem to be used consequently):
in struct uart_port, I'm adding a struct resource field for holding the
port's iomem range, and helpers for it. Then, I'm step by step patching
the individual drivers to use that, instead of the old fields, directly.

For now, this all is early, untested and not yet meant for mainline.
I'd just like to have your oppions on my approach.

What do you think about it ?


thx
--mtx


