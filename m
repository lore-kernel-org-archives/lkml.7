Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC59C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7B02190C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126017;
	bh=YuSMkZM65/NjQ9WXjVF24+iHtilzedFNGsMDh3GwRKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IwlQYlWYybN0Npa75cd48qKG8a0+mezG0DpfK31RH5hEOdv8otBOtJ4B1elkDpZ+9
	 U6Jt9/hxaNn3hayiyQnVfON5X8ciypcJWeYOpUVfUFacMYMGfVFoanhLUjiZMcVtMK
	 zJt6o396ZwtXZtLHb1RNvbPKJaluUDoDUzgEe4mQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387912AbfDXRNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:13:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387896AbfDXRNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:13:32 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AE3521903;
        Wed, 24 Apr 2019 17:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126011;
        bh=YuSMkZM65/NjQ9WXjVF24+iHtilzedFNGsMDh3GwRKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rBf9yL4DKiWm75l+0Z68XDgtWFYuV239Fw1fdo3CeyQbTRmQMbpv6i9wo+KOFDOlE
         bkkFKhESGc6k1BiGhclTUbybQa2hK1nDXE7DamFxA6ppYESwVmwti22g2HFNZ2814f
         JU7Od8A1K3N/eQmkhTKMjyFvRLWUWy23gBBtWdsU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephane Eranian <eranian@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 061/104] perf/core: Restore mmap record type correctly
Date:   Wed, 24 Apr 2019 19:09:18 +0200
Message-Id: <20190424170903.898703777@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
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
index fd8dea2b36ec..41d83a9aacaf 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5533,6 +5533,7 @@ static void perf_event_mmap_output(struct perf_event *event,
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
 	int size = mmap_event->event_id.header.size;
+	u32 type = mmap_event->event_id.header.type;
 	int ret;
 
 	if (!perf_event_mmap_match(event, data))
@@ -5576,6 +5577,7 @@ static void perf_event_mmap_output(struct perf_event *event,
 	perf_output_end(&handle);
 out:
 	mmap_event->event_id.header.size = size;
+	mmap_event->event_id.header.type = type;
 }
 
 static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
-- 
2.19.1



