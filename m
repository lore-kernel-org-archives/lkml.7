Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FE2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041582063F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710144;
	bh=g4LIPHHqvn7S6g33XK7Gxc4cLtQ4LoESKGrGQ+bYvdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zT2m5Rpo5zwWNBYY5qab4ksoRf/VqgFRzZP2GTPXuIagYopqwE2Ag1/I6ycaO9TXk
	 zvvo5gzcJBwkCzboO4xHwGoejf+GDkP7Tpw6xcDXR2ctcV42CfGyAbe0sFXkPVfa0X
	 Do038lvbU5LCkWSlUg5AeSxRENPveZmXK0ENGy2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388486AbfC0SJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:09:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731344AbfC0SI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:08:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5590321734;
        Wed, 27 Mar 2019 18:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710137;
        bh=g4LIPHHqvn7S6g33XK7Gxc4cLtQ4LoESKGrGQ+bYvdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bpEB5x3++/QM/ijKCZ05ftmIN8yYv0bWraT43rS2Bl4o8w3YgauJqIAWKcIJhhD9w
         +CzfkBjhK/M75PKXYkg3bL+shuVFJi32zs0gmQUaSmQXo+qs5qTpqNIQHys7GRGXu/
         9FzYgmGjTDrYdxhvr1HYybH7ig1ucJDOxDAvzhkU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Jones <tonyj@suse.de>,
        =?UTF-8?q?Jaroslav=20=C5=A0karvada?= <jskarvad@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 213/262] perf script python: Use PyBytes for attr in trace-event-python
Date:   Wed, 27 Mar 2019 14:01:08 -0400
Message-Id: <20190327180158.10245-213-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Jones <tonyj@suse.de>

[ Upstream commit 72e0b15cb24a497d7d0d4707cf51ff40c185ae8c ]

With Python3.  PyUnicode_FromStringAndSize is unsafe to call on attr and will
return NULL.  Use _PyBytes_FromStringAndSize (as with raw_buf).

Below is the observed behavior without the fix.  Note it is first necessary
to apply the prior fix (Add trace_context extension module to sys,modules):

  # ldd /usr/bin/perf | grep -i python
          libpython3.6m.so.1.0 => /usr/lib64/libpython3.6m.so.1.0 (0x00007f8e1dfb2000)

  # perf record -e raw_syscalls:sys_enter /bin/false
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.018 MB perf.data (21 samples) ]

  # perf script -g python | cat
  generated Python script: perf-script.py

  # perf script -s ./perf-script.py
  in trace_begin
  Segmentation fault (core dumped)

Signed-off-by: Tony Jones <tonyj@suse.de>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jaroslav Škarvada <jskarvad@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Fixes: 66dfdff03d19 ("perf tools: Add Python 3 support")
Link: http://lkml.kernel.org/r/20190124005229.16146-3-tonyj@suse.de
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/scripting-engines/trace-event-python.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 87ef16a1b17e..2fe3cc43526f 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -733,8 +733,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 		Py_FatalError("couldn't create Python dictionary");
 
 	pydict_set_item_string_decref(dict, "ev_name", _PyUnicode_FromString(perf_evsel__name(evsel)));
-	pydict_set_item_string_decref(dict, "attr", _PyUnicode_FromStringAndSize(
-			(const char *)&evsel->attr, sizeof(evsel->attr)));
+	pydict_set_item_string_decref(dict, "attr", _PyBytes_FromStringAndSize((const char *)&evsel->attr, sizeof(evsel->attr)));
 
 	pydict_set_item_string_decref(dict_sample, "pid",
 			_PyLong_FromLong(sample->pid));
-- 
2.19.1

