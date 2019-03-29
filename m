Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7C5C10F05
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86BB921773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="LWY2W9iI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbfC2Is0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:48:26 -0400
Received: from mail.nic.cz ([217.31.204.67]:43078 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729073AbfC2IsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:48:25 -0400
Received: from localhost (unknown [172.20.6.218])
        by mail.nic.cz (Postfix) with ESMTPS id 258EA63254;
        Fri, 29 Mar 2019 09:48:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1553849304; bh=AgkAYS9ByYUk0PRWfebCOMogVjogsATh/yCeLjamddg=;
        h=Date:From:To;
        b=LWY2W9iIhgFk5ah+OsTo7G9DBml5wPD5DPjPTfUY5Y9MHnkLR8ctsNZrdxvZqOj4s
         4f/2Q8f591664I5fLNRW3hBmYh/s7YnC6RGh0dMp3Y5AVM/3hTN91ack0L9pwfIl53
         W6P3Lh5kVa4U6kmpooYsCfTeo/UPtTII+lNDBB90=
Date:   Fri, 29 Mar 2019 09:48:23 +0100
From:   Marek Behun <marek.behun@nic.cz>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: kernfs: can read/write method grow buffer size?
Message-ID: <20190329094823.426d7ed8@nic.cz>
In-Reply-To: <20190329083440.GA12945@amd>
References: <20190329040922.34ab01c6@nic.cz>
        <20190329062253.GA9659@kroah.com>
        <20190329083440.GA12945@amd>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> pavel@amd:~/cip$ cat /sys/power/state
> freeze mem disk
> pavel@amd:~/cip$ cat /sys/class/leds/phy0-led/trigger
> none bluetooth-power rfkill-any rfkill-none kbd-scrolllock kbd-numlock
> kbd-capslock kbd-kanalock kbd-shiftlock kbd-altgrlock kbd-ctrllock
> kbd-altlock kbd-shiftllock kbd-shiftrlock kbd-ctrlllock kbd-ctrlrlock
> AC-online BAT0-charging-or-full BAT0-charging BAT0-full
> BAT0-charging-blink-full-solid rfkill0 phy0rx phy0tx phy0assoc
> phy0radio [phy0tpt] mmc0 timer heartbeat audio-mute audio-micmute
> rfkill1 hci0-power rfkill8
> pavel@amd:~/cip$
> 

Yes, and cpufreq governors too list available governosrs as space
separated list.
Maybe the "one value per file" rule was thought-of only after these
were merged?

Marek
