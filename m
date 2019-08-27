Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC638C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D67E2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 21:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codon.org.uk header.i=@codon.org.uk header.b="W1ovLiBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfH0VOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 17:14:38 -0400
Received: from cavan.codon.org.uk ([93.93.128.6]:40114 "EHLO
        cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfH0VOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 17:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codon.org.uk; s=63138784; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Mx9Dk0y/TBT36EVwZByK1hsTBU2mCJBn5CqiJJkzVLg=; b=W1ovLiBG+dKXEhJcPYqAthsG5
        lO7UH68rMmm/aUW6+VJjzE5WIvCXi1esvPkkO0TnyumOoV0vJqKUJRZMm97hAsyCWTQ4zfsJsUu60
        HWux9CGbT+LTgBwf23oijcC7MmvT/+nsPJrsNEJmMMEpKjfBMyIEPCY+pNrDVLA/bmmCI=;
Received: from mjg59 by cavan.codon.org.uk with local (Exim 4.89)
        (envelope-from <mjg59@cavan.codon.org.uk>)
        id 1i2inB-000246-T5; Tue, 27 Aug 2019 22:14:17 +0100
Date:   Tue, 27 Aug 2019 22:14:17 +0100
From:   Matthew Garrett <mjg59@srcf.ucam.org>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
Message-ID: <20190827211417.snpwgnhsu5t6u52y@srcf.ucam.org>
References: <cover.1559129225.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1559129225.git.vpillai@digitalocean.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@cavan.codon.org.uk
X-SA-Exim-Scanned: No (on cavan.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple have provided a sysctl that allows applications to indicate that 
specific threads should make use of core isolation while allowing 
the rest of the system to make use of SMT, and browsers (Safari, Firefox 
and Chrome, at least) are now making use of this. Trying to do something 
similar using cgroups seems a bit awkward. Would something like this be 
reasonable? Having spoken to the Chrome team, I believe that the 
semantics we want are:

1) A thread to be able to indicate that it should not run on the same 
core as anything not in posession of the same cookie
2) Descendents of that thread to (by default) have the same cookie
3) No other thread be able to obtain the same cookie
4) Threads not be able to rejoin the global group (ie, threads can 
segregate themselves from their parent and peers, but can never rejoin 
that group once segregated)

but don't know if that's what everyone else would want.

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 094bb03b9cc2..5d411246d4d5 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -229,4 +229,5 @@ struct prctl_mm_map {
 # define PR_PAC_APDBKEY			(1UL << 3)
 # define PR_PAC_APGAKEY			(1UL << 4)
 
+#define PR_CORE_ISOLATE			55
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 12df0e5434b8..a054cfcca511 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2486,6 +2486,13 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 			return -EINVAL;
 		error = PAC_RESET_KEYS(me, arg2);
 		break;
+	case PR_CORE_ISOLATE:
+#ifdef CONFIG_SCHED_CORE
+		current->core_cookie = (unsigned long)current;
+#else
+		result = -EINVAL;
+#endif
+		break;
 	default:
 		error = -EINVAL;
 		break;


-- 
Matthew Garrett | mjg59@srcf.ucam.org
