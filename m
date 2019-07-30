Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118CFC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D726B206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564481615;
	bh=E2AYfkBk/oDVai9EqQbrHLUfzpa/DdlWmiFmI063qtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oeID+u+/hW35p+cHaIw9+Omo0gTK/94lgGzzuxOFyPOfdj8FvNmwopWGhiPhDQxL3
	 oiKSTljSfSQ4qsPBUXWWNuvmh4JB6wYZogmEZNSbFqY0z2FIflxXgfrfgo9Ia318C+
	 aWsq2/L/zOR+Yxi17tYOB7OFxTG0SSi1KhxfEVBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732409AbfG3KNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 06:13:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37174 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfG3KNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 06:13:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id f17so56082211wme.2;
        Tue, 30 Jul 2019 03:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vpOJpjLvWhhFCWrAoAjdNHk+pYnyUbLPQUxlwJQE5Uw=;
        b=OUDWWQx9JqZLCwTGYKOcExiQFL/u05i3tey2TSMSeHiCMQc5HXr67BMezCKgQ1jkmX
         Vxwaav0MGSR0DVbcDPrYi3cZNiLpPBrGLWHrOS887ZrexeU5Ag2w06PBASFt5rIWMHb0
         DXaq9oEwJ21btV3nPePokQds294hy/04zLGbffRX/w/rFYQwfhYx+qi0VwPcGjLVm6mQ
         IHgdYuE0uAJbDDUtLuRY9ksDZ53ifYj0xvvntyJxJHoXJmzkTGQhwQcDBdnTxA/cFanP
         3L4/Ff/AN9P2oj5xhxkVgPAmlPHolHqAVHCx6HPGPSnnDBp2PE8k8tFHPhu+R30UjhvF
         SwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vpOJpjLvWhhFCWrAoAjdNHk+pYnyUbLPQUxlwJQE5Uw=;
        b=AIEEyDKo2dsLd/45qGrg75iwdLmLy6wddSVFxFEPc2takwJxfRpHHqeDD5n1wXKSwr
         Hf5p/WhVjfUSx97Qa5vmNLIw3gxHvrYI+Hcpbzk8xRdf4NSzezEhoCb4mKozsYSp976i
         rCec8UfMWfh7NV7/8nTE2n5hOsB/aFbftCX0YUYbd1iqMfHHma8kww9KhoNNp/6IMjDd
         1ICdsu5mZM4yR9yiSK/XEkGxkW4eL7CZWspsDq1aD1KIF6i/fmokLKZ9KHe9dugj4pXp
         2aCtyX8p9jOYIfEtY3pqSvGahUq/foN0T/M2qy1Z0lJj5Ncwb8hIHkPGl/5RZPTTBauN
         8e3Q==
X-Gm-Message-State: APjAAAXUjnw5k9R/RBG8NGr4WI9M+hxzyMM8+0GdxeaYf57mLoH/WEkx
        qQfK9+jfckYUhA/N8nSZCHM=
X-Google-Smtp-Source: APXvYqx4OGhx9v8RZ7utEDED0b7wWvE48vFXemjIkMfm6aB15cKr7J/KrDhmD/CbqSTbhNrkilgYmw==
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr103018482wmh.100.1564481612487;
        Tue, 30 Jul 2019 03:13:32 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id f7sm63173368wrv.38.2019.07.30.03.13.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 03:13:31 -0700 (PDT)
Date:   Tue, 30 Jul 2019 12:13:29 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Michael Petlan <mpetlan@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 000/107] perf/core improvements and fixes
Message-ID: <20190730101329.GA7596@gmail.com>
References: <20190730025610.22603-1-acme@kernel.org>
 <20190730080358.GA115870@gmail.com>
 <alpine.DEB.2.21.1907301048030.1738@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907301048030.1738@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> > Pulled, thanks a lot Arnaldo!
> 
> Having to scroll through 400+ lines of useless information to find a single
> line of content.

I typically quote the full shortlog and diffstat for all pull requests I 
take, to create a secondary plain-text fingerprint of what I've pulled.

Thanks,

	Ingo
