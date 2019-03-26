Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B833EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997F32084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732386AbfCZSDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:03:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731940AbfCZSDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:03:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E6D163004E7B;
        Tue, 26 Mar 2019 18:03:54 +0000 (UTC)
Received: from treble (ovpn-120-253.rdu2.redhat.com [10.10.120.253])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C7A6C5C72F;
        Tue, 26 Mar 2019 18:03:51 +0000 (UTC)
Date:   Tue, 26 Mar 2019 13:03:48 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] cpu/hotplug: Create SMT sysfs interface for all arches
Message-ID: <20190326180348.fzerpltlf62dnurd@treble>
References: <426cde0f727f0cbadc501bb9bca8c99c4e11ac02.1551462051.git.jpoimboe@redhat.com>
 <alpine.DEB.2.21.1903242104280.1798@nanos.tec.linutronix.de>
 <20190326133236.lylrrbacznezybjm@treble>
 <alpine.DEB.2.21.1903261452290.1789@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903261452290.1789@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 26 Mar 2019 18:03:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 02:53:04PM +0100, Thomas Gleixner wrote:
> On Tue, 26 Mar 2019, Josh Poimboeuf wrote:
> > On Sun, Mar 24, 2019 at 09:13:18PM +0100, Thomas Gleixner wrote:
> > > Second thoughts. I'm not really convinced that changing the meaning of
> > > notsupported and in fact overloading it, is the right thing to do.
> > > notsupported means now:
> > > 
> > >   CPU does not support it - OR - architecture does not support it
> > > 
> > > That's not pretty and we are surely not short of state space. There are
> > > several options for handling this:
> > > 
> > >  1) Do not expose the state file, just expose the active file
> > > 
> > >  2) Expose the state file, but return -ENOTSUPP or some other sensible error
> > >     code
> > > 
> > >  3) Expose the state file and let show return 'notimplemented' which is
> > >     more accurate. That wouldn't even require to expand the state space
> > >     enum. It just can be returned unconditionally.
> > 
> > Makes sense.  I like #3.  I can post another version.
> 
> Yes, please.

Something like so (on top of the original patch)?

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 4a11cba73085..5eea46fefcb2 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -511,11 +511,12 @@ Description:	Control Symetric Multi Threading (SMT)
 		control: Read/write interface to control SMT. Possible
 			 values:
 
-			 "on"		SMT is enabled
-			 "off"		SMT is disabled
-			 "forceoff"	SMT is force disabled. Cannot be changed.
-			 "notsupported" Runtime SMT toggling is not currently
-					supported for the architecture
+			 "on"		  SMT is enabled
+			 "off"		  SMT is disabled
+			 "forceoff"	  SMT is force disabled. Cannot be changed.
+			 "notsupported"   SMT is not supported by the CPU
+			 "notimplemented" SMT runtime toggling is not
+					  implemented for the architecture
 
 			 If control status is "forceoff" or "notsupported" writes
 			 are rejected.
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 517ab1803a22..05a71ee98440 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2145,7 +2145,11 @@ static const char *smt_states[] = {
 static ssize_t
 show_smt_control(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE - 2, "%s\n", smt_states[cpu_smt_control]);
+	const char *state = IS_ENABLED(CONFIG_HOTPLUG_SMT) ?
+				smt_states[cpu_smt_control] :
+				"notimplemented";
+
+	return snprintf(buf, PAGE_SIZE - 2, "%s\n", state);
 }
 
 static ssize_t
