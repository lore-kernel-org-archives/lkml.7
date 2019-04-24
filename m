Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43975C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1043021907
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126524;
	bh=6Bd+bYLwZzoxqnD655HN2BqVQ+UKE9SMsQRodzDow3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vNiOssrCqoLSf5HbDZ9cQRdo5eX0pgoMN0pwcLOnLZDe8YcTdoAaJnAWNNYDpKnSd
	 DYAYXcGor4ymWGwnS4HFz33V3gEt/UrHjwIH2GYGaHamQRjKTB89otTPzRA6b8iADm
	 k8+HiY7d+/HQDY9kp1Du9ZqErPBgzm2eC+lYjBkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389110AbfDXRWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:22:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389068AbfDXRVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:21:54 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 610DA205ED;
        Wed, 24 Apr 2019 17:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126514;
        bh=6Bd+bYLwZzoxqnD655HN2BqVQ+UKE9SMsQRodzDow3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z+nGqvZjHOnie7jKyDKN8sVuDTvNzNWqvR87XegArLaJbVr4iWUA2xn7g4kMD9wMX
         HwZmAJlrADnh+2LyQDO63+0XaGy2FVw81e9rVNC0XrKW3IZ9dxULRLihvc1GGJPmHc
         dN46ZK5Y+1npNumcSpO/AJ3zRzDoqjWLRHNQW/dU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephane Eranian <eranian@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 098/168] perf/core: Restore mmap record type correctly
Date:   Wed, 24 Apr 2019 19:09:02 +0200
Message-Id: <20190424170929.476908531@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d9c1bb2f6a2157b38e8eb63af437cb22701d31ee ]

On mmap(), perf_events generates a RECORD_MMAP record and then checks
which events are interested in this record. There are currently 2
versions of mmap records: RECORD_MMAP and RECORD_MMAP2. MMAP2 is larger.
The event configuration controls which version the user level tool
accepts.

If the event->attr.mmap2=1 field then MMAP2 record is returned.  The
perf_event_mmap_output() takes care of this. It checks attr->mmap2 and
corrects the record fields before putting it in the sampling buffer of
the event.  At the end the function restores the modified MMAP record
fields.

The problem is that the function restores the size but not the type.
Thus, if a subsequent event only accepts MMAP type, then it would
instead receive an MMAP2 record with a size of MMAP record.

This patch fixes the problem by restoring the record type on exit.

Signed-off-by: Stephane Eranian <eranian@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Fixes: 13d7a2410fa6 ("perf: Add attr->mmap2 attribute to an event")
Link: http://lkml.kernel.org/r/20190307185233.225521-1-eranian@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e53dfb5b826e..17230ca00bd4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5998,6 +5998,7 @@ static void perf_event_mmap_output(struct perf_event *event,
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
 	int size = mmap_event->event_id.header.size;
+	u32 type = mmap_event->event_id.header.type;
 	int ret;
 
 	if (!perf_event_mmap_match(event, data))
@@ -6041,6 +6042,7 @@ static void perf_event_mmap_output(struct perf_event *event,
 	perf_output_end(&handle);
 out:
 	mmap_event->event_id.header.size = size;
+	mmap_event->event_id.header.type = type;
 }
 
 static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
-- 
2.19.1



