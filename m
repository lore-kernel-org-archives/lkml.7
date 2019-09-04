Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADB1C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C83A72087E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbfIDUza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 16:55:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55094 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbfIDUz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 16:55:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 142653090FCF;
        Wed,  4 Sep 2019 20:55:29 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7FAFC60C18;
        Wed,  4 Sep 2019 20:55:28 +0000 (UTC)
Subject: Re: [PATCH 0/8] tools-power-x86-intel-speed-select: Fixes and updates
 for output
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     David Arcari <darcari@redhat.com>, linux-kernel@vger.kernel.org
References: <20190903153734.11904-1-prarit@redhat.com>
 <e6390a656dfd29b114b1e0659e3db169344cfa81.camel@linux.intel.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <bab7688c-6ab6-16ad-d6f2-ade16af6892b@redhat.com>
Date:   Wed, 4 Sep 2019 16:55:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e6390a656dfd29b114b1e0659e3db169344cfa81.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 04 Sep 2019 20:55:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/19 4:06 PM, Srinivas Pandruvada wrote:
> On Tue, 2019-09-03 at 11:37 -0400, Prarit Bhargava wrote:
>> Some general fixes and updates for intel-speed-select.  Fixes include
>> some
>> typos as well as an off-by-one cpu count reporting error.  Updates
>> for the
>> output are
>>
>> - switching to MHz as a standard
>> - reporting CPU frequencies instead of ratios as a standard
>> - viewing a human-readable CPU list.
>> - avoiding reporting "0|1" as success|fail as these can be confusing
>> for a
>>   user.
> Series looks fine, except 8/8.
> So please submit v2. Better to resubmit as a series as v2, unless Andy
> has other preference.

Thanks Srinivas.

I have an additional patch.  It looks like there's a memory leak.  Sorry for the
cut-and-paste but if okay I'll submit this as part of v2.  Reworking the code
this way makes it easier to introduce CascadeLake-N support too.

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/
intel-speed-select/isst-config.c
index 78f0cebda1da..59753b3917bb 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -603,6 +603,10 @@ static int isst_fill_platform_info(void)

        close(fd);

+       if (isst_platform_info.api_version > supported_api_ver) {
+               printf("Incompatible API versions; Upgrade of tool is required\n");
+               return -1;
+       }
        return 0;
 }

@@ -1528,6 +1532,7 @@ static void cmdline(int argc, char **argv)
 {
        int opt;
        int option_index = 0;
+       int ret;

        static struct option long_options[] = {
                { "cpu", required_argument, 0, 'c' },
@@ -1589,13 +1594,14 @@ static void cmdline(int argc, char **argv)
        set_max_cpu_num();
        set_cpu_present_cpu_mask();
        set_cpu_target_cpu_mask();
-       isst_fill_platform_info();
-       if (isst_platform_info.api_version > supported_api_ver) {
-               printf("Incompatible API versions; Upgrade of tool is required\n");
-               exit(0);
-       }
+       ret = isst_fill_platform_info();
+       if (ret)
+               goto out;

        process_command(argc, argv);
+out:
+       free_cpu_set(present_cpumask);
+       free_cpu_set(target_cpumask);
 }

 int main(int argc, char **argv)

P.
> 
> Thanks,
> Srinivas
> 
>>
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> Cc: David Arcari <darcari@redhat.com>
>> Cc: linux-kernel@vger.kernel.org
>>
>> Prarit Bhargava (8):
>>   tools/power/x86/intel-speed-select: Fix package typo
>>   tools/power/x86/intel-speed-select: Fix help option typo
>>   tools/power/x86/intel-speed-select: Fix cpu-count output
>>   tools/power/x86/intel-speed-select: Simplify output for turbo-freq
>> and
>>     base-freq
>>   tools/power/x86/intel-speed-select: Switch output to MHz
>>   tools/power/x86/intel-speed-select: Change turbo ratio output to
>>     maximum turbo frequency
>>   tools/power/x86/intel-speed-select: Output human readable CPU list
>>   tools/power/x86/intel-speed-select: Output success/failed for
>> command
>>     output
>>
>>  .../x86/intel-speed-select/isst-config.c      |   4 +-
>>  .../x86/intel-speed-select/isst-display.c     | 116 ++++++++++++--
>> ----
>>  2 files changed, 83 insertions(+), 37 deletions(-)
>>
> 
