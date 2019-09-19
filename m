Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493CEC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1229D217D6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568932448;
	bh=DdbsRQrasbBJPd+uNCTuwjdggFssW12cvLMg0WbkFUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BsrpTuYMYjUeZrE2VQ4zxJxEqS+DDchQkB0o4+46D7I72KmVj5Y95YQJ0H0kjYaOH
	 xlU0nUN6vYG5HWky9g6hIGRddJ87W+rzZ86nC0uHLdDxYdFTdIaL/FJP2zFWejrh+y
	 cQNRpAwPty4wPG4MPTyxXbvJjMKEFqr7H8/ixM1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405695AbfISWKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405672AbfISWK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:10:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5872721907;
        Thu, 19 Sep 2019 22:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931027;
        bh=DdbsRQrasbBJPd+uNCTuwjdggFssW12cvLMg0WbkFUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bXW6uRIf6Q+4DiBDmJcDO7Cz+c7zVeTWte0MLPcYQrBHfetEoNl9dbEjSIHSQoYDO
         kfhwxksUwuPPj6SpzlJJFY4MYXZLpO1IUMmG1Vz97awsOUnd97OlfOmNXYnDiaxDzo
         i9EuZyviKIcbuWZY3Ng5DMRD/q/4hsSLKUhlinLU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 100/124] tools/power turbostat: Add Ice Lake NNPI support
Date:   Fri, 20 Sep 2019 00:03:08 +0200
Message-Id: <20190919214822.828810769@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214819.198419517@linuxfoundation.org>
References: <20190919214819.198419517@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>

[ Upstream commit d93ea567fc4eec2d3581015e23d2c555f8b393ba ]

This enables turbostat utility on Ice Lake NNPI SoC.

Link: https://lkml.org/lkml/2019/6/5/1034
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/turbostat/turbostat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 56c3e041d4f93..0a80f3cc24e31 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4586,6 +4586,7 @@ unsigned int intel_model_duplicates(unsigned int model)
 		return INTEL_FAM6_SKYLAKE_MOBILE;
 
 	case INTEL_FAM6_ICELAKE_MOBILE:
+	case INTEL_FAM6_ICELAKE_NNPI:
 		return INTEL_FAM6_CANNONLAKE_MOBILE;
 	}
 	return model;
-- 
2.20.1



