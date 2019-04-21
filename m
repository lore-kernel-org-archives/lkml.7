Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4AFC282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 16:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F05720833
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 16:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+RQ6yhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfDUQua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 12:50:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42977 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfDUQua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 12:50:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so13184212wrx.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 09:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=z4R0Iqo2hQ3pWsGLkiXQZCqUrVoMbp7rRWOtfQxntMU=;
        b=L+RQ6yhck5TP4eqBep4aDNkBsYk53/wR6jiaQlW84Yee3U6uwFKI49b4hEN6fvPADK
         Sptd6ShfRouGQzE/TpwWWMb9TRL0fEZkN3YRWaEJDmu7CH74tCJrEWGKjNoUfL0feZBh
         hxfPsUCRkv+Piy8+Cb/5DVDUT7djLHi3wL9Ya4ICYmBVgdxgQqT7OzR55N4lJJCobLya
         NYqg82mq2XrCHjNpzykPu8HMaFoQXAeTDAU4CnUdC1EG3Gq2J0soE+hA6VdBJmU3QHlr
         P8t7+/IQmXHoqrdcfcO5QDO5GgMhaeZQ64UfpY9/2urQ9Pz3bRezIvY/pKHm8jo1FtP5
         YE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=z4R0Iqo2hQ3pWsGLkiXQZCqUrVoMbp7rRWOtfQxntMU=;
        b=g6SKiwXZa1LUxWWgtHyaVoslPKDu/9KGVP7RcKFlbTcl/8zGaBOzB+eVF2kLvi0Ni9
         S0AoFZ2WKtWN3JrudV8nSCgZuCo/IINn9r6kp1g/t0jVVcyyYUwaqT0BSClmDoDdMraE
         WdGwXQYFfftY/WzHvXJyU/0B7B7C+hrpDP6fN6X3tayBu4dnEGcupXZk2khsoKxXG9zd
         8J8G5RmD7pSEYae+6CQ9L/oaNXkMVNDWC/k84H9AjsZJ0uXtGyzmBBB2mRkAeAJ/WMUG
         ZtzljJ9tuK/Sq9gtzysWJOIH9WE7JsN86cnOslSqtrm+KCwHHYDAAWyQF5heBETzUOnE
         /Nng==
X-Gm-Message-State: APjAAAUGXz5weK6sM06j0Qw+uUPw7aVlkTrhZP+TmG7urt5NAELC6+xj
        Yb1mq1eav1esMz7FTZ6u4TEmqCs=
X-Google-Smtp-Source: APXvYqw0euw3gkJKhTbNEbtGeUHzeIDslZZLUZqvMmGOzJz6mi1Bhxq41MMH4jLRByTY5c4gHrkTTg==
X-Received: by 2002:a5d:6682:: with SMTP id l2mr9888871wru.33.1555865428691;
        Sun, 21 Apr 2019 09:50:28 -0700 (PDT)
Received: from avx2 ([46.53.240.200])
        by smtp.gmail.com with ESMTPSA id r6sm10866402wrt.38.2019.04.21.09.50.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 09:50:27 -0700 (PDT)
Date:   Sun, 21 Apr 2019 19:50:25 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] exec: move struct linux_binprm::buf
Message-ID: <20190421165025.GA26843@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct linux_binprm::buf is the first field and it is exactly 128 bytes
in size. It means that on x86_64 all accesses to other fields will go
though [r64 + disp32] addressing mode which is 3 bytes bloatier than
[r64 + disp8] addressing mode. Given that accesses to other fields
outnumber accesses to ->buf, move it down.

Space savings (x86_64 defconfig):
more on distro configs because LSMs actively dereference "bprm"
but do not care about first 128 bytes of the executable itself.

add/remove: 0/0 grow/shrink: 0/24 up/down: 0/-492 (-492)
Function                                     old     new   delta
selinux_bprm_committing_creds                552     549      -3
finalize_exec                                 94      91      -3
__audit_log_bprm_fcaps                       283     280      -3
__audit_bprm                                  39      36      -3
perf_trace_sched_process_exec                347     341      -6
install_exec_creds                           105      99      -6
cap_bprm_set_creds.cold                       60      54      -6
would_dump                                   137     128      -9
load_script                                  637     628      -9
bprm_change_interp                            61      52      -9
trace_event_raw_event_sched_process_exec     260     250     -10
search_binary_handler                        255     240     -15
remove_arg_zero                              295     277     -18
free_bprm                                    119     101     -18
prepare_binprm                               379     360     -19
setup_new_exec                               336     315     -21
flush_old_exec                              1638    1617     -21
copy_strings.isra                            746     724     -22
setup_arg_pages                              559     530     -29
load_misc_binary                            1151    1118     -33
selinux_bprm_set_creds                       792     753     -39
load_elf_binary                            11111   11072     -39
cap_bprm_set_creds                          1496    1454     -42
__do_execve_file.isra                       2395    2286    -109

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/binfmts.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -15,7 +15,6 @@ struct filename;
  * This structure is used to hold the arguments that are used when loading binaries.
  */
 struct linux_binprm {
-	char buf[BINPRM_BUF_SIZE];
 #ifdef CONFIG_MMU
 	struct vm_area_struct *vma;
 	unsigned long vma_pages;
@@ -64,6 +63,8 @@ struct linux_binprm {
 	unsigned long loader, exec;
 
 	struct rlimit rlim_stack; /* Saved RLIMIT_STACK used during exec. */
+
+	char buf[BINPRM_BUF_SIZE];
 } __randomize_layout;
 
 #define BINPRM_FLAGS_ENFORCE_NONDUMP_BIT 0
