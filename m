Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19120C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E016B2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139830;
	bh=CpW0Vn87Th0ZQ3N4t6gOJVGPzw9DxzX7k9WURNiahXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zJzjEHPUbLjCTssp/hb9aGoKE7oRoXmQQOazT+hxXY5FNxw7lEw4P7VyDcRL8BnBM
	 RL1grHocxOpEdgZN0BhIb9lgSwA1+HLtZkwSEZH7S2wSImNNiL+/IqA5pyaZlwzqAx
	 XBOqAfBnsUctLuSwPUjzU7OMY/p7Wf7HOv0PmhZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733101AbfDARa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:30:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728698AbfDARa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:30:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 303BD20830;
        Mon,  1 Apr 2019 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139825;
        bh=CpW0Vn87Th0ZQ3N4t6gOJVGPzw9DxzX7k9WURNiahXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PVERkyywoLArg0ozmvteeETq2mA6ZMV6p7FnrMw0QCkRwcUlKo+6j6XIypg8odoDG
         h19DVDqA37Mfm3IxYyzCaF16hTLGc0zvSIdpGQLu1bzjY00OUXON0sXcvlGu7C3mnl
         XIQctpvvugLZA4dcTdklHdrQ3ZWY+d9GJEH9u5Bo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Michal Marek <mmarek@suse.com>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 025/131] kbuild: setlocalversion: print error to STDERR
Date:   Mon,  1 Apr 2019 19:01:35 +0200
Message-Id: <20190401170054.129546491@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wolfram Sang <wsa@the-dreams.de>

commit 78283edf2c01c38eb840a3de5ffd18fe2992ab64 upstream.

I tried to use 'make O=...' from an unclean source tree. This triggered
the error path of setlocalversion. But by printing to STDOUT, it created
a broken localversion which then caused another (unrelated) error:

"4.7.0-rc2Error: kernelrelease not valid - run make prepare to update it" exceeds 64 characters

After printing to STDERR, the true build error gets displayed later:

  /home/wsa/Kernel/linux is not clean, please run 'make mrproper'
  in the '/home/wsa/Kernel/linux' directory.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Michal Marek <mmarek@suse.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/setlocalversion |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -143,7 +143,7 @@ fi
 if test -e include/config/auto.conf; then
 	. include/config/auto.conf
 else
-	echo "Error: kernelrelease not valid - run 'make prepare' to update it"
+	echo "Error: kernelrelease not valid - run 'make prepare' to update it" >&2
 	exit 1
 fi
 


