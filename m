Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A51C742AE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1818120863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfGLI76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 04:59:58 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:54105 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfGLI75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 04:59:57 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mi2Fj-1iPsyN4Apl-00e6a2; Fri, 12 Jul 2019 10:59:11 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Petr Mladek <pmladek@suse.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] xen/trace: avoid clang warning on function pointers
Date:   Fri, 12 Jul 2019 10:58:48 +0200
Message-Id: <20190712085908.4146364-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:r9K45RUOqX7EL2FgFvB2I5Nlw7QMUweeL6eeTaUyO4nmnnOdEKZ
 UVF9Re1lNEQUVmpmkCXtfUXSV+4pGIYXOJSBdhc2coR9OjLDrPGMYDyjR80itjqpVNYDyjr
 tL7Z2txRDgexpWAhKuVSXidcoVb08GhRVOgqkrX+jmUT9rniOp770IlAaTpWjwSrd2+Tz9L
 +RWlHH5KALpcd+4YvXc9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lglkteexDEs=:n6oHHMme+/XkiTYmFdbiR0
 Z2nMcZ+YbdTMXSUNBLnuMrtKnbo+CO//RyuFoU60NsAn75bnyFYXBe7oQ03zgXYiEJ74ZMNfi
 xFYgwe9cOOZrHjYa7wFPq1tSYw4+xTF1p9v4md8PBTw2R7LGfV02afuobHmnKxu9jt1CiEHJm
 PvbQQJW4hjD0TV4fg2fZFpcPAb0PwKflIEgO0cmbyUI5QvrBSvzCMHPYDED0noI3GhmUPEIvZ
 PYGWj7VZlcVzxMR4ARiupKk/Q/t5wZ2Qj4PpWeMtBFH2u6eqkdq9OOZ8J30nUr8XsEaJFyg01
 SmG5ioZrhkUfm+m2DbXeAPeA5UIc6jiRwwYqgiAe9Ax+H8mtDeoDE0PnEg+Pl/B/MZZ0If7SV
 UxTCrX6pmqgIW75MPNjQGW6YUWoDIlPSEy9ARl+X5ZT8cN3jOFbuPV7PQS9JO1qYi1bOFlUvr
 WePdNL2lgKEqw+aDEI7XijINJAiMIT76MXefQYHzcZEhuh/4ncfdD519PhY7DauRBvuagkq8S
 2o2M0jafjdVtDLsFtXHLfg6ImbMDu6M8oSgkhNClEPMOgr9im1+OTKfH5BNIxknJPm2yWdJPP
 uBLH8dxDI846LpKhPaIUMcXOiJWqB6Pr9pavYArrvBQFxDrnE5gdMGAIR1zMxOgyr7vj6jJxO
 VcbBYDqY6yXIB+lhwJkrVgQ2etAk6au3lIyhE1mc7oWVUuiVE/3qm8zjmzuYB9dGrwoQaM+dw
 i4stcrjqqQkIsydTqh4sfgUUa/Vbc1QgnoFP5Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang-9 does not like the way that the is_signed_type() compares
function pointers deep inside of the trace even macros:

In file included from arch/x86/xen/trace.c:21:
In file included from include/trace/events/xen.h:475:
In file included from include/trace/define_trace.h:102:
In file included from include/trace/trace_events.h:467:
include/trace/events/xen.h:69:7: error: ordered comparison of function pointers ('xen_mc_callback_fn_t' (aka 'void (*)(void *)') and 'xen_mc_callback_fn_t') [-Werror,-Wordered-compare-function-pointers]
                    __field(xen_mc_callback_fn_t, fn)
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/trace/trace_events.h:415:29: note: expanded from macro '__field'
 #define __field(type, item)     __field_ext(type, item, FILTER_OTHER)
                                ^
include/trace/trace_events.h:401:6: note: expanded from macro '__field_ext'
                                 is_signed_type(type), filter_type);    \
                                 ^
include/linux/trace_events.h:540:44: note: expanded from macro 'is_signed_type'
 #define is_signed_type(type)    (((type)(-1)) < (type)1)
                                              ^
note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
include/trace/trace_events.h:77:16: note: expanded from macro 'TRACE_EVENT'
                             PARAMS(tstruct),                  \
                             ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/tracepoint.h:95:25: note: expanded from macro 'PARAMS'
 #define PARAMS(args...) args
                        ^
include/trace/trace_events.h:455:2: note: expanded from macro 'DECLARE_EVENT_CLASS'
        tstruct;                                                        \
        ^~~~~~~

I guess the warning is reasonable in principle, though this seems to
be the only instance we get in the entire kernel today.
Shut up the warning by making it a void pointer in the exported
structure.

Fixes: c796f213a693 ("xen/trace: add multicall tracing")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/trace/events/xen.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/xen.h b/include/trace/events/xen.h
index 9a0e8af21310..f75b77414ac1 100644
--- a/include/trace/events/xen.h
+++ b/include/trace/events/xen.h
@@ -66,7 +66,7 @@ TRACE_EVENT(xen_mc_callback,
 	    TP_PROTO(xen_mc_callback_fn_t fn, void *data),
 	    TP_ARGS(fn, data),
 	    TP_STRUCT__entry(
-		    __field(xen_mc_callback_fn_t, fn)
+		    __field(void *, fn)
 		    __field(void *, data)
 		    ),
 	    TP_fast_assign(
-- 
2.20.0

