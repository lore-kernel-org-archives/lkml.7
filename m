Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7502C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 06:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FDE2089D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 06:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="W6LwwNZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfKUGUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 01:20:30 -0500
Received: from sender4-pp-o98.zoho.com ([136.143.188.98]:25835 "EHLO
        sender4-pp-o98.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKUGUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 01:20:30 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574317214; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=AOkv8j0EE7P/Zv/V2ChKHfPM12CDL3YuVF4r2zlx1UFXsRjfwD0IaoGGAlzIuwDFdwkPXzy9jgfLbetPFdxhUNrLs370OscjaBEURx3uqnS+KAClMPsKAhiBv0km36/nMY43Sny1XExbDnhGba+w5/37yzMih0Nc5fMIEFKH4Qc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1574317214; h=Cc:Date:From:Message-ID:Subject:To; 
        bh=FAy7jqquQAapheBDzp1cM7A9lHyJZLucFezdW+jrC04=; 
        b=gr+7nFuhVHnMPewM270z6RTExhBRMjmVabNX23K5SjtNlUEGSUD9uMRc/Jthy9XcqKq6cvPofrcTZw4LaVXsBHsBU8BVD3FdOtknyzpEo4e0WFlrwwhAfQOuYM5p4RvL2jzOOoZTh3QazHw4b6dATknZg3IHeafzETefgX/MoBA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=MWFQ7/e1+yMJJC1BUNqt7wHm2xU3CgGoz/r8NR0zyibQF5Ab1nJ7pwwYUfvfdHqevh91y+3glnjH
    EKxdeYp6c4rzeml5k42barXQArgadb+WLwLRH9FihUARHuV/y3uK  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1574317214;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id; l=110;
        bh=FAy7jqquQAapheBDzp1cM7A9lHyJZLucFezdW+jrC04=;
        b=W6LwwNZ8OQvaYXV3Emv/Dy9lJq0iMsZMbDQHg/9v3CphVPDbhfJzejmsyCV9tCK8
        x4NuBtDAeTCh8CV0Twz+K8CfC83sg1wW80BDO5duhaADm/8K/3mgBbdCtnBa8JU23AU
        aN0ImIAiGswbcbNggG1gKAKNsoQPkiXROr4romHI=
Received: from zhouyanjie-virtual-machine.localdomain (182.148.156.27 [182.148.156.27]) by mx.zohomail.com
        with SMTPS id 157431721405347.50658671788722; Wed, 20 Nov 2019 22:20:14 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, paulburton@kernel.org,
        paul.burton@mips.com, linus.walleij@linaro.org,
        paul@crapouillou.net, robh+dt@kernel.org, mark.rutland@arm.com,
        syq@debian.org
Subject: Fix bugs in X1000/X1500 and add X1830 pinctrl driver v3.
Date:   Thu, 21 Nov 2019 14:19:39 +0800
Message-Id: <1574317183-126374-1-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2->v3:
1.Fix typo in "Add missing parts for X1000 and X1500."
2.Add pinctrl drivers for the PWM of X1830.


