Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4140CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D28A214B2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="fGUWF2RS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389186AbfJWHCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 03:02:45 -0400
Received: from sender4-pp-o94.zoho.com ([136.143.188.94]:25453 "EHLO
        sender4-pp-o94.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfJWHCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 03:02:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571814155; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=DzTI8uAv37sSlDbbdSQNVDJBrLT5GQE0PmaiCQ4Eui7kbEUKiLv7afVIYpGPzN7cOirwUaSVMFO84U0u5fV0pkU4z1mJyhrOprGMzL/Ibm4zFIRPW07moFfGNn1B92Rt6X7RRpUxY1XE7VVXcKHTvYEvODnAWEqK5uHC0RaMXMw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1571814155; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To; 
        bh=QajU/YJB5JT8Ixayp/A46IHMn1VWSFYrqfNHTzzOn58=; 
        b=c0Vi3iP4qh+9hgvygZacDbe7YPnHn/iS9OkEYOb5ztwy1Rv+hYkbY7WEJnM74kCwRVHlZTumMsfXRyc7qMIoxCH2MoK6VNIBICU3vXLXpOshhZnhcnNxAvqeYnsqkeR76/U+mRaL9KuBsGfCTe64oqmYDuBDStP6BawmoZqyeHs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=RI1+cpvL/1dWIISsMmela5KA8qls5TZJOOda25LDKXBQAEtKuWoB+b4f3WjJGJWGSWYOVWQaiHDi
    OgYcwUPzHTzjYXz1NqDFO6CYaTkFAfHR1O2qNVQi5OgmndiVxTDX  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571814155;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=144;
        bh=QajU/YJB5JT8Ixayp/A46IHMn1VWSFYrqfNHTzzOn58=;
        b=fGUWF2RSBwTWzIZ6P2pu8dxFkwDvR2QUG3UqwxImgwcmNuHDp+qLWza2jdz26hSC
        hC4XVoe+OivXmLC/0FtaYOGVj4gbzkTOrXYnOT9z8bY6xIlp0f9G1MYFLLDJY/43tBz
        gM7+41JWqj8wKIWFUUicgFYKmmnDOqZd3BBG3xMs=
Received: from zhouyanjie-virtual-machine.localdomain (125.71.5.36 [125.71.5.36]) by mx.zohomail.com
        with SMTPS id 1571814153429169.98988820120655; Wed, 23 Oct 2019 00:02:33 -0700 (PDT)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, vkoul@kernel.org, paul@crapouillou.net,
        mark.rutland@arm.com, Zubair.Kakakhel@imgtec.com,
        dan.j.williams@intel.com
Subject: dmaengine: JZ4780: Add dmaengine driver for X1000.
Date:   Wed, 23 Oct 2019 15:02:15 +0800
Message-Id: <1571814137-46002-1-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571799903-44561-1-git-send-email-zhouyanjie@zoho.com>
References: <1571799903-44561-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.Add the dmaengine bindings for the X1000 SoC from Ingenic.
2.Add support for probing the dma-jz4780 driver on the
  X1000 SoC from Ingenic.


