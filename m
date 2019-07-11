Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85098C742A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 22:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366AC21019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 22:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="NMg30P8u";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="NMg30P8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfGKWip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 18:38:45 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42538 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726199AbfGKWip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 18:38:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C96278EE2F6;
        Thu, 11 Jul 2019 15:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562884724;
        bh=/1255e8Tjixil0gRxjTfflVSDcZj9hkIQGrFNtahCec=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NMg30P8uSvkU6KqJhY7ynVqmgqCJSCbQRz+D+BfbwWWwCC68Pcu9jfueS8OAwEvt6
         rJ/3whLNIMAYLS0TC4NfYgA8osksmffDC6Ox7otIaqCvGiH5JsH1iUc/k0zVWY08re
         nW1tX8IuHWKvw8sXVjgkVIWWTnO4Y6jlbywMJkoI=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tKSAySbuThlq; Thu, 11 Jul 2019 15:38:44 -0700 (PDT)
Received: from [153.66.254.242] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 32E138EE0C7;
        Thu, 11 Jul 2019 15:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562884724;
        bh=/1255e8Tjixil0gRxjTfflVSDcZj9hkIQGrFNtahCec=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NMg30P8uSvkU6KqJhY7ynVqmgqCJSCbQRz+D+BfbwWWwCC68Pcu9jfueS8OAwEvt6
         rJ/3whLNIMAYLS0TC4NfYgA8osksmffDC6Ox7otIaqCvGiH5JsH1iUc/k0zVWY08re
         nW1tX8IuHWKvw8sXVjgkVIWWTnO4Y6jlbywMJkoI=
Message-ID: <1562884722.15001.3.camel@HansenPartnership.com>
Subject: Re: [Intel-gfx] screen freeze with 5.2-rc6 Dell XPS-13 skylake i915
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Souza, Jose" <jose.souza@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 11 Jul 2019 15:38:42 -0700
In-Reply-To: <dad073fb4b06cf0abb7ab702a9474b9c443186eb.camel@intel.com>
References: <1561834612.3071.6.camel@HansenPartnership.com>
         <156283735757.12757.8954391372130933707@skylake-alporthouse-com>
         <1562875878.2840.0.camel@HansenPartnership.com>
         <27a5b2ca8cfc79bf617387a363ea7192acc4e1f0.camel@intel.com>
         <1562876880.2840.12.camel@HansenPartnership.com>
         <1562882235.13723.1.camel@HansenPartnership.com>
         <dad073fb4b06cf0abb7ab702a9474b9c443186eb.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-11 at 22:26 +0000, Souza, Jose wrote:
> On Thu, 2019-07-11 at 14:57 -0700, James Bottomley wrote:
> > On Thu, 2019-07-11 at 13:28 -0700, James Bottomley wrote:
> > > I've also updated to the released 5.2 kernel and am running with
> > > the
> > > debug parameters you requested ... but so far no reproduction.
> > 
> > OK, it's happened.  I've attached the dmesg (it's 4MB
> > uncompressed). 
> > Is there any other output you'd like from the machine?  I've got an
> > ssh session into it so I can try anything.
> 
> Thanks, could you also share the output of this after the screen
> freeze?
> 
> /sys/kernel/debug/dri/0/i915_edp_psr_status
> /sys/kernel/debug/dri/0/i915_display_info
> /sys/kernel/debug/dri/0/i915_dmc_info
> /sys/kernel/debug/pmc_core/package_cstate_show

jarvis:~ # for f in `cat ~/tmp.txt`; do echo $f; cat $f; done
/sys/kernel/debug/dri/0/i915_edp_psr_status
Sink support: yes [0x01]
PSR mode: PSR1 enabled
Source PSR ctl: disabled [0x01f00726]
Source PSR status: IDLE [0x04010216]
Busy frontbuffer bits: 0x00000001
/sys/kernel/debug/dri/0/i915_display_info
CRTC info
---------
CRTC 47: pipe: A, active=yes, (size=3200x1800), dither=no, bpp=24
        fb: 118, pos: 0x0, size: 3200x1800
        encoder 84: type: DDI A, connectors:
                connector 85: type: eDP-1, status: connected, mode:
                "": 0 373250 3200 3248 3280 3360 1800 1803 1808 1852
0x0 0xa
        cursor visible? yes, position (-3, 261), size 256x256, addr
0x01740000
        num_scalers=2, scaler_users=0 scaler_id=-1, scalers[0]: use=no,
mode=0, scalers[1]: use=no, mode=0
        --Plane id 30: type=PRI, crtc_pos=   0x   0,
crtc_size=3200x1800, src_pos=0.0000x0.0000,
src_size=3200.0000x1800.0000, format=XR24 little-endian (0x34325258),
rotation=0 (0x00000001)
        --Plane id 37: type=OVL, crtc_pos=   0x   0,
crtc_size=   0x   0, src_pos=0.0000x0.0000, src_size=0.0000x0.0000,
format=N/A, rotation=0 (0x00000001)
        --Plane id 44: type=CUR, crtc_pos=  -3x 261, crtc_size= 256x
256, src_pos=0.0000x0.0000, src_size=256.0000x256.0000, format=AR24
little-endian (0x34325241), rotation=0 (0x00000001)
        underrun reporting: cpu=yes pch=yes 
CRTC 65: pipe: B, active=yes, (size=1600x1200), dither=no, bpp=24
        fb: 118, pos: 0x0, size: 3200x1800
        encoder 90: type: DDI B, connectors:
                connector 91: type: DP-1, status: connected, mode:
                "": 0 162000 1600 1664 1856 2160 1200 1201 1204 1250
0x0 0x5
        cursor visible? yes, position (-3, 261), size 256x256, addr
0x017c0000
        num_scalers=2, scaler_users=0 scaler_id=-1, scalers[0]: use=no,
mode=0, scalers[1]: use=no, mode=0
        --Plane id 48: type=PRI, crtc_pos=   0x   0,
crtc_size=1600x1200, src_pos=0.0000x0.0000,
src_size=1600.0000x1200.0000, format=XR24 little-endian (0x34325258),
rotation=0 (0x00000001)
        --Plane id 55: type=OVL, crtc_pos=   0x   0,
crtc_size=   0x   0, src_pos=0.0000x0.0000, src_size=0.0000x0.0000,
format=N/A, rotation=0 (0x00000001)
        --Plane id 62: type=CUR, crtc_pos=  -3x 261, crtc_size= 256x
256, src_pos=0.0000x0.0000, src_size=256.0000x256.0000, format=AR24
little-endian (0x34325241), rotation=0 (0x00000001)
        underrun reporting: cpu=yes pch=yes 
CRTC 83: pipe: C, active=no, (size=0x0), dither=no, bpp=0
        underrun reporting: cpu=yes pch=yes 

Connector info
--------------
connector 85: type eDP-1, status: connected
        physical dimensions: 290x170mm
        subpixel order: Unknown
        CEA rev: 0
        DPCD rev: 12
        audio support: no
        fixed mode:
                "3200x1800": 60 373250 3200 3248 3280 3360 1800 1803
1808 1852 0x48 0xa
        DP branch device present: no
        modes:
                "3200x1800": 60 373250 3200 3248 3280 3360 1800 1803
1808 1852 0x48 0xa
                "3200x1800": 48 298600 3200 3248 3280 3360 1800 1803
1808 1852 0x40 0xa
connector 91: type DP-1, status: connected
        physical dimensions: 430x320mm
        subpixel order: Unknown
        CEA rev: 0
        DPCD rev: 12
        audio support: no
        DP branch device present: yes
                Type: VGA
                ID: 
                HW: 0.0
                SW: 1.0
        modes:
                "1600x1200": 60 162000 1600 1664 1856 2160 1200 1201
1204 1250 0x48 0x5
                "1400x1050": 75 156000 1400 1504 1648 1896 1050 1053
1057 1099 0x40 0x6
                "1400x1050": 60 121750 1400 1488 1632 1864 1050 1053
1057 1089 0x40 0x6
                "1280x1024": 75 135000 1280 1296 1440 1688 1024 1025
1028 1066 0x40 0x5
                "1280x1024": 60 108000 1280 1328 1440 1688 1024 1025
1028 1066 0x40 0x5
                "1280x960": 60 108000 1280 1376 1488 1800 960 961 964
1000 0x40 0x5
                "1152x864": 75 108000 1152 1216 1344 1600 864 865 868
900 0x40 0x5
                "1024x768": 75 78750 1024 1040 1136 1312 768 769 772
800 0x40 0x5
                "1024x768": 70 75000 1024 1048 1184 1328 768 771 777
806 0x40 0xa
                "1024x768": 60 65000 1024 1048 1184 1344 768 771 777
806 0x40 0xa
                "832x624": 75 57284 832 864 928 1152 624 625 628 667
0x40 0xa
                "800x600": 75 49500 800 816 896 1056 600 601 604 625
0x40 0x5
                "800x600": 72 50000 800 856 976 1040 600 637 643 666
0x40 0x5
                "800x600": 60 40000 800 840 968 1056 600 601 605 628
0x40 0x5
                "800x600": 56 36000 800 824 896 1024 600 601 603 625
0x40 0x5
                "640x480": 75 31500 640 656 720 840 480 481 484 500
0x40 0xa
                "640x480": 73 31500 640 664 704 832 480 489 492 520
0x40 0xa
                "640x480": 67 30240 640 704 768 864 480 483 486 525
0x40 0xa
                "640x480": 60 25175 640 656 752 800 480 490 492 525
0x40 0xa
                "720x400": 70 28320 720 738 846 900 400 412 414 449
0x40 0x6
connector 98: type HDMI-A-1, status: disconnected
connector 105: type DP-2, status: disconnected
connector 111: type HDMI-A-2, status: disconnected
/sys/kernel/debug/dri/0/i915_dmc_info
fw loaded: yes
path: i915/skl_dmc_ver1_27.bin
version: 1.27
DC3 -> DC5 count: 1226
DC5 -> DC6 count: 0
program base: 0x09004040
ssp base: 0x00002fc0
htp: 0x00b40068
/sys/kernel/debug/pmc_core/package_cstate_show
Package C2 : 0x5055eddc7d0
Package C3 : 0xee561ada80
Package C6 : 0xb038cdcfd0
Package C7 : 0x195c61800
Package C8 : 0x8a5a9fd25a0
Package C9 : 0x0
Package C10 : 0x0

> It eventually comes back from screen freeze? Like moving the mouse or
> typing brings it back?

No, it seems to be frozen for all time (at least until I got bored
waiting, which was probably 20 minutes).  Even if I reboot the machine,
the current screen state stays until the system powers off.

I've actually got a VGA display plugged in over a USB-C to VGA
converter and that's working fine in mirrored mode even as the panel is
completely frozen.

James

