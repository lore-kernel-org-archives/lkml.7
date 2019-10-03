Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102A4C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28BE20673
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570121802;
	bh=u0uuZNqbC5y4WeD1oLHRxcr3SNy3Eqtmb8PtIZipKPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ylef5wdma+c4hGvnjIvMhUoH32hSXU9/4Z9VN+6o/9lAojFBiCYyoEKxEhWMqBRzo
	 5J9Rb15jVt7KlKv1SXp6mnw3XNtUuCf99/61ItnnP4zdkmAcHb7LtnD0kJdBX3bywk
	 UZggJ4v4AGDDsu8p8cEDM7RIg1GJrLJj2mP0RrWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393098AbfJCQux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:50:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405948AbfJCQuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:50:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B17620865;
        Thu,  3 Oct 2019 16:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121440;
        bh=u0uuZNqbC5y4WeD1oLHRxcr3SNy3Eqtmb8PtIZipKPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rWycyvCJH1S4/bTviqedA8axPD9uWS4VF2XW0ZIcq6Dilza8mfqB+qgC2c+ZHOZzc
         BDQBqCIJwrBiHZxvheKAXtrfM/3UDGsSCHXphijEmd0BgA2H26ShDuNUYPFl3VUcRM
         0yHNm143ofM2bGUXO6cY3Jb90197gZM7whq0P95Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 5.3 279/344] staging: erofs: cannot set EROFS_V_Z_INITED_BIT if fill_inode_lazy fails
Date:   Thu,  3 Oct 2019 17:54:04 +0200
Message-Id: <20191003154607.555887592@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

commit 3407a4198faf01c9d7596c45b8606834b8dfc2b7 upstream.

As reported by erofs-utils fuzzer, unsupported compressed
clustersize will make fill_inode_lazy fail, for such case
we cannot set EROFS_V_Z_INITED_BIT since we need return
failure for each z_erofs_map_blocks_iter().

Fixes: 152a333a5895 ("staging: erofs: add compacted compression indexes support")
Cc: <stable@vger.kernel.org> # 5.3+
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Link: https://lore.kernel.org/r/20190819103426.87579-3-gaoxiang25@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/erofs/zmap.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/staging/erofs/zmap.c
+++ b/drivers/staging/erofs/zmap.c
@@ -86,12 +86,11 @@ static int fill_inode_lazy(struct inode
 
 	vi->z_physical_clusterbits[1] = vi->z_logical_clusterbits +
 					((h->h_clusterbits >> 5) & 7);
+	set_bit(EROFS_V_Z_INITED_BIT, &vi->flags);
 unmap_done:
 	kunmap_atomic(kaddr);
 	unlock_page(page);
 	put_page(page);
-
-	set_bit(EROFS_V_Z_INITED_BIT, &vi->flags);
 out_unlock:
 	clear_and_wake_up_bit(EROFS_V_BL_Z_BIT, &vi->flags);
 	return err;


