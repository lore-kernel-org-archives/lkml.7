Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F12CC742D1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6D220651
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfGLRHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 13:07:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:35024 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbfGLRHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 13:07:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2019 10:07:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,483,1557212400"; 
   d="scan'208";a="171607073"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga006.jf.intel.com with SMTP; 12 Jul 2019 10:06:58 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 12 Jul 2019 20:06:57 +0300
Date:   Fri, 12 Jul 2019 20:06:57 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Tony Camuso <tcamuso@redhat.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, dkwon@redhat.com
Subject: Re: [PATCH] drm: assure aux_dev is nonzero before using it
Message-ID: <20190712170657.GL5942@intel.com>
References: <20190523110905.22445-1-tcamuso@redhat.com>
 <87v9y0mept.fsf@intel.com>
 <5111581c-9d73-530d-d3ff-4f6950bf3f8c@redhat.com>
 <20190710135617.GE5942@intel.com>
 <374b7e4e-40a2-f3c0-ae14-c533bd42243f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <374b7e4e-40a2-f3c0-ae14-c533bd42243f@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 12:07:46PM -0400, Tony Camuso wrote:
> On 7/10/19 9:56 AM, Ville Syrjälä wrote:
> > On Wed, Jul 10, 2019 at 09:47:11AM -0400, Tony Camuso wrote:
> >> On 5/24/19 4:36 AM, Jani Nikula wrote:
> >>> On Thu, 23 May 2019, tcamuso <tcamuso@redhat.com> wrote:
> >>>>   From Daniel Kwon <dkwon@redhat.com>
> >>>>
> >>>> The system was crashed due to invalid memory access while trying to access
> >>>> auxiliary device.
> >>>>
> >>>> crash> bt
> >>>> PID: 9863   TASK: ffff89d1bdf11040  CPU: 1   COMMAND: "ipmitool"
> >>>>    #0 [ffff89cedd7f3868] machine_kexec at ffffffffb0663674
> >>>>    #1 [ffff89cedd7f38c8] __crash_kexec at ffffffffb071cf62
> >>>>    #2 [ffff89cedd7f3998] crash_kexec at ffffffffb071d050
> >>>>    #3 [ffff89cedd7f39b0] oops_end at ffffffffb0d6d758
> >>>>    #4 [ffff89cedd7f39d8] no_context at ffffffffb0d5bcde
> >>>>    #5 [ffff89cedd7f3a28] __bad_area_nosemaphore at ffffffffb0d5bd75
> >>>>    #6 [ffff89cedd7f3a78] bad_area at ffffffffb0d5c085
> >>>>    #7 [ffff89cedd7f3aa0] __do_page_fault at ffffffffb0d7080c
> >>>>    #8 [ffff89cedd7f3b10] do_page_fault at ffffffffb0d70905
> >>>>    #9 [ffff89cedd7f3b40] page_fault at ffffffffb0d6c758
> >>>>       [exception RIP: drm_dp_aux_dev_get_by_minor+0x3d]
> >>>>       RIP: ffffffffc0a589bd  RSP: ffff89cedd7f3bf0  RFLAGS: 00010246
> >>>>       RAX: 0000000000000000  RBX: 0000000000000000  RCX: ffff89cedd7f3fd8
> >>>>       RDX: 0000000000000000  RSI: 0000000000000000  RDI: ffffffffc0a613e0
> >>>>       RBP: ffff89cedd7f3bf8   R8: ffff89f1bcbabbd0   R9: 0000000000000000
> >>>>       R10: ffff89f1be7a1cc0  R11: 0000000000000000  R12: 0000000000000000
> >>>>       R13: ffff89f1b32a2830  R14: ffff89d18fadfa00  R15: 0000000000000000
> >>>>       ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> >>>>       RIP: 00002b45f0d80d30  RSP: 00007ffc416066a0  RFLAGS: 00010246
> >>>>       RAX: 0000000000000002  RBX: 000056062e212d80  RCX: 00007ffc41606810
> >>>>       RDX: 0000000000000000  RSI: 0000000000000002  RDI: 00007ffc41606ec0
> >>>>       RBP: 0000000000000000   R8: 000056062dfed229   R9: 00002b45f0cdf14d
> >>>>       R10: 0000000000000002  R11: 0000000000000246  R12: 00007ffc41606ec0
> >>>>       R13: 00007ffc41606ed0  R14: 00007ffc41606ee0  R15: 0000000000000000
> >>>>       ORIG_RAX: 0000000000000002  CS: 0033  SS: 002b
> >>>>
> >>>> ----------------------------------------------------------------------------
> >>>>
> >>>> It was trying to open '/dev/ipmi0', but as no entry in aux_dir, it returned
> >>>> NULL from 'idr_find()'. This drm_dp_aux_dev_get_by_minor() should have done a
> >>>> check on this, but had failed to do it.
> >>>
> >>> I think the better question is, *why* does the idr_find() return NULL? I
> >>> don't think it should, under any circumstances. I fear adding the check
> >>> here papers over some other problem, taking us further away from the
> >>> root cause.
> >>>
> >>> Also, can you reproduce this on a recent upstream kernel? The aux device
> >>> nodes were introduced in kernel v4.6. Whatever you reproduced on v3.10
> >>> is pretty much irrelevant for upstream.
> >>>
> >>>
> >>> BR,
> >>> Jani.
> >>
> >> I have not been able to reproduce this problem.
> > 
> > mknod /dev/foo c <drm_dp_aux major> 255
> > cat /dev/foo
> > 
> > should do it.
> 
> How do I determine <drm_dp_aux major>?

ls,file,stat. Take your pick.

-- 
Ville Syrjälä
Intel
