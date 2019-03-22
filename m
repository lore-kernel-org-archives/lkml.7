Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A60C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020B021A4A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256110;
	bh=ETm5/AIDsD1XlGz2xtT0seS9TcpXkNef7X4JNaNXhZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EtK+/qsO2QHLZDUCU+NlQTTailj9cjTrkGigQBu4eLO50DchCQut47UWvQ1kEUaQn
	 Z6PY7cLIDsbeoMILfOMLiOvTE/PklJ2ua+6xOyNobd4ffeJt0qvOuptSUYBa6CZYxi
	 sWVsL9m4xf1auumiXCSIZSEBIWQRIphXUy9oRXcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388262AbfCVMBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:01:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388255AbfCVMBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:01:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCA102192D;
        Fri, 22 Mar 2019 12:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256105;
        bh=ETm5/AIDsD1XlGz2xtT0seS9TcpXkNef7X4JNaNXhZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BzylWYAKtyYcg16xM3RW/JyoBIbqhEay8IG+JQFp1/7mB/8O81qvVkDA3QvSAtvFk
         UFQi2qYvIF7RxiU/CczPBRXmO7IE6yKucNa9hLhxq0kOgQ+AJtA9/qiQ6ufcx/viZ1
         xJLf9BgKQ0BS2h4cMY9feetdPu4AQfrxJC+p9RHc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 110/280] selftests: fib_tests: sleep after changing carrier. again.
Date:   Fri, 22 Mar 2019 12:14:23 +0100
Message-Id: <20190322111313.394820760@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit af548a27b158d548d41e56255e6eaca1658cc3be ]

Just like commit e2ba732a1681 ("selftests: fib_tests: sleep after
changing carrier"), wait one second to allow linkwatch to propagate the
carrier change to the stack.

There are two sets of carrier tests. The first slept after the carrier
was set to off, and when the second set ran, it was likely that the
linkwatch would be able to run again without much delay, reducing the
likelihood of a race. However, if you run 'fib_tests.sh -t carrier' on a
loop, you will quickly notice the failures.

Sleeping on the second set of tests make the failures go away.

Cc: David Ahern <dsahern@gmail.com>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/fib_tests.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 0f45633bd634..a4ccde0e473b 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -385,6 +385,7 @@ fib_carrier_unicast_test()
 
 	set -e
 	$IP link set dev dummy0 carrier off
+	sleep 1
 	set +e
 
 	echo "    Carrier down"
-- 
2.19.1



