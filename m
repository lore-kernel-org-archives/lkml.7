Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199A6C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6FA21734
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578294672;
	bh=Xd1XYnhQ7Eicl7UzbwxZz46bNnzvE+nGFxcgUnwF8uQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yZuFIl2cTlzlXOPLzRVGP4WrpzExpmocHGFqe2T2JWR55Wevkz1jUAt7HToe3iaqe
	 4EcWVjZOoXVc7I1wmj6fDkc6/mEi5hUl3gn5tvliF0DQglgDLgrn5cp6wUXE/268RW
	 YpRgy4rfVXscxiMg5Dv9geBUvbz5/yRO2PKYftDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgAFHLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 02:11:12 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53365 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgAFHLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 02:11:11 -0500
Received: by mail-wm1-f68.google.com with SMTP id m24so13963134wmc.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 23:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=esTdrX5D7MTLTW+rnayOdTrMeF9TKqXQdWkkivOvSh4=;
        b=SoLHbDPTN+qjDA8D2Hlh3G3IrERo2a+vpJnBIE4NQrkqN2lx9XhoImwCxNefsCiirS
         81HhQxoF4mtRrGNh9zPbtHTWyfUiPscXDXPYJ/0pjcu6KT1F6QD9z5g/PcckApTbcy2A
         1xvlEo1KAOzfH7u2Q51fwaJCX6aM9l5dcibTRBnmbC63MDO/+vu7mOldQbrcMUCdSzyN
         ipt8bnT+2hlsroK8XFKHSdVgTVzIcGgfxvQtOkpRg6bW1fYWsLnzFqtcvFc1ao4FC1wZ
         O64j6GIsmU5KMpauzzDHxCUy0LoDrQtu0+09CBcEsXbX4tCXfe6lyvs9bWv38zY5zuTb
         PX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=esTdrX5D7MTLTW+rnayOdTrMeF9TKqXQdWkkivOvSh4=;
        b=aR64XAzBNGCfysuD/L9t1da4CWkDAC8ZQ1gOFVhHp+jeMb6Te5Ga7TgqjOPReqZjlc
         pODFOiMzUpTTCeRRXeKs/CFopg2sBSwhIc1Fyx3ZuDXmakIgzE3HLypZiyoa38VyAP89
         D9+X7ylsAqXba5cX13E6nmyL2mXnryqHGQPSIlJrYQjrjwWaWo8SSIdwS938y8jtuQlO
         EQq3oIDj8iP3TtnxuCE4VubQSS7uMPwOD0H+UPZqxvx3K+j2k0+Xd0buLWGOIzO7bb8O
         jUV1gzWScyywYY/x0xlceM2ZHEQ6yAH1EDH47TU2aqdMEiogSgTzlu0oPl0onrZzgcNc
         M1Iw==
X-Gm-Message-State: APjAAAXWQDO1r2EBDQqOzLr08wOJAti5TLE8Z96lHt4TFTOgt+tmiwPQ
        4GF8+Cf3qJIT01rDHmg04uk=
X-Google-Smtp-Source: APXvYqwOXlxeR+8JM5Cm/nHyaaMJfsDnSOOdOr82rmvoWNQ9CU6W+b2siFhfayfKLqcT4U9vWK15Fg==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr32598399wmi.152.1578294669688;
        Sun, 05 Jan 2020 23:11:09 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id n3sm22456698wmc.27.2020.01.05.23.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 23:11:09 -0800 (PST)
Date:   Mon, 6 Jan 2020 08:11:07 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Chuansheng Liu <chuansheng.liu@intel.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Subject: Re: [PATCH] x86/mce/therm_throt: Fix the access of uninitialized
 therm_work
Message-ID: <20200106071107.GA95725@gmail.com>
References: <20200106064155.64-1-chuansheng.liu@intel.com>
 <20200106070759.GB12238@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106070759.GB12238@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Borislav Petkov <bp@alien8.de> wrote:

> On Mon, Jan 06, 2020 at 06:41:55AM +0000, Chuansheng Liu wrote:
> > In ICL platform, it is easy to hit bootup failure with panic
> > in thermal interrupt handler during early bootup stage.
> > 
> > Such issue makes my platform almost can not boot up with
> > latest kernel code.
> > 
> > The call stack is like:
> > kernel BUG at kernel/timer/timer.c:1152!
> > 
> > Call Trace:
> > __queue_delayed_work
> > queue_delayed_work_on
> > therm_throt_process
> > intel_thermal_interrupt
> > ...
> > 
> > When one CPU is up, the irq is enabled prior to CPU UP
> > notification which will then initialize therm_worker.
> 
> You mean the unmasking of the thermal vector at the end of
> intel_init_thermal()?
> 
> If so, why don't you move that to the end of the notifier and unmask it
> only after all the necessary work like setting up the workqueues etc, is
> done, and save yourself adding yet another silly bool?

A debugging WARN_ON_ONCE() when the workqueue is not initialized yet 
would also be useful I suspect. This would turn any remaining race-crash 
boot failure in this area into a warning.

Thanks,

	Ingo
