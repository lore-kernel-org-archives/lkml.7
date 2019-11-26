Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A021C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 17:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F8520722
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 17:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="m3CRJ8Gm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbfKZRHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 12:07:20 -0500
Received: from sender4-pp-o98.zoho.com ([136.143.188.98]:25864 "EHLO
        sender4-pp-o98.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfKZRHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 12:07:19 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574788000; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=AhsO/clZZEG3jjlJcaOADFNrZBs3QQUAtftWtms4XMsUusy0OD0kiJ9DjEMbZp5IZ/KfISPmTnUKwlGdcNN/wKExD2ixWO4z6YpH/KhMXaTMYk/EViQcP93o6L19a9nwSZeFj3JKUp59XfIgVYb9kdkHxEof6Y0eJi+aH6j0b9I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1574788000; h=Cc:Date:From:Message-ID:Subject:To; 
        bh=9rst/KNdAOi1RygK7VeZo3nqOJHjpCDuY0gWSPfISSU=; 
        b=nEsBacAtJFBBLIkK0pZf5nhw46Hj1ovfOqWAc06cQKQ0JEQMpylhn5sthA5kVRL8pQcl2xBc/kwuLcf498oiAOBAWM1OWfQRYzINXFcs4EnFsXQltjPNFQpVptqakHhgGvqlSuxxthWGvwLsWUcmBC39jNAISo0QRkwJgcCjhbw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=PrUcg4B8YQkhaYO3RAsVP397+Ray7U4ckmc58zzM5MfVVs6LDqX1aedWqITpBqADIg13q7pOkH+Y
    hSrmyQGujf3BLkBmhxeONV+KkBijBwKrBVrg8q394eyjxhFFXqJb  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1574788000;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=9rst/KNdAOi1RygK7VeZo3nqOJHjpCDuY0gWSPfISSU=;
        b=m3CRJ8Gm1n6xSy/UlbyGnr4sGSlDYP6BHOn1mW83Yrgj47i9JusUzK6o64AEdhv0
        s2ZV6vemjuBineNwZstchk0ionZDUKs3AERcedvHMu9OR3chhPJWg1Li7yd6fdILrPk
        yc2curyfIEAF4+vXd0ZE41VKREoHvb90m1aeJHfI=
Received: from zhouyanjie-virtual-machine.localdomain (171.221.112.214 [171.221.112.214]) by mx.zohomail.com
        with SMTPS id 1574787998363855.623005154438; Tue, 26 Nov 2019 09:06:38 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, paulburton@kernel.org,
        jhogan@kernel.org, mripard@kernel.org, shawnguo@kernel.org,
        mark.rutland@arm.com, syq@debian.org, ralf@linux-mips.org,
        heiko@sntech.de, icenowy@aosc.io,
        laurent.pinchart@ideasonboard.com, krzk@kernel.org,
        geert+renesas@glider.be, paul@crapouillou.net,
        prasannatsmkumar@gmail.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, 772753199@qq.com
Subject: Add initial support for Ingenic X1000 SoC and Y&A CU Neo board v4.
Date:   Wed, 27 Nov 2019 01:06:08 +0800
Message-Id: <1574787974-58040-1-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.Adjust the description in "devices.yaml" to make it more reasonable.
2.Adjust "model" in "cu1000.dts" to match the description in "devices.yaml".
3.Adjust "bool" in "Kconfig" to avoid duplicate names with subsequent boards.
4.Add pdma controller DT node and Update defconfig for pdma controller.


