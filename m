Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A46C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5FC12082E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="XZFhg9m4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfGSHmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 03:42:32 -0400
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:46793 "EHLO
        mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726563AbfGSHmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 03:42:32 -0400
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Jul 2019 03:42:30 EDT
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 45qjT26mVvzPjnn;
        Fri, 19 Jul 2019 09:35:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1563521702; bh=yOYrrqsoP7xiL7aTR5BIYron1L3/CjNHI2+GyajljJo=;
        h=Date:From:To:Cc:Subject:From:To:CC:Subject;
        b=XZFhg9m4FEj9Zh6256KAD+1e7gii5kauo6uGYk0bxy2QIcUfYS9ULegzXzM2popl3
         i2RuWz/x91vsWKnb2gSE7FrHbyBhN5u7skdRx6QG6ApmyyypU5A9aZ1hDFexhoba9B
         UPj+DcrqWHrS9TvxviCbuVNl/wILpwV4m/MHSJPRhHGjKYZ+zR5ozQQ7hA2i37VOW8
         yqF8SL7Kj8HTGlNuuNMgV5s5HHBxvNlS0xvweewsbp+My51VawrK9lou3HqkfNn3dk
         NFoHpsgiLVfeo9IsdeYQqccbLFHzf3g89Vrqbu1p4WnF+wIySSnYjCvFzpu4L1sr/q
         MXfZfqUZ15P/Q==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 131.188.11.37
Received: from faumail.fau.de (smtp-auth.fau.de [131.188.11.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1883fpKlfwRJYkDn4vR1d9ipl8I7lHqxkQ=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 45qjT046K3zPm7w;
        Fri, 19 Jul 2019 09:35:00 +0200 (CEST)
Received: from k1yuaZ/LKFFjKx39D0nQu8gFL8SwcwKHOWELJhm3b/E=
 by faumail.uni-erlangen.de
 with HTTP (HTTP/1.1 POST); Fri, 19 Jul 2019 09:35:00 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 19 Jul 2019 07:35:00 +0000
From:   "Duda, Sebastian" <sebastian.duda@fau.de>
To:     joe@perches.com
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        ralf.ramsauer@oth-regensburg.de, wolfgang.mauerer@oth-regensburg.de
Subject: get_maintainers.pl subsystem output
Message-ID: <2c912379f96f502080bfcc79884cdc35@fau.de>
X-Sender: sebastian.duda@fau.de
User-Agent: Roundcube Webmail/1.2.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

I'm conducting a large-scale patch analysis of the LKML with 1.8 million 
patch emails. I'm using the `get_maintainer.pl` script to know which 
patch is related to which subsystem.

I ran into two issues while using the script:

1. When I use the script the trivial way

     $ scripts/get_maintainer.pl --subsystem --status --separator , 
drivers/media/i2c/adv748x/
     Kieran Bingham <kieran.bingham@ideasonboard.com> (maintainer:ANALOG 
DEVICES INC ADV748X DRIVER),Mauro Carvalho Chehab <mchehab@kernel.org> 
(maintainer:MEDIA INPUT INFRASTRUCTURE 
(V4L/DVB)),linux-media@vger.kernel.org (open list:ANALOG DEVICES INC 
ADV748X DRIVER),linux-kernel@vger.kernel.org (open list)
     Maintained,Buried alive in reporters
     ANALOG DEVICES INC ADV748X DRIVER,MEDIA INPUT INFRASTRUCTURE 
(V4L/DVB),THE REST

the output is hard to parse because the status `Maintained` is displayed 
only once but related to two subsystems.

I'd prefer a more table like representation, like this:

     Kieran Bingham <kieran.bingham@ideasonboard.com> (maintainer:ANALOG 
DEVICES INC ADV748X DRIVER),linux-media@vger.kernel.org (open 
list:ANALOG DEVICES INC ADV748X DRIVER),ANALOG DEVICES INC ADV748X 
DRIVER,Maintained
     Mauro Carvalho Chehab <mchehab@kernel.org> (maintainer:MEDIA INPUT 
INFRASTRUCTURE (V4L/DVB)),MEDIA INPUT INFRASTRUCTURE 
(V4L/DVB),Maintained
     linux-kernel@vger.kernel.org (open list),THE REST,Buried alive in 
reporters


2. I want to analyze multiple patches, currently I am calling the script 
once per patch. When calling the script with multiple files the files 
output is merged

     $ scripts/get_maintainer.pl --subsystem --status --separator ',' 
drivers/media/i2c/adv748x/ include/uapi/linux/wmi.h
     Kieran Bingham <kieran.bingham@ideasonboard.com> (maintainer:ANALOG 
DEVICES INC ADV748X DRIVER),Mauro Carvalho Chehab <mchehab@kernel.org> 
(maintainer:MEDIA INPUT INFRASTRUCTURE 
(V4L/DVB)),linux-media@vger.kernel.org (open list:ANALOG DEVICES INC 
ADV748X DRIVER),linux-kernel@vger.kernel.org (open 
list),platform-driver-x86@vger.kernel.org (open list:ACPI WMI DRIVER)
     Maintained,Buried alive in reporters,Orphan
     ANALOG DEVICES INC ADV748X DRIVER,MEDIA INPUT INFRASTRUCTURE 
(V4L/DVB),THE REST,ACPI WMI DRIVER

I'd like to run the script with all files but separated output, like 
this:

     $ scripts/get_maintainer.pl --subsystem --status --separator ',' 
--separate-files drivers/media/i2c/adv748x/ include/uapi/linux/wmi.h
     Kieran Bingham <kieran.bingham@ideasonboard.com> (maintainer:ANALOG 
DEVICES INC ADV748X DRIVER),Mauro Carvalho Chehab <mchehab@kernel.org> 
(maintainer:MEDIA INPUT INFRASTRUCTURE 
(V4L/DVB)),linux-media@vger.kernel.org (open list:ANALOG DEVICES INC 
ADV748X DRIVER),linux-kernel@vger.kernel.org (open list)
     Maintained,Buried alive in reporters
     ANALOG DEVICES INC ADV748X DRIVER,MEDIA INPUT INFRASTRUCTURE 
(V4L/DVB),THE REST

     platform-driver-x86@vger.kernel.org (open list:ACPI WMI 
DRIVER),linux-kernel@vger.kernel.org (open list)
     Orphan,Buried alive in reporters
     ACPI WMI DRIVER,THE REST


My Questions are:
1. How can I make get_maintainer's output to be more table-like?
2. How can I make get_maintainer.pl to separate each file's output?

Kind Regards
Sebastian
