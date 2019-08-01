Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D21C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CBE7206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCfa3dY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732306AbfHAShA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 14:37:00 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45974 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfHASg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 14:36:59 -0400
Received: by mail-qt1-f195.google.com with SMTP id x22so66361412qtp.12;
        Thu, 01 Aug 2019 11:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jN2C67uMWK4kd4P2xs5PFHzxlLIwghH8oAtxdrPV1UQ=;
        b=iCfa3dY6VM1fbxwIw2Q5CRbLFfJshyj+ydsXmquxuNKt8lu0K1cXwL+QTQsidjO4DH
         0rb3y8N6GNur9joNcECCAeORLfYv312DD6FBk6GBdp0KbZmqDNpQlXv+HC8TVSj6WHaY
         pChh50PQZvi0D1c/RBxwCZ4HNmNzh+pl4UU2Lq1JC7lCjfCvV+/922JXxxNWX5FRX2XR
         /N92/caxMjWVD9I9++6VttEfEMIe2SXF8dzcb9GEUbmtPseYbScMrQVtRTLdAZe5+xa8
         xFVBqt5dFk3G9TviOaFJv/GqyvWPhb0TF9WXQoGOXhfycl4Yw/zXGH+97aKWDZutp8Ej
         a/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jN2C67uMWK4kd4P2xs5PFHzxlLIwghH8oAtxdrPV1UQ=;
        b=R3z2HWD6vhgQIU5G4ERMmQQNY17dNUQzZjbVLwlsllSG5/Y2z6mImd4FKKqmWIS0ja
         dqZdH4XSQ6M2YAyR4rrAIDA3Ira5+Pa5AL9/o3Y+wyaK3f9mdf3oqU+CTvqTcKwiGoax
         o89p2s1gJ/v2t9UXIGwPhenjKu6ssEdMOH+VICtLBYfFYVAStsTquqyEIhel82Hu5UMZ
         zfSvqX1HsxeCwKS7bDFvSZUOq+Zppiyz7mysyO6vytS2p+EuhG2jqk11j+dTAnOaHdtN
         OTeQrotVmT0RD0vo2ZzvErslam4X6iLy52rGXLxFPvEnrLCPtU/XPx5vQ68ZQ2wMsBCo
         Wtkg==
X-Gm-Message-State: APjAAAXyOgiIBi4525HoOdB9Zi5FZgqRy4Z08iFjAGotxGmmckFOLQH3
        mHG6cHoE1u/OclGYtMa5EQbz2At3/P0=
X-Google-Smtp-Source: APXvYqyIqlEZM0SZTvRPByBpme8tnNmkrkJqFLEdlOqWJmADwC/UyV+ePyOqU0g5UpecAaB2GTw8lg==
X-Received: by 2002:aed:3c44:: with SMTP id u4mr90375404qte.73.1564684618440;
        Thu, 01 Aug 2019 11:36:58 -0700 (PDT)
Received: from localhost (modemcable249.105-163-184.mc.videotron.ca. [184.163.105.249])
        by smtp.gmail.com with ESMTPSA id 23sm30936490qkk.121.2019.08.01.11.36.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 11:36:57 -0700 (PDT)
From:   Vivien Didelot <vivien.didelot@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        f.fainelli@gmail.com, andrew@lunn.ch, netdev@vger.kernel.org,
        davem@davemloft.net
Subject: [PATCH net-next 0/5] net: dsa: mv88e6xxx: avoid some redundant VTU operations
Date:   Thu,  1 Aug 2019 14:36:32 -0400
Message-Id: <20190801183637.24841-1-vivien.didelot@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mv88e6xxx driver currently uses a mv88e6xxx_vtu_get wrapper to get a
single entry and uses a boolean to eventually initialize a fresh one.

However the fresh entry is only needed in one place and mv88e6xxx_vtu_getnext
is simple enough to call it directly. Doing so makes the code easier to read,
especially for the return code expected by switchdev to honor software VLANs.

In addition to not loading the VTU again when an entry is already correctly
programmed, this also allows to avoid programming the broadcast entries
again when updating a port's membership, from e.g. tagged to untagged.

This patch series removes the mv88e6xxx_vtu_get wrapper in favor of direct
calls to mv88e6xxx_vtu_getnext, and also renames the _mv88e6xxx_port_vlan_add
and _mv88e6xxx_port_vlan_del helpers using an old underscore prefix convention.

In case the port's membership is already correctly programmed in hardware,
the following debug message may be printed:

    [  745.989884] mv88e6085 2188000.ethernet-1:00: p4: already a member of VLAN 42

Vivien Didelot (5):
  net: dsa: mv88e6xxx: lock mutex in vlan_prepare
  net: dsa: mv88e6xxx: explicit entry passed to vtu_getnext
  net: dsa: mv88e6xxx: call vtu_getnext directly in db load/purge
  net: dsa: mv88e6xxx: call vtu_getnext directly in vlan_del
  net: dsa: mv88e6xxx: call vtu_getnext directly in vlan_add

 drivers/net/dsa/mv88e6xxx/chip.c | 182 +++++++++++++++++--------------
 1 file changed, 98 insertions(+), 84 deletions(-)

-- 
2.22.0

