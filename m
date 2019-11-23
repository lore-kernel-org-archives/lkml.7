Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7199EC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 21:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505E5206D4
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 21:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfKWVIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 16:08:20 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40031 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKWVIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 16:08:19 -0500
Received: by mail-qk1-f196.google.com with SMTP id a137so7588911qkc.7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 13:08:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ks6VXyhQYbwbWdDu7jOK7bIaMkmqq8TaCySgeWCd3V0=;
        b=ZQPOVJsmnr/YB4JJUh7M4A17p3WJUMZkzKOe6eFJEX2piFQ60VIVnAlAk0Js7bC63J
         ViluqgLhjzkz8pN3GTLIOPOKPJWLehgtDU6YxDrAvFR0wKpFMYgYqONazdJy+ScQGnO0
         0FRbQGquIY9AlFkOUsWq7NlbpOiCPWTD1scQHSQ5UG7EYfCeR62bF7JcdUXdRBxtwceY
         Q9tpulvXr7DA0jKsBH6IktU+GwSll6VJy08dSxnrn1l0hlvxJekLDdgGG5+eP8qGj8Wa
         cWlmJ+j/DQL4YywAgFtJVHw1UVw4cTBMuO4Jv7D/jUeUlCo/svlCsDJcRxbqcMEkJq1T
         MBXw==
X-Gm-Message-State: APjAAAXdoxfgz35JeLT4BMCNflIc/fzLWpWpuke3F99Cx1Qij1u1DWn5
        nDNrah+NcNkRxrCi4IV8zNAJMnifq0w=
X-Google-Smtp-Source: APXvYqxEK6VBfv8iN4hHfoWax8DOYZupNkOySjgJ26b8LhXNpKa6qZWeoEJCc3IO4bnDb91n9so3sg==
X-Received: by 2002:a37:6481:: with SMTP id y123mr2854280qkb.171.1574543298296;
        Sat, 23 Nov 2019 13:08:18 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c37sm1164978qta.56.2019.11.23.13.08.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 13:08:17 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] init/main.c: minor cleanup/bugfix of envvar handling
Date:   Sat, 23 Nov 2019 16:08:05 -0500
Message-Id: <20191123210808.107904-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unknown_bootoption passes unrecognized command line arguments to init as
either environment variables or arguments. Some of the logic in the
function is broken for quoted command line arguments.

When an argument of the form param="value" is processed by parse_args
and passed to unknown_bootoption, the command line has
  param\0"value\0
with val pointing to the beginning of value. The helper function
repair_env_string is then used to restore the '=' character that was
removed by parse_args, and strip the quotes off fully. This results in
  param=value\0\0
and val ends up pointing to the 'a' instead of the 'v' in value. This
bug was introduced when repair_env_string was refactored into a separate
function, and the decrement of val in repair_env_string became dead code.

This causes two problems in unknown_bootoption in the two places where
the val pointer is used as a substitute for the length of param:

1. An argument of the form param=".value" is misinterpreted as a
potential module parameter, with the result that it will not be placed
in init's environment.

2. An argument of the form param="value" is checked to see if param is
an existing environment variable that should be overwritten, but the
comparison is off-by-one and compares 'param=v' instead of 'param='
against the existing environment. So passing, for example, TERM="vt100"
on the command line results in init being passed both TERM=linux and
TERM=vt100 in its environment.

Patch 1 adds logging for the arguments and environment passed to init
and is independent of the rest: it can be dropped if this is
unnecessarily verbose.

Patch 2 removes repair_env_string from initcall parameter parsing in
do_initcall_level, as that uses a separate copy of the command line now
and the repairing is no longer necessary.

Patch 3 fixes the bug in unknown_bootoption by recording the length of
param explicitly instead of implying it from val-param.


