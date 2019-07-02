Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A27CC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F410E21721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="UT429osi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfGBJlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 05:41:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:56819 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfGBJlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 05:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562060457;
        bh=xXxtxyTTAn8WYnm5rjgM/bMkAxJpK4CP+ke02d7vvFg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=UT429osiJWt9Ktapaxnx8fs5B8LcwmS7KgJKihCwBJfXVOcrW4YkDk4ZYpRjphlJv
         8tRm9c8ftFzcVjvsh54fMeK72mB+7tfWiixpeB5Obj4KqO++ik16d+sX0+OOia83aj
         jUA/3FmIOmW/y5zzVb21MVSOKpk/1xe3aZ6lpAhs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([217.61.147.59]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MbAci-1iFOAj2AQa-00bcOR; Tue, 02 Jul 2019 11:40:57 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Frank Wunderlich <frank-w@public-files.de>
Subject: [PATCH 0/3] implement poweroff for mt6323/6397
Date:   Tue,  2 Jul 2019 11:40:42 +0200
Message-Id: <20190702094045.3652-1-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:vYKfD5Hh1FjG0AmzmJlBnrFiyiLdIG4UpK+hPmNFhBA295L5B2E
 mQ5m4TWy+Z6lodaNgkm5A8VAm0OgBMObKifo2SKYDpIdlWYN3bj8XFS5SrIC7tb6dptTv6U
 CY2W/tOlOq+Gxqa+LZDzXopMLbuCqOOJRWU0Jw8awZXwwa5R+DMZK1RIWFRRhjhBNliuyD0
 5r1JKZbDUTOoleblNtLWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c+vdco4YyNU=:rlxBYVMFtWfezfoncYCRpQ
 +CYJbcolYvgXyOHBFqGoz65on402iVLY39B7kjoR6U0tKfphAuatufZMaGJ+tDeloCDLbV237
 rmcXYalB5u8cRsJOfEO7D473L7h8fWSiPJyiV4wskLnuheg6ildREWL+03V/bxUWlQ858hXzt
 Up3UumFj3GihS5/nPvhmGWpt31K4VOgiAq2Q8HeaMQjRjn9IEkpnaURt0m+kr3O7t5RLJTTDH
 dzy0GfqkW5G6eJoSKst9yJtgnqdpD4LuhdZKAGeS55JJoa1DAin5KH7QIbVcsI0RDMPaw3TGC
 cY96oXOdi+BW1GPLOu9TNNfIacK0ovyW0xEt1RQVNdTZtqYIoaSGDXQc01x3QUDAKyj9HjixN
 +k6R6/JyUQVvbUClRCd05i2PdpqkCAW3vUYiveUDwFLToAiSQDtmv/HiZoSWG6ZewoNmIaC3a
 bDGi2BmwUPk8DvHroY3Pu8qLszmYXTA9hDhbW/vvBnLGzq73kzvn9KbTU58fpKgMtJ4fLuBkb
 oDiD2Cqp7KbZMrz4QbPQoSL8GeIXF9YQQSolunrJ30cG9yV0YyGOQ7NwfW230ztZhgHVsvSiC
 fRZzvpvuVOIDngkMfLNxMoUvpZC9lDfv+xk84wRXLBtnzVjgI+7V+OLH8l2BLmH1JJ9xpL6/C
 nnzOge6xhYmvilm7WBsfbjBswT2FagA/z3LirptWEufMsovKO44gxHYKW8NrDVO3CwkQX/K8M
 MvHtD734cBTEme4Ir3YgeT4niXTSW5dLBS9Brf5nycrt+OrGwwEvLV9HdYwRcBE+4bhzvJTX8
 fdr7ARQegsDRMiYupwqOGX34Gh2noiaHA9m9xILeEQ7InxzxZEqswYoWL8Bd7BpdumxIgbNtS
 vFLQ2efcIvCPQUpF/0B2qrZ9yyCahV3eFi+sXNf5TQr2BAd9bOHJ/r6Rthqo4uVPVzkhHm2hY
 oKEgJjcusBCUX8k/NjnAyM8lDsNNTPya/EauTFD/wKc++9M1dYNEnwJ/jrJ6PCtlPy60shKq3
 /z+V8I1KrPkvRhbGIpV1dxEykFzBJe8KCtX9R69RGWcPeRLlwW2oeg1KMVc0tgc4D8o6DmquW
 Mh2LamFUs4osOQ=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i got this Patchset from josef friedl and want got get it in mainline

tested on bananapi-r2 (mt7623)

with this Patchset real power off (in mailine only "system halted") and
reboot by power-key is working

Josef Friedl (3):
  add doc and MAINTAINERS for poweroff
  add dts for poweroff
  add driver and MAINTAINERS for poweroff

 .../devicetree/bindings/mfd/mt6397.txt        |  10 +-
 .../bindings/power/reset/mt6323-poweroff.txt  |  20 ++++
 .../devicetree/bindings/rtc/rtc-mt6397.txt    |  29 +++++
 MAINTAINERS                                   |   7 ++
 arch/arm/boot/dts/mt6323.dtsi                 |  27 +++++
 drivers/mfd/mt6397-core.c                     |  40 +++++--
 drivers/power/reset/Kconfig                   |  10 ++
 drivers/power/reset/Makefile                  |   1 +
 drivers/power/reset/mt6323-poweroff.c         |  97 +++++++++++++++
 drivers/rtc/rtc-mt6397.c                      | 110 ++++--------------
 include/linux/mfd/mt6397/core.h               |   2 +
 include/linux/mfd/mt6397/rtc.h                |  71 +++++++++++
 12 files changed, 325 insertions(+), 99 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/mt6323-p=
oweroff.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
 create mode 100644 drivers/power/reset/mt6323-poweroff.c
 create mode 100644 include/linux/mfd/mt6397/rtc.h

=2D-
2.17.1
