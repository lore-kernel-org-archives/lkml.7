Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D75C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5F120651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356198;
	bh=VaXOLE2WGm9xCzg1zqcLDIlB8qNwohGne1xxPBGKNy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zy4xEe/o82tECmsUpUPH4E+O/UsGisdGSheVjyhZn2TlUIyI7dW8Im0rvuLcmtHxg
	 Q/u4wb4wlp2DLuThaxX4R73Doo8KT1FDTxpZv4zHVwtzMHGNVs9haeyyHdlkldYW8D
	 gsfPp/Cil3+hIZLldD3zO5i73QdJhSozIHgOjyXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbfDOTHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:07:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729730AbfDOTHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:07:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58245218A1;
        Mon, 15 Apr 2019 19:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355255;
        bh=VaXOLE2WGm9xCzg1zqcLDIlB8qNwohGne1xxPBGKNy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WN6o4Ytq0zT2qdhESU2VkxK4+ntW6Q87+mXxDZHUrCrWcfyGXylsfHclOwL1B3e2P
         uEtEz2eTegeoRZPq/wKqJCSSK2K834HjzcWgorxNLIJHxtQRS/Xw4sms84CBRgQSHc
         XUXZUVSQDodwHItnCNoAypvWTlc5QAl/5ITSEO5c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 069/101] btrfs: prop: fix vanished compression property after failed set
Date:   Mon, 15 Apr 2019 20:59:07 +0200
Message-Id: <20190415183744.122598536@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anand Jain <anand.jain@oracle.com>

commit 272e5326c7837697882ce3162029ba893059b616 upstream.

The compression property resets to NULL, instead of the old value if we
fail to set the new compression parameter.

  $ btrfs prop get /btrfs compression
    compression=lzo
  $ btrfs prop set /btrfs compression zli
    ERROR: failed to set compression for /btrfs: Invalid argument
  $ btrfs prop get /btrfs compression

This is because the compression property ->validate() is successful for
'zli' as the strncmp() used the length passed from the userspace.

Fix it by using the expected string length in strncmp().

Fixes: 63541927c8d1 ("Btrfs: add support for inode properties")
Fixes: 5c1aab1dd544 ("btrfs: Add zstd support")
CC: stable@vger.kernel.org # 4.14+
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/props.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -366,11 +366,11 @@ int btrfs_subvol_inherit_props(struct bt
 
 static int prop_compression_validate(const char *value, size_t len)
 {
-	if (!strncmp("lzo", value, len))
+	if (!strncmp("lzo", value, 3))
 		return 0;
-	else if (!strncmp("zlib", value, len))
+	else if (!strncmp("zlib", value, 4))
 		return 0;
-	else if (!strncmp("zstd", value, len))
+	else if (!strncmp("zstd", value, 4))
 		return 0;
 
 	return -EINVAL;


