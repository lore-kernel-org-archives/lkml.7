Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69945C282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A39214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 16:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ACvZS26t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfDMQbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 12:31:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:54865 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbfDMQbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 12:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555173064;
        bh=xkBRSWUEj0/UfcEeS3vCROCM0B0nHpxZ5MVxtsBeg8U=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ACvZS26tB0rKTvJn9APPS5FrsJKp6n1X3U+BqnkZoJ171Ke8yvqwbVVduEw9giq6R
         Gc833ZUsa4uZgPkWhM2YhwQzbvz+il3BKU0IbSmjronuIJsaMYnXPeJtodcRu+TuIo
         6o9fPCfY9O/qDOBXJJ9HdZllmh1phA2zt9jZrPaw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([84.118.159.3]) by mail.gmx.com
 (mrgmx001 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0Lev1D-1gW9Jv2aHX-00qn2K; Sat, 13 Apr 2019 18:31:04 +0200
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] arm: mm: Export __sync_icache_dcache() for xen-privcmd
Date:   Sat, 13 Apr 2019 18:30:52 +0200
Message-Id: <20190413163052.11407-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AzDUzibd36FOOQJxaC6fIZllBiq7Mn1e8uBjDFef53QzS9zOeAu
 SJh3GGeTu4IGsEB2GN5k/SZMn0iRbT44T7tPyi5M48PZaTS3QKRO3jYsV6PWjQhgaNGly3k
 NkQ/bqWiNtICI0y81YZ6rpkwEebAvVmmy1v1BeyWJ9Fban2qRzNRK5hYp5BpvAjN3KcYJH9
 W3aBFqR3YmRpV7NiV9UXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h6FIh+ZF2Aw=:9MMWxFt5lwPXIdvEaHmDZV
 3mAZ2+jrnD5Cv8KRADik84+/g+dMLwWGyxnPa0j7q+Xy4PHq5wrvbEgXmvX5gt3VioJcpJAIw
 YMeMg9E7S+x+MghxW/O7p1SBGFzfepPXhQefmfe0rjFsye0P/F1BPgayokqJHbJma1hyDsmP1
 k2a/jUAz9QT9fNmjodUPyoG2mzCkay2y8u5mODftQewYBEYwvG8Gl8wrLBoC6BBxgnsWyRSbO
 thLlfN8b8q7ojOoqVYNtGxy3ZNvx6yUUXxCsxTENG+DPiNtI1L7lBdRZ3uDRqGTFkXqnj50j+
 5inUQB9E7/+jDKlHvYSvBhZaqTWVW1egsrLXH3uhaQAqeAx6aM6ceU9Ej8mS3a3ZJqKaGILLi
 2w38BbXWHFq/Ctki39y9EjmkAV25JcTD3myac8D6pRMt9DMmbEvi810t+rSk/E07bBxXan5Ec
 KycD/iO/W4mtHKeFu1v8BEEOAJqzQFhGIxg0jqSfGWLKhj03rgA/34Qj8YJpSS1C0Ii+bMncX
 8SSCz/3cwJLJ3jmJZvsd8hhTJIy0+Ti/Hlm4BtLAPvOzaWNtI4eKgC3371f19KNipxElcCOg1
 2zujpbuJaLebryfmp7FfY/h4MXB1lpu40/coUzJF4jJpkh22EJGhwcSUPDnR7WD2jasf7bqjI
 Lkq/9+NWgLvA/MMu1KEArSOqqGMe1q8tYqUOU1CQfidztyCQVQ60baq4nA2nrR34XzHwchCZs
 RBaAbEX78mcFpRtq7rXdNt8seQ1Mmk0S8pzUm8fTrPPMwv9SfdmgBXAxUTFd6zYF7lbFZpRJN
 GL1kGSBZBQ63RDSPtysHPtq6ouWKEyAUc+wI8yWYa1EVC6o6VZkrU4t96dvMP2x+SGljSEkfd
 lOhPB7dt66/c/vA2K7XXmJoWUoC3hsE2AVctxLabWx1etaw3b/DeyKWeihdycG
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch avoids
ERROR: "__sync_icache_dcache" [drivers/xen/xen-privcmd.ko] undefined!
observed when compiling v4.19.34.

The xen-privcmd driver, which can be modular, calls set_pte_at()
which in turn may call __sync_icache_dcache().

Cc: stable@vger.kernel.org
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 arch/arm/mm/flush.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 58469623b015..5345f86c56d2 100644
=2D-- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -295,6 +295,7 @@ void __sync_icache_dcache(pte_t pteval)
 	if (pte_exec(pteval))
 		__flush_icache_all();
 }
+EXPORT_SYMBOL_GPL(__sync_icache_dcache);
 #endif

 /*
=2D-
2.20.1

