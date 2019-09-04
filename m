Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3066C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8179B2087E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbfIDU7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 16:59:49 -0400
Received: from mga12.intel.com ([192.55.52.136]:57442 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbfIDU7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 16:59:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 13:59:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,468,1559545200"; 
   d="scan'208";a="187748999"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga006.jf.intel.com with ESMTP; 04 Sep 2019 13:59:48 -0700
Message-ID: <6119c6d98c056b3a3377031b1e46fb0fa77e6af2.camel@linux.intel.com>
Subject: Re: [PATCH 0/8] tools-power-x86-intel-speed-select: Fixes and
 updates for output
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Prarit Bhargava <prarit@redhat.com>,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     David Arcari <darcari@redhat.com>, linux-kernel@vger.kernel.org
Date:   Wed, 04 Sep 2019 13:59:48 -0700
In-Reply-To: <bab7688c-6ab6-16ad-d6f2-ade16af6892b@redhat.com>
References: <20190903153734.11904-1-prarit@redhat.com>
         <e6390a656dfd29b114b1e0659e3db169344cfa81.camel@linux.intel.com>
         <bab7688c-6ab6-16ad-d6f2-ade16af6892b@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2019-09-04 at 16:55 -0400, Prarit Bhargava wrote:
> 
> On 9/4/19 4:06 PM, Srinivas Pandruvada wrote:
> > On Tue, 2019-09-03 at 11:37 -0400, Prarit Bhargava wrote:
> > > Some general fixes and updates for intel-speed-select.  Fixes
> > > include
> > > some
> > > typos as well as an off-by-one cpu count reporting
> > > error.  Updates
> > > for the
> > > output are
> > > 
> > > - switching to MHz as a standard
> > > - reporting CPU frequencies instead of ratios as a standard
> > > - viewing a human-readable CPU list.
> > > - avoiding reporting "0|1" as success|fail as these can be
> > > confusing
> > > for a
> > >   user.
> > 
> > Series looks fine, except 8/8.
> > So please submit v2. Better to resubmit as a series as v2, unless
> > Andy
> > has other preference.
> 
> Thanks Srinivas.
> 
> I have an additional patch.  It looks like there's a memory
> leak.  Sorry for the
> cut-and-paste but if okay I'll submit this as part of v2.  Reworking
> the code
> this way makes it easier to introduce CascadeLake-N support too.
> 
Looks good to me.

> diff --git a/tools/power/x86/intel-speed-select/isst-config.c
> b/tools/power/x86/
> intel-speed-select/isst-config.c
> index 78f0cebda1da..59753b3917bb 100644
> --- a/tools/power/x86/intel-speed-select/isst-config.c
> +++ b/tools/power/x86/intel-speed-select/isst-config.c
> @@ -603,6 +603,10 @@ static int isst_fill_platform_info(void)
> 
>         close(fd);
> 
> +       if (isst_platform_info.api_version > supported_api_ver) {
> +               printf("Incompatible API versions; Upgrade of tool is
> required\n");
> +               return -1;
> +       }
>         return 0;
>  }
> 
> @@ -1528,6 +1532,7 @@ static void cmdline(int argc, char **argv)
>  {
>         int opt;
>         int option_index = 0;
> +       int ret;
> 
>         static struct option long_options[] = {
>                 { "cpu", required_argument, 0, 'c' },
> @@ -1589,13 +1594,14 @@ static void cmdline(int argc, char **argv)
>         set_max_cpu_num();
>         set_cpu_present_cpu_mask();
>         set_cpu_target_cpu_mask();
> -       isst_fill_platform_info();
> -       if (isst_platform_info.api_version > supported_api_ver) {
> -               printf("Incompatible API versions; Upgrade of tool is
> required\n");
> -               exit(0);
> -       }
> +       ret = isst_fill_platform_info();
> +       if (ret)
> +               goto out;
> 
>         process_command(argc, argv);
> +out:
> +       free_cpu_set(present_cpumask);
> +       free_cpu_set(target_cpumask);
>  }
> 
>  int main(int argc, char **argv)
> 
> P.
> > 
> > Thanks,
> > Srinivas
> > 
> > > 
> > > Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> > > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > Cc: David Arcari <darcari@redhat.com>
> > > Cc: linux-kernel@vger.kernel.org
> > > 
> > > Prarit Bhargava (8):
> > >   tools/power/x86/intel-speed-select: Fix package typo
> > >   tools/power/x86/intel-speed-select: Fix help option typo
> > >   tools/power/x86/intel-speed-select: Fix cpu-count output
> > >   tools/power/x86/intel-speed-select: Simplify output for turbo-
> > > freq
> > > and
> > >     base-freq
> > >   tools/power/x86/intel-speed-select: Switch output to MHz
> > >   tools/power/x86/intel-speed-select: Change turbo ratio output
> > > to
> > >     maximum turbo frequency
> > >   tools/power/x86/intel-speed-select: Output human readable CPU
> > > list
> > >   tools/power/x86/intel-speed-select: Output success/failed for
> > > command
> > >     output
> > > 
> > >  .../x86/intel-speed-select/isst-config.c      |   4 +-
> > >  .../x86/intel-speed-select/isst-display.c     | 116
> > > ++++++++++++--
> > > ----
> > >  2 files changed, 83 insertions(+), 37 deletions(-)
> > > 

