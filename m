Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F102AC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 17:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55FC2075C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 17:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="VvKIDMFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfG1RfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 13:35:01 -0400
Received: from sender4-pp-o95.zoho.com ([136.143.188.95]:25529 "EHLO
        sender4-pp-o95.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfG1RfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 13:35:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1564335289; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=FkkEcpJMTmydDx2O2mE7TXkW7mjkMPKwGHl7ASueQGkdg2J7SDhIuzmK73NOGZblhP3z47fC4uPK4DqaBgBAJcyK8ovHKbtX4BQ4PSNjZBc2d1+t8UxQAY5kw4LNzkUORIiOKp8aFDoTV50cSeAZaARzsJwmhCpfP4MmUTrfTWg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1564335289; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=G6oQedkI8J0YrP2JXslPEck2U7srvknFaEmDIBRZKdE=; 
        b=onE3tNhCMnEcbFwsxqJMAdb32lbjYmqhcDtjpbWsmzzGAeQhZ+A9O3FLaxMmwtr5C2ECWfmNe4tZmQmIzM+y8xGhRyWZG025IOEBbzJfJnEHD/hvSBxESRYo7jn6bqmbR9pImk8OFEMAuH1Zb87Q7ZqSXpSRQ/o+LjZwXUsSifA=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=iebehV1jM85MXTDn4KFFK2phE8K5R/jxbi2eI5cD2eWnBGmJeiEoqISpzyorVnZzTN5lDcOI8/SO
    69uyO7bz7Nzq6IJp3OW2pUxFKfBVxNrVQXQ290UZlw2dkxmRtBDj  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1564335289;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=230;
        bh=G6oQedkI8J0YrP2JXslPEck2U7srvknFaEmDIBRZKdE=;
        b=VvKIDMFBhNgTJCT0vdrNoc1qbrAJyzYfBq8k63O8wxg47yQGLd8Xm0i9yDACn5SV
        syF+OR0DxnC/+v29Ib6DYIivGyArqlgFDpoKh0OnIiHNVvFs1SChnPa12BBiHWARFuS
        530RBO5V61iAZ+qfbDXuU2OSkxE3Pciw1Oj+qglg=
Received: from zhouyanjie-virtual-machine.localdomain (171.221.113.137 [171.221.113.137]) by mx.zohomail.com
        with SMTPS id 1564335287626688.0546299602289; Sun, 28 Jul 2019 10:34:47 -0700 (PDT)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, tglx@linutronix.de,
        mark.rutland@arm.com, jason@lakedaemon.net, marc.zyngier@arm.com
Subject: Add Ingenic JZ4760 and X1000 and X1500 irqchip support v4.
Date:   Mon, 29 Jul 2019 01:34:29 +0800
Message-Id: <1564335273-22931-1-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548517123-60058-1-git-send-email-zhouyanjie@zoho.com>
References: <1548517123-60058-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1->v2: Replace "__fls(pending)" with "bit" in function "generic_handle_irq".
v2->v3: Add support for probing irq-ingenic driver on JZ4760 and X1500 Soc.
v3->v4: Combined with patches 5 and 7, combined with patches 4, 6 and 8.


