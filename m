Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9569C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9C9218EA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555353925;
	bh=KR6aSEvNHR8dpkikGZPwihP6nIvxV3cnex0/K0fOEkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yuy9aqW+yQWotJ9Zs8h114QlBhY8GvygXgGeFxzfnCFdQT3U3OEkADPFojojvKnA/
	 tr+hzgOu1h2gpWeAl9hkzcDL5qmiDVFNjCgZF78iuy1U914Z1w7wfgZnHpF8jQE8li
	 i7Hh0g2M7fGyYrBObNB/mkOkZrq+r6w9C10SSz3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfDOSpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:45:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728335AbfDOSpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:45:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E343218EA;
        Mon, 15 Apr 2019 18:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353917;
        bh=KR6aSEvNHR8dpkikGZPwihP6nIvxV3cnex0/K0fOEkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cWJSLYddR9mq03cFrvFl95ceegjxOuLsxHrgPrjEThEH3Y75xfktUxEa2HE3Y6LOU
         iDk9DsqpfJOLG/rh0PGq5vKVDrzgtAtasa8rJsJY4ryGW9tfZzlOG+3DYIdBYmgDVu
         xMyYAyG8zP0TUNp0qEwmNJg+d9EpPeY7l8oV6Ei8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Suchanek <msuchanek@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 18/76] powerpc/64s: Enhance the information in cpu_show_spectre_v1()
Date:   Mon, 15 Apr 2019 20:43:42 +0200
Message-Id: <20190415183712.389439208@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit a377514519b9a20fa1ea9adddbb4129573129cef upstream.

We now have barrier_nospec as mitigation so print it in
cpu_show_spectre_v1() when enabled.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/security.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index d0e974da4918..f189f946d935 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -121,6 +121,9 @@ ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr, c
 	if (!security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR))
 		return sprintf(buf, "Not affected\n");
 
+	if (barrier_nospec_enabled)
+		return sprintf(buf, "Mitigation: __user pointer sanitization\n");
+
 	return sprintf(buf, "Vulnerable\n");
 }
 
-- 
2.19.1



