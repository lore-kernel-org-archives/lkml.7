Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DF6C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0746D2084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560800287;
	bh=Ou8ovWcUbQ7QgJV1jf4OKeCz/aEauP8/c2IuQt74M9g=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=D8iMfZ4Wsyuxz+e7FH3CgpI+S8s7ahvwHICdIeoiCNdMkfvVgl2cYUJUTUQ9ASsY1
	 OE1c+PifgTTl2QHzOy9G6MRzuY6+OI/kUwrMcEsCaWdNHrvbSrRQsq9OKbkMeB9XSd
	 NihUb9WPSIzl+wg4qaoENe4Ku682yWjJ8CUbxA3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfFQTiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:38:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32788 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfFQTiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5xRzFtDdaivjnv581uo/jwZarInLXzLaBnfMiJtw2P4=; b=oTQkCjimhA9QyQPppsvvXssX6
        +TAuWE5s3YBqDGLe3vudoWbIeJxwx1r2klft9CRq0y+WXixQqWKJWYaGqcy9iSdkGy6W8piXK1ALz
        JtM9cvEuuAwsEuOdd3sw4PDgisU2FwvuSB61f07HkLthRE42WUyFptK7k7dntcwbEm+NoNYXAQ1hr
        /rJhiAs5J6I7689enMHgmkciNrPm0S0EQ+VuFKcNRIejrVRveC/8c0M2P8D/OIcYfvX6obJlM1I7C
        4O9yIR7yvYEuXpWB96tDSy9PSq4FiN8lkOZ9hxoEOscW0Vo9BKYH8AAGbFrXbtW9LgE/tStE/p4dd
        6jEhzeOcw==;
Received: from 179.186.105.91.dynamic.adsl.gvt.net.br ([179.186.105.91] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcxS8-0001Y2-GO; Mon, 17 Jun 2019 19:38:04 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hcxS6-0002jG-5T; Mon, 17 Jun 2019 16:38:02 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/2] scripts/get_feat.pl: handle ".." special case
Date:   Mon, 17 Jun 2019 16:38:00 -0300
Message-Id: <59a9078408e4c4bf593c60af48e30ddfee845354.1560800240.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The status ".." Means that the feature can't be implemented
on a given architecture.

The problem is that this doesn't show anything at the
output, so replace it by "---", with is a markup for a long
hyphen.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---

In time: this patch fixes an small issue with the series I just posted.

 scripts/get_feat.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/get_feat.pl b/scripts/get_feat.pl
index 401cbc820caa..79d83595addd 100755
--- a/scripts/get_feat.pl
+++ b/scripts/get_feat.pl
@@ -141,6 +141,8 @@ sub parse_feat {
 				$max_size_arch = length($a);
 			}
 
+			$status = "---" if ($status =~ m/^\.\.$/);
+
 			$archs{$a} = 1;
 			$arch_table{$a} = $status;
 			next;
-- 
2.21.0


