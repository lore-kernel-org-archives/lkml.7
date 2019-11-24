Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957E9C43215
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 14:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3142073F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 14:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="toytxy0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKXO7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 09:59:53 -0500
Received: from sender4-pp-o98.zoho.com ([136.143.188.98]:25892 "EHLO
        sender4-pp-o98.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfKXO7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 09:59:53 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574607563; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=eOXaGnmiulyzcUt/8E1KXcD8y/YgAKz6LN6krKRVPHCkcs9mJk3AHUqo4lsmJiFeIZ6CbaB1zTb7K3QOXe4CzYUPZQMa8SmfFrVbUf6XfkSQtWF5yetSMl7XJwfelWs/bK4majpjCJesLRV1BW3WWu53rAe+mSGxO+AFnPCIcBE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1574607563; h=Cc:Date:From:Message-ID:Subject:To; 
        bh=u/19MAMtVmEd/wcn3DLYxvKXmR4DrupttRYHZbWjPzI=; 
        b=MQliOkGHi0bdSuZS041Qi/TV8DM9QPXNpvGPcBKGt9lIDIjBnSqgDjXiM7AtHtOjR1Qqxm2mYItFVFH5JU62VCI4iKgrX3SpyQ+TGdhQk9sBDwFTzVlWog71uzMTQxqtpvEv5BntjhZ3cZE98kAGGrhYhIZkPDDUHqzfM+L/tcE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=pqFSsOp3Qn24gWotqzE6o29sH+y21Hk8tWP+OaPz9CSgBPSBY8tby7h3HFFYhS3o5WCFcT0NUpjJ
    x57mOqklQa+hzdgVJzFJEobiDsAMnxVZspLr+T6BWO3yKOEERxCy  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1574607563;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=u/19MAMtVmEd/wcn3DLYxvKXmR4DrupttRYHZbWjPzI=;
        b=toytxy0K8Kb7BFjjsgUTIK9HIsDzF4C77F2qXSFYncovcYUFIGE5cA249Y77CTyd
        40d+CXv++RIHDrhoJMdoP9WI4QDz2U7C+CxEO3Hz62n84QVAb3gvfYIAeqU6bVjxgD+
        xM3zIr8aweUfDFMOruqMFAwwlZpSuL/r5ff67IUk=
Received: from zhouyanjie-virtual-machine.localdomain (171.221.112.247 [171.221.112.247]) by mx.zohomail.com
        with SMTPS id 1574607560908801.4503934533182; Sun, 24 Nov 2019 06:59:20 -0800 (PST)
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
Subject: Add initial support for Ingenic X1000 SoC and Y&A CU Neo board v3.
Date:   Sun, 24 Nov 2019 22:58:58 +0800
Message-Id: <1574607542-25670-1-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2->v3:
Drop the "apb" node in x1000.dtsi


