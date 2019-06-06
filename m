Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D630C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C45820872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfFFMyA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 08:54:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:10831 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbfFFMyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 08:54:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 05:53:59 -0700
X-ExtLoop1: 1
Received: from xxx.igk.intel.com (HELO xxx) ([10.237.93.170])
  by orsmga005.jf.intel.com with ESMTP; 06 Jun 2019 05:53:57 -0700
Date:   Thu, 6 Jun 2019 14:57:44 +0200
From:   Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 02/14] ALSA: hdac: fix memory release for
 SST and SOF drivers
Message-ID: <20190606145744.4ea389db@xxx>
In-Reply-To: <190f5c09-e6ae-918e-3fcc-d91a72a895da@linux.intel.com>
References: <20190605134556.10322-1-amadeuszx.slawinski@linux.intel.com>
 <20190605134556.10322-3-amadeuszx.slawinski@linux.intel.com>
 <190f5c09-e6ae-918e-3fcc-d91a72a895da@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2019 10:06:47 -0500
Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:

> On 6/5/19 8:45 AM, Amadeusz Sławiński wrote:
> > During the integration of HDaudio support, we changed the way in
> > which we get hdev in snd_hdac_ext_bus_device_init() to use one
> > preallocated with devm_kzalloc(), however it still left kfree(hdev)
> > in snd_hdac_ext_bus_device_exit(). It leads to oopses when trying to
> > rmmod and modprobe. Fix it, by just removing kfree call.
> > 
> > SOF also uses some of the snd_hdac_ functions for HDAudio support
> > but allocated the memory with kzalloc. A matching fix is provided
> > separately to align all users of the snd_hdac_ library.  
> 
> There are stability issues with this change (already shared in a 
> separate series) and additional findings reported by Libin so this 
> should not be applied for now.
> 

Yes, as mentioned in cover letter there is pending discussion, I
provided it for completeness.

> > 
> > Fixes: 6298542fa33b ("ALSA: hdac: remove memory allocation from
> > snd_hdac_ext_bus_device_init") Reviewed-by: Takashi Iwai
> > <tiwai@suse.de> Signed-off-by: Amadeusz Sławiński
> > <amadeuszx.slawinski@linux.intel.com> Signed-off-by: Pierre-Louis
> > Bossart <pierre-louis.bossart@linux.intel.com> ---
> >   sound/hda/ext/hdac_ext_bus.c | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/sound/hda/ext/hdac_ext_bus.c
> > b/sound/hda/ext/hdac_ext_bus.c index c203af71a099..f33ba58b753c
> > 100644 --- a/sound/hda/ext/hdac_ext_bus.c
> > +++ b/sound/hda/ext/hdac_ext_bus.c
> > @@ -170,7 +170,6 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_device_init);
> >   void snd_hdac_ext_bus_device_exit(struct hdac_device *hdev)
> >   {
> >   	snd_hdac_device_exit(hdev);
> > -	kfree(hdev);
> >   }
> >   EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_device_exit);
> >   
> >   
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

