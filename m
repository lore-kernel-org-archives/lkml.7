Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CEFC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6670206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDwi/tZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbfDZFdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 01:33:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44547 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfDZFdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 01:33:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id z16so1017072pgv.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 22:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0BlWP+G5OWGW9mpUi7okyYbJLLGMBmtOivNIy7fAx4I=;
        b=DDwi/tZqqfSFaSVDCjsFOX8uVprJkxHGNToSWybSY/ZirrohPGXxFQ5l+krGNxrYtN
         3S/ba+c0ZsscEq5/9N2W5wn/5fbLpvakGAdbFPUH7Iwo2927nEnbGS0vScZZidwiBMZR
         fZxhi9yUSkyG7Qe4WcqOqnuG6sO4w7gudmcrcWebNBRdtBjl4BZlcMYasV4/pf+cLsQq
         mo481jhPhxFNyexl5/seYbWVmYIfune7gWbvYLJO+ORqwTiOQQTojAoGsLfmUymrvmQ4
         xO2BdDnS4qejGzXfo+192vSI8A97LysV3Xt1KimejkTp046F+KpEsmjf0F/TRB7b792z
         upXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0BlWP+G5OWGW9mpUi7okyYbJLLGMBmtOivNIy7fAx4I=;
        b=U8j3fojCRj8qWVTSFmSoXWj1t/4/1n00rMi7y5vyhvvpo79ezRh6vS3O/TkvhSZhmc
         FduMTZDvbEhWn7E9YzXvufTed4arX6ds+xwu7s2EAx+985sYLw9ixVXfXJFCMrbYa1Xr
         g+gtUj0ym20HyMaKCPJJpMaprHxswe2aZay5n0XwUA/M1BVP/WZyDwTTu+aECGHyEUtL
         JGOgSAzxb1ft22gWmLLezkjJnK5ptg2whZZAbBvI83OSa2GQN1PLoB2w20+Njw12z4tO
         mxm0floRK1JZRBD5Ss7Q9VfFKcyZ7tS3YKDTqp2A+lsR8q9G/BU/UOGLuq4wumT5cjyQ
         ZDeA==
X-Gm-Message-State: APjAAAUpvaxcovXFZycJs266spFwSfQ1YsXN+IIur1+fiXmj3bMSADw4
        2U0GVknnpiYHF42ITKLgjYg=
X-Google-Smtp-Source: APXvYqzUyO1/qtvvUmS8tJE3ItFawslD6xkZGJKA5zyltJL0Mgnesyhhlb8pLaqQTWWOLWD9mE97XQ==
X-Received: by 2002:a63:4a5f:: with SMTP id j31mr38851660pgl.369.1556256790373;
        Thu, 25 Apr 2019 22:33:10 -0700 (PDT)
Received: from localhost.localdomain ([110.70.55.171])
        by smtp.gmail.com with ESMTPSA id j5sm5256532pfg.186.2019.04.25.22.33.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 22:33:09 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [PATCHv2 0/4] Access console drivers list under console_sem
Date:   Fri, 26 Apr 2019 14:32:58 +0900
Message-Id: <20190426053302.4332-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

        Normally, we grab console_sem lock before we iterate consoles
list, which is necessary if we want to be race free. The only exception
to this rule is console_flush_on_panic(). However, it seems that we are
not fully race free - register_console() iterates console drivers list
in unsafe manner in several places. E.g. the following scenarion:

        CPU0                                    CPU1
        register_console()                      unregister_console()
                                                 console_lock()
          for_each_console()                      // modify console_drivers
            con->foo                                kfree(con)

I factored out register_console() and unregister_console() and now
the bulk of the work is done under console_sem. Both in register
and unregister paths we now have that oddly looking thing

	pr_info("console enabled/disabled");
	console_unlock();
	console_lock();

Which is not really odd, in fact. This is to make sure that we always
print messages on all the consoles.

v2:
- removed outdated comment (Petr)
- factor out register_console() and always run it under console_sem (Petr)
- added a patch which enusures that we always print "console disabled'
  on every console, before we unregister one of them

Sergey Senozhatsky (4):
  printk: factor out __unregister_console() code
  printk: remove invalid register_console() comment
  printk: factor out register_console() code
  printk: make sure we always print console disabled message

 kernel/printk/printk.c | 125 +++++++++++++++++++++++++----------------
 1 file changed, 76 insertions(+), 49 deletions(-)

-- 
2.21.0

