Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05C6C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0756217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kraav.com header.i=@kraav.com header.b="IvnrGi97";
	dkim=pass (1024-bit key) header.d=kraav.com header.i=@kraav.com header.b="IvnrGi97"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbfH0IPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:15:06 -0400
Received: from mail-out.elkdata.ee ([185.7.252.64]:10887 "EHLO
        mail-out.elkdata.ee" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbfH0IPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:15:02 -0400
X-Greylist: delayed 381 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Aug 2019 04:15:01 EDT
Received: from mail-relay2.elkdata.ee (unknown [185.7.252.69])
        by mail-out.elkdata.ee (Postfix) with ESMTP id 1D231372A77
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 11:08:37 +0300 (EEST)
Received: from mail-relay2.elkdata.ee (unknown [185.7.252.69])
        by mail-relay2.elkdata.ee (Postfix) with ESMTP id 1B95783088C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 11:08:37 +0300 (EEST)
X-Virus-Scanned: amavisd-new at elkdata.ee
Received: from mail-relay2.elkdata.ee ([185.7.252.69])
        by mail-relay2.elkdata.ee (mail-relay2.elkdata.ee [185.7.252.69]) (amavisd-new, port 10024)
        with ESMTP id yUwoLpVB-fio for <linux-kernel@vger.kernel.org>;
        Tue, 27 Aug 2019 11:08:34 +0300 (EEST)
Received: from mail.elkdata.ee (unknown [185.7.252.68])
        by mail-relay2.elkdata.ee (Postfix) with ESMTP id 8F9A2830889
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 11:08:34 +0300 (EEST)
Received: from mail.meie.biz (21-182-190-90.sta.estpak.ee [90.190.182.21])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: leho@jaanalind.ee)
        by mail.elkdata.ee (Postfix) with ESMTPSA id 84F8160BF17
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 11:08:34 +0300 (EEST)
Received: by mail.meie.biz (Postfix, from userid 500)
        id 6DBAEA831AC; Tue, 27 Aug 2019 11:08:34 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kraav.com; s=mail;
        t=1566893314; bh=c/MrxXN3t+vrxKSqHztny/pq7o/8x6ETk1RdwA+mN7Y=;
        h=Date:From:To:Subject;
        b=IvnrGi97/zDPekludBp3LRKk6NmHzfS+5dRb9xVJWxnsGXFatizJRMShAeC6cMarN
         308BOjLkudsRoCb7acKmhqOybVc0dN0v7mVGQRmLX30E0Rln41saitzf+q/xJSO0Qu
         xnDRJur0EzIlu4A9lF1Ta5l35QNJjysqDUs+Vy9s=
Received: from papaya (papaya-vpn.meie.biz [192.168.48.157])
        by mail.meie.biz (Postfix) with ESMTPA id 55A26A831AA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 11:08:34 +0300 (EEST)
Authentication-Results: mail.meie.biz; dmarc=fail (p=none dis=none) header.from=kraav.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kraav.com; s=mail;
        t=1566893314; bh=c/MrxXN3t+vrxKSqHztny/pq7o/8x6ETk1RdwA+mN7Y=;
        h=Date:From:To:Subject;
        b=IvnrGi97/zDPekludBp3LRKk6NmHzfS+5dRb9xVJWxnsGXFatizJRMShAeC6cMarN
         308BOjLkudsRoCb7acKmhqOybVc0dN0v7mVGQRmLX30E0Rln41saitzf+q/xJSO0Qu
         xnDRJur0EzIlu4A9lF1Ta5l35QNJjysqDUs+Vy9s=
Received: (nullmailer pid 9626 invoked by uid 1000);
        Tue, 27 Aug 2019 08:08:34 -0000
Date:   Tue, 27 Aug 2019 11:08:34 +0300
From:   Leho Kraav <leho@kraav.com>
To:     linux-kernel@vger.kernel.org
Subject: 5.3.0-rc6: i915 fails at typec_displayport 5120x1440
Message-ID: <20190827080834.GB4124@papaya>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Bogosity: Unsure, tests=bogofilter, spamicity=0.500000, version=1.2.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware: Dell Latitude 7400 2-in-1, Whiskey Lake, Intel 620

5120x1440 fails to display.

Next available mode 3840x1080 displays fine.

Is this a kernel, or a driver level issue? It fails both in Xorg and
Wayland, so seems something at the lower levels. This 49" monitor worked
fine on Latitude 7480 (Kaby Lake), so I'm thinking something with `i915`
module layer.

What should I try next?

```
leho@papaya ~ $ [-] uname 
Linux papaya 5.3.0-rc6+gentoo+ #95 SMP PREEMPT Mon Aug 26 23:50:08 EEST 2019 x86_64 Intel(R) Core(TM) i5-8365U CPU @ 1.60GHz GenuineIntel GNU/Linux

leho@papaya ~ $ [-] xrandr 
Screen 0: minimum 8 x 8, current 5120 x 1440, maximum 32767 x 32767
...
DP1 disconnected (normal left inverted right x axis y axis)
DP2 connected primary 3840x1080+0+0 (normal left inverted right x axis y axis) 1200mm x 340mm
   5120x1440     59.98 +  29.98  
   3840x1080     59.97*+
   2560x1080     60.00    59.94    59.98  
   1920x1080     60.00    60.00    50.00    59.94  
   1920x1080i    60.00    50.00    59.94  
   1600x1200     60.00  
   1280x1024     75.02    60.02  
   1280x800      59.81  
   1152x864      75.00  
   1280x720      60.00    50.00    59.94  
   1024x768      75.03    60.00  
   800x600       75.00    60.32  
   720x576       50.00  
   720x480       60.00    59.94  
   640x480       75.00    60.00    59.94  
   720x400       70.08  
HDMI1 disconnected (normal left inverted right x axis y axis)
HDMI2 disconnected (normal left inverted right x axis y axis)
VIRTUAL1 disconnected (normal left inverted right x axis y axis)

leho@papaya ~ $ [-] xrandr --output DP2 --mode 5120x1440 --verbose
crtc 0:    5120x1440  59.98 +0+0 "DP2"
xrandr: Configure crtc 0 failed
crtc 0: disable
crtc 1: disable
crtc 2: disable
crtc 3: disable
screen 0: revert
crtc 0: revert
crtc 1: revert
crtc 2: revert
crtc 3: revert
```

-- 
Leho Kraav, senior technology & digital marketing architect
