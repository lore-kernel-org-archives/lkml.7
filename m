Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF85C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 22:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1341B2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 22:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="B0kp+i3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732700AbfHOWcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 18:32:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41928 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731783AbfHOWcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 18:32:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id j16so3582144wrr.8;
        Thu, 15 Aug 2019 15:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gh7bsGYbNQoYyg4yGUT9u/g5lRriXJz8oS4IHQgucXk=;
        b=B0kp+i3vDugvxV0jJjXT52DgeBzCxYP3h7rPFg3bUauVTBOUAiKnHGahD1mSo5s5Vi
         jRBpUNVk4+WGpOIbt8rViffu4pQ2wLQisE5EKRHc0t9FGQMMy0ToCU3S77JXON5J4Aui
         sLrm5qqGp1jseuH78hJeHd05gwlf2fjjyE1gfCnMRo+2u8cvNhYvMhv5NHuhha6N0GIO
         bOkWEK75QdwtJ7GhTKBrFClOkBC7AuaTlnR57Yem1SinQRgJvQ2ZTi8D1qfhtlMJtBW0
         jUj23LiUeP+qj+WgMtOoHX/OlOOX7GzMaC0uvV3MC+USXqUSk4OYJv0IB2mnwsFRvwYW
         nlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gh7bsGYbNQoYyg4yGUT9u/g5lRriXJz8oS4IHQgucXk=;
        b=F44MwUbMPJWF28NUfsJky92/54qtLaxKACWWHQejmXpMJjDOsEJYg/6AOnIeQs2NGG
         00xRhKKomTXUCTVFkmaizJJO5NZ8YgEuvAOs/t8hwTXQaxMwkIrKkBXjkCYSBTICZQ1o
         Q2Ee/SWOo9p9IDUDDHA47utTYpZ+YB4VpXRusI/1+jbH15EcFpKu6OnS0fsIFC/4cG4n
         cA+BBCVmNtEIWCj1m2kQVEUyozi1qHV19tDSka8osByLMwlsgERyLqebX0vPRdNZdl/J
         67X73wXxWfa2AuHzEQQflbBjBGiHGC93ctS8sJW+VZa056vPkDtxZwO8MNQCisi12+u9
         lHcg==
X-Gm-Message-State: APjAAAW2bkg7yW1REfqrpTydSCpWQEp2EYHFlxDW8qyfG130Yq5cZ38X
        58UaGKVmxhYCX3MgdMMDYjWhkH/I
X-Google-Smtp-Source: APXvYqwQSTq6lAEUAIlxpw2SeqLRvxY2JOPIQ2k2Wq7n6N8myyCy/3GIYy5iUTzcxnuDTOQ9JrfIDA==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr193560wrs.108.1565908324656;
        Thu, 15 Aug 2019 15:32:04 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C1F600F17406154CCE0537.dip0.t-ipconnect.de. [2003:f1:33c1:f600:f174:615:4cce:537])
        by smtp.googlemail.com with ESMTPSA id c15sm12146513wrb.80.2019.08.15.15.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 15:32:04 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-clk@vger.kernel.org, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1] clk: Fix potential NULL dereference in clk_fetch_parent_index()
Date:   Fri, 16 Aug 2019 00:31:55 +0200
Message-Id: <20190815223155.21384-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't compare the parent clock name with a NULL name in the
clk_parent_map. This prevents a kernel crash when passing NULL
core->parents[i].name to strcmp().

An example which triggered this is a mux clock with four parents when
each of them is referenced in the clock driver using
clk_parent_data.fw_name and then calling clk_set_parent(clk, 3rd_parent)
on this mux.
In this case the first parent is also the HW default so
core->parents[i].hw is populated when the clock is registered. Calling
clk_set_parent(clk, 3rd_parent) will then go through all parents and
skip the first parent because it's hw pointer doesn't match. For the
second parent no hw pointer is cached yet and clk_core_get(core, 1)
returns a non-matching pointer (which is correct because we are comparing
the second with the third parent). Comparing the result of
clk_core_get(core, 2) with the requested parent gives a match. However
we don't reach this point because right after the clk_core_get(core, 1)
mismatch the old code tried to !strcmp(parent->name, NULL) (where the
second argument is actually core->parents[i].name, but that was never
populated by the clock driver).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
I have seen the original crash when I was testing an MMC driver which
is not upstream yet on v5.3-rc4. I'm not sure whether this fix is
"correct" (it fixes the crash for me) or where to point the Fixes tag
to, it may be one of:
- fc0c209c147f ("clk: Allow parents to be specified without string names")
- 1a079560b145 ("clk: Cache core in clk_fetch_parent_index() without names")

This is meant to be applied on top of v5.3-rc4.


 drivers/clk/clk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c0990703ce54..567a044a368b 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1632,7 +1632,8 @@ static int clk_fetch_parent_index(struct clk_core *core,
 			break;
 
 		/* Fallback to comparing globally unique names */
-		if (!strcmp(parent->name, core->parents[i].name))
+		if (core->parents[i].name &&
+		    !strcmp(parent->name, core->parents[i].name))
 			break;
 	}
 
-- 
2.22.1

