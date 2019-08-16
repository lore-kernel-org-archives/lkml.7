Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD29C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FF32133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfHPGze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 02:55:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:11229 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbfHPGzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 02:55:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 23:55:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,391,1559545200"; 
   d="scan'208";a="182101092"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.113])
  by orsmga006.jf.intel.com with ESMTP; 15 Aug 2019 23:55:29 -0700
Date:   Fri, 16 Aug 2019 14:55:48 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>, michel@daenzer.net,
        linux-kernel@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>, lkp@01.org
Subject: Re: [LKP] [drm/mgag200] 90f479ae51: vm-scalability.median -18.8%
 regression
Message-ID: <20190816065548.GA67708@shbuild999.sh.intel.com>
References: <1c0bf22b-2c69-6b45-f700-ed832a3a5c17@suse.de>
 <14fdaaed-51c8-b270-b46b-cba7b5c4ba52@suse.de>
 <20190805070200.GA91650@shbuild999.sh.intel.com>
 <c0c3f387-dc93-3146-788c-23258b28a015@intel.com>
 <045a23ab-78f7-f363-4a2e-bf24a7a2f79e@suse.de>
 <37ae41e4-455d-c18d-5c93-7df854abfef9@intel.com>
 <370747ca-4dc9-917b-096c-891dcc2aedf0@suse.de>
 <c6e220fe-230c-265c-f2fc-b0948d1cb898@intel.com>
 <20190812072545.GA63191@shbuild999.sh.intel.com>
 <20190813093616.GA65475@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190813093616.GA65475@shbuild999.sh.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Tue, Aug 13, 2019 at 05:36:16PM +0800, Feng Tang wrote:
> Hi Thomas, 
> 
> On Mon, Aug 12, 2019 at 03:25:45PM +0800, Feng Tang wrote:
> > Hi Thomas,
> > 
> > On Fri, Aug 09, 2019 at 04:12:29PM +0800, Rong Chen wrote:
> > > Hi,
> > > 
> > > >>Actually we run the benchmark as a background process, do we need to
> > > >>disable the cursor and test again?
> > > >There's a worker thread that updates the display from the shadow buffer.
> > > >The blinking cursor periodically triggers the worker thread, but the
> > > >actual update is just the size of one character.
> > > >
> > > >The point of the test without output is to see if the regression comes
> > > >from the buffer update (i.e., the memcpy from shadow buffer to VRAM), or
> > > >from the worker thread. If the regression goes away after disabling the
> > > >blinking cursor, then the worker thread is the problem. If it already
> > > >goes away if there's simply no output from the test, the screen update
> > > >is the problem. On my machine I have to disable the blinking cursor, so
> > > >I think the worker causes the performance drop.
> > > 
> > > We disabled redirecting stdout/stderr to /dev/kmsg,  and the regression is
> > > gone.
> > > 
> > > commit:
> > >   f1f8555dfb9 drm/bochs: Use shadow buffer for bochs framebuffer console
> > >   90f479ae51a drm/mgag200: Replace struct mga_fbdev with generic framebuffer
> > > emulation
> > > 
> > > f1f8555dfb9a70a2  90f479ae51afa45efab97afdde testcase/testparams/testbox
> > > ----------------  -------------------------- ---------------------------
> > >          %stddev      change         %stddev
> > >              \          |                \
> > >      43785                       44481
> > > vm-scalability/300s-8T-anon-cow-seq-hugetlb/lkp-knm01
> > >      43785                       44481        GEO-MEAN vm-scalability.median
> > 
> > Till now, from Rong's tests:
> > 1. Disabling cursor blinking doesn't cure the regression.
> > 2. Disabling printint test results to console can workaround the
> > regression.
> > 
> > Also if we set the perfer_shadown to 0, the regression is also
> > gone.
> 
> We also did some further break down for the time consumed by the
> new code.
> 
> The drm_fb_helper_dirty_work() calls sequentially 
> 1. drm_client_buffer_vmap	  (290 us)
> 2. drm_fb_helper_dirty_blit_real  (19240 us)
> 3. helper->fb->funcs->dirty()    ---> NULL for mgag200 driver
> 4. drm_client_buffer_vunmap       (215 us)
> 
> The average run time is listed after the function names.
> 
> From it, we can see drm_fb_helper_dirty_blit_real() takes too long
> time (about 20ms for each run). I guess this is the root cause
> of this regression, as the original code doesn't use this dirty worker.
> 
> As said in last email, setting the prefer_shadow to 0 can avoid
> the regrssion. Could it be an option?

Any comments on this? thanks

- Feng

> 
> Thanks,
> Feng
> 
> > 
> > --- a/drivers/gpu/drm/mgag200/mgag200_main.c
> > +++ b/drivers/gpu/drm/mgag200/mgag200_main.c
> > @@ -167,7 +167,7 @@ int mgag200_driver_load(struct drm_device *dev, unsigned long flags)
> >  		dev->mode_config.preferred_depth = 16;
> >  	else
> >  		dev->mode_config.preferred_depth = 32;
> > -	dev->mode_config.prefer_shadow = 1;
> > +	dev->mode_config.prefer_shadow = 0;
> > 
> > And from the perf data, one obvious difference is good case don't
> > call drm_fb_helper_dirty_work(), while bad case calls.
> > 
> > Thanks,
> > Feng
> > 
> > > Best Regards,
> > > Rong Chen
> _______________________________________________
> LKP mailing list
> LKP@lists.01.org
> https://lists.01.org/mailman/listinfo/lkp
