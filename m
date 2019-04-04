Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE55EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 22:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E3E217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 22:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WcgKfTzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbfDDWKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 18:10:55 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:55043 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731114AbfDDWKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 18:10:44 -0400
Received: by mail-qk1-f201.google.com with SMTP id v2so3391736qkf.21
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 15:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=L5LvzMvCQ5lJQqGEkj2/cW5yzxNhaTrHsD5BxhP/ag8=;
        b=WcgKfTzuh0PykOiGG0VI9Jh+NdkgN84xe9ytoqumQ5HkuKWESwhFtIDSN035B+Z9BB
         oVVGkMuVGQZM+wlgfoc3GZk4gNCS8XMgnVo6LxIO9jA4wpMJWB92jpG5yb7q7s31NDQr
         1LbLRwCQ9MOcJbNRGOX64SszAB4nuN/GZ+9EYEgMHPJ+gyAUcCezHw8SE7ZuBBZiBaVH
         Ua2z5NA0ViFOUhYXo+SzPh44OAjz+T8jefjfIk17Bgdb+j/FnsYYZZM18DPMe4eU4fVE
         k+ALWn3wvHhCe12BHcgoJRYgAFUVInSeUvOcnkc6hpq9neP+BeRWCdL2Gp2E7T4st/+Z
         f/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=L5LvzMvCQ5lJQqGEkj2/cW5yzxNhaTrHsD5BxhP/ag8=;
        b=Ti8cphBAo3ExVnVP+cMV8deU53zm4QJSYkCC0DuyWb1DpBi4hBzNEKujA/O1RBOrE/
         JJANm6cSfqPl4PAQsr2wp9BXt6HnBLcMMuSSlKxDDsYbBcK76Yb78sr6rqG32j7lEkqU
         cdhbC92JdZT1zj8JNG4s5nBGYJtlSatYudMAFWmm9o1n7lvoa2PV2mORG1Gx8xOyCD9h
         p+3g1qtnnQJBvvhk8f/X3rJ3k4JmwKp9YvoWLy7LqLsvgs7khRJa/DkRNwECoMB0Vzs1
         gty8ugN4AQPprL9YRiqS24Ki9A+sDqnIMHi/Ds49bqtaynPv24pNaNm5vuJsqP9QeH6l
         EQog==
X-Gm-Message-State: APjAAAW5cJ+H4a3HFHEo7onrLyY+DESQVUIRXDgtYARcVxBfCqGq4ixa
        iuTBADbJs/74Qakg5W2LlLRQRlMTt+E4j/9UY5/5GA==
X-Google-Smtp-Source: APXvYqzmjmGQNzF9zYfxjgFiSMsEoYx7+JOSmpQkDkopJEnQWX84XH6Rjir6av3kZqX+/f1WgNwZW60WiG8xXQ5eURXAog==
X-Received: by 2002:a05:620a:1376:: with SMTP id d22mr1247563qkl.53.1554415843728;
 Thu, 04 Apr 2019 15:10:43 -0700 (PDT)
Date:   Thu,  4 Apr 2019 15:06:52 -0700
In-Reply-To: <20190404220652.19765-1-brendanhiggins@google.com>
Message-Id: <20190404220652.19765-18-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190404220652.19765-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v1 17/17] MAINTAINERS: add proc sysctl KUnit test to PROC
 SYSCTL section
From:   Brendan Higgins <brendanhiggins@google.com>
To:     corbet@lwn.net, frowand.list@gmail.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        robh@kernel.org, shuah@kernel.org, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch,
        gregkh@linuxfoundation.org, jdike@addtoit.com, joel@jms.id.au,
        julia.lawall@lip6.fr, khilman@baylibre.com, knut.omang@oracle.com,
        mpe@ellerman.id.au, pmladek@suse.com, richard@nod.at,
        rostedt@goodmis.org, wfg@linux.intel.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for the new proc sysctl KUnit test to the PROC SYSCTL section.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fc2cedbd9b43e..03054e4c6386c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12523,6 +12523,7 @@ S:	Maintained
 F:	fs/proc/proc_sysctl.c
 F:	include/linux/sysctl.h
 F:	kernel/sysctl.c
+F:	kernel/sysctl-test.c
 F:	tools/testing/selftests/sysctl/
 
 PS3 NETWORK SUPPORT
-- 
2.21.0.392.gf8f6787159e-goog

