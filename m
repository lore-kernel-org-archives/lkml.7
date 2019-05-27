Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6C6C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 04:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C089206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 04:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbfE0ENo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 00:13:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:2278 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725847AbfE0ENo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 00:13:44 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 May 2019 21:13:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,517,1549958400"; 
   d="scan'208";a="178711127"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 26 May 2019 21:13:42 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hV713-000ANz-PE; Mon, 27 May 2019 12:13:41 +0800
Date:   Mon, 27 May 2019 12:13:39 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     kbuild-all@01.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] video: fbdev: pvr2fb: add COMPILE_TEST support
Message-ID: <201905271244.WaVc5BQS%lkp@intel.com>
References: <2d2b283e-a5c5-3c94-423c-8cb085492921@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d2b283e-a5c5-3c94-423c-8cb085492921@samsung.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartlomiej,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.2-rc2 next-20190524]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bartlomiej-Zolnierkiewicz/video-fbdev-pvr2fb-remove-function-prototypes/20190524-145925

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

smatch warnings:
drivers/video/fbdev/pvr2fb.c:467 pvr2fb_check_var() warn: unsigned 'var->xoffset' is never less than zero.
drivers/video/fbdev/pvr2fb.c:467 pvr2fb_check_var() warn: unsigned 'var->yoffset' is never less than zero.

vim +467 drivers/video/fbdev/pvr2fb.c

^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  430  
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  431  static int pvr2fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  432  {
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  433  	struct pvr2fb_par *par = (struct pvr2fb_par *)info->par;
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  434  	unsigned int vtotal, hsync_total;
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  435  	unsigned long line_length;
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  436  
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  437  	if (var->pixclock != TV_CLK && var->pixclock != VGA_CLK) {
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  438  		pr_debug("Invalid pixclock value %d\n", var->pixclock);
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  439  		return -EINVAL;
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  440  	}
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  441  
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  442  	if (var->xres < 320)
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  443  		var->xres = 320;
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  444  	if (var->yres < 240)
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  445  		var->yres = 240;
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  446  	if (var->xres_virtual < var->xres)
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  447  		var->xres_virtual = var->xres;
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  448  	if (var->yres_virtual < var->yres)
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  449  		var->yres_virtual = var->yres;
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  450  
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  451  	if (var->bits_per_pixel <= 16)
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  452  		var->bits_per_pixel = 16;
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  453  	else if (var->bits_per_pixel <= 24)
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  454  		var->bits_per_pixel = 24;
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  455  	else if (var->bits_per_pixel <= 32)
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  456  		var->bits_per_pixel = 32;
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  457  
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  458  	set_color_bitfields(var);
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  459  
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  460  	if (var->vmode & FB_VMODE_YWRAP) {
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  461  		if (var->xoffset || var->yoffset < 0 ||
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  462  		    var->yoffset >= var->yres_virtual) {
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  463  			var->xoffset = var->yoffset = 0;
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  464  		} else {
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  465  			if (var->xoffset > var->xres_virtual - var->xres ||
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  466  			    var->yoffset > var->yres_virtual - var->yres ||
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16 @467  			    var->xoffset < 0 || var->yoffset < 0)
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  468  				var->xoffset = var->yoffset = 0;
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  469  		}
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  470  	} else {
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  471  		var->xoffset = var->yoffset = 0;
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  472  	}
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  473  
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  474  	/*
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  475  	 * XXX: Need to be more creative with this (i.e. allow doublecan for
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  476  	 * PAL/NTSC output).
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  477  	 */
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  478  	if (var->yres < 480 && video_output == VO_VGA)
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  479  		var->vmode |= FB_VMODE_DOUBLE;
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  480  
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  481  	if (video_output != VO_VGA) {
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  482  		var->sync |= FB_SYNC_BROADCAST;
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  483  		var->vmode |= FB_VMODE_INTERLACED;
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  484  	} else {
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  485  		var->sync &= ~FB_SYNC_BROADCAST;
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  486  		var->vmode &= ~FB_VMODE_INTERLACED;
fcb1fec7 drivers/video/pvr2fb.c Paul Mundt     2008-03-06  487  		var->vmode |= FB_VMODE_NONINTERLACED;
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  488  	}
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  489  
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  490  	if ((var->activate & FB_ACTIVATE_MASK) != FB_ACTIVATE_TEST) {
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  491  		var->right_margin = par->borderstop_h -
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  492  				   (par->diwstart_h + var->xres);
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  493  		var->left_margin  = par->diwstart_h - par->borderstart_h;
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  494  		var->hsync_len    = par->borderstart_h +
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  495  		                   (par->hsync_total - par->borderstop_h);
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  496  
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  497  		var->upper_margin = par->diwstart_v - par->borderstart_v;
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  498  		var->lower_margin = par->borderstop_v -
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  499  				   (par->diwstart_v + var->yres);
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  500  		var->vsync_len    = par->borderstop_v +
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  501  				   (par->vsync_total - par->borderstop_v);
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  502  	}
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  503  
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  504  	hsync_total = var->left_margin + var->xres + var->right_margin +
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  505  		      var->hsync_len;
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  506  	vtotal = var->upper_margin + var->yres + var->lower_margin +
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  507  		 var->vsync_len;
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  508  
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  509  	if (var->sync & FB_SYNC_BROADCAST) {
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  510  		if (var->vmode & FB_VMODE_INTERLACED)
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  511  			vtotal /= 2;
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  512  		if (vtotal > (PAL_VTOTAL + NTSC_VTOTAL)/2) {
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  513  			/* PAL video output */
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  514  			/* XXX: Should be using a range here ... ? */
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  515  			if (hsync_total != PAL_HTOTAL) {
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  516  				pr_debug("invalid hsync total for PAL\n");
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  517  				return -EINVAL;
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  518  			}
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  519  		} else {
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  520  			/* NTSC video output */
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  521  			if (hsync_total != NTSC_HTOTAL) {
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  522  				pr_debug("invalid hsync total for NTSC\n");
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  523  				return -EINVAL;
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  524  			}
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  525  		}
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  526  	}
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  527  
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  528  	/* Check memory sizes */
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  529  	line_length = get_line_length(var->xres_virtual, var->bits_per_pixel);
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  530  	if (line_length * var->yres_virtual > info->fix.smem_len)
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  531  		return -ENOMEM;
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  532  
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  533  	return 0;
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  534  }
^1da177e drivers/video/pvr2fb.c Linus Torvalds 2005-04-16  535  

:::::: The code at line 467 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
