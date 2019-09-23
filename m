Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715A4C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512A121841
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbfIWPWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 11:22:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:52530 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfIWPWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:22:12 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Sep 2019 08:22:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,540,1559545200"; 
   d="scan'208";a="203143434"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga001.fm.intel.com with SMTP; 23 Sep 2019 08:22:07 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 23 Sep 2019 18:22:06 +0300
Date:   Mon, 23 Sep 2019 18:22:06 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Tony Camuso <tcamuso@redhat.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, dkwon@redhat.com,
        Joe Donahue <jdonohue@redhat.com>,
        John Feeney <jfeeney@redhat.com>
Subject: Re: [PATCH] drm: assure aux_dev is nonzero before using it
Message-ID: <20190923152206.GN1208@intel.com>
References: <20190523110905.22445-1-tcamuso@redhat.com>
 <87v9y0mept.fsf@intel.com>
 <5111581c-9d73-530d-d3ff-4f6950bf3f8c@redhat.com>
 <20190710135617.GE5942@intel.com>
 <374b7e4e-40a2-f3c0-ae14-c533bd42243f@redhat.com>
 <20190712170657.GL5942@intel.com>
 <841db615-a353-2174-6fd6-a3302f352b08@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <841db615-a353-2174-6fd6-a3302f352b08@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 11:03:35AM -0400, Tony Camuso wrote:
> On 7/12/19 1:06 PM, Ville Syrjälä wrote:
> > On Fri, Jul 12, 2019 at 12:07:46PM -0400, Tony Camuso wrote:
> >> On 7/10/19 9:56 AM, Ville Syrjälä wrote:
> >>> On Wed, Jul 10, 2019 at 09:47:11AM -0400, Tony Camuso wrote:
> >>>> On 5/24/19 4:36 AM, Jani Nikula wrote:
> >>>>> On Thu, 23 May 2019, tcamuso <tcamuso@redhat.com> wrote:
> >>>>>>    From Daniel Kwon <dkwon@redhat.com>
> >>>>>>
> >>>>>> The system was crashed due to invalid memory access while trying to access
> >>>>>> auxiliary device.
> >>>>>>
> >>>>>> crash> bt
> >>>>>> PID: 9863   TASK: ffff89d1bdf11040  CPU: 1   COMMAND: "ipmitool"
> >>>>>>     #0 [ffff89cedd7f3868] machine_kexec at ffffffffb0663674
> >>>>>>     #1 [ffff89cedd7f38c8] __crash_kexec at ffffffffb071cf62
> >>>>>>     #2 [ffff89cedd7f3998] crash_kexec at ffffffffb071d050
> >>>>>>     #3 [ffff89cedd7f39b0] oops_end at ffffffffb0d6d758
> >>>>>>     #4 [ffff89cedd7f39d8] no_context at ffffffffb0d5bcde
> >>>>>>     #5 [ffff89cedd7f3a28] __bad_area_nosemaphore at ffffffffb0d5bd75
> >>>>>>     #6 [ffff89cedd7f3a78] bad_area at ffffffffb0d5c085
> >>>>>>     #7 [ffff89cedd7f3aa0] __do_page_fault at ffffffffb0d7080c
> >>>>>>     #8 [ffff89cedd7f3b10] do_page_fault at ffffffffb0d70905
> >>>>>>     #9 [ffff89cedd7f3b40] page_fault at ffffffffb0d6c758
> >>>>>>        [exception RIP: drm_dp_aux_dev_get_by_minor+0x3d]
> >>>>>>        RIP: ffffffffc0a589bd  RSP: ffff89cedd7f3bf0  RFLAGS: 00010246
> >>>>>>        RAX: 0000000000000000  RBX: 0000000000000000  RCX: ffff89cedd7f3fd8
> >>>>>>        RDX: 0000000000000000  RSI: 0000000000000000  RDI: ffffffffc0a613e0
> >>>>>>        RBP: ffff89cedd7f3bf8   R8: ffff89f1bcbabbd0   R9: 0000000000000000
> >>>>>>        R10: ffff89f1be7a1cc0  R11: 0000000000000000  R12: 0000000000000000
> >>>>>>        R13: ffff89f1b32a2830  R14: ffff89d18fadfa00  R15: 0000000000000000
> >>>>>>        ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> >>>>>>        RIP: 00002b45f0d80d30  RSP: 00007ffc416066a0  RFLAGS: 00010246
> >>>>>>        RAX: 0000000000000002  RBX: 000056062e212d80  RCX: 00007ffc41606810
> >>>>>>        RDX: 0000000000000000  RSI: 0000000000000002  RDI: 00007ffc41606ec0
> >>>>>>        RBP: 0000000000000000   R8: 000056062dfed229   R9: 00002b45f0cdf14d
> >>>>>>        R10: 0000000000000002  R11: 0000000000000246  R12: 00007ffc41606ec0
> >>>>>>        R13: 00007ffc41606ed0  R14: 00007ffc41606ee0  R15: 0000000000000000
> >>>>>>        ORIG_RAX: 0000000000000002  CS: 0033  SS: 002b
> >>>>>>
> >>>>>> ----------------------------------------------------------------------------
> >>>>>>
> >>>>>> It was trying to open '/dev/ipmi0', but as no entry in aux_dir, it returned
> >>>>>> NULL from 'idr_find()'. This drm_dp_aux_dev_get_by_minor() should have done a
> >>>>>> check on this, but had failed to do it.
> >>>>>
> >>>>> I think the better question is, *why* does the idr_find() return NULL? I
> >>>>> don't think it should, under any circumstances. I fear adding the check
> >>>>> here papers over some other problem, taking us further away from the
> >>>>> root cause.
> >>>>>
> >>>>> Also, can you reproduce this on a recent upstream kernel? The aux device
> >>>>> nodes were introduced in kernel v4.6. Whatever you reproduced on v3.10
> >>>>> is pretty much irrelevant for upstream.
> >>>>>
> >>>>>
> >>>>> BR,
> >>>>> Jani.
> >>>>
> >>>> I have not been able to reproduce this problem.
> >>>
> >>> mknod /dev/foo c <drm_dp_aux major> 255
> >>> cat /dev/foo
> >>>
> >>> should do it.
> >>
> >> How do I determine <drm_dp_aux major>?
> > 
> > ls,file,stat. Take your pick.
> > 
> 
> Problem here is I can't ls,file,stat /dev/foo until after it's created,
> but I need to know the drm_dp_aux major number befroe I can use mknod.
> 
> What am I missing here?

udev/whatever should create a bunch of these for you so you can check
from them. If not, then dig around in /sys/class/drm_dp_aux_dev.

-- 
Ville Syrjälä
Intel
