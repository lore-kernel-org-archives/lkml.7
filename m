Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9714EC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F92218B0
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 08:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="AgtVFZJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404156AbfHBI2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 04:28:25 -0400
Received: from sender4-pp-o95.zoho.com ([136.143.188.95]:25573 "EHLO
        sender4-pp-o95.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390852AbfHBI2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 04:28:23 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1564734476; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=G4Cq8OYWfqhfhnlxc+GcZlAN4pHlgPyLls5CdBhz6k8fLnR0jR61OWAfnl/nlyaRq5eWAkU1yXW2cgVxYuZdITrs+UNP6JHfu1wLyATfPLa4N+6Fe1N/OSNcPWHJWXfcaGG3kbZTrxBP3clbpfpeIXET0wh85quhknusk45cSjo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1564734476; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=+3erHcEilJdLeorVhWvlSZIVgwfXIb0YRZhJi6Tmog8=; 
        b=jJZDszmq6S70ioYmlSNEIUorEHfA+xHM+IiOYCn7+s1ZvMze+UbFyNJnXHpTcVuX41Ei9vqClhGllwijPSpW5E5K8xkP7nOLcdeCx4+O+t/VojCPpiD7EQify6tPzTcP09Nh8cQXvmnapfM/yxZb8lDmnteMu3yeWwurIAZ39ZQ=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=N8oKCyBfacw495TAv4kUjyD9TGh+uHL5S23sX1GJoRBz0sctl9q/GCyG3W9CgPy55JmU+L4/r/EM
    lGVuxBeycyCc2pmA0h+hcIw66G25UBL1obM5kWi1xk0aYzzFMPxC  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1564734476;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; l=181;
        bh=+3erHcEilJdLeorVhWvlSZIVgwfXIb0YRZhJi6Tmog8=;
        b=AgtVFZJ9yuKQtKgw/4tDuCUS8Plkjx3ahFDmrRu5P7/RY3irf478hYk58U/sZcoD
        vIkpfIZAsI+NOwCeAxhXiq+me01gZ8kcApGIVhcQfbmGHoQXFSGLT+vLLdHyzJk5KYh
        6EkQliAgn194WTd6XgRjB9uN3oI8DA1kVC18OCNs=
Received: from localhost.localdomain (125.71.5.36 [125.71.5.36]) by mx.zohomail.com
        with SMTPS id 1564734473888282.7306527180192; Fri, 2 Aug 2019 01:27:53 -0700 (PDT)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        paul@crapouillou.net, paul.burton@mips.com, jhogan@kernel.org,
        malat@debian.org, gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, syq@debian.org, chenhc@lemote.com,
        jiaxun.yang@flygoat.com
Subject: MIPS: Ingenic: Fix bugs when detecting X1000's parameters v4
Date:   Fri,  2 Aug 2019 16:27:35 +0800
Message-Id: <1564734457-48801-1-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564498510-3751-1-git-send-email-zhouyanjie@zoho.com>
References: <1564498510-3751-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1->v2: Use "set_c0_config7(BIT(4))" to simplify code and add comment.
v2->v3: Split patch and use "MIPS_CONF7_BTB_LOOP_EN" to instead "BIT(4)".
v3->v4: Change the commit title.


