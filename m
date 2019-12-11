Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600ABC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7C32073B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576079827;
	bh=bMEM8CgX/6uIErmN9B5ttGlNi4wBwVVcAmuXfFf4Z8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TnkVGqvnm3fP1qlgooTwVLQOi0Z5vOLDrAFncx4AyFWllFsY3tP9T2d/At21I3UXU
	 2Pvom5c75aDYcHE194vtfUf7wxelTS4A09u6HHocuL7Xy1NyPEHDPyzaqhOrwPBJxw
	 pZfQqvBup4tWTg/EGvCGAbKz90e+i1eCWW9ncFek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbfLKP5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:57:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:41284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730821AbfLKPPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:15:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0E4424654;
        Wed, 11 Dec 2019 15:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077316;
        bh=bMEM8CgX/6uIErmN9B5ttGlNi4wBwVVcAmuXfFf4Z8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fVzuyl3QbVp58nLw8ZDixxTGDWA0rigQ6sGrlPXl6MVMhpQn5FcW1V3rrDCPUsnyk
         k71hVPWyYOfdU8rdACZp0dAeDhjMN2QqiG/6/sMcm9jTDqfPlqcaE3GC4H8wNdUVPt
         Ask8T1Vrk/8nW3pNt/MCnNqHuIhStHdzo04xVQEQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 099/105] RDMA/qib: Validate ->show()/store() callbacks before calling them
Date:   Wed, 11 Dec 2019 16:06:28 +0100
Message-Id: <20191211150303.441176134@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150221.153659747@linuxfoundation.org>
References: <20191211150221.153659747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 7ee23491b39259ae83899dd93b2a29ef0f22f0a7 upstream.

The permissions of the read-only or write-only sysfs files can be
changed (as root) and the user can then try to read a write-only file or
write to a read-only file which will lead to kernel crash here.

Protect against that by always validating the show/store callbacks.

Link: https://lore.kernel.org/r/d45cc26361a174ae12dbb86c994ef334d257924b.1573096807.git.viresh.kumar@linaro.org
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/qib/qib_sysfs.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/infiniband/hw/qib/qib_sysfs.c
+++ b/drivers/infiniband/hw/qib/qib_sysfs.c
@@ -301,6 +301,9 @@ static ssize_t qib_portattr_show(struct
 	struct qib_pportdata *ppd =
 		container_of(kobj, struct qib_pportdata, pport_kobj);
 
+	if (!pattr->show)
+		return -EIO;
+
 	return pattr->show(ppd, buf);
 }
 
@@ -312,6 +315,9 @@ static ssize_t qib_portattr_store(struct
 	struct qib_pportdata *ppd =
 		container_of(kobj, struct qib_pportdata, pport_kobj);
 
+	if (!pattr->store)
+		return -EIO;
+
 	return pattr->store(ppd, buf, len);
 }
 


