Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EA3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9C5205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414269;
	bh=XwjLRCB+WXJ/BYIPTLfeyqV65tgqyv2W7KXV6NErv/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=STWq/PnNd1xLJD+qnw0fxWsMP3r4/mf33h072jK72BifFPSAU9quXtCV8XVizrvP4
	 0mIBeDo1uc82N7NVnpIL4lkHbdr3AoMBEsX5pX4VdD7LNm9cigvUP7QLWwPgdEeI1H
	 QROvNH5Tk2EqExGEiSJSy/lGaFqFcy6j9G+BZDhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbfCLSLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:11:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbfCLRLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:11:45 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6774214AE;
        Tue, 12 Mar 2019 17:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410705;
        bh=XwjLRCB+WXJ/BYIPTLfeyqV65tgqyv2W7KXV6NErv/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tYOaRa/RUctVdMMzGdPq8W11UBksP6EXcFYQeea3pmrlKSDADxN/dKmOlv65uZ0F7
         dXEV2GiwS/Vc3jvKYFtD+mdhHuyJfAS+WgM4fAmoZXg3+BDrUmcKJVINpW4Mc4uq5t
         AOdmNzRj9WErgL4do52ArnKiQkaLmVFIkyALKLI4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Song Liu <liu.song.a23@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 003/171] perf ordered_events: Fix crash in ordered_events__free
Date:   Tue, 12 Mar 2019 10:06:23 -0700
Message-Id: <20190312170348.156374025@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 99d86c8b88393e29cf07c020585f2c8afbcdd97d ]

Song Liu reported crash in 'perf record':

  > #0  0x0000000000500055 in ordered_events(float, long double,...)(...) ()
  > #1  0x0000000000500196 in ordered_events.reinit ()
  > #2  0x00000000004fe413 in perf_session.process_events ()
  > #3  0x0000000000440431 in cmd_record ()
  > #4  0x00000000004a439f in run_builtin ()
  > #5  0x000000000042b3e5 in main ()"

This can happen when we get out of buffers during event processing.

The subsequent ordered_events__free() call assumes oe->buffer != NULL
and crashes. Add a check to prevent that.

Reported-by: Song Liu <liu.song.a23@gmail.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Song Liu <liu.song.a23@gmail.com>
Tested-by: Song Liu <liu.song.a23@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190117113017.12977-1-jolsa@kernel.org
Fixes: d5ceb62b3654 ("perf ordered_events: Add 'struct ordered_events_buffer' layer")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/ordered-events.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 1904e7f6ec84..77126a5fa9b6 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -359,8 +359,10 @@ void ordered_events__free(struct ordered_events *oe)
 	 * Current buffer might not have all the events allocated
 	 * yet, we need to free only allocated ones ...
 	 */
-	list_del(&oe->buffer->list);
-	ordered_events_buffer__free(oe->buffer, oe->buffer_idx, oe);
+	if (oe->buffer) {
+		list_del(&oe->buffer->list);
+		ordered_events_buffer__free(oe->buffer, oe->buffer_idx, oe);
+	}
 
 	/* ... and continue with the rest */
 	list_for_each_entry_safe(buffer, tmp, &oe->to_free, list) {
-- 
2.19.1



