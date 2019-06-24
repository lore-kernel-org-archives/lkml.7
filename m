Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309AEC48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00FBD208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaVWc9JS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfFXImc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 04:42:32 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44758 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfFXImc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 04:42:32 -0400
Received: by mail-io1-f68.google.com with SMTP id s7so314057iob.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 01:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZDK98pFVpxt3chkW1SOjanxcVKTD0vgdvliCnO9TDw=;
        b=GaVWc9JSf9wAxISpuhTVscTFLYvILW3vniklJFaI1vv/NHx9x1mRLzYj/z0McDaIeh
         UC2vVaMO7FpWZQP3TW5wdKIxA4UlAI7b2N1VaOCcNCctRhbMbyy6RECYU1QiHsVyOriM
         siiSyvwCDXUyOxOwnDOqdCHjuJsKeAyey2cmjwd9hzF4qJz3x2gW3YxggyHWn3FlToV+
         9rjw8ZCnxaWx2gEpS/hmCi3nAWjd3FobYDlVWMJU+SoqDOTwK6pmo3qlmxzEHHXCx8tF
         vRPGIzZQxBbIJIdesoB/MbQ9xrDVXG0U8pXE/jhRah3fpzWlpC2c5Dzrn2NaYHF7FxKJ
         TYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZDK98pFVpxt3chkW1SOjanxcVKTD0vgdvliCnO9TDw=;
        b=f0F17R4MRpNMgaAP+vmi4MPYtKwiCS3bTHVOO2flf09GCvGRnPtHjrlOopFfxiHLS0
         PbsbnNO8dTHUp0vvkIJxj9o6zznY/1hQJsemym1ULQ5SDxXHoZYbbRi5rUahRJtkEsXK
         EgqrxeyR0Bek/2kMHn7p0SYXDhTpWtVS2uIXxvEHPjMHC4EcjEEMDB4/VDE3y44RdKV9
         i0lwCVHOy1yqfheKw8iEO4HeAAmPBSZ/xJbu8rR3R10CncFRgobvTYHohH5IGkpOtL55
         XemLYDmS4JQDZjKxTJ5E67BajSLl6/iqImSePamTSmpUa+08r04/EEBmLLtlfc17xgN0
         GsBQ==
X-Gm-Message-State: APjAAAWc5hKnP/KXqNEZGe6pYRFl1DaIFlkfLRo+3a60Eexr2+UnQJRs
        PPTb6jDRMmGyZuH5p2a5MLOjXZ+dL1bFTju3bg==
X-Google-Smtp-Source: APXvYqxx7glCCsFqx7G/HkqXPaiYIfpS79svZoUBDKDV/wgnir+RKuzvj8Mui4giQxIVCXR+W8I7qXj9HjI3nRGl4Eo=
X-Received: by 2002:a05:6638:40c:: with SMTP id q12mr22707922jap.17.1561365751552;
 Mon, 24 Jun 2019 01:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190512054829.11899-1-cai@lca.pw> <20190513124112.GH24036@dhcp22.suse.cz>
 <1561123078.5154.41.camel@lca.pw> <20190621135507.GE3429@dhcp22.suse.cz>
In-Reply-To: <20190621135507.GE3429@dhcp22.suse.cz>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 24 Jun 2019 16:42:20 +0800
Message-ID: <CAFgQCTvSJjzFGGyt_VOvyB46yy6452wach7UmmuY5ZJZ3YZzcg@mail.gmail.com>
Subject: Re: [PATCH -next v2] mm/hotplug: fix a null-ptr-deref during NUMA boot
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Barret Rhoden <brho@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@elte.hu>,
        Oscar Salvador <osalvador@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

What about dropping the change of the online definition of your patch,
just do the following?
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index e6dad60..9c087c3 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -749,13 +749,12 @@ static void __init init_memory_less_node(int nid)
  */
 void __init init_cpu_to_node(void)
 {
-       int cpu;
+       int cpu, node;
        u16 *cpu_to_apicid = early_per_cpu_ptr(x86_cpu_to_apicid);

        BUG_ON(cpu_to_apicid == NULL);

-       for_each_possible_cpu(cpu) {
-               int node = numa_cpu_node(cpu);
+       for_each_node_mask(node, numa_nodes_parsed) {

                if (node == NUMA_NO_NODE)
                        continue;
@@ -765,6 +764,10 @@ void __init init_cpu_to_node(void)

                numa_set_node(cpu, node);
        }
+       for_each_possible_cpu(cpu) {
+               int node = numa_cpu_node(cpu);
+               numa_set_node(cpu, node);
+       }
 }

Thanks,
  Pingfan

On Fri, Jun 21, 2019 at 9:55 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 21-06-19 09:17:58, Qian Cai wrote:
> > Sigh...
> >
> > I don't see any benefit to keep the broken commit,
> >
> > "x86, numa: always initialize all possible nodes"
> >
> > for so long in linux-next that just prevent x86 NUMA machines with any memory-
> > less node from booting.
> >
> > Andrew, maybe it is time to drop this patch until Michal found some time to fix
> > it properly.
>
> Yes, please drop the patch for now, Andrew. I thought I could get to
> this but time is just scarce.
> --
> Michal Hocko
> SUSE Labs
