Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0F9C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 08:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252952173B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 08:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="AvuHbQPk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731978AbfGPIwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 04:52:03 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40358 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfGPIwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 04:52:03 -0400
Received: by mail-ed1-f65.google.com with SMTP id k8so18757965eds.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 01:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Ct41c9jR/xNKwQoE+eTBxMagn1NUebyIFvbvznkylT8=;
        b=AvuHbQPkFcMTK4G8x0kccQiEX8X1dYCRvxG+RFfj+xABwX3A2hbaT4K9qP3jVR8+3t
         eJd6hTgLu6f4UVruKgQySYno24M9Gckv4si29UOMPEzocG+qFvPEZYzG1QS7izQWZB3T
         pyEygpJ/mscJWEUyYl2PWUdi1GdmMn6nWPRzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Ct41c9jR/xNKwQoE+eTBxMagn1NUebyIFvbvznkylT8=;
        b=fDpSnVZkyAU9Lcr4eQ0KA6Qjoel/ALybBu19J5dB6mj96e4MRHzRPrwHBo9I/yFhDv
         FsrGQAO0P/5CXC2P5DON7kP+ENJkJBO90vIcACzfv8xEpV71EWx5dX+ZDkJr1tK/2NfT
         g8QWZHoqUx/voR0jVwvdvhZMUO1xpUzGu+c9vF03WX5PLrgpPu8cWk69Y7Eav2OqRqx2
         RLfuXfDPvhLl7U3WWNdGs9fT2hMtLA8DerPwE3GS4D8FfcSgJVfhhUfSfZXjGzM97JBP
         Mfw6yeYPH9MbURG3gBoyqW0dd0wcmw5EmUewt6uGPpyIYY41u+k2AOZKol17RzQ88yO1
         Avdg==
X-Gm-Message-State: APjAAAWZSZUrzR1BzHINH9jq7cWn/derhZoBiSlu2wwnvz1Jm5bDMW6R
        f+s/auvbnVxb0aaNtMQfuwCGFrne
X-Google-Smtp-Source: APXvYqxi8ESgTfkG3IUnGSjORTBf52sJZTmdCPPKJXq0E8D4/0JWGEjwqQ7Kh1auP1EUo9O4UbbeZQ==
X-Received: by 2002:a17:906:11da:: with SMTP id o26mr24779610eja.64.1563267121066;
        Tue, 16 Jul 2019 01:52:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id gz5sm4238864ejb.21.2019.07.16.01.51.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 01:52:00 -0700 (PDT)
Date:   Tue, 16 Jul 2019 10:51:58 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Vasilev, Oleg" <oleg.vasilev@intel.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "hamohammed.sa@gmail.com" <hamohammed.sa@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "rodrigosiqueiramelo@gmail.com" <rodrigosiqueiramelo@gmail.com>,
        "contact@emersion.fr" <contact@emersion.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] drm/vkms: Introduce basic support for configfs
Message-ID: <20190716085158.GV15868@phenom.ffwll.local>
Mail-Followup-To: "Vasilev, Oleg" <oleg.vasilev@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "hamohammed.sa@gmail.com" <hamohammed.sa@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "rodrigosiqueiramelo@gmail.com" <rodrigosiqueiramelo@gmail.com>,
        "contact@emersion.fr" <contact@emersion.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1561950553.git.rodrigosiqueiramelo@gmail.com>
 <20190710170116.GB15868@phenom.ffwll.local>
 <20190712030757.a7sp5xmyzyt24i4e@smtp.gmail.com>
 <d7300673f3fbb10331080b751aa4e9a7ec8f56f8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7300673f3fbb10331080b751aa4e9a7ec8f56f8.camel@intel.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 11:09:24AM +0000, Vasilev, Oleg wrote:
> On Fri, 2019-07-12 at 00:07 -0300, Rodrigo Siqueira wrote:
> > On 07/10, Daniel Vetter wrote:
> > > On Mon, Jul 01, 2019 at 12:23:39AM -0300, Rodrigo Siqueira wrote:
> > > > This patchset introduces the support for configfs in vkms by
> > > > adding a
> > > > primary structure for handling the vkms subsystem and exposing
> > > > connectors as a use case.  This series allows enabling/disabling
> > > > virtual
> > > > and writeback connectors on the fly. The first patch of this
> > > > series
> > > > reworks the initialization and cleanup code of each type of
> > > > connector,
> > > > with this change, the second patch adds the configfs support for
> > > > vkms.
> > > > It is important to highlight that this patchset depends on
> > > > https://patchwork.freedesktop.org/series/61738/.
> > > > 
> > > > After applying this series, the user can utilize these features
> > > > with the
> > > > following steps:
> > > > 
> > > > 1. Load vkms without parameter
> > > > 
> > > >   modprobe vkms
> > > > 
> > > > 2. Mount a configfs filesystem
> > > > 
> > > >   mount -t configfs none /mnt/
> > > > 
> > > > After that, the vkms subsystem will look like this:
> > > > 
> > > > vkms/
> > > >  |__connectors
> > > >     |__Virtual
> > > >         |__ enable
> > > > 
> > > > The connectors directories have information related to
> > > > connectors, and
> > > > as can be seen, the virtual connector is enabled by default.
> > > > Inside a
> > > > connector directory (e.g., Virtual) has an attribute named
> > > > ‘enable’
> > > > which is used to enable and disable the target connector. For
> > > > example,
> > > > the Virtual connector has the enable attribute set to 1. If the
> > > > user
> > > > wants to enable the writeback connector it is required to use the
> > > > mkdir
> > > > command, as follows:
> > > > 
> > > >   cd /mnt/vkms/connectors
> > > >   mkdir Writeback
> > > > 
> > > > After the above command, the writeback connector will be enabled,
> > > > and
> > > > the user could see the following tree:
> > > > 
> > > > vkms/
> > > >  |__connectors
> > > >     |__Virtual
> > > >     |   |__ enable
> > > >     |__Writeback
> > > >         |__ enable
> > > > 
> > > > If the user wants to remove the writeback connector, it is
> > > > required to
> > > > use the command rmdir, for example
> > > > 
> > > >   rmdir Writeback
> > > > 
> > > > Another way to enable and disable a connector it is by using the
> > > > enable
> > > > attribute, for example, we can disable the Virtual connector
> > > > with:
> > > > 
> > > >   echo 0 > /mnt/vkms/connectors/Virtual/enable
> > > > 
> > > > And enable it again with:
> > > > 
> > > >   echo 1 > /mnt/vkms/connectors/Virtual/enable
> > > > 
> > > > It is important to highlight that configfs 'obey' the parameters
> > > > used
> > > > during the vkms load and does not allow users to remove a
> > > > connector
> > > > directory if it was load via module parameter. For example:
> > > > 
> > > >   modprobe vkms enable_writeback=1
> > > > 
> > > > vkms/
> > > >  |__connectors
> > > >     |__Virtual
> > > >     |   |__ enable
> > > >     |__Writeback
> > > >         |__ enable
> > > > 
> > > > If the user tries to remove the Writeback connector with “rmdir
> > > > Writeback”, the operation will be not permitted because the
> > > > Writeback
> > > > connector was loaded with the modules. However, the user may
> > > > disable the
> > > > writeback connector with:
> > > > 
> > > >   echo 0 > /mnt/vkms/connectors/Writeback/enable
> > 
> > Thanks for detail this issue, I just have some few questions inline.
> >  
> > > I guess I should have put a warning into that task that step one is
> > > designing the interface. Here's the fundamental thoughts:
> > > 
> > > - The _only_ thing we can hotplug after drm_dev_register() is a
> > >   drm_connector. That's an interesting use-case, but atm not really
> > >   supported by the vkms codebase. So we can't just enable/disable
> > >   writeback like this. We also can't change _anything_ else in the
> > > drm
> > >   driver like this.
> > 
> > In the first patch of this series, I tried to decouple enable/disable
> > for virtual and writeback connectors; I tried to take advantage of
> > drm_connector_[register/unregister] in each connector. Can we use the
> > first patch or it doesn't make sense?

No, because you also add the drm_encoder. That cannot be hotadded/removed
right now. So you'd need to add a drm_encoder preemptively for all
writeback connectors you might need, which doesn't make much sense.

> > I did not understand why writeback connectors should not be
> > registered
> > and unregister by calling drm_connector_[register/unregister], is it
> > a
> > writeback or vkms limitation? Could you detail why we cannot change
> > connectors as I did?
> 
> Hi,
> 
> I guess, some more stuff should happen during the hotplug, like
> drm_kms_helper_hotplug_event()?

writeback is generally a SoC feature. I don't think anyone expects that
you can hotplug a writeback connector.
> 
> > 
> > Additionally, below you said "enable going from 1 -> 0, needs to be
> > treated like a physical hotunplug", do you mean that we first have to
> > add support for drm_dev_plug and drm_dev_unplug in vkms?
> >  
> > > - The other bit we want is support multiple vkms instances, to
> > > simulate
> > >   multi-gpus and fun stuff like that.
> > 
> > Do you mean something like this:
> > 
> > configfs/vkms/instance1
> > > _enable_device 
> > > _more_stuff
> > configfs/vkms/instance2
> > > _enable_device
> > > _more_stuff
> > configfs/vkms/instanceN
> > > _enable_device
> > > _more_stuff
> 
> I think it would be a good idea. This way the creation of new device
> could look like this:
> 
> mkdir -p instanceN/connector/virtual0
> echo "virtual" > instanceN/connector/virtual0/type

virtual should be a top-level property. I'm not aware of any real driver
where vblank works on some connector/crtc, but not on another one.

> echo 1 > instanceN/connector/virtual0/enable

For the initial connectors those don't need separate enable properties,
they get enabled with the global enable knob.

> mkdir -p instanceN/crtc/crtc0
> ...
> echo 1 > instanceN/enable
> 
> Once the last command is executed, the whole instanceN/ becomes
> immutable, except for
>  - instanceN/enable, so we can later disable it
>  - instanceN/connector, where we can create new connectors, it would be
> treated as a hotplug.

For hotplugged connectors we need a separate enable knob. But we're still
_very_ far away from making that possible I think.

> > Will each instance work like a totally independent device? What is
> > the
> > main benefit of this? I can think about some use case for testing
> > prime, but I cannot see other things.
> 
> We can test that userspace always select the right device to display. 

Also hotunplug behaviour. We can take out an entire drm_device, and make
sure userspace and the kernel copes correctly. This is _really_ hard to
get right on both sides.

And it's a real thing with stuff like usb display link.

> > > - Therefore vkms configs should be at the drm_device level, so a
> > >   directory under configfs/vkms/ represents an entire device.
> > > 
> > > - We need a special config item to control
> > >   drm_dev_register/drm_dev_unregister. While a drm_device is
> > > registers,
> > >   all other config items need to fail if userspace tries to change
> > > them.
> > >   Maybe this should be a top-level "enable" property.
> > > 
> > > - Every time enable goes from 0 -> 1 we need to create a completely
> > > new
> > >   vkms instance. The old one might still be around, waiting for the
> > > last
> > >   few references to disappear.
> > > 
> > > - enable going from 1 -> 0 needs to be treated like a physical
> > > hotunplug,
> > >   i.e. not drm_dev_unregister but drm_dev_unplug. We also need to
> > > annotate
> > >   all the vkms code with drm_dev_enter/exit() as the kerneldoc of
> > >   drm_dev_unplug explains.
> > > 
> > > - rmdir should be treated like enable going from 1 -> 0. Or maybe
> > > we
> > >   should disable enable every going from 1 -> 0, would propably
> > > simplify
> > >   everything.
> > > 
> > > - The initial instance created at module load also neeeds to be
> > > removable
> > >   like this.
> > > 
> > > Once we have all this, then can we start to convert driver module
> > > options
> > > over to configs and add cool features. But lots of infrastructure
> > > needed
> > > first.
> > > 
> > > Also, we probably want some nasty testcases which races an rmdir in
> > > configfs against userspace still doing ioctl calls against vkms.
> > > This is
> > > ideal for validation the hotunplug infrastructure we have in drm.
> > > 
> > > An alternative is adding connector hotplugging. But I think before
> > > we do
> > > that we need to have support for more crtc and more connectors as
> > > static
> > > module options. So maybe not a good starting point for configfs.
> > 
> > So, probably the first set of tasks should be:
> > 
> > 1. Enable multiple CRTC via module parameters. For example:
> >   modprobe vkms crtcs=13
> > 2. Enable multiple connectors via module parameters. For example:
> >   modprobe vkms crtcs=3 connector=3 // 3 virtual connectors per crtc
> 
> But do we want to have those parameters as module options, if we then
> plan to replace those with configfs?  

Imo we should phase out module options, or at least not add more. Then you
can just have a small script which sets up the vkms device you want, and
then run the tests. I'd go further even, and say we should have
default_device=0 knob to start out with nothing when you load the driver.
-Daniel

> 
> > 
> > Thanks again,
> >  
> > > The above text should probably be added to the vkms.rst todo item
> > > ...
> > > -Daniel
> > > 
> > > > 
> > > > Rodrigo Siqueira (2):
> > > >   drm/vkms: Add enable/disable functions per connector
> > > >   drm/vkms: Introduce configfs for enabling/disabling connectors
> > > > 
> > > >  drivers/gpu/drm/vkms/Makefile         |   3 +-
> > > >  drivers/gpu/drm/vkms/vkms_configfs.c  | 229
> > > > ++++++++++++++++++++++++++
> > > >  drivers/gpu/drm/vkms/vkms_drv.c       |   6 +
> > > >  drivers/gpu/drm/vkms/vkms_drv.h       |  17 ++
> > > >  drivers/gpu/drm/vkms/vkms_output.c    |  84 ++++++----
> > > >  drivers/gpu/drm/vkms/vkms_writeback.c |  31 +++-
> > > >  6 files changed, 332 insertions(+), 38 deletions(-)
> > > >  create mode 100644 drivers/gpu/drm/vkms/vkms_configfs.c
> > > > 
> > > > -- 
> > > > 2.21.0
> > > > 
> > > > 
> > > > -- 
> > > > Rodrigo Siqueira
> > > > https://siqueira.tech
> > > 
> > > -- 
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > http://blog.ffwll.ch
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> -- 
> Oleg Vasilev <oleg.vasilev@intel.com>
> Intel Corporation



> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
