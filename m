Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F328EC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 19:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A6A20717
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 19:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392344AbfISTdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 15:33:50 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:45109 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389652AbfISTdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 15:33:49 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iB2BY-00051W-0w; Thu, 19 Sep 2019 13:33:48 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iB2BX-0001NK-55; Thu, 19 Sep 2019 13:33:47 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190917100350.GB1872@dhcp22.suse.cz>
        <38349607-b09c-fa61-ccbb-20bee9f282a3@gmx.de>
        <20190917153830.GE1872@dhcp22.suse.cz>
        <87ftku96md.fsf@x220.int.ebiederm.org>
        <20190918071541.GB12770@dhcp22.suse.cz>
Date:   Thu, 19 Sep 2019 14:33:24 -0500
In-Reply-To: <20190918071541.GB12770@dhcp22.suse.cz> (Michal Hocko's message
        of "Wed, 18 Sep 2019 09:15:41 +0200")
Message-ID: <87h8585bej.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iB2BX-0001NK-55;;;mid=<87h8585bej.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+R0XZkwUpXRftZRQYFO4Fw/RnZFIdY2A0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: threads-max observe limits
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> On Tue 17-09-19 12:26:18, Eric W. Biederman wrote:
>> Michal Hocko <mhocko@kernel.org> writes:
>> 
>> > On Tue 17-09-19 17:28:02, Heinrich Schuchardt wrote:
>> >> 
>> >> On 9/17/19 12:03 PM, Michal Hocko wrote:
>> >> > Hi,
>> >> > I have just stumbled over 16db3d3f1170 ("kernel/sysctl.c: threads-max
>> >> > observe limits") and I am really wondering what is the motivation behind
>> >> > the patch. We've had a customer noticing the threads_max autoscaling
>> >> > differences btween 3.12 and 4.4 kernels and wanted to override the auto
>> >> > tuning from the userspace, just to find out that this is not possible.
>> >> 
>> >> set_max_threads() sets the upper limit (max_threads_suggested) for
>> >> threads such that at a maximum 1/8th of the total memory can be occupied
>> >> by the thread's administrative data (of size THREADS_SIZE). On my 32 GiB
>> >> system this results in 254313 threads.
>> >
>> > This is quite arbitrary, isn't it? What would happen if the limit was
>> > twice as large?
>> >
>> >> With patch 16db3d3f1170 ("kernel/sysctl.c: threads-max observe limits")
>> >> a user cannot set an arbitrarily high number for
>> >> /proc/sys/kernel/threads-max which could lead to a system stalling
>> >> because the thread headers occupy all the memory.
>> >
>> > This is still a decision of the admin to make.  You can consume the
>> > memory by other means and that is why we have measures in place. E.g.
>> > memcg accounting.
>> >
>> >> When developing the patch I remarked that on a system where memory is
>> >> installed dynamically it might be a good idea to recalculate this limit.
>> >> If you have a system that boots with let's say 8 GiB and than
>> >> dynamically installs a few TiB of RAM this might make sense. But such a
>> >> dynamic update of thread_max_suggested was left out for the sake of
>> >> simplicity.
>> >> 
>> >> Anyway if more than 100,000 threads are used on a system, I would wonder
>> >> if the software should not be changed to use thread-pools instead.
>> >
>> > You do not change the software to overcome artificial bounds based on
>> > guessing.
>> >
>> > So can we get back to the justification of the patch. What kind of
>> > real life problem does it solve and why is it ok to override an admin
>> > decision?
>> > If there is no strong justification then the patch should be reverted
>> > because from what I have heard it has been noticed and it has broken
>> > a certain deployment. I am not really clear about technical details yet
>> > but it seems that there are workloads that believe they need to touch
>> > this tuning and complain if that is not possible.
>> 
>> Taking a quick look myself.
>> 
>> I am completely mystified by both sides of this conversation.
>> 
>> a) The logic to set the default number of threads in a system
>>    has not changed since 2.6.12-rc2 (the start of the git history).
>> 
>> The implementation has changed but we should still get the same
>> value.  So anyone seeing threads_max autoscaling differences
>> between kernels is either seeing a bug in the rewritten formula
>> or something else weird is going on.
>> 
>> Michal is it a very small effect your customers are seeing?
>> Is it another bug somewhere else?
>
> I am still trying to get more information. Reportedly they see a
> different auto tuned limit between two kernel versions which results in
> an applicaton complaining. As already mentioned this might be a side
> effect of something else and this is not yet fully analyzed. My main
> point for bringing up this discussion is ...

Please this sounds like the kind of issue that will reveal something
deeper about what is going on.

>
>> b) Not being able to bump threads_max to the physical limit of
>>    the machine is very clearly a regression.
>
> ... exactly this part. The changelog of the respective patch doesn't
> really exaplain why it is needed except of "it sounds like a good idea
> to be consistent".

I suggest doing a partial revert to just:

diff --git a/kernel/fork.c b/kernel/fork.c
index 7a74ade4e7d6..de8264ea34a7 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2943,7 +2943,7 @@ int sysctl_max_threads(struct ctl_table *table, int write,
 	if (ret || !write)
 		return ret;
 
-	set_max_threads(threads);
+	max_threads = threads;
 
 	return 0;
 }

proc_dointvec_minmax limiting the values to MIN_THREADS and MAX_THREADS
is justifiable.  Those are the minimum and maximum values the kernel can
function with.

With a good changelog we should be able to backport that change without
any fear.

Eric

