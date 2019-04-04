Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A59C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336FE20693
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369103;
	bh=ofrA8/WjGNggrwk2Ws/G6mDUgwTiuX1bav/sO/TwqCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VlplJEomLfLXdItqGaVuitp30vAvOFqvqrbScyFQlN7exMifmzJKL32uWIjNT0JlM
	 48PPlXNXCF8QiKRHtKUxPXKHO7zS0Dq87gwxoP8j65K+DzQRD5de7eRiyoAiT6rwtD
	 DVEw5+2eaSygW+As0AA/Yx7K9fjgq19cgr8IvBqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733200AbfDDJLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:11:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732770AbfDDJLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:11:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00DF32075E;
        Thu,  4 Apr 2019 09:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369097;
        bh=ofrA8/WjGNggrwk2Ws/G6mDUgwTiuX1bav/sO/TwqCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X7FrY2vjYVmhVkFZWbJbgtJ3fSyp+eStfw6ILZN4GymrN+le0gXFDBlV24LEVPv8U
         AZ3mkGxFlQu9Eh7NvUsiGgdMWDtCMI31t9Kh5/eNUUWNnYOhdtUPOyqn2bom2YKWB2
         lPNSSZJKVdholN6Smrz2jXqb/UGOxuxfiKjJoCnw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 083/246] perf script: Handle missing fields with -F +..
Date:   Thu,  4 Apr 2019 10:46:23 +0200
Message-Id: <20190404084622.040868337@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4b6ac811bce46c83811b83cdf87b41251596b9fc ]

When using -F + syntax to add a field the existing defaults are
currently all marked user_set. This can cause errors when some field is
missing in the perf.data

This patch tracks the actually user set fields separately, so that we don't
error out in this case.

Before:

  % perf record true
  % perf script -F +metric
  Samples for 'cycles:ppp' event do not have CPU attribute set. Cannot print 'cpu' field.
  %

After:

  5 perf record true
  % perf script -F +metric
              perf 28936 278636.237688:          1 cycles:ppp:  ffffffff8117da99 perf_event_exec+0x59 (/lib/modules/4.20.0-odilo/build/vmlinux)
  ...
  %

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20190224153722.27020-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-script.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index ac221f137ed2..cff4d10daf49 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -148,6 +148,7 @@ static struct {
 	unsigned int print_ip_opts;
 	u64 fields;
 	u64 invalid_fields;
+	u64 user_set_fields;
 } output[OUTPUT_TYPE_MAX] = {
 
 	[PERF_TYPE_HARDWARE] = {
@@ -344,7 +345,7 @@ static int perf_evsel__do_check_stype(struct perf_evsel *evsel,
 	if (attr->sample_type & sample_type)
 		return 0;
 
-	if (output[type].user_set) {
+	if (output[type].user_set_fields & field) {
 		if (allow_user_set)
 			return 0;
 		evname = perf_evsel__name(evsel);
@@ -2627,10 +2628,13 @@ parse:
 					pr_warning("\'%s\' not valid for %s events. Ignoring.\n",
 						   all_output_options[i].str, event_type(j));
 				} else {
-					if (change == REMOVE)
+					if (change == REMOVE) {
 						output[j].fields &= ~all_output_options[i].field;
-					else
+						output[j].user_set_fields &= ~all_output_options[i].field;
+					} else {
 						output[j].fields |= all_output_options[i].field;
+						output[j].user_set_fields |= all_output_options[i].field;
+					}
 					output[j].user_set = true;
 					output[j].wildcard_set = true;
 				}
-- 
2.19.1



