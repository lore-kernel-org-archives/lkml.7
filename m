Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA82C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A59124305
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559171392;
	bh=xhyB6ilpQLz/eBsjEdAFa3wEjbF6NIvf4QsECV/WMcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1+ILbgQgNo1+6R3Gm1tXJXC8OkODKp0ofLDFD68QXXYNyQPI+gOOvVOFPInld/9kU
	 En3D95DsLv+0cNSZm8trSbn7fkZOEv/I3W0gUoQC0r96fAnXKMqSCqY2JED+nYPGm3
	 rH0CkAvOwwCV0JQo7tBkFzmMJ3y6juOu8omSAKhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfE2XJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 19:09:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47582 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfE2XJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=t7V/jAIyRWeGVCJDZeH1LhdUcZQK43LHg68xT8DRQOM=; b=gwVvUgnXfZyNeurHHgH90G15vz
        QUWoJ6dIMEAOTt8/Oq5juFdsLVVXXvXJIqv3dB7r75ikwSlHpbgsYP3ea/i+swQzYp9bGESSCcevy
        yA7+A25AE/5DBMUsh47XGJdqOyo/JuCb85Yf32Cg614KX+z6ac9kaeez7UlGjhAjbGmB0yxrORDIg
        Rep1gYn9l74D2KEYHj1Fa+Mbd5DpGhf01ph4dFbFh+Oyp0BF1yBVCKBgMnR4G6nnTfxpEliaADEQC
        xqGdFe1l+/hfCnl8YZpfM02Ss/wjvd5cZnWhxbD9kghzmkAozG87LlozG3MTdjUzyTPJiAJgipUX5
        P8uLfM0A==;
Received: from 177.132.232.81.dynamic.adsl.gvt.net.br ([177.132.232.81] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW7hQ-0000lH-Hw; Wed, 29 May 2019 23:09:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hW7hN-0007Th-Mf; Wed, 29 May 2019 20:09:33 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 07/10] scripts/documentation-file-ref-check: improve tools ref handling
Date:   Wed, 29 May 2019 20:09:29 -0300
Message-Id: <9992ab4f4728b99dddf2eb018b5a47509d0ebf24.1559170790.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559170790.git.mchehab+samsung@kernel.org>
References: <cover.1559170790.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a false positive on perf/util:

	tools/perf/util/s390-cpumsf.c: Documentation/perf.data-file-format.txt

The file is there at tools/perf/Documentation/, but the logic
with detects relative documentation references inside tools is
not capable of detecting it.

So, improve it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/documentation-file-ref-check | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/documentation-file-ref-check b/scripts/documentation-file-ref-check
index 05235775cc71..5d775ca7469b 100755
--- a/scripts/documentation-file-ref-check
+++ b/scripts/documentation-file-ref-check
@@ -127,7 +127,7 @@ while (<IN>) {
 		if ($f =~ m/tools/) {
 			my $path = $f;
 			$path =~ s,(.*)/.*,$1,;
-			next if (grep -e, glob("$path/$ref $path/$fulref"));
+			next if (grep -e, glob("$path/$ref $path/../$ref $path/$fulref"));
 		}
 
 		# Discard known false-positives
-- 
2.21.0

