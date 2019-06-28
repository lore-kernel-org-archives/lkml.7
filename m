Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7D9C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BD2215EA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561743657;
	bh=Aww1CuY+nNWchBpG1TRF+5hPu82SNYFOgNZPNettiVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=LK00/H2kphiKKxqKYvXjerbBOzV+SplIa1YwH/FR1bTVLsGlJzxdCDI3uk7IF8Srr
	 0wuZgA0ZlMa1BiTen2w/GwUoxZgcE1LVYg1oRhoOyc2S5Cj355HX9ogFg9QsBJsu7n
	 Mbu67rD7I9s09RRtMC7alUDYRZVeNOG9bHJXZ1xs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfF1Rkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 13:40:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbfF1Rky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 13:40:54 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4EDF208CB;
        Fri, 28 Jun 2019 17:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561743653;
        bh=Aww1CuY+nNWchBpG1TRF+5hPu82SNYFOgNZPNettiVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=TKxw+iYJl2aeb5zLcfZYtW/0bJQkeVtfsi/g9KaUUvj+QaoJlYGS67ZA67Ldy0l3u
         AtuqnAvZaAJSzupqlPfAlxj5mOJVCdvpeXUgyR2BFPo2FdhcWLHfkoas4R+TqAisPv
         bR3fEKpUUwDzgNm9t3YnuGB0QHdi2EBkNQA5yPsw=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] tracing: Add hist trigger error messages for sort specification
Date:   Fri, 28 Jun 2019 12:40:21 -0500
Message-Id: <237830dc05e583fbb53664d817a784297bf961be.1561743018.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1561743018.git.zanussi@kernel.org>
References: <cover.1561743018.git.zanussi@kernel.org>
In-Reply-To: <cover.1561743018.git.zanussi@kernel.org>
References: <cover.1561743018.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add error codes and messages for all the error paths leading to sort
specification parsing errors.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_events_hist.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 964d032f51c6..d33c94a1cfa9 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -61,7 +61,12 @@
 	C(INVALID_SUBSYS_EVENT,	"Invalid subsystem or event name"),	\
 	C(INVALID_REF_KEY,	"Using variable references in keys not supported"), \
 	C(VAR_NOT_FOUND,	"Couldn't find variable"),		\
-	C(FIELD_NOT_FOUND,	"Couldn't find field"),
+	C(FIELD_NOT_FOUND,	"Couldn't find field"),			\
+	C(EMPTY_ASSIGNMENT,	"Empty assignment"),			\
+	C(INVALID_SORT_MODIFIER,"Invalid sort modifier"),		\
+	C(EMPTY_SORT_FIELD,	"Empty sort field"),			\
+	C(TOO_MANY_SORT_FIELDS,	"Too many sort fields (Max = 2)"),	\
+	C(INVALID_SORT_FIELD,	"Sort field must be a key or a val"),
 
 #undef C
 #define C(a, b)		HIST_ERR_##a
@@ -2129,6 +2134,7 @@ parse_hist_trigger_attrs(struct trace_array *tr, char *trigger_str)
 		if (rhs) {
 			if (!strlen(++rhs)) {
 				ret = -EINVAL;
+				hist_err(tr, HIST_ERR_EMPTY_ASSIGNMENT, errpos(str));
 				goto free;
 			}
 			ret = parse_assignment(tr, str, attrs);
@@ -4680,7 +4686,7 @@ static int create_hist_fields(struct hist_trigger_data *hist_data,
 	return ret;
 }
 
-static int is_descending(const char *str)
+static int is_descending(struct trace_array *tr, const char *str)
 {
 	if (!str)
 		return 0;
@@ -4691,11 +4697,14 @@ static int is_descending(const char *str)
 	if (strcmp(str, "ascending") == 0)
 		return 0;
 
+	hist_err(tr, HIST_ERR_INVALID_SORT_MODIFIER, errpos((char *)str));
+
 	return -EINVAL;
 }
 
 static int create_sort_keys(struct hist_trigger_data *hist_data)
 {
+	struct trace_array *tr = hist_data->event_file->tr;
 	char *fields_str = hist_data->attrs->sort_key_str;
 	struct tracing_map_sort_key *sort_key;
 	int descending, ret = 0;
@@ -4719,10 +4728,12 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
 
 		if (!*field_str) {
 			ret = -EINVAL;
+			hist_err(tr, HIST_ERR_EMPTY_SORT_FIELD, errpos("sort="));
 			break;
 		}
 
 		if ((i == TRACING_MAP_SORT_KEYS_MAX - 1) && fields_str) {
+			hist_err(tr, HIST_ERR_TOO_MANY_SORT_FIELDS, errpos("sort="));
 			ret = -EINVAL;
 			break;
 		}
@@ -4730,11 +4741,12 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
 		field_name = strsep(&field_str, ".");
 		if (!field_name || !*field_name) {
 			ret = -EINVAL;
+			hist_err(tr, HIST_ERR_EMPTY_SORT_FIELD, errpos("sort="));
 			break;
 		}
 
 		if (strcmp(field_name, "hitcount") == 0) {
-			descending = is_descending(field_str);
+			descending = is_descending(tr, field_str);
 			if (descending < 0) {
 				ret = descending;
 				break;
@@ -4756,7 +4768,7 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
 
 			if (strcmp(field_name, test_name) == 0) {
 				sort_key->field_idx = idx;
-				descending = is_descending(field_str);
+				descending = is_descending(tr, field_str);
 				if (descending < 0) {
 					ret = descending;
 					goto out;
@@ -4767,6 +4779,7 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
 		}
 		if (j == hist_data->n_fields) {
 			ret = -EINVAL;
+			hist_err(tr, HIST_ERR_INVALID_SORT_FIELD, errpos(field_name));
 			break;
 		}
 	}
-- 
2.14.1

