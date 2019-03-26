Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B1BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B6020857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553581892;
	bh=/BIAqmIxMYDhG3Iuj0708wQhOuPdbAw8JlKV8tC3UTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t8Wco6jt8mod18EirGKhA7+EEr8kLSRVkao9RkPSfMSW/Jh9UzsybyBs7fcB84kup
	 52rqCwrD7GA7e4S8fw8GiEubFDKWFOuJpm8L3rNaX5xBJ43xOc4LIy9+i1XmE3EZWo
	 Ep+H8AyWA5QV9WeGQ4mVcYPGpbaaK/YyhIAzJn8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbfCZGba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:31:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfCZGb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:31:27 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CF1D20823;
        Tue, 26 Mar 2019 06:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553581887;
        bh=/BIAqmIxMYDhG3Iuj0708wQhOuPdbAw8JlKV8tC3UTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lwfpqoQSlLXwm2P4SgGSYLKv8M89NRsgykEJptVAmRv1fTZOE0/MOs+ggYQf4H/dh
         1O7q7IKBo3YrC/Re3JZ4zu5toOrLpLN/rB4G6TCO3PuUxG/G5MXdjvxBvNczHp2nuf
         rHR5mEoELz6rohOdegE1zhpixeh1S1hS21I5FQIY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, jean-luc malet <jeanluc.malet@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 4.9 05/30] udf: Fix crash on IO error during truncate
Date:   Tue, 26 Mar 2019 15:29:44 +0900
Message-Id: <20190326042607.756454144@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042607.558087893@linuxfoundation.org>
References: <20190326042607.558087893@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit d3ca4651d05c0ff7259d087d8c949bcf3e14fb46 upstream.

When truncate(2) hits IO error when reading indirect extent block the
code just bugs with:

kernel BUG at linux-4.15.0/fs/udf/truncate.c:249!
...

Fix the problem by bailing out cleanly in case of IO error.

CC: stable@vger.kernel.org
Reported-by: jean-luc malet <jeanluc.malet@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/udf/truncate.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -260,6 +260,9 @@ void udf_truncate_extents(struct inode *
 			epos.block = eloc;
 			epos.bh = udf_tread(sb,
 					udf_get_lb_pblock(sb, &eloc, 0));
+			/* Error reading indirect block? */
+			if (!epos.bh)
+				return;
 			if (elen)
 				indirect_ext_len =
 					(elen + sb->s_blocksize - 1) >>


