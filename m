Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD82C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 01:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0095B22CE3
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 01:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kTDliowP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfHXBfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 21:35:33 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:44054 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbfHXBfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 21:35:30 -0400
Received: by mail-pl1-f201.google.com with SMTP id t2so6845677plq.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 18:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Q7v6rEQoCsNNbU95UVuiGKqKwX05H1mjzimMiwgdjks=;
        b=kTDliowP7o3AiRgwqQlGdSorwzrpE74OzrYLBSyQym+RMD9BcY3HKgRqyUg56Jh5m2
         I0kSBhwhcQDEAp90nh3ZujDoa38kQhvTP1Jc+/wt8WWFrQiFg8l/9HyGs9d14T1TjS1K
         Iw0FVBL+/zSCAfzOAcwGjAtR42R3mpopg+GAsodk20VK3Hx90/Z6GucUnjkTQWGo6oql
         bMw16WK1ZxXYYN0eEFBOFKGaezq1RdQqMO8lXVb1eJIA70O3pkzZs/U8eRTUz/d/bNJT
         yjpEiEVsNfRUxPdw7uiUvTOiKewWG+vAZPNE1VIsegRpZQeLlLR0Qo6aFDH1RA0oJYKp
         WGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q7v6rEQoCsNNbU95UVuiGKqKwX05H1mjzimMiwgdjks=;
        b=OH0l9G01vP4A2nBCvn/+fwjbsC0/mNtkXAVIKNp7SUdLeooAtj1OdbU+e66Z3XntLo
         sBfjmKUfTD5gTCUgkKdbzVB1AFcAcO0K4ijAaK0CyofsMp27njl9dHZ20OQ10IiXL5Vs
         LIamLQncrBjMK6gUpYGazoUHNSxKXJaLx71xy7GA25gkbsN93MpIY3+LGhbaAQmURSUx
         4xoHtGmZCS8KnL9eCKx6hl8xH8c+8wByTtfhVeIJUagoeaJ/TgI8Q7JTzSPmcRvsPGJ1
         SDf3wWmxl4aGtN98tyXKN/dj+PufVYaRbuJiecEOKYU8BwtbPN0Qnj8eOnyE8k4xEAL1
         h3Dg==
X-Gm-Message-State: APjAAAUR9wuNZonjm/uAvkfIk8Ju/UAc86fstgXJKU9mgRUHUkPz3Ih9
        qzbcvfg39+HABccYt2o3Uwsp2fKCXhWDcdEfQ3QkBQ==
X-Google-Smtp-Source: APXvYqzJyyLtfmAOBIQlbX+eop2/oig96oKMIaKGeExSCTI7BXDWjOnL13u84fw7hBXw+uulsexqobHzTGtoBwBytj+Rlg==
X-Received: by 2002:a65:4b8b:: with SMTP id t11mr6412047pgq.130.1566610521287;
 Fri, 23 Aug 2019 18:35:21 -0700 (PDT)
Date:   Fri, 23 Aug 2019 18:34:23 -0700
In-Reply-To: <20190824013425.175645-1-brendanhiggins@google.com>
Message-Id: <20190824013425.175645-17-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190824013425.175645-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v15 16/18] MAINTAINERS: add entry for KUnit the unit testing framework
From:   Brendan Higgins <brendanhiggins@google.com>
To:     frowand.list@gmail.com, gregkh@linuxfoundation.org,
        jpoimboe@redhat.com, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        peterz@infradead.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, tytso@mit.edu, yamada.masahiro@socionext.com
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-um@lists.infradead.org,
        Alexander.Levin@microsoft.com, Tim.Bird@sony.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, knut.omang@oracle.com, logang@deltatee.com,
        mpe@ellerman.id.au, pmladek@suse.com, rdunlap@infradead.org,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com, Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as maintainer of KUnit, the Linux kernel's unit testing
framework.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a2c343ee3b2c..f0bd77e8a8a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8799,6 +8799,17 @@ S:	Maintained
 F:	tools/testing/selftests/
 F:	Documentation/dev-tools/kselftest*
 
+KERNEL UNIT TESTING FRAMEWORK (KUnit)
+M:	Brendan Higgins <brendanhiggins@google.com>
+L:	linux-kselftest@vger.kernel.org
+L:	kunit-dev@googlegroups.com
+W:	https://google.github.io/kunit-docs/third_party/kernel/docs/
+S:	Maintained
+F:	Documentation/dev-tools/kunit/
+F:	include/kunit/
+F:	kunit/
+F:	tools/testing/kunit/
+
 KERNEL USERMODE HELPER
 M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.23.0.187.g17f5b7556c-goog

