Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FF4C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA6922314
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003275;
	bh=6b+sZdMwmOL7UbovoFHfnaF//OginANOAToqmKTpeK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CzrVS0LelU5nAVrhYlazAakfhpWQs5RSj3MyF2y+23nwfs4IymZyxkX2zClC95XSB
	 iZTGnrghN4bacvaBeFZhF/hPQGhgvgM7lEZL8E/IthoQFYctA418iYCJ6jGw69hWZu
	 XxljBbxumixFLSpkiXpsVG2FdgNRtRRYbdK9ySJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgABWOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:14:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:54806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgABWOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:14:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35D5B22525;
        Thu,  2 Jan 2020 22:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003270;
        bh=6b+sZdMwmOL7UbovoFHfnaF//OginANOAToqmKTpeK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cYlRzhzX4GA5pchB+aqJ0vRSSixfVh0YNznpwR5qhd9PvAWIgZ9fEhJmIE4OCsVvO
         /AsNZxunxrRRah3PdlnnXjXpr3Lr6FwHMc48spT8iUnnniNrKUKT/G8mR3GvLLV1zz
         UKRKi5rQIG82LE1KwCjMQhE6C+JG0XgQ8YCsOgKU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 065/191] powerpc/pseries/cmm: Implement release() function for sysfs device
Date:   Thu,  2 Jan 2020 23:05:47 +0100
Message-Id: <20200102215836.932643358@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Hildenbrand <david@redhat.com>

[ Upstream commit 7d8212747435c534c8d564fbef4541a463c976ff ]

When unloading the module, one gets
  ------------[ cut here ]------------
  Device 'cmm0' does not have a release() function, it is broken and must be fixed. See Documentation/kobject.txt.
  WARNING: CPU: 0 PID: 19308 at drivers/base/core.c:1244 .device_release+0xcc/0xf0
  ...

We only have one static fake device. There is nothing to do when
releasing the device (via cmm_exit()).

Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20191031142933.10779-2-david@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/cmm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/cmm.c b/arch/powerpc/platforms/pseries/cmm.c
index b33251d75927..572651a5c87b 100644
--- a/arch/powerpc/platforms/pseries/cmm.c
+++ b/arch/powerpc/platforms/pseries/cmm.c
@@ -411,6 +411,10 @@ static struct bus_type cmm_subsys = {
 	.dev_name = "cmm",
 };
 
+static void cmm_release_device(struct device *dev)
+{
+}
+
 /**
  * cmm_sysfs_register - Register with sysfs
  *
@@ -426,6 +430,7 @@ static int cmm_sysfs_register(struct device *dev)
 
 	dev->id = 0;
 	dev->bus = &cmm_subsys;
+	dev->release = cmm_release_device;
 
 	if ((rc = device_register(dev)))
 		goto subsys_unregister;
-- 
2.20.1



