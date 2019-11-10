Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B01C17443
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 09:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA69207FA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 09:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="Z1oJxFTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfKJJ3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 04:29:54 -0500
Received: from sender4-pp-o98.zoho.com ([136.143.188.98]:25851 "EHLO
        sender4-pp-o98.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfKJJ3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 04:29:54 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573378178; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=gHV3k9hZcXvSfznkfz/qV1dyxDoQqfCXleCenSeNucbDY4rBWrb0R54D+3+a4PVSsMUKsGC3TFZ3efccYB4ao8LYwIKdVi2Ipik9R38Ivs+7T2WBBu3/886iyZDqtITuqnxvNVXj9Li9hhCHqXvfxA2v3BBoB63UKFmq9G9lSwg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1573378178; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To; 
        bh=RwiJDZMBHlfZojS1baXbRX4kFLS7JIIBhzbGeIpNw3o=; 
        b=FBfDDAQwV14qZARH1+kXZ46SBJpWKvRJpplrpAixanW9adggOpoNcxBywA3oCbjpDn1g1/FVLYTHREraAxZF/bBNeWR94PuvLf6faBdaIgrknnj763DTqSe5wm9MPNrO1bPeYwl53Q+xzhQvjqKD4JHT8SkRCJ6reEzbMpbHa78=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=FA0Fso/iUEpmhuQqzFFQGcgPrEGA8RZq4BBdlAnK/+gF/1kIdcn+xO3kEVgd8pXV2RrzcgboOUeC
    gzMyveoIY0IwkBEFZWOA1LxxVgV2jPEAFlSSF+iAAmJ6XUg+yAWR  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1573378178;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=383;
        bh=RwiJDZMBHlfZojS1baXbRX4kFLS7JIIBhzbGeIpNw3o=;
        b=Z1oJxFTx4puNX/mBC1fKo55Lzk5vMhjTnb42XqsM4+UivXFIkK1J8NyyqTz7fBO4
        dWN407e5bGzFcACI6YkMNoc3giCiiD08zXZHBIBeFPpRNmWpd+Tp6QKiZSKn2v93ITY
        hDXuED1cSPyYytDKX7eJLnAKsJ0HWjNvIe5rMYVE=
Received: from localhost.localdomain (171.221.113.200 [171.221.113.200]) by mx.zohomail.com
        with SMTPS id 157337817689296.20366141280374; Sun, 10 Nov 2019 01:29:36 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, mturquette@baylibre.com,
        paul.burton@mips.com, sboyd@kernel.org, robh+dt@kernel.org,
        syq@debian.org, mark.rutland@arm.com, paul@crapouillou.net
Subject: clk: X1000: Add support for the X1000 v3
Date:   Sun, 10 Nov 2019 17:28:20 +0800
Message-Id: <1573378102-72380-1-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571421006-12771-1-git-send-email-zhouyanjie@zoho.com>
References: <1571421006-12771-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1:
1.Add the clock bindings for X1000 from Ingenic.
2.Add support for the clocks provided by the CGU in the
  Ingenic X1000 SoC.

v1->v2:
use BIT() macro instead left shift, add a call of
"ingenic_cgu_register_syscore_ops()", replace "CLK_OF_DECLARE"
with a "CLK_OF_DECLARE_DRIVER".

v2->v3:
1.Modify the wrong register in "X1000_CLK_MAC".
2.Add the clock of I2C0~I2C2.


