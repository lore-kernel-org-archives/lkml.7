Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3A9C35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA3D215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 13:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aMCNGRz4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="B9x321Jk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbfI3Ndp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 09:33:45 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52804 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729738AbfI3Ndp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 09:33:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 777CF6118C; Mon, 30 Sep 2019 13:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569850424;
        bh=Aane7lX/b8MbjQ7N/QXU+4I4h3uabatlKt7JDCZCBCc=;
        h=Date:From:To:Cc:Subject:From;
        b=aMCNGRz4KLejyWB8zNxhuPfOc1y9kFOnaD6aHKsJev6sWuFrCu/Kwo5RGPNIkj7Py
         4bDbrUHl3QobQeeNK840WeIgZd4JjN6tmu827/ujJxH17umsh68XzjU2mbjkwHLX1j
         qNKSI6be8yOjiMyzwjUgBeSzriOeMAyyPbq+M5Dc=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 53E35602CC;
        Mon, 30 Sep 2019 13:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569850422;
        bh=Aane7lX/b8MbjQ7N/QXU+4I4h3uabatlKt7JDCZCBCc=;
        h=Date:From:To:Cc:Subject:From;
        b=B9x321Jkh0mHK3l5DYh1NPooOL0E0ipngQgnbuOHPc1PDSOLBbAlRKIZEtsxRV/xJ
         lNM5pXRB3sl9PRHaH6pAReMCqufknidHJWnDMRxtTg7UDiGhs6/rE4ZlTjoTWpTTGY
         KhCViZIXESKd7a0Puh/YQ6hTq3sH8U3RxAgRU4xY=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 30 Sep 2019 06:33:42 -0700
From:   Sodagudi Prasad <psodagud@codeaurora.org>
To:     pmladek@suse.com, sergey.senozhatsky@gmail.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org
Subject: Time stamp value in printk records
Message-ID: <7d1aee8505b91c460fee347ed4204b9a@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

 From Qualcomm side, we would like to check with upstream team about 
adding Raw time stamp value to printk records. On Qualcomm soc, there 
are various DSPs subsystems are there - for example audio, video and 
modem DSPs.
Adding raw timer value(along with sched_clock()) in the printk record 
helps in the following use cases –
1)	To find out which subsystem  crashed first  -  Whether application 
processor crashed first or DSP subsystem?
2)	If there are any system stability issues on the DSP side, what is the 
activity on the APPS processor side during that time?

Initially during the device boot up, printk shed_clock value can be 
matched with timer raw value used on the dsp subsystem, but after APPS 
processor suspends several times, we don’t have way to correlate the 
time stamp  value on the DSP and APPS processor. All timers(both apps 
processor timer and dsp timers) are derived from globally always on 
timer on Qualcomm soc, So keeping global timer raw values in printk 
records and dsp logs help to correlate the activity of all the 
processors in SoC.

It would be great if upstream team adds common solution this problem if 
all soc vendors would get benefit by adding raw timer value to  printk 
records.

-Thanks, Prasad

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
