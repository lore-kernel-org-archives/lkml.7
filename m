Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF4EC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD3721D71
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733294AbfJAME3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:04:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:37522 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725821AbfJAME3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:04:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B00D5B149;
        Tue,  1 Oct 2019 12:04:26 +0000 (UTC)
Date:   Tue, 1 Oct 2019 14:04:23 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sodagudi Prasad <psodagud@codeaurora.org>
Cc:     sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: Re: Time stamp value in printk records
Message-ID: <20191001120423.ann2i2cvkojy6hcb@pathway.suse.cz>
References: <7d1aee8505b91c460fee347ed4204b9a@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d1aee8505b91c460fee347ed4204b9a@codeaurora.org>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2019-09-30 06:33:42, Sodagudi Prasad wrote:
> Hi All,
> 
> From Qualcomm side, we would like to check with upstream team about adding
> Raw time stamp value to printk records. On Qualcomm soc, there are various
> DSPs subsystems are there - for example audio, video and modem DSPs.
> Adding raw timer value(along with sched_clock()) in the printk record helps
> in the following use cases –
> 1)	To find out which subsystem  crashed first  -  Whether application
> processor crashed first or DSP subsystem?
> 2)	If there are any system stability issues on the DSP side, what is the
> activity on the APPS processor side during that time?
> 
> Initially during the device boot up, printk shed_clock value can be matched
> with timer raw value used on the dsp subsystem, but after APPS processor
> suspends several times, we don’t have way to correlate the time stamp  value
> on the DSP and APPS processor. All timers(both apps processor timer and dsp
> timers) are derived from globally always on timer on Qualcomm soc, So
> keeping global timer raw values in printk records and dsp logs help to
> correlate the activity of all the processors in SoC.
> 
> It would be great if upstream team adds common solution this problem if all
> soc vendors would get benefit by adding raw timer value to  printk records.

There were some proposals in the past. IMHO, the most comprehensive
discussion can be found at
https://lore.kernel.org/lkml/alpine.DEB.2.20.1711131023170.1851@nanos/

The main requirement is:

   + The main timestamp must have the same semantic on all systems

   + User space parses the timestamp. We must not break the format
     and semantic.

  + printk() need to get the timestamp a lockless way


Now, different people wanted different clocks in the past. Which
brings several problems:

   + configuration
   + storing
   + output format so that people/tools know what they read

There is a huge risk that it will get over engineered. Also
there is a risk that some userspace tools might parse it
and we would need to maintain compatibility forever.

IMHO, the most acceptable idea was to print a line with "all"
possible clocks every now and then. It can be done regularly
(once a hour/day) or on event (resume).

These are hints and pointers. Feel free to send patches so
that we could discuss them.

Best Regards,
Petr
