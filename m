Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03022C10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C92F32075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369453;
	bh=mL3P1WKEHm37xYIlUU1J1wFg2S4HHG5Zad6V7tcQZ1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fQ+kN9jsoVbbNz6+rv+SAqmQT5Fm92nAmvD7aGlvBRH3DS28JOgf7EMDhKgl4d3Wq
	 UOJrniAWMh821OK+YucuIg//AHdH9XfsHAKuXeLKDMx1KsEaier7ECJpZbMpIVfdtV
	 ke/wmAzkR5h/JdJL/YafEAG8ejE+SOssvFJrTl7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388235AbfDDJRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:17:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387796AbfDDJR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:17:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 354D02075E;
        Thu,  4 Apr 2019 09:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369446;
        bh=mL3P1WKEHm37xYIlUU1J1wFg2S4HHG5Zad6V7tcQZ1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K1hLkuwaeO9/beBmBC55NegI96qPn7nogIXfZMOPgwW1pomIhW7iCUfKrs/ZCacvX
         v+o7m6EI1UtxxwmuKjfEvABkTQZ4IB8HH60PG/z420HhwUO4dsGQub8M5R34Ez5iTC
         Xz8VIvTsEAbnhl9cpFjOkSI8hnbrNywt3BCJuoTM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Jones <tonyj@suse.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        =?UTF-8?q?Jaroslav=20=C5=A0karvada?= <jskarvad@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 201/246] perf script python: Use PyBytes for attr in trace-event-python
Date:   Thu,  4 Apr 2019 10:48:21 +0200
Message-Id: <20190404084626.225923086@linuxfoundation.org>
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



