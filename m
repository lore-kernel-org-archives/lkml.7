Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F6BC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976AD2085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561557005;
	bh=LsFayJEQLjTF6JJGMCu7ArGwS/IzubA7urCZ774L2Ug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bO3VBIz1YDdggVcfSz2U3idgIe6oDen6zGwPR60ajgPD3O0ZE+1Z+6UDaRbFQHuCR
	 INYlHHJdIS6Yad9zBB/LYW1UEZVIhXN2jTj/gwa2VD387ndzsKj54qx/8TyLmY/I/3
	 fkppZLkkRryD56m9yEyKuJPe2vn7YnF4LDz0TixQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfFZNuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:50:04 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43208 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfFZNuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:50:04 -0400
Received: by mail-qk1-f196.google.com with SMTP id m14so1648743qka.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 06:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V7w6w+dfv0biqzUUE5ewrpDw9Ee41HXfc9CN96OAGX4=;
        b=JzCa9uKAvPQuqpfMqHF5HWHDsl6QmWzvmcjJ2YSvYbg0uFwQ36TQs/5LC9hUHNQgWf
         SKA25T4g4TUmSDUhmYDGkSIVn1nsYeryl6hOYCNavuGkTHjznxcy/8GXn5fcZF1lcrKo
         tI8iFzwzAbFsWvQqnOgb1BWBHOrgcdUYhc+BwzvWYj/29fjX3956+K/aYPRO3oV4X0Hh
         mkRgC52gXjaceBCfX0MStw9jeTzhu+IU2866gFenUBvZTYuVBMXusmPp6vpIF8Fg8gbH
         +uyX+3SeN7Mm603/UQR4HY26ISO3wD/uGi1woSneZSs28KKDwQzmVTabKs6XgRRlPAPm
         XM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=V7w6w+dfv0biqzUUE5ewrpDw9Ee41HXfc9CN96OAGX4=;
        b=GgXkxHqjElzsMIX5eQguazLlPLRP6Yyww8Lb5GXkjdtUCG3HyKMGmbIjWmO3qlL18e
         T7kJYuzZSBT9MD4Cq0GwDjZb0S9A1r6a1P3pTcHbcTmxKWs/+ai32K4iYLrSao16UrTy
         Zb6RqrQKf6jw+ESKTqPhGMcDNdkYGnYPyH326zqnN8w5bjkgOwuqH1ETOH4EU/MKtN1N
         4CeaI1gx4If1QbrI3TtPbMN2+PahPhrNzgkoZkYJi4N1T8audxqUIFU0NfBBCR/BkRjW
         XknhuAgbelgdJxeHh06RD4OLmTRUt/A2mUtcLp0UFxTEaF0J7sNyTO/RWxel8txaC8au
         wABA==
X-Gm-Message-State: APjAAAWNqfW5ncDpX4KH+Qt6BT0JhLBxCtlNkfdBGkmYP+I2flGz7SQ5
        hBDZ4U/uPVOHa7C7yj0/jV8=
X-Google-Smtp-Source: APXvYqyP+2O1WiPSQrXK2geunwBg+Sltr+2NPgnwpLtV1XhHq9vyJhLtHbePOThD6wMhbn/e5VzHFg==
X-Received: by 2002:a37:ccb:: with SMTP id 194mr3626080qkm.363.1561557002549;
        Wed, 26 Jun 2019 06:50:02 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::953f])
        by smtp.gmail.com with ESMTPSA id h185sm9025825qkd.11.2019.06.26.06.50.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 06:50:00 -0700 (PDT)
Date:   Wed, 26 Jun 2019 06:49:57 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/6] workqueue: convert to raw_spinlock_t
Message-ID: <20190626134957.GT657710@devbig004.ftw2.facebook.com>
References: <20190613145027.27753-1-bigeasy@linutronix.de>
 <20190626071719.psyftqdop4ny3zxd@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626071719.psyftqdop4ny3zxd@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 09:17:19AM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-06-13 16:50:21 [+0200], To linux-kernel@vger.kernel.org wrote:
> > Hi,
> > 
> > the workqueue code has been reworked in -RT to use raw_spinlock_t based
> > locking. This change allows to schedule worker from preempt_disable()ed
> > or IRQ disabled section on -RT. This is the last patch. The previous
> > patches are prerequisites or tiny cleanup (like patch #1 and #2).
> 
> a gentle *ping*

I don't now what to make of the series.  AFAICS, there's no benefit to
mainline.  What am I missing?

Thanks.

-- 
tejun
