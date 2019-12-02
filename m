Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70282C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4051A20833
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zK9GMzrq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfLBRGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:06:40 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45866 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbfLBRGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=12vfepLsf3YjzqkbhBhkyf8yhAtAkfl23HqEvJbIYys=; b=zK9GMzrqmWlBy2n7w8dQ32Vqf
        bv8aGZN49p6N2cxJl8zVgmFND6A2TJ6qR2c+N17WmR7c5M+PhTby3xuCZmjxs8D1e5BFfTTehCC3P
        fpC8GqCLcf714iQFA+30cAgS2AaxfXmMyMyVEXAQuZQeK97qAGOWN8nJ44do0XzJmylqa6JQjNfOG
        6MITRiyMF3gFeuz2hM/dahKKuDKCf69x2sLnGWAcQ4ZYmTBsPg9edkoooNdcXI+aGLzZea3WejnXj
        Td34e9V1X+aEoOdriw5fZaAKVTP7AjKTTHGbceS3WAIVLrTodn4iH3j8tzAJrzDua9grQJsPDwmWK
        fMmWlKCZg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ibp9e-00020p-OC; Mon, 02 Dec 2019 17:06:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 363CD301A6C;
        Mon,  2 Dec 2019 18:05:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D51120D96EC4; Mon,  2 Dec 2019 18:06:33 +0100 (CET)
Date:   Mon, 2 Dec 2019 18:06:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Meelis Roos <mroos@linux.ee>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: UBSAN: Undefined behaviour in arch/x86/events/intel/p6.c:116:29
Message-ID: <20191202170633.GN2844@hirez.programming.kicks-ass.net>
References: <02f44ed5-13ac-f9c6-1f35-129c41006900@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02f44ed5-13ac-f9c6-1f35-129c41006900@linux.ee>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 07:55:08PM +0200, Meelis Roos wrote:
> While testing 5.4 on a Dell D600 (32-bit), I noticed the old UBSAN warnings from p6 perf events.
> I remember having seen these warnings on other p6 era computers too.
> 
> [    2.795167] ================================================================================
> [    2.795206] UBSAN: Undefined behaviour in arch/x86/events/intel/p6.c:116:29
> [    2.795235] index 8 is out of range for type 'u64 [8]'
> [    2.795265] CPU: 0 PID: 1 Comm: swapper Not tainted 5.4.0-03419-g386403a115f9-dirty #18
> [    2.795266] Hardware name: Dell Computer Corporation Latitude D600                   /0X2034, BIOS A16 06/29/2005
> [    2.795268] Call Trace:
> [    2.795283]  dump_stack+0x16/0x19
> [    2.795290]  ubsan_epilogue+0xb/0x29
> [    2.795293]  __ubsan_handle_out_of_bounds.cold+0x43/0x48
> [    2.795299]  ? sysfs_add_file_mode_ns+0xad/0x180
> [    2.795304]  p6_pmu_event_map+0x3b/0x50
> [    2.795306]  is_visible+0x25/0x30
> [    2.795308]  ? collect_events+0x150/0x150
> [    2.795310]  internal_create_group+0xd8/0x3e0
> [    2.795312]  ? collect_events+0x150/0x150
> [    2.795314]  internal_create_groups.part.0+0x34/0x80
> [    2.795317]  sysfs_create_groups+0x10/0x20
> [    2.795321]  device_add+0x536/0x5a0
> [    2.795326]  ? kvasprintf_const+0x59/0x90
> [    2.795331]  ? kfree_const+0xf/0x30
> [    2.795334]  ? kobject_set_name_vargs+0x6a/0xa0
> [    2.795338]  pmu_dev_alloc+0x8e/0xe0
> [    2.795344]  perf_event_sysfs_init+0x40/0x78
> [    2.795346]  ? stack_map_init+0x17/0x17
> [    2.795347]  do_one_initcall+0x7a/0x1b3
> [    2.795351]  ? do_early_param+0x75/0x75
> [    2.795354]  kernel_init_freeable+0x1ae/0x230
> [    2.795357]  ? rest_init+0x6d/0x6d
> [    2.795359]  kernel_init+0x9/0xf3
> [    2.795361]  ? rest_init+0x6d/0x6d
> [    2.795363]  ret_from_fork+0x2e/0x38
> [    2.795364] ================================================================================

Does something like so fix it?

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 9a89d98c55bd..f0ab61cd2f68 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1642,9 +1642,12 @@ static struct attribute_group x86_pmu_format_group __ro_after_init = {
 
 ssize_t events_sysfs_show(struct device *dev, struct device_attribute *attr, char *page)
 {
-	struct perf_pmu_events_attr *pmu_attr = \
+	struct perf_pmu_events_attr *pmu_attr =
 		container_of(attr, struct perf_pmu_events_attr, attr);
-	u64 config = x86_pmu.event_map(pmu_attr->id);
+	u64 config = 0;
+
+	if (pmu_attr->id < x86_pmu.max_events)
+		config = x86_pmu.event_map(pmu_attr->id);
 
 	/* string trumps id */
 	if (pmu_attr->event_str)
