Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D85C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950C72089F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732903AbfIWQak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:30:40 -0400
Received: from scorn.kernelslacker.org ([45.56.101.199]:49116 "EHLO
        scorn.kernelslacker.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfIWQak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:30:40 -0400
X-Greylist: delayed 2397 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Sep 2019 12:30:40 EDT
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtp (Exim 4.92)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1iCQbp-0007XD-MU; Mon, 23 Sep 2019 11:50:41 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id 55492560162; Mon, 23 Sep 2019 11:50:41 -0400 (EDT)
Date:   Mon, 23 Sep 2019 11:50:41 -0400
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
Subject: ntp audit spew.
Message-ID: <20190923155041.GA14807@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have some hosts that are constantly spewing audit messages like so:

[46897.591182] audit: type=1333 audit(1569250288.663:220): op=offset old=2543677901372 new=2980866217213
[46897.591184] audit: type=1333 audit(1569250288.663:221): op=freq old=-2443166611284 new=-2436281764244
[48850.604005] audit: type=1333 audit(1569252241.675:222): op=offset old=1850302393317 new=3190241577926
[48850.604008] audit: type=1333 audit(1569252241.675:223): op=freq old=-2436281764244 new=-2413071187316
[49926.567270] audit: type=1333 audit(1569253317.638:224): op=offset old=2453141035832 new=2372389610455
[49926.567273] audit: type=1333 audit(1569253317.638:225): op=freq old=-2413071187316 new=-2403561671476

This gets emitted every time ntp makes an adjustment, which is apparently very frequent on some hosts.


Audit isn't even enabled on these machines.

# auditctl -l
No rules

# auditctl -s
enabled 0
failure 1
pid 0
rate_limit 0
backlog_limit 64
lost 0
backlog 0
loginuid_immutable 0 unlocked

Asides from the log spew, why is this code doing _anything_ when audit
isn't enabled ?

Something like this:


diff --git a/kernel/audit.c b/kernel/audit.c
index da8dc0db5bd3..1291d826c024 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2340,6 +2340,9 @@ void audit_log(struct audit_context *ctx, gfp_t gfp_mask, int type,
 	struct audit_buffer *ab;
 	va_list args;
 
+	if (audit_initialized != AUDIT_INITIALIZED)
+		return;
+
 	ab = audit_log_start(ctx, gfp_mask, type);
 	if (ab) {
 		va_start(args, fmt);


Might silence the spew, but I'm concerned that the amount of work that
audit is doing on an unconfigured machine might warrant further
investigation.

("turn off CONFIG_AUDIT" isn't an option unfortunately, as this is a
one-size-fits-all kernel that runs on some other hosts that /do/ have
audit configured)

	Dave

