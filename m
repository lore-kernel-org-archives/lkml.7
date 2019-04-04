Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A11C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D356E205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370578;
	bh=RVQ76LLQor2ryz6bxmMfusmXLgD4cADWDGnSCaP6ybw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hv+2odEzLwgFAwHV/Mmefc0hvBkm/CZmMgAw+zIfa13NB4uUzMmVxDjW7AXQvI3Ju
	 1OamT9wc6ju7bEH72PoemovTyb5vR9Rtxev04cQSYwYPo7xDc7Yt9MlL4yfr+y58yW
	 pbnh1Ryf+Xxx1IbC60S/t43/bAznKUaF3IX+8qNI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732235AbfDDJgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:36:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730246AbfDDJFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:05:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C84E021855;
        Thu,  4 Apr 2019 09:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368747;
        bh=RVQ76LLQor2ryz6bxmMfusmXLgD4cADWDGnSCaP6ybw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QadUbjG6W1cuGiFnpKWOK3g9YfOqDEYgIpm5UbkQJfDTXrPhd/04LmLzuldRwSpEt
         uGv99F1wIXumbEySXaH0/3pC1xe6XjPZ8Ka2YJXg5VrW0DzVvUQPjGC6R2XRAxGrc0
         velD9VEVgS3uCiQTW9ujMgUZ366veTt9Rcib8dKI=
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
Subject: [PATCH 4.19 155/187] perf script python: Add trace_context extension module to sys.modules
Date:   Thu,  4 Apr 2019 10:48:12 +0200
Message-Id: <20190404084610.426069706@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

[ Upstream commit cc437642255224e4140fed1f3e3156fc8ad91903 ]

In Python3, the result of PyModule_Create (called from
scripts/python/Perf-Trace-Util/Context.c) is not automatically added to
sys.modules.  See: https://bugs.python.org/issue4592

Below is the observed behavior without the fix:

  # ldd /usr/bin/perf | grep -i python
	libpython3.6m.so.1.0 => /usr/lib64/libpython3.6m.so.1.0 (0x00007f8e1dfb2000)

  # perf record /bin/false
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.015 MB perf.data (17 samples) ]

  # perf script -g python | cat
  generated Python script: perf-script.py

  # perf script -s ./perf-script.py
  Traceback (most recent call last):
    File "./perf-script.py", line 18, in <module>
      from perf_trace_context import *
  ModuleNotFoundError: No module named 'perf_trace_context'
  Error running python script ./perf-script.py
  #

Committer notes:

To build with python3 use:

  $ make -C tools/perf PYTHON=python3

Use a non-const variable to pass the 'name' arg to
PyImport_AppendInittab(), as python2.6 has that as 'char *', which ends
up trowing this in some environments:

   CC       /tmp/build/perf/util/parse-branch-options.o
  util/scripting-engines/trace-event-python.c: In function 'python_start_script':
  util/scripting-engines/trace-event-python.c:1520:2: error: passing argument 1 of 'PyImport_AppendInittab' discards 'const' qualifier from pointer target type [-Werror]
    PyImport_AppendInittab("perf_trace_context", initfunc);
    ^
  In file included from /usr/include/python2.6/Python.h:130:0,
                   from util/scripting-engines/trace-event-python.c:22:
  /usr/include/python2.6/import.h:54:17: note: expected 'char *' but argument is of type 'const char *'
   PyAPI_FUNC(int) PyImport_AppendInittab(char *name, void (*initfunc)(void));
                   ^
  cc1: all warnings being treated as errors

Signed-off-by: Tony Jones <tonyj@suse.de>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jaroslav Škarvada <jskarvad@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Fixes: 66dfdff03d19 ("perf tools: Add Python 3 support")
Link: http://lkml.kernel.org/r/20190124005229.16146-2-tonyj@suse.de
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../perf/util/scripting-engines/trace-event-python.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index fb11396ec861..9569cc06e0a7 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1493,34 +1493,40 @@ static void _free_command_line(wchar_t **command_line, int num)
 static int python_start_script(const char *script, int argc, const char **argv)
 {
 	struct tables *tables = &tables_global;
+	PyMODINIT_FUNC (*initfunc)(void);
 #if PY_MAJOR_VERSION < 3
 	const char **command_line;
 #else
 	wchar_t **command_line;
 #endif
-	char buf[PATH_MAX];
+	/*
+	 * Use a non-const name variable to cope with python 2.6's
+	 * PyImport_AppendInittab prototype
+	 */
+	char buf[PATH_MAX], name[19] = "perf_trace_context";
 	int i, err = 0;
 	FILE *fp;
 
 #if PY_MAJOR_VERSION < 3
+	initfunc = initperf_trace_context;
 	command_line = malloc((argc + 1) * sizeof(const char *));
 	command_line[0] = script;
 	for (i = 1; i < argc + 1; i++)
 		command_line[i] = argv[i - 1];
 #else
+	initfunc = PyInit_perf_trace_context;
 	command_line = malloc((argc + 1) * sizeof(wchar_t *));
 	command_line[0] = Py_DecodeLocale(script, NULL);
 	for (i = 1; i < argc + 1; i++)
 		command_line[i] = Py_DecodeLocale(argv[i - 1], NULL);
 #endif
 
+	PyImport_AppendInittab(name, initfunc);
 	Py_Initialize();
 
 #if PY_MAJOR_VERSION < 3
-	initperf_trace_context();
 	PySys_SetArgv(argc + 1, (char **)command_line);
 #else
-	PyInit_perf_trace_context();
 	PySys_SetArgv(argc + 1, command_line);
 #endif
 
-- 
2.19.1



