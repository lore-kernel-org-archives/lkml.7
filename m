Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA33C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 21:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C372087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 21:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733053AbfHBVZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 17:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfHBVZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 17:25:11 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C056B2087C;
        Fri,  2 Aug 2019 21:25:09 +0000 (UTC)
Date:   Fri, 2 Aug 2019 17:25:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Divya Indi <divya.indi@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Joe Jin <joe.jin@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>
Subject: Re: [PATCH 7/7] tracing: Un-export ftrace_set_clr_event
Message-ID: <20190802172508.10e829d6@gandalf.local.home>
In-Reply-To: <87e1a9b8-9f72-c240-9b9a-2d454046e2f3@oracle.com>
References: <1564444954-28685-1-git-send-email-divya.indi@oracle.com>
        <1564444954-28685-8-git-send-email-divya.indi@oracle.com>
        <20190729205138.689864d2@gandalf.local.home>
        <8e50d405-a4fb-fadf-509e-157b031d7542@oracle.com>
        <20190802134229.2a969047@gandalf.local.home>
        <291a12f6-e1eb-052e-0dd6-0e649dd4a752@oracle.com>
        <20190802164641.46416744@gandalf.local.home>
        <87e1a9b8-9f72-c240-9b9a-2d454046e2f3@oracle.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Aug 2019 14:12:54 -0700
Divya Indi <divya.indi@oracle.com> wrote:

> Hi Steve,
> 
> The first patch would be like a temporary fix in case we need more 
> changes to the patches that add the new function - trace_array_set_clr() 
> and unexport ftrace_set_clr_event() and might take some time. In which 
> case I think it would be good to have this in place (But, not part of 
> this series).
> 
> If they all are to go in together as part of the same release ie if all 
> is good with the concerned patches (Patch 6 & Patch 7), then I think 
> having this patch would be meaningless.

Can you just do this part of patch 6 instead?

+/**
+ * trace_array_set_clr_event - enable or disable an event for a trace array
+ * @system: system name to match (NULL for any system)
+ * @event: event name to match (NULL for all events, within system)
+ * @set: 1 to enable, 0 to disable
+ *
+ * This is a way for other parts of the kernel to enable or disable
+ * event recording to instances.
+ *
+ * Returns 0 on success, -EINVAL if the parameters do not match any
+ * registered events.
+ */
+int trace_array_set_clr_event(struct trace_array *tr, const char *system,
+		const char *event, int set)
+{
+	if (!tr)
+		return -ENOENT;
+
+	return __ftrace_set_clr_event(tr, NULL, system, event, set);
+}
+EXPORT_SYMBOL_GPL(trace_array_set_clr_event);
+

-- Steve
