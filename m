Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D86C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275AA20863
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfCSRtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:49:36 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.67]:3958 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726612AbfCSRtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:49:36 -0400
Received: from [46.226.52.200] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-west-1.aws.symcld.net id 7E/E2-11025-CAB219C5; Tue, 19 Mar 2019 17:49:32 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRWlGSWpSXmKPExsVy8IPnUd012hN
  jDCYnWZxq2cNuceXiISaLqQ+fsFnMP3KO1eLblQ4mi8u75rBZLL1+kcmic1c/q0Xr3iPsFhu+
  r2V04PLY8LmJzaP10l82jzXz1jB67Jx1l91j06pONo99b5exeazfcpXF4/MmuQCOKNbMvKT8i
  gTWjJsXzrIUPGCraDh5haWB8S9LFyMXh5DAekaJwxO+sHcxcgI5FRL35u9l7mLk4OAVcJM4fU
  QEJMwmYCEx+cQDNhCbRUBVYsfV34wgtrCAv8TJI6cYQeaICFxilJj76i1YgllgL6PEyldSIDa
  vgKDEyZlPWCDiEhIHX7xghthlIHF6QSNYXELAXmL6+6tgeyUE9CUaj8VChA0lvs/6BlViLrH5
  2HaWCYz8s5BMnYVk6gJGplWMFklFmekZJbmJmTm6hgYGuoaGRrqGlma6RoZmeolVukl6qaW65
  anFJbqGeonlxXrFlbnJOSl6eaklmxiBkZJScOTGDsYvy9MPMUpyMCmJ8jppTYwR4kvKT6nMSC
  zOiC8qzUktPsQow8GhJMErC5ITLEpNT61Iy8wBxixMWoKDR0mE94EmUJq3uCAxtzgzHSJ1ilF
  RSpz3GUhCACSRUZoH1wZLE5cYZaWEeRkZGBiEeApSi3IzS1DlXzGKczAqCfNKg2znycwrgZv+
  CmgxE9DidfP6QRaXJCKkpBoYS199PP+y8vSWd31tU+d37n9t/CHutQL7s6/XeifFLT8TYGCcN
  FWH98yc608PcORtO2r96tLOA4kRrr4fj25v2yNwQutD0ZWzTt5pTDrpWdr6zNcf7Bd7nin90a
  D71o2YZb7HRI65LlZX3hH7UXBG/L73L4VO3eRaw2NltG27vN02HtOjd5k5G5VYijMSDbWYi4o
  TAe5zGDYOAwAA
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-15.tower-288.messagelabs.com!1553017771!4862358!1
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14763 invoked from network); 19 Mar 2019 17:49:31 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-15.tower-288.messagelabs.com with AES128-SHA256 encrypted SMTP; 19 Mar 2019 17:49:31 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Tue, 19 Mar 2019 17:49:29 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22379)      id
 B32C73FB15; Tue, 19 Mar 2019 17:49:29 +0000 (GMT)
Message-ID: <cover.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date:   Tue, 19 Mar 2019 17:49:29 +0000
Subject: [PATCH 0/3] ASoC: da7219: Extend CCF support to allow WCLK/BCLK config
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Akshu Agrawal <Akshu.Agrawal@amd.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 19/03/2019 15:22:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set extends the existing CCF support in the DA7219 codec driver by
splitting the DAI clock gate into clocks to cover WCLK and BCLK, to enable the
configuration of these clocks from audio machine drivers when this codec is
the clock master of the DAI.

Adam Thomson (3):
  ASoC: da7219: Update DAI clock binding info to cover WCLK/BCLK
  ASoC: da7219: Expose BCLK and WCLK control through CCF
  ASoC: AMD: Update DA7219 DAI clock name to align with codec updates

 Documentation/devicetree/bindings/sound/da7219.txt |   8 +-
 include/sound/da7219.h                             |   8 +-
 sound/soc/amd/acp-da7219-max98357a.c               |   2 +-
 sound/soc/codecs/da7219.c                          | 523 ++++++++++++++++-----
 sound/soc/codecs/da7219.h                          |   6 +-
 5 files changed, 412 insertions(+), 135 deletions(-)

-- 
1.9.1

