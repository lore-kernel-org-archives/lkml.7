Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59786C31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 02:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF5220644
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 02:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408526AbfFLCwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 22:52:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60858 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404957AbfFLCwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 22:52:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D1965307D849;
        Wed, 12 Jun 2019 02:52:33 +0000 (UTC)
Received: from treble (ovpn-120-37.rdu2.redhat.com [10.10.120.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AFB3D68B23;
        Wed, 12 Jun 2019 02:52:30 +0000 (UTC)
Date:   Tue, 11 Jun 2019 21:52:27 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Subject: Re: linux-next 20190611: objtool warning
Message-ID: <20190612025227.lxumqqtqao6iqms3@treble>
References: <a9ceb8f8-f2fd-e57d-3428-aaf50e011a43@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9ceb8f8-f2fd-e57d-3428-aaf50e011a43@infradead.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 12 Jun 2019 02:52:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 06:59:22PM -0700, Randy Dunlap wrote:
> Hi,
> 
> New warning AFAIK:
> 
> drivers/hwmon/smsc47m1.o: warning: objtool: fan_div_store()+0x11f: sibling call from callable instruction with modified stack frame

I'm getting a different warning:

  drivers/hwmon/smsc47m1.o: warning: objtool: fan_div_store()+0xb6: can't find jump dest instruction at .text+0x93a

But I bet the root cause is the same.

This fixes it for me:

From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] hwmon/smsc47m1: Fix objtool warning caused by undefined behavior

Objtool is reporting the following warning:

  drivers/hwmon/smsc47m1.o: warning: objtool: fan_div_store()+0xb6: can't find jump dest instruction at .text+0x93a

It's apparently caused by

  2cf6745e69d1 ("hwmon: (smsc47m1) fix (suspicious) outside array bounds warnings")

which is somehow convincing GCC to add a jump past the end of the
function:

  793:   45 85 ed                test   %r13d,%r13d
  796:   0f 88 9e 01 00 00       js     93a <fan_div_store+0x25a>
  ...
  930:   e9 5e fe ff ff          jmpq   793 <fan_div_store+0xb3>
  935:   e8 00 00 00 00          callq  93a <fan_div_store+0x25a>
			936: R_X86_64_PLT32     __stack_chk_fail-0x4
  <function end>

I suppose this falls under the category of undefined behavior, so we
probably can't call it a GCC bug.  But if the value of "nr" were out of
range somehow then it would start executing random code.  Use a runtime
BUG() assertion to avoid undefined behavior.

Fixes: 2cf6745e69d1 ("hwmon: (smsc47m1) fix (suspicious) outside array bounds warnings")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 drivers/hwmon/smsc47m1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
index 6d366c9cb906..b637836b58a1 100644
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -352,7 +352,7 @@ static ssize_t fan_div_store(struct device *dev,
 		smsc47m1_write_value(data, SMSC47M2_REG_FANDIV3, tmp);
 		break;
 	default:
-		unreachable();
+		BUG();
 	}
 
 	/* Preserve fan min */
-- 
2.20.1

