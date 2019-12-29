Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E769C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEAFB2253D
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642192;
	bh=hrFbxjNhvsrrvY+oqXEKDGCsS2EywNEgduk9cGEsG8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vivt+ZIFf4oNj6XGCk3XP7XoRELAytm7no0Owh3/rw3lP17vYSMmxEIIKcqDNI0zz
	 VUqOb3l7sjB15Mm81//HQ1PEBYljwt43WugmSF1EUeonAaYAhjNfQNs1WMwLlcnhUp
	 bWWPL1JS0Zhmfd2+NmBJEuC/p7WIJsMqBIYI0hh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733081AbfL2R4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:56:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:45972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733064AbfL2R4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:56:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20DC8222C3;
        Sun, 29 Dec 2019 17:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577642184;
        bh=hrFbxjNhvsrrvY+oqXEKDGCsS2EywNEgduk9cGEsG8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0hx68a1LIJlTCYXWoek7YHUelWYsa6DQROmxeXu9BtHwOKxYMiACKl7NwDqtKBdOs
         cBBPAuOPU2MgragYSoedXbeDBxPCnRY5/r7qiJWSwwDzv3q5vPa1Lt2LtabCf++mNx
         yEvpokpkm4JYV2Y7RyoT2IgFEQ4sNFkOPqIm9brQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Benc <jbenc@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Willem de Bruijn <willemb@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 324/434] selftests, bpf: Fix test_tc_tunnel hanging
Date:   Sun, 29 Dec 2019 18:26:17 +0100
Message-Id: <20191229172723.491154593@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Benc <jbenc@redhat.com>

[ Upstream commit 3b054b7133b4ad93671c82e8d6185258e3f1a7a5 ]

When run_kselftests.sh is run, it hangs after test_tc_tunnel.sh. The reason
is test_tc_tunnel.sh ensures the server ('nc -l') is run all the time,
starting it again every time it is expected to terminate. The exception is
the final client_connect: the server is not started anymore, which ensures
no process is kept running after the test is finished.

For a sit test, though, the script is terminated prematurely without the
final client_connect and the 'nc' process keeps running. This in turn causes
the run_one function in kselftest/runner.sh to hang forever, waiting for the
runaway process to finish.

Ensure a remaining server is terminated on cleanup.

Fixes: f6ad6accaa99 ("selftests/bpf: expand test_tc_tunnel with SIT encap")
Signed-off-by: Jiri Benc <jbenc@redhat.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Willem de Bruijn <willemb@google.com>
Link: https://lore.kernel.org/bpf/60919291657a9ee89c708d8aababc28ebe1420be.1573821780.git.jbenc@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/test_tc_tunnel.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_tc_tunnel.sh b/tools/testing/selftests/bpf/test_tc_tunnel.sh
index ff0d31d38061..7c76b841b17b 100755
--- a/tools/testing/selftests/bpf/test_tc_tunnel.sh
+++ b/tools/testing/selftests/bpf/test_tc_tunnel.sh
@@ -62,6 +62,10 @@ cleanup() {
 	if [[ -f "${infile}" ]]; then
 		rm "${infile}"
 	fi
+
+	if [[ -n $server_pid ]]; then
+		kill $server_pid 2> /dev/null
+	fi
 }
 
 server_listen() {
@@ -77,6 +81,7 @@ client_connect() {
 
 verify_data() {
 	wait "${server_pid}"
+	server_pid=
 	# sha1sum returns two fields [sha1] [filepath]
 	# convert to bash array and access first elem
 	insum=($(sha1sum ${infile}))
-- 
2.20.1



