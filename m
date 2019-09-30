Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65303C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 15:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3542F206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 15:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSYyvmHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731866AbfI3PIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 11:08:55 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42323 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731471AbfI3PIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 11:08:55 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so4022505pls.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 08:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ikApTYOgNDbcm2fbjspoUTMPGqOJShasqx7zWBwbSvs=;
        b=BSYyvmHCff1NNAFiHUaepws8k+BE5WREgyKG5kQaKaROuZh8Uzwu5mhO7eLHrEQk3p
         ai979woMyqyER2vN/IktGmXdsuuRaIPSc/G8m7dL5RPNPL8Nz536HodDslUEPJSxcsL5
         J5crE9Ol9I8wtkiKqcCYedqTsAhWjwh+SNtlc2NC5gEOL33wiEjV3rhDO48MSGgESU78
         /uPZGrkDP7g0D6+ZPR/9AmqxkMZBK2YLncKBcu0+EzMtNMVETa9MDWibg6odGK14i5o9
         2c+oyEfGqlB58dk9VLW+8zWElXC2n+D8Xt0MOutYrwsbbTHFr4DmSrksUhi4NmjsU3Nc
         oIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ikApTYOgNDbcm2fbjspoUTMPGqOJShasqx7zWBwbSvs=;
        b=PxEaKD+vTsIVu942i/z8GJ911wOvtsdnAsX3NyYY6BA2W7BWf8+fzAjMhhxBYsbmtX
         tmtAlhSKh0+R8qVe5x/QnKmqw8t0y6POxLhiJHmW7CKdfE+uTax2wOFvLM7IeEKDX+z5
         mCIyVkDY1DsF4vgZEDjA33wFVwUGyQkN5c4wxP+7ttIvnmO9QWjq3Fgj1AxIQv98CAkH
         zI2k++EsHH6N1/u4DKvuBfTbHuRLYAxwyF4UVB7uVpSBung/xMSMYqN0Ol9C0erFV7rQ
         I+Et8cLqyqYN1EU297teWVHnAb2umd0aHxlj9GhDkRL6qbIpIn1zV/yhawfGb8OfajlL
         LbjQ==
X-Gm-Message-State: APjAAAXYfRhWg8VN/RiYWaRM6/xn2Vqz/q7sKQvzGgkciXWQT/peQzWB
        4rYA5V2fYWOA0uFT+1k7ap8=
X-Google-Smtp-Source: APXvYqw/KQmgPb3C2PcVy/lA9wFRnhiyU5ciN4rjcoq+OaKMcz0AdcaTBx1nSXwfEESOUMTrlrSIDw==
X-Received: by 2002:a17:902:a717:: with SMTP id w23mr20502339plq.17.1569856134000;
        Mon, 30 Sep 2019 08:08:54 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id w6sm15690309pfj.17.2019.09.30.08.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 08:08:52 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 1 Oct 2019 00:08:48 +0900
To:     Sodagudi Prasad <psodagud@codeaurora.org>
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: Time stamp value in printk records
Message-ID: <20190930150848.GA303191@tigerII.localdomain>
References: <7d1aee8505b91c460fee347ed4204b9a@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d1aee8505b91c460fee347ed4204b9a@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On (09/30/19 06:33), Sodagudi Prasad wrote:
> From Qualcomm side, we would like to check with upstream team about adding
> Raw time stamp value to printk records. On Qualcomm soc, there are various
> DSPs subsystems are there - for example audio, video and modem DSPs.
> Adding raw timer value(along with sched_clock()) in the printk record helps
> in the following use cases –
> 1)	To find out which subsystem  crashed first  -  Whether application
> processor crashed first or DSP subsystem?
> 2)	If there are any system stability issues on the DSP side, what is the
> activity on the APPS processor side during that time?
>
> Initially during the device boot up, printk shed_clock value can be matched
> with timer raw value used on the dsp subsystem, but after APPS processor
> suspends several times, we don’t have way to correlate the time stamp  value
> on the DSP and APPS processor. All timers(both apps processor timer and dsp
> timers) are derived from globally always on timer on Qualcomm soc, So
> keeping global timer raw values in printk records and dsp logs help to
> correlate the activity of all the processors in SoC.

Off the top of my head - timestamps are really hard.

Not only because, as of now, we serialize printk() internally. But also
because a lot of things can happen on any CPU between the moment when event
occurs - printk() - and the moment when we read clocks. NMI, IRQ, preemption.

Consider the following case

CPU0			CPU1			CPU2			CPU3
printk()		printk()		printk()		printk()
			<<preemption>>					<<irq>>
 spin_lock(logbuf)
 clock()
 spin_unlock(logbuf)				spin_lock(logbuf)
 						clock()			<<iret>>
						spin_unlock(logbuf)	spin_lock(logbuf)
									clock()
			spin_lock(logbuf)				spin_unlock(logbuf)
			clock()
			spin_unlock(logbuf)

	-ss
